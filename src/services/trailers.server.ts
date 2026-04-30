import { createServerSupabaseClient } from '@/lib/supabase/server'
import { Trailer } from '@/types/trailers'

export async function getTrailersServer(
  limit: number,
): Promise<Trailer[]> {
  const supabase = await createServerSupabaseClient()

  const query = supabase
    .from('trailers')
    .select(
      `id, title, youtube_url)`
    )

  const { data, error } = await query
    .limit(limit)
    .overrideTypes<Trailer[], { merge: false }>()

  if (error) {
    console.error('Error fetching movies:', error)
    return []
  }

  return (
    data
  )
}