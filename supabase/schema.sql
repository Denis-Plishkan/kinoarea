-- =============================================
-- KINOAREA DATABASE SCHEMA FOR SUPABASE
-- Based on Figma mockup analysis
-- =============================================

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================
-- ENUMS
-- =============================================

CREATE TYPE content_type AS ENUM ('movie', 'series', 'cartoon');
CREATE TYPE gender_type AS ENUM ('male', 'female', 'other');
CREATE TYPE person_role AS ENUM ('actor', 'director', 'writer', 'producer', 'composer', 'cinematographer', 'editor');
CREATE TYPE mpaa_rating AS ENUM ('G', 'PG', 'PG-13', 'R', 'NC-17');

-- =============================================
-- CORE TABLES
-- =============================================

-- Genres (жанры)
CREATE TABLE genres (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Countries (страны)
CREATE TABLE countries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(3) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Movies/Series/Cartoons (фильмы/сериалы/мультфильмы)
CREATE TABLE movies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(500) NOT NULL,
    original_title VARCHAR(500),
    slug VARCHAR(500) NOT NULL UNIQUE,
    type content_type DEFAULT 'movie',
    year INTEGER,
    release_date DATE,
    runtime_minutes INTEGER,
    description TEXT,
    tagline VARCHAR(500),

    -- Ratings
    rating_kinoarea DECIMAL(3,2) DEFAULT 0,
    rating_imdb DECIMAL(3,2) DEFAULT 0,
    votes_count INTEGER DEFAULT 0,

    -- Financial
    budget BIGINT,
    box_office_world BIGINT,
    box_office_usa BIGINT,
    box_office_russia BIGINT,

    -- Media (YouTube links for trailers, Supabase Storage for images)
    poster_url TEXT,
    backdrop_url TEXT,

    -- Metadata
    mpaa mpaa_rating,
    is_in_cinema BOOLEAN DEFAULT FALSE,
    is_expected BOOLEAN DEFAULT FALSE,
    premiere_russia DATE,
    premiere_world DATE,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Movie-Genre relation (many-to-many)
CREATE TABLE movie_genres (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    genre_id UUID REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genre_id)
);

-- Movie-Country relation (many-to-many)
CREATE TABLE movie_countries (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    country_id UUID REFERENCES countries(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, country_id)
);

-- Persons (актёры, режиссёры, и т.д.)
CREATE TABLE persons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(300) NOT NULL,
    original_name VARCHAR(300),
    slug VARCHAR(300) NOT NULL UNIQUE,

    photo_url TEXT,
    gender gender_type,
    birth_date DATE,
    death_date DATE,
    birth_place VARCHAR(300),

    height_cm INTEGER,
    biography TEXT,

    -- Career info
    career_start INTEGER,
    total_movies INTEGER DEFAULT 0,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Movie-Person relation (roles in movies)
CREATE TABLE movie_persons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES persons(id) ON DELETE CASCADE,
    role person_role NOT NULL,
    character_name VARCHAR(300), -- for actors
    billing_order INTEGER, -- order in credits
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Trailers (трейлеры с YouTube)
CREATE TABLE trailers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    title VARCHAR(300),
    youtube_url TEXT NOT NULL, -- YouTube video URL
    youtube_id VARCHAR(20), -- YouTube video ID for embedding
    thumbnail_url TEXT,
    duration_seconds INTEGER,
    is_main BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Movie Images (постеры, кадры)
CREATE TABLE movie_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    image_type VARCHAR(50) NOT NULL, -- 'poster', 'backdrop', 'still', 'behind_scenes'
    width INTEGER,
    height INTEGER,
    is_main BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Person Images (фото персон)
