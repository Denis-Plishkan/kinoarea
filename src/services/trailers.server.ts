import { createServerSupabaseClient } from '@/lib/supabase/server'
import { Trailer } from '@/types/trailers'

export async function getTrailersServer(
  limit: number,
  offset: number = 0,
): Promise<Trailer[]> {
  const supabase = await createServerSupabaseClient()

  const query = supabase
    .from('trailers')
    .select(
      `id, title, youtube_url)`
    )

  const { data, error } = await query
    .range(offset, offset + limit - 1)
    .overrideTypes<Trailer[], { merge: false }>()

  if (error) {
    console.error('Error fetching movies:', error)
    return []
  }

  return (
    data
  )
}