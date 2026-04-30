'use server'

import { getMoviesServer, getMoviesCount } from '@/services/movies.server'
import { getTrailersServer } from '@/services/trailers.server'

export async function fetchMoviesCount(year?: number) {
  return getMoviesCount(year)
}

export async function loadMoreMovies(
  limit: number,
  offset: number = 0,
  genre?: string,
  inCinemaOnly?: boolean,
  orderByRating?: boolean,
  year?: number
) {
  return getMoviesServer(limit, offset, genre, inCinemaOnly, orderByRating, year)
}

export async function loadMoreTrailers(limit: number, offset: number) {
  return getTrailersServer(limit, offset)
}
