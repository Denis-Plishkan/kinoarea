import { CinemaSection } from '@/components/main'
import { TrailersSection } from '@/components/main/TrailersSection'
import { getMoviesInCinemaServer } from '@/services/movies.server'

export default async function MoviesPage() {
  const initialMovies = await getMoviesInCinemaServer(8)

  return (
    <>
      <CinemaSection initialMovies={initialMovies} />
      <TrailersSection />
    </>
  )
}
