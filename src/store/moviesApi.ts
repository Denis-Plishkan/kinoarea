import { getMovies, getMoviesInCinema } from '@/services/movies'
import { Movie } from '@/types/movie'
import { fakeBaseQuery } from '@reduxjs/toolkit/query'
import { createApi } from '@reduxjs/toolkit/query/react'

export const moviesApi = createApi({
  reducerPath: 'moviesApi',
  baseQuery: fakeBaseQuery(),
  endpoints: builder => ({
    getMovies: builder.query<Movie[], void>({
      queryFn: async () => {
        const { data, error } = await getMovies()
        if (error) return { error }
        return { data: data ?? [] }
      },
    }),
    getMoviesInCinema: builder.query<Movie[], number>({
      queryFn: async limit => {
        const { data, error } = await getMoviesInCinema(limit)
        if (error) return { error }
        return { data: data ?? [] }
      },
    }),
  }),
})

export const { useGetMoviesQuery, useGetMoviesInCinemaQuery } = moviesApi
