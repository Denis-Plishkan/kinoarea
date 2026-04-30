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
      const newMovies = await loadMoreMovies(newLimit, selectedGenre)
      setMovies(newMovies)
    })
  }

  const handleGenreChange = (genre: string | undefined) => {
    setSelectedGenre(genre)
    setLimit(8)

    startTransition(async () => {
      const newMovies = await loadMoreMovies(8, genre)
      setMovies(newMovies)
    })
  }

  return (
    <div className='mt-10 mb-10'>
      <div className="flex items-center justify-between">
        <h1 className="text-4xl">{titleIsCinema}</h1>
        <FilterTabs items={navIsCinema} onChange={handleGenreChange} />
      </div>
      <div className="mt-4 mb-4 flex flex-wrap justify-center gap-3">
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
      <BtnLoad handleLoadMore={handleLoadMore} isPending={isPending}/>
    </div>
  )
}
