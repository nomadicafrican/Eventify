import { getEventsByDate } from "$lib/events/events";
import type { Event } from "$lib/events/events";
import type { PageServerLoad } from "./$types";

export const load: PageServerLoad = async () => {
  const searchResult = await getEventsByDate(new Date("2025-01-01"), new Date("2026-01-01"));

  const events: Event[] = [];
  for (let i = 0; i <= searchResult.length - 1; i++) {
    const newEvent: Event = {
      id: searchResult[i].id,
      name: searchResult[i].name,
      max_attendees: searchResult[i].max_attendees,
      min_attendees: searchResult[i].min_attendees,
      event_date: searchResult[i].event_date,
      venue_id: searchResult[i].venue_id,
    };

    events.push(newEvent);
  };

  return {
    events: events
  }
};
