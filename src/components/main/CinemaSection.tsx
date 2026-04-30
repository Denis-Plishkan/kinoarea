'use client'

import { MovieCard } from '../MovieCard'
import { useState, useTransition } from 'react'
import { Movie } from '@/types/movie'
import { loadMoreMovies } from '@/app/actions'

import { navIsCinema } from '@/constants/navigation'
import { FilterTabs } from '../ui'
import { titleIsCinema } from '@/constants/titles'
import { BtnLoad } from '../ui/BtnLoad'

interface Props {
  initialMovies: Movie[]
}

export const CinemaSection = ({ initialMovies }: Props) => {
  const [movies, setMovies] = useState(initialMovies)
  const [limit, setLimit] = useState(8)
  const [isPending, startTransition] = useTransition()

  const [selectedGenre, setSelectedGenre] = useState<string | undefined>()

  const handleLoadMore = () => {
    const newLimit = limit + 4
    setLimit(newLimit)

    startTransition(async () => {
      const newMovies = await loadMoreMovies(newLimit, 0, selectedGenre, true)
      setMovies(newMovies)
    })
  }

  const handleGenreChange = (genre: string | undefined) => {
    setSelectedGenre(genre)
    setLimit(8)

    startTransition(async () => {
      const newMovies = await loadMoreMovies(8, 0, genre, true)
      setMovies(newMovies)
    })
  }

  return (
    <div className="mt-10 mb-10">
      <div className="text-center lg:flex lg:items-center lg:justify-between">
        <h1 className="text-4xl">{titleIsCinema}</h1>
        <div className="flex justify-center lg:justify-end">
          <FilterTabs items={navIsCinema} onChange={handleGenreChange} />
        </div>
      </div>
      <div className="mt-4 mb-4 grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3 justify-items-center">
        {movies?.map(movie => (
          <MovieCard
            key={movie.id}
            id={movie.id}
            rating_kinoarea={movie.rating_kinoarea}
            title={movie.title}
            genres={movie.genres}
            poster_url={movie.poster_url}
          />
        ))}
      </div>
      <BtnLoad handleLoadMore={handleLoadMore} isPending={isPending} />
    </div>
  )
}
