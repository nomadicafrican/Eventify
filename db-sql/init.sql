CREATE TABLE IF NOT EXISTS app_user (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    email_verified BOOLEAN NOT NULL,
    registered_2fa BOOLEAN NOT NULL
);

CREATE INDEX idx_app_user_email ON app_user(email);
CREATE INDEX idx_app_user_username ON app_user(username);

CREATE TABLE IF NOT EXISTS user_session (
    id TEXT NOT NULL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES app_user (id),
    ip_address INET NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX idx_user_session_user_id ON user_session(user_id);

CREATE TABLE IF NOT EXISTS venue (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip TEXT NOT NULL,
    phone TEXT NOT NULL,
    capacity INTEGER NOT NULL,
    website TEXT NOT NULL
);

CREATE INDEX idx_venue_name ON venue(name);
CREATE INDEX idx_venue_city ON venue(city);


CREATE TABLE IF NOT EXISTS event (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    max_attendees INTEGER NOT NULL,
    min_attendees INTEGER,
    event_date DATE NOT NULL,
    venue_id INTEGER NOT NULL REFERENCES venue (id)
);

CREATE INDEX idx_event_name ON event(name);
CREATE INDEX idx_event_event_date ON event(event_date);

CREATE TABLE IF NOT EXISTS tag (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE INDEX idx_tag_name ON tag(name);


CREATE TABLE IF NOT EXISTS event_to_tag (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES event (id),
    tag_id INTEGER NOT NULL REFERENCES tag (id)
);

CREATE INDEX idx_event_to_tag_event_id ON event_to_tag(event_id);
CREATE INDEX idx_event_to_tag_tag_id ON event_to_tag(tag_id);
CREATE TABLE IF NOT EXISTS booking (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES app_user (id),
    event_id INTEGER NOT NULL REFERENCES event (id),
    number_of_people INTEGER NOT NULL
);

CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_event_id ON booking(event_id);

CREATE TABLE IF NOT EXISTS schedule (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES event (id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL
);

CREATE INDEX idx_schedule_event_id ON schedule(event_id);
CREATE INDEX idx_schedule_start_time ON schedule(start_time);

INSERT INTO app_user (
    email,
    username,
    password_hash,
    email_verified,
    registered_2fa
)
VALUES (
    'test@example.com',
    'example',
    '$argon2id$v=19$m=65536,t=2,p=1$GtODAiMDbT1js8GQAGDxbV4euZPKFQtsB325LlDjm/E$Q2QEtpK7z5301y2wZnSBTeS576dZxx94eDKlshKb/X0',
    true,
    true
);

