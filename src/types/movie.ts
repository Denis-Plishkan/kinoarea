export interface Genre {
  id: string
  name: string
}

export interface MovieRaw {
  id: string
  title: string
  rating_kinoarea: number
  poster_url: string | null
  movie_genres: { genres: Genre }[]
}

export interface Movie {
  rating_kinoarea: number
  title: string
  id: string
  poster_url: string | null
  genres: Genre[]
}
