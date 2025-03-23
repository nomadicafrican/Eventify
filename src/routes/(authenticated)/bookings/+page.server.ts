import { getBookingsByUserId, deleteBooking, getBookingById } from '$lib/events/bookings'; // Your custom API access library
import type { Booking } from '$lib/events/bookings';

// PageServerLoad
import { error, fail } from '@sveltejs/kit';
import type { Action, Actions, PageServerLoad, RequestEvent } from './$types';
import { getEventById } from '$lib/events/events';
import type { Event } from '$lib/events/events';
import { page } from '$app/state';


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
  }
};


export const actions: Actions = {
  default: async (event) => {
    const formData = await event.request.formData();
    const newNumAttendees = Number.parseInt(formData.get("numPeople") as string)
    const bookingId = Number.parseInt(formData.get("bookingId") as string)
    const bookingResult: Booking = await getBookingById(bookingId)

    // console.log("Bookings/+page.server.js:")
    // console.log("Num attendees: ", newNumAttendees)
    // console.log("Booking Id: ", bookingId)
    // console.log(`Booking result: {
    //   id: ${bookingResult.id},
    //   userId: ${bookingResult.userId},
    //   eventId: ${bookingResult.eventId},
    //   numberOfPeople: ${bookingResult.numberOfPeople}
    // }`);

    const result = await event.fetch("/api/changeAttendees?numAttendees=" + newNumAttendees, {
      method: "PUT",
      body: JSON.stringify(bookingResult)
    })


    if (result && result.ok) {
      return {
        success: true
      }
    }
    else {
      return {
        message: false
      }
    }
  }
}