CREATE TABLE person_images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    person_id UUID REFERENCES persons(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    is_main BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Awards (награды)
CREATE TABLE awards (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(300) NOT NULL, -- "Оскар", "Золотой глобус"
    year INTEGER,
    category VARCHAR(300), -- "Лучший фильм", "Лучший актёр"
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    person_id UUID REFERENCES persons(id) ON DELETE SET NULL,
    is_winner BOOLEAN DEFAULT FALSE, -- winner or nominee
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Movie quotes (цитаты из фильма)
CREATE TABLE movie_quotes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    quote_text TEXT NOT NULL,
    character_name VARCHAR(200),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sequels/Prequels (сиквелы и приквелы)
CREATE TABLE movie_relations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    related_movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    relation_type VARCHAR(50) NOT NULL, -- 'sequel', 'prequel', 'spinoff', 'remake'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(movie_id, related_movie_id)
);

-- =============================================
-- USER SYSTEM
-- =============================================

-- User profiles (расширение auth.users от Supabase)
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    username VARCHAR(100) UNIQUE,
    display_name VARCHAR(200),
    avatar_url TEXT,
    bio TEXT,

    -- Location
    country VARCHAR(100),
    city VARCHAR(100),

    -- Social links
    social_vk TEXT,
    social_telegram TEXT,
    social_twitter TEXT,

    -- Settings
    is_public BOOLEAN DEFAULT TRUE,
    email_notifications BOOLEAN DEFAULT TRUE,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- User movie ratings (оценки фильмов)
CREATE TABLE user_ratings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating >= 1 AND rating <= 10),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, movie_id)
);

-- User reviews/recensions (рецензии)
CREATE TABLE reviews (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    title VARCHAR(300),
    content TEXT NOT NULL,
    is_positive BOOLEAN, -- positive/negative/neutral review
    likes_count INTEGER DEFAULT 0,
    dislikes_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Review votes (лайки/дизлайки рецензий)
CREATE TABLE review_votes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    review_id UUID REFERENCES reviews(id) ON DELETE CASCADE,
    is_like BOOLEAN NOT NULL, -- true = like, false = dislike
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, review_id)
);

-- User comments (комментарии к персонам, новостям и т.д.)
CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,

    -- Polymorphic relation
    entity_type VARCHAR(50) NOT NULL, -- 'person', 'news', 'collection'
    entity_id UUID NOT NULL,

    parent_id UUID REFERENCES comments(id) ON DELETE CASCADE, -- for nested comments
    content TEXT NOT NULL,
    likes_count INTEGER DEFAULT 0,

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- User friends (друзья)
CREATE TABLE friendships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    friend_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'accepted', 'blocked'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, friend_id)
);

-- User movie lists (списки фильмов - буду смотреть, просмотрено и т.д.)
CREATE TABLE user_lists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Movies in user lists
CREATE TABLE user_list_movies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    list_id UUID REFERENCES user_lists(id) ON DELETE CASCADE,
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    added_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(list_id, movie_id)
);

-- =============================================
-- NEWS SYSTEM
-- =============================================

