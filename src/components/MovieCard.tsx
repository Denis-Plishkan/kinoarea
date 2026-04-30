import { Movie } from '@/types/movie'
import Image from 'next/image'
import Link from 'next/link'

export const MovieCard = ({
  title,
  poster_url,
  genres,
  rating_kinoarea,
  id,
}: Movie) => {
  return (
    <Link href={`/movies/${id}`} className="group block w-full max-w-80">
      <div className="relative aspect-[338/480] overflow-hidden">
        <Image
          className="rounded object-cover"
          src={poster_url ?? '/poster.png'}
          fill
          sizes="(max-width: 640px) 100vw, (max-width: 768px) 50vw, (max-width: 1024px) 33vw, 25vw"
          alt={title}
        />
        <p className="absolute top-2 right-2 h-6 w-10 rounded bg-green-500 text-center">
          {rating_kinoarea}
        </p>

        <div className="absolute inset-0 flex items-center justify-center bg-blue-400/65 opacity-0 transition-opacity group-hover:opacity-100">
          <span className="flex h-20 w-60 items-center justify-center rounded bg-white text-lg font-bold text-blue-500">
            Карточка фильма
          </span>
        </div>
      </div>

      <h3>{title}</h3>
      <p className="text-yellow-500">{genres?.map(g => g.name).join(', ')}</p>
    </Link>
  )
}
