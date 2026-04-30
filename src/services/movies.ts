import { createClient } from '@/lib/supabase/client'
import { Movie, Genre } from '@/types/movie'

type MovieFromDB = Omit<Movie, 'genres'> & { genres: { genres: Genre }[] }

export async function getMovies() {
  const supabase = createClient()

  return supabase
    .from('movies')
    .select(
      `id,title, rating_kinoarea, poster_url, genres: movie_genres(genre:genres(id, name))`
    )
    .overrideTypes<Movie[], { merge: false }>()
}

export async function getMoviesInCinema(limit: number) {
  const supabase = createClient()

  const { data, error } = await supabase
    .from('movies')
    .select(
      `id,title, rating_kinoarea, poster_url, genres: movie_genres(genres(id, name))`
    )
    .eq('is_in_cinema', true)
    .limit(limit)
    .overrideTypes<MovieFromDB[], { merge: false }>()

  const movies = data?.map(movie => ({
    ...movie,
    genres: movie.genres?.map(mg => mg.genres) ?? [],
  }))

  return { data: movies, error }
}
