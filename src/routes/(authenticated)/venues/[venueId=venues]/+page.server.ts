import type { PageServerLoad } from './$types';
import { redirect } from "@sveltejs/kit";
import { getVenueById } from '$lib/events/venues';
import { getEventsByVenueId } from '$lib/events/events';
import type { Event } from '$lib/events/events';
import { getBookingsByEventId } from '$lib/events/bookings';

interface EventWithBookings extends Event {
  bookings?: number
}

export const load: PageServerLoad = async ({ params }) => {
  const venueId: number = Number(params.venueId);
  if (params.venueId) {
    const venue = await getVenueById(venueId);
    const events: EventWithBookings[] = await getEventsByVenueId(venueId);

    events.forEach(async (event) => {
      const bookings = await getBookingsByEventId(event.id)
      event.bookings = bookings.length;
    });

    return {
      venue,
      events
    }
  }
  return redirect(303, "/venues/")
}
