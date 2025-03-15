import type { PageServerLoad } from './$types';
import { getEventById } from '$lib/events/events';
import { redirect } from "@sveltejs/kit";
import { getVenueById } from '$lib/events/venues';
import { getBookingsByEventId } from '$lib/events/bookings';

export const load: PageServerLoad = async ({ params }) => {
  const eventId: number = Number(params.eventId);
  if (params.eventId) {
    const event = await getEventById(eventId);
    const bookingResults = await getBookingsByEventId(eventId);
    const numBookings = bookingResults.length;
    const venue = await getVenueById(event.venue_id);
    return { event, numBookings, venue };
  }
  return redirect(303, "/events/")
}
