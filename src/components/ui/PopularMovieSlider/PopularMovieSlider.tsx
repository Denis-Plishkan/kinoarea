import { Swiper, SwiperSlide } from 'swiper/react'
import { Navigation, Autoplay } from 'swiper/modules'
import { MovieCard } from '@/components/MovieCard'
import { Movie } from '@/types/movie'

interface Props {
  memoizedMovies: Movie[]
  loadMore: () => void
}

export const PopularMovieSlider = ({ loadMore, memoizedMovies }: Props) => {
  return (
    <div className="relative mt-4 mb-4">
      <Swiper
        modules={[Navigation, Autoplay]}
        slidesPerView={1}
        slidesPerGroup={1}
        spaceBetween={12}
        navigation
        autoplay={{
          delay: 2000,
          disableOnInteraction: false,
          pauseOnMouseEnter: true,
        }}
        speed={2000}
        onReachEnd={loadMore}
        breakpoints={{
          640: { slidesPerView: 2, slidesPerGroup: 2 },
          768: { slidesPerView: 3, slidesPerGroup: 3 },
          1024: { slidesPerView: 4, slidesPerGroup: 4 },
        }}
      >
        {memoizedMovies.map(movie => (
          <SwiperSlide key={movie.id}>
            <MovieCard
              id={movie.id}
              rating_kinoarea={movie.rating_kinoarea}
              title={movie.title}
              genres={movie.genres}
              poster_url={movie.poster_url}
            />
          </SwiperSlide>
        ))}
      </Swiper>
    </div>
  )
}
