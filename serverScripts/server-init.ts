import { sql } from "bun";
import { updateUserPassword } from "../src/lib/server/user";
const connect = async () => {
  try {
    sql.connect();
    const current_time = await sql`SELECT NOW() AS current_time`;
    console.log("Connected to database, current time: ", current_time[0].current_time);
    await updateUserPassword(1, "example")
    console.log("Updated password")
  }
  catch (error) {
    console.error("Failed to connect to database:", error);
  }
}



connect();
// sql.flush();
// sql.close()
