import { createServerSupabaseClient } from '@/lib/supabase/server'
import { Person } from '@/types/person'

export async function getPersonServer(): Promise<Person[]> {
  const supabase = await createServerSupabaseClient()

  const { data, error } = await supabase
    .from('persons')
    .select('id, name, original_name, photo_url, total_movies')
    .order('total_movies', { ascending: false })
    .limit(6)

  if (error) {
    console.error('Error fetching persons:', error)
    return []
  }

   return data.map((person, index) => ({
      ...person,
      place: index + 1
    }))

}
