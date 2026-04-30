'use client'

import { loadMoreMovies } from '@/app/actions'
import { Movie } from '@/types/movie'
import { useEffect, useState, useTransition, useMemo } from 'react'
import { FilterTabs } from '../ui'
import { titlePopularMovie } from '@/constants/titles'
import { navPopularMovie } from '@/constants/navigation'

import 'swiper/css'
import 'swiper/css/navigation'
import { PopularMovieSlider } from '../ui/PopularMovieSlider'

const ITEMS_PER_PAGE = 8

export const PopularMovieSection = () => {
  const [movies, setMovies] = useState<Movie[]>([])
  const [selectedYear, setSelectedYear] = useState<number | undefined>()
  const [hasMore, setHasMore] = useState(true)
  const [isPending, startTransition] = useTransition()

  const loadInitial = (year?: number) => {
    startTransition(async () => {
      const data = await loadMoreMovies(
        ITEMS_PER_PAGE,
        0,
        undefined,
        false,
        true,
        year
      )
      setMovies(data)
      setHasMore(data.length === ITEMS_PER_PAGE)
    })
  }

  const loadMore = () => {
    if (isPending || !hasMore) return
    startTransition(async () => {
      const data = await loadMoreMovies(
        ITEMS_PER_PAGE,
        movies.length,
        undefined,
        false,
        true,
        selectedYear
      )
      setMovies(prev => [...prev, ...data])
      setHasMore(data.length === ITEMS_PER_PAGE)
    })
  }

  useEffect(() => {
    loadInitial()
  }, [])

  const handleYearChange = (value: string | undefined) => {
    const year = value && !isNaN(+value) ? +value : undefined
    setSelectedYear(year)
    loadInitial(year)
  }

  const memoizedMovies = useMemo(() => movies, [movies])

  return (
    <div className="mt-10 mb-10">
      <div className="text-center lg:flex lg:items-center lg:justify-between">
        <h2 className="text-4xl">{titlePopularMovie}</h2>
        <div className="flex justify-center lg:justify-end">
          <FilterTabs items={navPopularMovie} onChange={handleYearChange} />
        </div>
      </div>

      <PopularMovieSlider memoizedMovies={memoizedMovies} loadMore={loadMore} />
    </div>
  )
}
