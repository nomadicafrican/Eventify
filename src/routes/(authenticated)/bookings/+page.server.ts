<<<<<<< Updated upstream
import { getBookingsByUserId, deleteBooking } from '$lib/events/bookings'; // Your custom API access library
import type { Booking } from '$lib/events/bookings';

let bookings: Booking[] = [];
let loading = true;

async function fetchBookings(userId: number) {
  try {
    const res = await getBookingsByUserId(userId);
    bookings = res;
  } catch (error) {
    console.error(error);
  } finally {
    loading = false;
  }
}

async function cancelBooking(id: number) {
  if (!confirm('Are you sure you want to cancel this booking?')) return;

  try {
    await deleteBooking(id);
    bookings = bookings.filter((booking) => booking.id !== id);
  } catch (error) {
    console.error(error);
=======
import {
  getBookingsByUserId,
  type Booking
} from '$lib/events/bookings';
import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { getEventById } from '$lib/events/events';
import type { Event } from '$lib/events/events';

export const load: PageServerLoad = async ({ params, locals }) => {
  if (!params) return error(404, 'Event not found');

  try {
    const bookingsResult: Booking[] = await getBookingsByUserId(locals.user?.id!);
    let bookedEvents: Event[] = [];
    for (let i = 0; i < bookingsResult.length; i++) {
      bookedEvents.push(await getEventById(bookingsResult[i].eventId))
    }

    if (bookingsResult.length != bookedEvents.length) {
      console.log("routes/bookings/+page.server.ts: uhhhhhhhhhhhhhhhhh")
    }

    return {
      bookedEvents,
      bookingsResult,
    };
  } catch (e) {
    console.error('Error in load function:', e);
    throw error(500, 'Failed to load event data.');
>>>>>>> Stashed changes
  }
};

