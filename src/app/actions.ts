'use server'

import { getMoviesInCinemaServer } from "@/services/movies.server"
import { getTrailersServer } from "@/services/trailers.server"

export async function loadMoreMovies(limit: number, genre?: string) {
    return getMoviesInCinemaServer(limit, genre)
}

export async function loadMoreTrailers(limit: number, trailer?: string) {
    return getTrailersServer(limit, trailer)
}