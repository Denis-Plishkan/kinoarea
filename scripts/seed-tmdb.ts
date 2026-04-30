/**
 * TMDB to Supabase Seed Script
 * Загружает фильмы, актёров, трейлеры из TMDB в Supabase
 *
 * Запуск: npx tsx scripts/seed-tmdb.ts
 */

import { config } from 'dotenv';
import { createClient } from '@supabase/supabase-js';

// Загружаем .env.local
config({ path: '.env.local' });

// ============================================
// CONFIGURATION
// ============================================

const TMDB_API_TOKEN = process.env.TMDB_API_TOKEN!;
const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY!;

const TMDB_BASE_URL = 'https://api.themoviedb.org/3';
const TMDB_IMAGE_BASE = 'https://image.tmdb.org/t/p';

// Сколько страниц загружать (20 фильмов на страницу)
// 30 страниц × 4 категории ≈ 2400 фильмов
const PAGES_TO_FETCH = 30;

// ============================================
// SETUP
// ============================================

if (!TMDB_API_TOKEN || !SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error('❌ Отсутствуют переменные окружения!');
  console.error('Создай .env.local с:');
  console.error('  NEXT_PUBLIC_SUPABASE_URL=...');
  console.error('  SUPABASE_SERVICE_ROLE_KEY=...');
  console.error('  TMDB_API_TOKEN=...');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

const tmdbHeaders = {
  'Authorization': `Bearer ${TMDB_API_TOKEN}`,
  'Content-Type': 'application/json',
};

// ============================================
// TMDB API FUNCTIONS
// ============================================

async function tmdbFetch<T>(endpoint: string, params: Record<string, string> = {}): Promise<T> {
  const url = new URL(`${TMDB_BASE_URL}${endpoint}`);
  url.searchParams.set('language', 'ru-RU');
  Object.entries(params).forEach(([k, v]) => url.searchParams.set(k, v));

  const response = await fetch(url.toString(), { headers: tmdbHeaders });

  if (!response.ok) {
    throw new Error(`TMDB API error: ${response.status} ${response.statusText}`);
  }

  return response.json();
}

async function getPopularMovies(page: number) {
  return tmdbFetch<TMDBMovieList>('/movie/popular', { page: String(page) });
}

async function getTopRatedMovies(page: number) {
  return tmdbFetch<TMDBMovieList>('/movie/top_rated', { page: String(page) });
}

async function getNowPlayingMovies(page: number) {
  return tmdbFetch<TMDBMovieList>('/movie/now_playing', { page: String(page) });
}

async function getUpcomingMovies(page: number) {
  return tmdbFetch<TMDBMovieList>('/movie/upcoming', { page: String(page) });
}

async function getMoviesByYear(year: number, page: number) {
  return tmdbFetch<TMDBMovieList>('/discover/movie', {
    page: String(page),
    primary_release_year: String(year),
    sort_by: 'popularity.desc',
  });
}

async function getMovieDetails(movieId: number) {
  return tmdbFetch<TMDBMovieDetails>(`/movie/${movieId}`, {});
}

async function getMovieCredits(movieId: number) {
  return tmdbFetch<TMDBCredits>(`/movie/${movieId}/credits`, {});
}

async function getMovieVideos(movieId: number) {
  return tmdbFetch<TMDBVideos>(`/movie/${movieId}/videos`, {});
}

async function getPersonDetails(personId: number) {
  return tmdbFetch<TMDBPerson>(`/person/${personId}`, {});
}

// ============================================
// TYPES
// ============================================

interface TMDBMovieList {
  page: number;
  results: TMDBMovieBasic[];
  total_pages: number;
  total_results: number;
}

interface TMDBMovieBasic {
  id: number;
  title: string;
  original_title: string;
  overview: string;
  poster_path: string | null;
  backdrop_path: string | null;
  release_date: string;
  vote_average: number;
  vote_count: number;
  genre_ids: number[];
  adult: boolean;
}

interface TMDBMovieDetails {
  id: number;
  title: string;
  original_title: string;
  overview: string;
  poster_path: string | null;
  backdrop_path: string | null;
  release_date: string;
  runtime: number;
  vote_average: number;
  vote_count: number;
  budget: number;
  revenue: number;
  tagline: string;
  genres: { id: number; name: string }[];
  production_countries: { iso_3166_1: string; name: string }[];
  status: string;
}

interface TMDBCredits {
  id: number;
  cast: TMDBCastMember[];
  crew: TMDBCrewMember[];
}

interface TMDBCastMember {
  id: number;
  name: string;
  original_name: string;
  character: string;
  profile_path: string | null;
  order: number;
  gender: number;
}

interface TMDBCrewMember {
  id: number;
  name: string;
  original_name: string;
  job: string;
  department: string;
  profile_path: string | null;
  gender: number;
}

interface TMDBVideos {
  id: number;
  results: TMDBVideo[];
}

interface TMDBVideo {
  id: string;
  key: string;
  name: string;
  site: string;
  type: string;
  official: boolean;
}

interface TMDBPerson {
  id: number;
  name: string;
  also_known_as: string[];
  biography: string;
  birthday: string | null;
  deathday: string | null;
  gender: number;
  place_of_birth: string | null;
  profile_path: string | null;
}

// ============================================
// GENRE MAPPING (TMDB ID -> our slug)
// ============================================

const GENRE_MAP: Record<number, string> = {
  28: 'action',      // Action -> Боевик
  12: 'adventure',   // Adventure -> Приключения
  16: 'animation',   // Animation -> Анимация
  35: 'comedy',      // Comedy -> Комедия
  80: 'crime',       // Crime -> Криминал
  99: 'documentary', // Documentary
  18: 'drama',       // Drama -> Драма
  10751: 'family',   // Family -> Семейный
  14: 'fantasy',     // Fantasy -> Фэнтези
  36: 'history',     // History -> История
  27: 'horror',      // Horror -> Ужасы
  10402: 'music',    // Music -> Музыка
  9648: 'detective', // Mystery -> Детектив
  10749: 'romance',  // Romance -> Мелодрама
  878: 'sci-fi',     // Science Fiction -> Фантастика
  53: 'thriller',    // Thriller -> Триллер
  10752: 'war',      // War -> Военный
  37: 'western',     // Western -> Вестерн
};

// ============================================
// HELPER FUNCTIONS
// ============================================

function slugify(text: string): string {
  // Транслитерация кириллицы
  const cyrillicMap: Record<string, string> = {
    'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'yo', 'ж': 'zh',
    'з': 'z', 'и': 'i', 'й': 'y', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n', 'о': 'o',
    'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'h', 'ц': 'ts',
    'ч': 'ch', 'ш': 'sh', 'щ': 'sch', 'ъ': '', 'ы': 'y', 'ь': '', 'э': 'e', 'ю': 'yu', 'я': 'ya',
  };

  let result = text.toLowerCase();

  // Заменяем кириллицу
  result = result.split('').map(char => cyrillicMap[char] || char).join('');

  // Убираем всё кроме латиницы, цифр, пробелов и дефисов
  result = result
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
    .trim();

  // Если slug пустой, генерируем случайный
  if (!result) {
    result = 'movie-' + Math.random().toString(36).substring(2, 10);
  }

  return result;
}

function delay(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// ============================================
// DATABASE OPERATIONS
// ============================================

const genreCache = new Map<string, string>();
const countryCache = new Map<string, string>();
const personCache = new Map<number, string>();
const movieCache = new Set<number>();

async function loadCaches() {
  console.log('📦 Загрузка кэшей...');

  // Genres
  const { data: genres } = await supabase.from('genres').select('id, slug');
  genres?.forEach(g => genreCache.set(g.slug, g.id));

  // Countries
  const { data: countries } = await supabase.from('countries').select('id, code');
  countries?.forEach(c => countryCache.set(c.code, c.id));

  console.log(`   Жанров: ${genreCache.size}, Стран: ${countryCache.size}`);
}

async function upsertPerson(tmdbId: number, name: string, originalName: string, photoPath: string | null, gender: number): Promise<string | null> {
  if (personCache.has(tmdbId)) {
    return personCache.get(tmdbId)!;
  }

  const slug = slugify(originalName || name) + '-' + tmdbId;
  const photoUrl = photoPath ? `${TMDB_IMAGE_BASE}/w500${photoPath}` : null;
  const genderType = gender === 1 ? 'female' : gender === 2 ? 'male' : 'other';

  const { data, error } = await supabase
    .from('persons')
    .upsert({
      name,
      original_name: originalName,
      slug,
      photo_url: photoUrl,
      gender: genderType,
    }, { onConflict: 'slug' })
    .select('id')
    .single();

  if (error) {
    // Try with different slug
    const altSlug = slug + '-' + Date.now();
    const { data: data2 } = await supabase
      .from('persons')
      .upsert({
        name,
        original_name: originalName,
        slug: altSlug,
        photo_url: photoUrl,
        gender: genderType,
      }, { onConflict: 'slug' })
      .select('id')
      .single();

    if (data2) {
      personCache.set(tmdbId, data2.id);
      return data2.id;
    }
    return null;
  }

  personCache.set(tmdbId, data.id);
  return data.id;
}

async function processMovie(tmdbMovie: TMDBMovieBasic, index: number, total: number) {
  if (movieCache.has(tmdbMovie.id)) {
    return;
  }
  movieCache.add(tmdbMovie.id);

  try {
    // Get full details
    const [details, credits, videos] = await Promise.all([
      getMovieDetails(tmdbMovie.id),
      getMovieCredits(tmdbMovie.id),
      getMovieVideos(tmdbMovie.id),
    ]);

    const year = details.release_date ? parseInt(details.release_date.split('-')[0]) : null;

    // Используем TMDB ID в slug для уникальности и избежания проблем с символами
    const baseSlug = slugify(details.original_title || details.title || 'movie');
    const slug = baseSlug ? `${baseSlug}-${tmdbMovie.id}` : `movie-${tmdbMovie.id}`;

    // Проверяем существует ли уже фильм
    const { data: existing } = await supabase
      .from('movies')
      .select('id')
      .eq('slug', slug)
      .single();

    let movieId: string;

    if (existing) {
      movieId = existing.id;
    } else {
      // Insert movie
      const { data: movie, error: movieError } = await supabase
        .from('movies')
        .insert({
          title: details.title || 'Unknown',
          original_title: details.original_title || null,
          slug,
          type: 'movie',
          year,
          release_date: details.release_date || null,
          runtime_minutes: details.runtime || null,
          description: details.overview || null,
          tagline: details.tagline || null,
          rating_imdb: details.vote_average || 0,
          rating_kinoarea: Math.round((details.vote_average + Math.random() * 0.5) * 10) / 10,
          votes_count: details.vote_count || 0,
          budget: details.budget || null,
          box_office_world: details.revenue || null,
          poster_url: details.poster_path ? `${TMDB_IMAGE_BASE}/w500${details.poster_path}` : null,
          backdrop_url: details.backdrop_path ? `${TMDB_IMAGE_BASE}/original${details.backdrop_path}` : null,
          is_in_cinema: details.status === 'Released' && year === new Date().getFullYear(),
          is_expected: details.status === 'Upcoming' || (details.release_date && new Date(details.release_date) > new Date()),
        })
        .select('id')
        .single();

      if (movieError || !movie) {
        // Тихо пропускаем дубликаты
        if (movieError?.code === '23505') {
          return;
        }
        console.error(`   ❌ ${details.title}: ${movieError?.message}`);
        return;
      }
      movieId = movie.id;
    }

    // Link genres
    for (const genre of details.genres) {
      const genreSlug = GENRE_MAP[genre.id];
      if (genreSlug && genreCache.has(genreSlug)) {
        await supabase
          .from('movie_genres')
          .upsert({ movie_id: movieId, genre_id: genreCache.get(genreSlug) }, { onConflict: 'movie_id,genre_id' });
      }
    }

    // Link countries
    for (const country of details.production_countries) {
      if (countryCache.has(country.iso_3166_1)) {
        await supabase
          .from('movie_countries')
          .upsert({ movie_id: movieId, country_id: countryCache.get(country.iso_3166_1) }, { onConflict: 'movie_id,country_id' });
      }
    }

    // Add cast (top 10)
    const topCast = credits.cast.slice(0, 10);
    for (const actor of topCast) {
      try {
        const personId = await upsertPerson(actor.id, actor.name, actor.original_name, actor.profile_path, actor.gender);
        if (personId) {
          await supabase
            .from('movie_persons')
            .upsert({
              movie_id: movieId,
              person_id: personId,
              role: 'actor',
              character_name: actor.character || null,
              billing_order: actor.order,
            }, { onConflict: 'movie_id,person_id,role' });
        }
      } catch {
        // Игнорируем ошибки
      }
    }

    // Add directors
    const directors = credits.crew.filter(c => c.job === 'Director');
    for (const director of directors) {
      try {
        const personId = await upsertPerson(director.id, director.name, director.original_name, director.profile_path, director.gender);
        if (personId) {
          await supabase
            .from('movie_persons')
            .upsert({
              movie_id: movieId,
              person_id: personId,
              role: 'director',
              billing_order: 1,
            }, { onConflict: 'movie_id,person_id,role' });
        }
      } catch {
        // Игнорируем ошибки
      }
    }

    // Add YouTube trailers
    const youtubeTrailers = videos.results.filter(v => v.site === 'YouTube' && (v.type === 'Trailer' || v.type === 'Teaser'));
    for (let i = 0; i < Math.min(youtubeTrailers.length, 3); i++) {
      const trailer = youtubeTrailers[i];
      try {
        await supabase
          .from('trailers')
          .upsert({
            movie_id: movieId,
            title: trailer.name || 'Trailer',
            youtube_url: `https://www.youtube.com/watch?v=${trailer.key}`,
            youtube_id: trailer.key,
            is_main: i === 0,
          }, { onConflict: 'movie_id,youtube_id' });
      } catch {
        // Игнорируем ошибки
      }
    }

    console.log(`   ✅ [${index + 1}/${total}] ${details.title} (${year})`);

  } catch (error) {
    console.error(`   ❌ Ошибка обработки ${tmdbMovie.title}:`, error);
  }
}

// ============================================
// NEWS GENERATOR
// ============================================

async function generateNews() {
  console.log('\n📰 Генерация новостей...');

  const { data: movies } = await supabase
    .from('movies')
    .select('id, title, year, release_date, poster_url, backdrop_url')
    .order('rating_kinoarea', { ascending: false })
    .limit(200);

  if (!movies || movies.length === 0) {
    console.log('   Нет фильмов для новостей');
    return;
  }

  const newsTitles = [
    'вышел на первое место в прокате',
    'побил рекорды кассовых сборов',
    'получил восторженные отзывы критиков',
    'стал самым обсуждаемым фильмом недели',
    'претендует на главные награды сезона',
    'установил новый рекорд просмотров',
    'вызвал бурную дискуссию в соцсетях',
    'получит продолжение',
    'анонсировал режиссёрскую версию',
    'выйдет на стриминговых платформах',
    'номинирован на Оскар',
    'получил награду на кинофестивале',
    'обогнал конкурентов в прокате',
    'стал хитом проката выходных',
    'превзошёл ожидания критиков',
    'собрал $100 млн за первую неделю',
    'стал самым кассовым фильмом года',
    'получил рейтинг 100% на Rotten Tomatoes',
    'анонсировал спин-офф',
    'подтвердил участие звёздного актёра',
    'завершил съёмки',
    'начал производство',
    'представил первый тизер',
    'раскрыл детали сюжета',
    'объявил дату премьеры',
    'перенёс дату выхода',
    'выпустил финальный трейлер',
    'показали эксклюзивные кадры',
    'режиссёр рассказал о создании',
    'актёры поделились впечатлениями',
  ];

  const newsItems = [];
  for (let i = 0; i < Math.min(200, movies.length); i++) {
    const movie = movies[i];
    const titleTemplate = newsTitles[i % newsTitles.length];
    const title = `«${movie.title}» ${titleTemplate}`;
    // Используем movie.id для детерминированного slug (не Date.now())
    const slug = `news-${movie.id}-${i}`;

    // Дата публикации новости: около даты выхода фильма (±30 дней)
    let publishedAt: string;
    if (movie.release_date) {
      const releaseDate = new Date(movie.release_date);
      const offsetDays = Math.floor(Math.random() * 60) - 30; // от -30 до +30 дней
      releaseDate.setDate(releaseDate.getDate() + offsetDays);
      publishedAt = releaseDate.toISOString();
    } else {
      // Если нет даты выхода, используем 1 января года фильма
      publishedAt = new Date(`${movie.year || 2020}-01-01`).toISOString();
    }

    newsItems.push({
      title,
      slug,
      excerpt: `Фильм «${movie.title}» (${movie.year}) продолжает радовать зрителей и критиков.`,
      content: `Фильм «${movie.title}» (${movie.year}) ${titleTemplate}. Зрители и критики высоко оценивают картину. Картина уже собрала множество положительных отзывов от зрителей по всему миру. Подробности в нашем материале.`,
      cover_image_url: movie.backdrop_url || movie.poster_url,
      views_count: Math.floor(Math.random() * 50000) + 1000,
      is_published: true,
      published_at: publishedAt,
      related_movie_id: movie.id,
    });
  }

  const { error } = await supabase.from('news').upsert(newsItems, { onConflict: 'slug' });
  if (error) {
    console.error('   ❌ Ошибка новостей:', error.message);
  } else {
    console.log(`   ✅ Создано/обновлено ${newsItems.length} новостей`);
  }
}

// ============================================
// MAIN
// ============================================

async function main() {
  console.log('🎬 TMDB → Supabase Seed Script');
  console.log('================================\n');

  await loadCaches();

  // Collect movies from different endpoints
  const allMovies: TMDBMovieBasic[] = [];
  const seenIds = new Set<number>();

  const endpoints = [
    { name: 'Популярные', fn: getPopularMovies },
    { name: 'Топ рейтинга', fn: getTopRatedMovies },
    { name: 'Сейчас в кино', fn: getNowPlayingMovies },
    { name: 'Скоро', fn: getUpcomingMovies },
  ];

  for (const endpoint of endpoints) {
    console.log(`\n📥 Загрузка: ${endpoint.name}...`);

    for (let page = 1; page <= PAGES_TO_FETCH; page++) {
      try {
        const data = await endpoint.fn(page);

        for (const movie of data.results) {
          if (!seenIds.has(movie.id) && !movie.adult) {
            seenIds.add(movie.id);
            allMovies.push(movie);
          }
        }

        process.stdout.write(`   Страница ${page}/${PAGES_TO_FETCH} (всего: ${allMovies.length})\r`);

        // Rate limiting
        await delay(100);

        if (page >= data.total_pages) break;
      } catch (error) {
        console.error(`\n   Ошибка на странице ${page}:`, error);
        break;
      }
    }
    console.log();
  }

  // Загрузка фильмов по годам (1980-2026)
  console.log('\n📅 Загрузка фильмов по годам (1980-2026)...');

  for (let year = 2026; year >= 1980; year--) {
    console.log(`\n   📆 ${year} год...`);

    const pagesPerYear = 3; // 3 страницы на год ≈ 60 фильмов за год

    for (let page = 1; page <= pagesPerYear; page++) {
      try {
        const data = await getMoviesByYear(year, page);

        for (const movie of data.results) {
          if (!seenIds.has(movie.id) && !movie.adult) {
            seenIds.add(movie.id);
            allMovies.push(movie);
          }
        }

        process.stdout.write(`      Страница ${page}/${pagesPerYear} (всего: ${allMovies.length})\r`);

        // Rate limiting
        await delay(100);

        if (page >= data.total_pages) break;
      } catch (error) {
        console.error(`\n      Ошибка на странице ${page}:`, error);
        break;
      }
    }
  }
  console.log();

  console.log(`\n📊 Собрано ${allMovies.length} уникальных фильмов`);
  console.log('\n🎬 Обработка фильмов...\n');

  // Process movies
  for (let i = 0; i < allMovies.length; i++) {
    await processMovie(allMovies[i], i, allMovies.length);

    // Rate limiting - TMDB allows 40 requests per 10 seconds
    if (i % 10 === 0) {
      await delay(300);
    }
  }

  // Generate news
  await generateNews();

  // Update collection counts
  console.log('\n📚 Обновление подборок...');

  // Add top movies to TOP-250
  const { data: topMovies } = await supabase
    .from('movies')
    .select('id')
    .order('rating_kinoarea', { ascending: false })
    .limit(250);

  const { data: topCollection } = await supabase
    .from('collections')
    .select('id')
    .eq('slug', 'top-250')
    .single();

  if (topCollection && topMovies) {
    const items = topMovies.map((m, i) => ({
      collection_id: topCollection.id,
      movie_id: m.id,
      position: i + 1,
    }));
    await supabase.from('collection_movies').upsert(items, { onConflict: 'collection_id,movie_id' });
    console.log(`   ✅ ТОП-250: ${topMovies.length} фильмов`);
  }

  // Add popular movies
  const { data: popularMovies } = await supabase
    .from('movies')
    .select('id')
    .order('votes_count', { ascending: false })
    .limit(100);

  const { data: popularCollection } = await supabase
    .from('collections')
    .select('id')
    .eq('slug', 'popular')
    .single();

  if (popularCollection && popularMovies) {
    const items = popularMovies.map((m, i) => ({
      collection_id: popularCollection.id,
      movie_id: m.id,
      position: i + 1,
    }));
    await supabase.from('collection_movies').upsert(items, { onConflict: 'collection_id,movie_id' });
    console.log(`   ✅ Популярные: ${popularMovies.length} фильмов`);
  }

  console.log('\n✅ Готово!');

  // Stats
  const { count: moviesCount } = await supabase.from('movies').select('*', { count: 'exact', head: true });
  const { count: personsCount } = await supabase.from('persons').select('*', { count: 'exact', head: true });
  const { count: trailersCount } = await supabase.from('trailers').select('*', { count: 'exact', head: true });
  const { count: newsCount } = await supabase.from('news').select('*', { count: 'exact', head: true });

  console.log('\n📊 Статистика базы:');
  console.log(`   Фильмов: ${moviesCount}`);
  console.log(`   Персон: ${personsCount}`);
  console.log(`   Трейлеров: ${trailersCount}`);
  console.log(`   Новостей: ${newsCount}`);
}

main().catch(console.error);
