import { sql } from "bun";

export type Event = {
  id: Number,
  name: String,
  max_attendees: Number,
  min_attendees: Number,
  event_date: Date,
  venue_id: Number,
};

export const getEventById = async (id: Number): Promise<Event> => {
  const eventResult = await sql`
    SELECT * FROM event WHERE id = ${id}
  `
  const event: Event = {
    id: eventResult[0].id,
    name: eventResult[0].name,
    max_attendees: eventResult[0].max_attendees,
    min_attendees: eventResult[0].min_attendees,
    event_date: eventResult[0].event_date,
    venue_id: eventResult[0].venue_id,
  }

  return event;
};

export const createEvent = async (event: Event): Promise<Number> => {
  await sql`
    INSERT INTO event (name, max_attendees, min_attendees, event_date, venue_id)
    VALUES (${event.name}, ${event.max_attendees}, ${event.min_attendees}, ${event.event_date}, ${event.venue_id});
  `;

  const eventId = await sql`SELECT LAST_INSERT_ID() as id;`
  return eventId[0].id;
}

export const getEventByUserId = async (userId: Number): Promise<Event[]> => {
  const queryResult = await sql`
    SELECT * FROM event WHERE id IN (
      SELECT event_id FROM bookings WHERE user_id = ${userId}
    )
  `;

  let bookings: Event[] = [];

  for (let i = 0; i < queryResult.length; i++) {
    const event: Event = {
      id: queryResult[i].id,
      name: queryResult[i].name,
      max_attendees: queryResult[i].max_attendees,
      min_attendees: queryResult[i].min_attendees,
      event_date: queryResult[i].event_date,
      venue_id: queryResult[i].venue_id,
    };

    bookings.push(event);
  };

  return bookings;
}

export const getEventsByVenueId = async (venueId: Number): Promise<Event[]> => {
  const queryResult = await sql`
SELECT * FROM event WHERE venue_id = ${venueId}
`;

  let bookings: Event[] = [];

  for (let i = 0; i < queryResult.length; i++) {
    const event: Event = {
      id: queryResult[i].id,
      name: queryResult[i].name,
      max_attendees: queryResult[i].max_attendees,
      min_attendees: queryResult[i].min_attendees,
      event_date: queryResult[i].event_date,
      venue_id: queryResult[i].venue_id,
    };

    bookings.push(event);
  };

  return bookings;
}

export const getEventsByDate = async (beginDate: Date, endDate: Date): Promise<Event[]> => {
  const queryResult = await sql`
    SELECT * FROM event WHERE event_date > ${beginDate}::date AND event_date < ${endDate}::date
  `;

  let bookings: Event[] = [];

  for (let i = 0; i < queryResult.length; i++) {
    const event: Event = {
      id: queryResult[i].id,
      name: queryResult[i].name,
      max_attendees: queryResult[i].max_attendees,
      min_attendees: queryResult[i].min_attendees,
      event_date: queryResult[i].event_date,
      venue_id: queryResult[i].venue_id,
    };

    bookings.push(event);
  };

  return bookings;
}



export const getEventsByTag = async (tag: String): Promise<Event[]> => {
  const queryResultTagId = await sql`
    SELECT id FROM tags WHERE name = ${tag}
  `;

  const queryResultEvents = await sql`
    SELECT * FROM event WHERE id IN (
      SELECT event_id FROM event_tags WHERE tag_id = ${queryResultTagId[0].id}
    );
  `;

  let bookings: Event[] = [];

  for (let i = 0; i < queryResultEvents.length; i++) {
    const event: Event = {
      id: queryResultEvents[i].id,
      name: queryResultEvents[i].name,
      max_attendees: queryResultEvents[i].max_attendees,
      min_attendees: queryResultEvents[i].min_attendees,
      event_date: queryResultEvents[i].event_date,
      venue_id: queryResultEvents[i].venue_id,
    };

    bookings.push(event);
  };

  return bookings;
}

























