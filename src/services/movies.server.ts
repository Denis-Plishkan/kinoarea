import { createServerSupabaseClient } from '@/lib/supabase/server'
import { Movie, Genre } from '@/types/movie'

type MovieFromDB = Omit<Movie, 'genres'> & {
  genres: { genres: Genre }[]
}

export async function getMoviesCount(year?: number): Promise<number> {
  const supabase = await createServerSupabaseClient()

  let query = supabase
    .from('movies')
    .select('id', { count: 'exact', head: true })

  if (year) {
    query = query.eq('year', year)
  }

  const { count, error } = await query

  if (error) {
    console.error('Error fetching movies count:', error)
    return 0
  }

  return count ?? 0
}

export async function getMoviesServer(
  limit: number,
  offset: number = 0,
  genre?: string,
  inCinemaOnly?: boolean,
  orderByRating?: boolean,
  year?: number
): Promise<Movie[]> {
  const supabase = await createServerSupabaseClient()

  let query = supabase
    .from('movies')
    .select(
      `id, title, rating_kinoarea, poster_url, genres: movie_genres!inner(genres!inner(id, name))`
    )
  if (inCinemaOnly) {
    query = query.eq('is_in_cinema', true)
  }
  if (genre) {
    query = query.eq('movie_genres.genres.name', genre)
  }
  if (orderByRating) {
    query = query.order('rating_kinoarea', { ascending: false })
  }
  if (year) {
    query = query.eq('year', year)
  }

  const { data, error } = await query
    .range(offset, offset + limit - 1)
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
