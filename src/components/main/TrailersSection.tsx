'use client'

import { loadMoreTrailers } from '@/app/actions'
import { Trailer } from '@/types/trailers'
import { useEffect, useState, useTransition } from 'react'
import { TrailersSlider } from '@/components/ui'
import { titleIsTrailer } from '@/constants/titles'
import Link from 'next/link'

export const TrailersSection = () => {
  const [trailers, setTrailers] = useState<Trailer[]>([])
  const [offset, setOffset] = useState(0)
  const [isPending, startTransition] = useTransition()

  const limit = 10

  useEffect(() => {
    startTransition(async () => {
      const newTrailers = await loadMoreTrailers(limit, offset)
      setTrailers(newTrailers)
      setOffset(limit)
    })
  }, [])

  const handleLoadMore = () => {
    if (isPending) return
    startTransition(async () => {
      const newTrailers = await loadMoreTrailers(limit, offset)
      setTrailers(prev => [...prev, ...newTrailers])
      setOffset(prev => prev + limit)
    }) 
  }

  return (
    <>
      <div className="flex items-center justify-between">
        <h2 className="text-4xl">{titleIsTrailer}</h2>
        <Link
          className="flex cursor-pointer items-center gap-3 font-bold transition hover:text-blue-200"
          href={'/trailers/'}
        >
          Все трейлеры <span>&#8594;</span>
        </Link>
      </div>
      <div className="mt-10 mb-10 flex justify-center">
        <TrailersSlider trailers={trailers} onLoadMore={handleLoadMore}/>
      </div>
    </>
  )
}
