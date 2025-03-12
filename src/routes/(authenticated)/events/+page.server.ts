import { getEventsByDate } from "$lib/events/events";
import type { Event } from "$lib/events/events";
import type { PageServerLoad } from "./$types";
import { getBookingsByEventId, type Booking } from "$lib/events/bookings";

type PageResult = Event & {
  attendees?: number,
  attendeesPercentage?: number,
}

type PageResultTyped = Event & {
  attendees: number,
  attendeesPercentage: number,
}

export const load: PageServerLoad = async () => {
  const eventSearchResult = await getEventsByDate(new Date("2025-01-01"), new Date("2026-01-01"));

  let events: PageResult[] = [];
  for (let i = 0; i <= eventSearchResult.length - 1; i++) {
    const newEvent: Event = {
      id: eventSearchResult[i].id,
      name: eventSearchResult[i].name,
      max_attendees: eventSearchResult[i].max_attendees,
      min_attendees: eventSearchResult[i].min_attendees,
      event_date: eventSearchResult[i].event_date,
      venue_id: eventSearchResult[i].venue_id,
    };

    events.push(newEvent);
  };

  for (let i = 0; i < events.length; i++) {
    const bookingSearchResult = await getBookingsByEventId(events[i].id);
    events[i].attendees = 0;

    bookingSearchResult.forEach((booking: Booking) => {
      events[i].attendees = booking.numberOfPeople + events[i].attendees!;
    });

    events[i].attendeesPercentage = (events[i].attendees! / events[i].max_attendees) * 100;
  }

  events = events as PageResultTyped[];

  return {
    events,
  }
}