-- News articles (новости)
CREATE TABLE news (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(500) NOT NULL,
    slug VARCHAR(500) NOT NULL UNIQUE,
    excerpt TEXT, -- short description
    content TEXT NOT NULL,
    cover_image_url TEXT,

    -- Author (can be admin or system)
    author_id UUID REFERENCES profiles(id) ON DELETE SET NULL,

    -- Stats
    views_count INTEGER DEFAULT 0,
    comments_count INTEGER DEFAULT 0,

    -- Related content
    related_movie_id UUID REFERENCES movies(id) ON DELETE SET NULL,
    related_person_id UUID REFERENCES persons(id) ON DELETE SET NULL,

    is_published BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- News tags
CREATE TABLE news_tags (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- News-Tag relation
CREATE TABLE news_tag_relations (
    news_id UUID REFERENCES news(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES news_tags(id) ON DELETE CASCADE,
    PRIMARY KEY (news_id, tag_id)
);

-- =============================================
-- COLLECTIONS SYSTEM (Подборки)
-- =============================================

-- Collections (подборки фильмов)
CREATE TABLE collections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title VARCHAR(300) NOT NULL,
    slug VARCHAR(300) NOT NULL UNIQUE,
    description TEXT,
    cover_image_url TEXT,

    -- Category: kinoarea, series, direction, critic, awards, years, genres
    category VARCHAR(50) NOT NULL,

    -- If based on year or genre
    year INTEGER,
    genre_id UUID REFERENCES genres(id) ON DELETE SET NULL,

    movies_count INTEGER DEFAULT 0,
    is_official BOOLEAN DEFAULT TRUE, -- official site collection vs user collection

    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Movies in collections
CREATE TABLE collection_movies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    collection_id UUID REFERENCES collections(id) ON DELETE CASCADE,
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    position INTEGER, -- order in collection
    added_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(collection_id, movie_id)
);

-- =============================================
-- BOX OFFICE DATA (Кассовые сборы)
-- =============================================

-- Weekly box office (еженедельные кассовые сборы)
CREATE TABLE box_office_weekly (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    week_start DATE NOT NULL,
    week_end DATE NOT NULL,
    rank INTEGER,
    weekend_gross BIGINT,
    total_gross BIGINT,
    theaters_count INTEGER,
    country VARCHAR(50) DEFAULT 'russia',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- EMAIL SUBSCRIPTIONS
-- =============================================

CREATE TABLE email_subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(300) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE,
    subscribed_at TIMESTAMPTZ DEFAULT NOW(),
    unsubscribed_at TIMESTAMPTZ
);

-- =============================================
-- CONTACT MESSAGES
-- =============================================

CREATE TABLE contact_messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(200) NOT NULL,
    email VARCHAR(300) NOT NULL,
    subject VARCHAR(300),
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- INDEXES FOR PERFORMANCE
-- =============================================

-- Movies indexes
CREATE INDEX idx_movies_year ON movies(year);
CREATE INDEX idx_movies_rating ON movies(rating_kinoarea DESC);
CREATE INDEX idx_movies_type ON movies(type);
CREATE INDEX idx_movies_is_in_cinema ON movies(is_in_cinema) WHERE is_in_cinema = TRUE;
CREATE INDEX idx_movies_is_expected ON movies(is_expected) WHERE is_expected = TRUE;
CREATE INDEX idx_movies_slug ON movies(slug);
CREATE INDEX idx_movies_created_at ON movies(created_at DESC);

-- Persons indexes
CREATE INDEX idx_persons_slug ON persons(slug);
CREATE INDEX idx_persons_name ON persons(name);

-- User ratings indexes
CREATE INDEX idx_user_ratings_movie ON user_ratings(movie_id);
CREATE INDEX idx_user_ratings_user ON user_ratings(user_id);

-- Reviews indexes
CREATE INDEX idx_reviews_movie ON reviews(movie_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);
CREATE INDEX idx_reviews_created ON reviews(created_at DESC);

-- News indexes
CREATE INDEX idx_news_published ON news(published_at DESC) WHERE is_published = TRUE;
CREATE INDEX idx_news_slug ON news(slug);

-- Collections indexes
CREATE INDEX idx_collections_category ON collections(category);
CREATE INDEX idx_collections_slug ON collections(slug);

-- Trailers indexes
CREATE INDEX idx_trailers_movie ON trailers(movie_id);

-- Comments indexes
CREATE INDEX idx_comments_entity ON comments(entity_type, entity_id);
CREATE INDEX idx_comments_user ON comments(user_id);

-- =============================================
-- FUNCTIONS AND TRIGGERS
-- =============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply updated_at trigger to relevant tables
CREATE TRIGGER update_movies_updated_at BEFORE UPDATE ON movies
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_persons_updated_at BEFORE UPDATE ON persons
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON reviews
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_news_updated_at BEFORE UPDATE ON news
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_collections_updated_at BEFORE UPDATE ON collections
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to update movie rating when user rates
CREATE OR REPLACE FUNCTION update_movie_rating()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE movies
    SET
        rating_kinoarea = (
            SELECT COALESCE(AVG(rating), 0)
            FROM user_ratings
            WHERE movie_id = COALESCE(NEW.movie_id, OLD.movie_id)
        ),
        votes_count = (
            SELECT COUNT(*)
            FROM user_ratings
            WHERE movie_id = COALESCE(NEW.movie_id, OLD.movie_id)
        )
    WHERE id = COALESCE(NEW.movie_id, OLD.movie_id);

    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_movie_rating_on_rate
    AFTER INSERT OR UPDATE OR DELETE ON user_ratings
    FOR EACH ROW EXECUTE FUNCTION update_movie_rating();

-- Function to create profile on user signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO profiles (id, username, display_name, avatar_url)
    VALUES (
        NEW.id,
        NEW.raw_user_meta_data->>'username',
        COALESCE(NEW.raw_user_meta_data->>'display_name', NEW.raw_user_meta_data->>'username'),
        NEW.raw_user_meta_data->>'avatar_url'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Function to update collection movies count
CREATE OR REPLACE FUNCTION update_collection_count()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE collections
    SET movies_count = (
        SELECT COUNT(*)
        FROM collection_movies
        WHERE collection_id = COALESCE(NEW.collection_id, OLD.collection_id)
    )
    WHERE id = COALESCE(NEW.collection_id, OLD.collection_id);

    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_collection_count_trigger
    AFTER INSERT OR DELETE ON collection_movies
    FOR EACH ROW EXECUTE FUNCTION update_collection_count();

-- =============================================
-- ROW LEVEL SECURITY (RLS)
-- =============================================

-- Enable RLS on all tables
ALTER TABLE movies ENABLE ROW LEVEL SECURITY;
ALTER TABLE persons ENABLE ROW LEVEL SECURITY;
ALTER TABLE genres ENABLE ROW LEVEL SECURITY;
ALTER TABLE countries ENABLE ROW LEVEL SECURITY;
ALTER TABLE trailers ENABLE ROW LEVEL SECURITY;
ALTER TABLE movie_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE person_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE awards ENABLE ROW LEVEL SECURITY;
ALTER TABLE movie_quotes ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE review_votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE friendships ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_lists ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_list_movies ENABLE ROW LEVEL SECURITY;
ALTER TABLE news ENABLE ROW LEVEL SECURITY;
ALTER TABLE collections ENABLE ROW LEVEL SECURITY;
ALTER TABLE collection_movies ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;

-- PUBLIC READ policies (anyone can read public content)
CREATE POLICY "Public movies are viewable by everyone" ON movies
    FOR SELECT USING (true);

CREATE POLICY "Public persons are viewable by everyone" ON persons
    FOR SELECT USING (true);

CREATE POLICY "Genres are viewable by everyone" ON genres
    FOR SELECT USING (true);

CREATE POLICY "Countries are viewable by everyone" ON countries
    FOR SELECT USING (true);

CREATE POLICY "Trailers are viewable by everyone" ON trailers
    FOR SELECT USING (true);

CREATE POLICY "Movie images are viewable by everyone" ON movie_images
    FOR SELECT USING (true);

CREATE POLICY "Person images are viewable by everyone" ON person_images
    FOR SELECT USING (true);

CREATE POLICY "Awards are viewable by everyone" ON awards
    FOR SELECT USING (true);

CREATE POLICY "Quotes are viewable by everyone" ON movie_quotes
    FOR SELECT USING (true);

CREATE POLICY "Published news is viewable by everyone" ON news
    FOR SELECT USING (is_published = true);

CREATE POLICY "Collections are viewable by everyone" ON collections
    FOR SELECT USING (true);

CREATE POLICY "Collection movies are viewable by everyone" ON collection_movies
    FOR SELECT USING (true);

CREATE POLICY "Reviews are viewable by everyone" ON reviews
    FOR SELECT USING (true);

-- PROFILE policies
CREATE POLICY "Public profiles are viewable by everyone" ON profiles
    FOR SELECT USING (is_public = true);

CREATE POLICY "Users can view their own profile" ON profiles
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON profiles
    FOR UPDATE USING (auth.uid() = id);

-- USER RATINGS policies
CREATE POLICY "Ratings are viewable by everyone" ON user_ratings
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can rate movies" ON user_ratings
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own ratings" ON user_ratings
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own ratings" ON user_ratings
    FOR DELETE USING (auth.uid() = user_id);

-- REVIEWS policies
CREATE POLICY "Authenticated users can create reviews" ON reviews
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own reviews" ON reviews
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own reviews" ON reviews
    FOR DELETE USING (auth.uid() = user_id);

-- COMMENTS policies
CREATE POLICY "Comments are viewable by everyone" ON comments
    FOR SELECT USING (true);

CREATE POLICY "Authenticated users can comment" ON comments
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own comments" ON comments
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own comments" ON comments
    FOR DELETE USING (auth.uid() = user_id);

-- USER LISTS policies
CREATE POLICY "Public lists are viewable by everyone" ON user_lists
    FOR SELECT USING (is_public = true OR auth.uid() = user_id);

CREATE POLICY "Users can create their own lists" ON user_lists
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own lists" ON user_lists
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own lists" ON user_lists
    FOR DELETE USING (auth.uid() = user_id);

-- USER LIST MOVIES policies
CREATE POLICY "List movies viewable if list is viewable" ON user_list_movies
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM user_lists
            WHERE id = user_list_movies.list_id
            AND (is_public = true OR user_id = auth.uid())
        )
    );

CREATE POLICY "Users can add movies to their lists" ON user_list_movies
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM user_lists
            WHERE id = user_list_movies.list_id
            AND user_id = auth.uid()
        )
    );

