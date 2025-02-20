import { sql } from "bun";

// const db = new SQL("postgres://postgres:postgres@localhost:5436/eventify");

const connect = async () => {
  try {
    const current_time = await sql`SELECT NOW() AS current_time`
    console.log("Connected to database, current time: ", current_time[0].current_time);
  }
  catch (error) {
    console.error("Failed to connect to database:", error);
  }
}

await sql`
  CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    email_verified BOOLEAN NOT NULL,
    registered_2fa BOOLEAN NOT NULL
  )`;

await sql`
  CREATE TABLE IF NOT EXISTS user_session (
    id TEXT NOT NULL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    expires_at TIMESTAMPTZ NOT NULL
  )`;

connect();
// sql.flush();
// sql.close()
