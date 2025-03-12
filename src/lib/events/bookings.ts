import { sql } from "bun";


// CREATE TABLE IF NOT EXISTS booking (
//     id SERIAL PRIMARY KEY,
//     user_id INTEGER NOT NULL REFERENCES app_user (id),
//     event_id INTEGER NOT NULL REFERENCES event (id),
//     number_of_people INTEGER NOT NULL
// );

export type Booking = {
  id: number,
  userId: number,
  eventId: number,
  numberOfPeople: number,
}

export type Tag = {
  id: number,
  name: string,
}

export const getBookingsByEventId = async (id: number): Promise<Booking[]> => {
  const bookingsResult = await sql`
    SELECT * FROM booking WHERE event_id = ${id}
  `;

  let bookingsList: Booking[] = [];

  for (let i = 0; i < bookingsResult.length; i++) {
    const singleBookingResult: Booking = {
      id: bookingsResult[i].id,
      userId: bookingsResult[i].user_id,
      eventId: bookingsResult[i].event_id,
      numberOfPeople: bookingsResult[i].number_of_people,
    }

    bookingsList.push(singleBookingResult);
  }

  return bookingsList;
}

export const getBookingsByUserId = async (id: number): Promise<Booking[]> => {
  const bookingsResult = await sql`
    SELECT * FROM booking WHERE user_id = ${id}
  `;

  let bookingsList: Booking[] = [];

  for (let i = 0; i < bookingsResult.length; i++) {
    const singleBookingResult: Booking = {
      id: bookingsResult[i].id,
      userId: bookingsResult[i].user_id,
      eventId: bookingsResult[i].event_id,
      numberOfPeople: bookingsResult[i].number_of_people,
    }

    bookingsList.push(singleBookingResult);
  }

  return bookingsList;
}

export const getBookingsById = async (id: number): Promise<Booking[]> => {
  const bookingsResult = await sql`
    SELECT * FROM booking WHERE id = ${id}
  `;

  let bookingsList: Booking[] = [];

  for (let i = 0; i < bookingsResult.length; i++) {
    const singleBookingResult: Booking = {
      id: bookingsResult[i].id,
      userId: bookingsResult[i].user_id,
      eventId: bookingsResult[i].event_id,
      numberOfPeople: bookingsResult[i].number_of_people,
    }

    bookingsList.push(singleBookingResult);
  }

  return bookingsList;
}

export async function createBooking(booking: Booking): Promise<number> {
  await sql`
    INSERT INTO booking (user_id, event_id, number_of_people)
    VALUES (${booking.userId}, ${booking.eventId}, ${booking.numberOfPeople})
  `;

  const bookingId = await sql`SELECT LAST_INSERT_ID() as id;`
  return bookingId[0].id;
}

export async function createTag(bookingId: number, tagId: number): Promise<void> {
  await sql`
    INSERT INTO booking_tag (booking_id, tag_id)
    VALUES (${bookingId}, ${tagId})
  `;
}

export async function deleteBooking(id: number): Promise<void> {
  await sql`
    DELETE FROM booking WHERE id = ${id}
  `;
}