CREATE POLICY "Users can remove movies from their lists" ON user_list_movies
    FOR DELETE USING (
        EXISTS (
            SELECT 1 FROM user_lists
            WHERE id = user_list_movies.list_id
            AND user_id = auth.uid()
        )
    );

-- FRIENDSHIPS policies
CREATE POLICY "Users can view their friendships" ON friendships
    FOR SELECT USING (auth.uid() = user_id OR auth.uid() = friend_id);

CREATE POLICY "Users can send friend requests" ON friendships
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update friendships they're part of" ON friendships
    FOR UPDATE USING (auth.uid() = user_id OR auth.uid() = friend_id);

-- EMAIL SUBSCRIPTIONS policies
CREATE POLICY "Anyone can subscribe" ON email_subscriptions
    FOR INSERT WITH CHECK (true);

-- CONTACT MESSAGES policies
CREATE POLICY "Anyone can send contact message" ON contact_messages
    FOR INSERT WITH CHECK (true);

-- =============================================
-- INITIAL SEED DATA
-- =============================================

-- Insert common genres
INSERT INTO genres (name, slug) VALUES
    ('Боевик', 'action'),
    ('Комедия', 'comedy'),
    ('Драма', 'drama'),
    ('Фантастика', 'sci-fi'),
    ('Фэнтези', 'fantasy'),
    ('Ужасы', 'horror'),
    ('Триллер', 'thriller'),
    ('Детектив', 'detective'),
    ('Мелодрама', 'romance'),
    ('Приключения', 'adventure'),
    ('Анимация', 'animation'),
    ('Документальный', 'documentary'),
    ('Криминал', 'crime'),
    ('Биография', 'biography'),
    ('История', 'history'),
    ('Военный', 'war'),
    ('Семейный', 'family'),
    ('Музыка', 'music'),
    ('Спорт', 'sport'),
    ('Вестерн', 'western');

