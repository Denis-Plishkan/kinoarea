'use client'

import { useState, useMemo } from 'react'
import Image from 'next/image'
import { Swiper, SwiperSlide } from 'swiper/react'
import { Trailer } from '@/types/trailers'
import styles from './TrailersSlider.module.css'

import 'swiper/css'

interface TrailersSliderProps {
  trailers: Trailer[]
  onLoadMore?: () => void
}

function getYoutubeId(url: string | null | undefined): string | null {
  if (!url) return null

  const patterns = [
    /(?:youtube\.com\/(?:watch\?.*v=|embed\/|v\/|shorts\/)|youtu\.be\/)([a-zA-Z0-9_-]{11})/,
    /^([a-zA-Z0-9_-]{11})$/
  ]

  for (const pattern of patterns) {
    const match = url.match(pattern)
    if (match) return match[1]
  }

  return null
}

export const TrailersSlider = ({ trailers, onLoadMore }: TrailersSliderProps) => {
  const [activeId, setActiveId] = useState<string | null>(null)
  const [isPlaying, setIsPlaying] = useState(false)
  const [badImages, setBadImages] = useState<Set<string>>(new Set())

  const handleImageError = (id: string) => {
    setBadImages(prev => new Set(prev).add(id))
  }

  const filteredTrailers = useMemo(() =>
    trailers.filter(trailer => {
      const id = getYoutubeId(trailer.youtube_url)
      return id && !badImages.has(id)
    }),
    [trailers, badImages]
  )

  const activeTrailer = useMemo(() =>
    filteredTrailers.find(t => t.id === activeId) || filteredTrailers[0],
    [filteredTrailers, activeId]
  )

  const videoId = useMemo(() =>
    activeTrailer ? getYoutubeId(activeTrailer.youtube_url) : null,
    [activeTrailer]
  )

  if (filteredTrailers.length === 0) {
    return null
  }

  const handlePlay = () => {
    setIsPlaying(true)
  }

  const handleThumbClick = (trailerId: string) => {
    setActiveId(trailerId)
    setIsPlaying(false)
  }

  return (
    <div className={styles.slider}>
      <div className={styles.main}>
        {isPlaying && videoId ? (
          <iframe
            src={`https://www.youtube.com/embed/${videoId}?autoplay=1`}
            allow="autoplay; encrypted-media"
            allowFullScreen
            className={styles.iframe}
          />
        ) : (
          <div className={styles.preview} onClick={handlePlay} key={videoId}>
            {videoId && (
              <>
                <Image
                  src={`https://img.youtube.com/vi/${videoId}/maxresdefault.jpg`}
                  alt={activeTrailer?.title || ''}
                  fill
                  className={styles.image}
                  onError={() => handleImageError(videoId)}
                />
                <button className={styles.playBtn} aria-label="Play">
                  <svg viewBox="0 0 68 48" width="68" height="48">
                    <path
                      d="M66.52 7.74c-.78-2.93-2.49-5.41-5.42-6.19C55.79.13 34 0 34 0S12.21.13 6.9 1.55c-2.93.78-4.63 3.26-5.42 6.19C.06 13.05 0 24 0 24s.06 10.95 1.48 16.26c.78 2.93 2.49 5.41 5.42 6.19C12.21 47.87 34 48 34 48s21.79-.13 27.1-1.55c2.93-.78 4.64-3.26 5.42-6.19C67.94 34.95 68 24 68 24s-.06-10.95-1.48-16.26z"
                      fill="red"
                    />
                    <path d="M45 24L27 14v20" fill="white" />
                  </svg>
                </button>
              </>
            )}
          </div>
        )}
      </div>

      <p className='lg:text-3xl font-bold mb-10'>{activeTrailer?.title}</p>

      <Swiper
        spaceBetween={10}
        slidesPerView={2}
        onReachEnd={onLoadMore}
        breakpoints={{
          768: { slidesPerView: 3 },
          1024: { slidesPerView: 4 }
        }}
        className={styles.thumbs}
      >
        {filteredTrailers.map((trailer) => {
          const thumbId = getYoutubeId(trailer.youtube_url)!
          return (
            <SwiperSlide
              key={trailer.id}
              className={trailer.id === activeTrailer?.id ? 'active' : ''}
              onClick={() => handleThumbClick(trailer.id)}
            >
              <Image
                src={`https://img.youtube.com/vi/${thumbId}/mqdefault.jpg`}
                alt={trailer.title}
                width={320}
                height={180}
                onError={() => handleImageError(thumbId)}
              />
              <p className='text-xs'>{trailer.title}</p>
            </SwiperSlide>
          )
        })}
      </Swiper>
    </div>
  )
}
