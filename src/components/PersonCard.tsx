import Image from 'next/image'

import { Person } from '@/types/person'
import Link from 'next/link'

export const PersonCard = ({
  name,
  original_name,
  photo_url,
  place,
  id,
}: Person) => {
  return (
    <Link href={`/person/${id}`}>
      <div className="relative h-111 w-111 hover:brightness-60 transition">
        <p>{place}</p>
        <Image
          src={photo_url}
          alt={name}
          fill
          objectFit="cover"
          className="object-cover brightness-75"
        />
        <h3 className="absolute bottom-16 left-4 text-2xl">{name}</h3>
        <h4 className="absolute bottom-10 left-4 text-white/60">
          {original_name}
        </h4>
      </div>
    </Link>
  )
}
