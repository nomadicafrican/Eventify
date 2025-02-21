CREATE TABLE IF NOT EXISTS app_user (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  username TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  email_verified BOOLEAN NOT NULL,
  registered_2fa BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS user_session (
  id TEXT NOT NULL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES app_user(id),
  expires_at TIMESTAMPTZ NOT NULL
);

INSERT INTO app_user (email, username, password_hash, email_verified, registered_2fa) 
VALUES ('test@example.com', 'example', '$argon2id$v=19$m=65536,t=2,p=1$GtODAiMDbT1js8GQAGDxbV4euZPKFQtsB325LlDjm/E$Q2QEtpK7z5301y2wZnSBTeS576dZxx94eDKlshKb/X0', true, true);
