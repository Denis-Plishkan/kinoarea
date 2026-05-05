import { getPersonServer } from '@/services/persons.server'
import { PersonCard } from '../PersonCard'
import { titlePopularPerson } from '@/constants/titles'
import { FilterTabs } from '../ui'

export const PopularPersonSection = async () => {
  const data = await getPersonServer()
  console.log(data)

  return (
    <div className="mt-10 mb-10">
      <div className="text-center lg:flex lg:items-center lg:justify-between">
        <h2 className="text-4xl">{titlePopularPerson}</h2>
        <div className="flex justify-center lg:justify-end">
          <FilterTabs />
        </div>
      </div>

      <div className='flex flex-wrap gap-4 justify-center mt-4 mb-4'>
        {data.map(el => (
          <PersonCard
            key={el.id}
            id={el.id}
            name={el.name}
            original_name={el.original_name}
            photo_url={el.photo_url}
            total_movies={el.total_movies}
          />
        ))}
      </div>
    </div>
  )
}
