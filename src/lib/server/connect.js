import { sql } from "bun";

const connect = async () => {
  try {
    const current_time = await sql`SELECT NOW() AS current_time`
    console.log("Connected to database, current time: ", current_time[0].current_time);
  }
  catch (error) {
    console.error("Failed to connect to database:", error);
  }
}

connect();
