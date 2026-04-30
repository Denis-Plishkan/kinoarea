import { CinemaSection, PopularMovieSection, TrailersSection } from '@/components/main'
import { getMoviesServer } from '@/services/movies.server'

export default async function MoviesPage() {
  const initialMovies = await getMoviesServer(8, 0, undefined, true)

  return (
    <>
      <CinemaSection initialMovies={initialMovies} />
      <TrailersSection />
      <PopularMovieSection/>
    </>
  )
}
