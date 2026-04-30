import { createServerSupabaseClient } from '@/lib/supabase/server'
import { Movie, Genre } from '@/types/movie'

type MovieFromDB = Omit<Movie, 'genres'> & {
  genres: { genres: Genre }[]
}

export async function getMoviesInCinemaServer(
  limit: number,
  genre?: string
): Promise<Movie[]> {
  const supabase = await createServerSupabaseClient()

  let query = supabase
    .from('movies')
    .select(
      `id, title, rating_kinoarea, poster_url, genres: movie_genres!inner(genres!inner(id, name))`
    )
    .eq('is_in_cinema', true)
  if (genre) {
    query = query.eq('movie_genres.genres.name', genre)
  }

  const { data, error } = await query
    .limit(limit)
    .overrideTypes<MovieFromDB[]>()

  if (error) {
    console.error('Error fetching movies:', error)
    return []
  }

  return (
    data?.map(movie => ({
      ...movie,
      genres: movie.genres?.map(mg => mg.genres) ?? [],
    })) ?? []
  )
}