-- Insert common countries
INSERT INTO countries (name, code) VALUES
    ('США', 'USA'),
    ('Россия', 'RUS'),
    ('Великобритания', 'GBR'),
    ('Франция', 'FRA'),
    ('Германия', 'DEU'),
    ('Италия', 'ITA'),
    ('Испания', 'ESP'),
    ('Канада', 'CAN'),
    ('Австралия', 'AUS'),
    ('Япония', 'JPN'),
    ('Южная Корея', 'KOR'),
    ('Китай', 'CHN'),
    ('Индия', 'IND'),
    ('Мексика', 'MEX'),
    ('Бразилия', 'BRA');

-- Insert default collections
INSERT INTO collections (title, slug, description, category, is_official) VALUES
    ('ТОП 250 лучших фильмов', 'top-250', 'Лучшие фильмы всех времён по версии Kinoarea', 'kinoarea', true),
    ('Популярные фильмы и сериалы', 'popular', 'Самые популярные фильмы и сериалы', 'kinoarea', true),
    ('Ожидаемые фильмы', 'expected', 'Самые ожидаемые премьеры', 'kinoarea', true),
    ('Фильмы про акул', 'sharks', 'Фильмы про акул', 'direction', true),
    ('Фильмы про любовь', 'love', 'Романтические фильмы про любовь', 'direction', true),
    ('Фильмы про школу', 'school', 'Фильмы про школу и подростков', 'direction', true),
    ('Фильмы про вампиров', 'vampires', 'Фильмы про вампиров', 'direction', true),
    ('Фильмы про зомби', 'zombies', 'Фильмы про зомби', 'direction', true),
    ('Фильмы про войну', 'war-movies', 'Военные фильмы', 'direction', true),
    ('Комедийные боевики', 'comedy-action', 'Комедийные боевики', 'direction', true);
