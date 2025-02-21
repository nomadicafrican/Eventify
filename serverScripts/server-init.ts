import { sql } from "bun";
import { hashPassword } from "../src/lib/server/password";

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
  CREATE TABLE IF NOT EXISTS app_user (
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

await sql`
  INSERT INTO app_user (email, username, password_hash, email_verified, registered_2fa) ("test@example.com", "example", ${hashPassword("example")}, true, true);
`

connect();
// sql.flush();
// sql.close()
