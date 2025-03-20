// for PageServerLoad
import { createBooking, getBookingsByEventId, type Booking, type CreateBookingInterface } from '$lib/events/bookings';
import type { Event } from '$lib/events/events';
import { getEventById } from '$lib/events/events';
import { getScheduleByEventId, type Schedule } from '$lib/events/schedule';
import { getVenueById, type Venue } from '$lib/events/venues';
import { error, fail, redirect } from '@sveltejs/kit';
import type { PageServerLoad } from '../../../events/[eventId=events]/$types';
import { navigating } from '$app/state';

// for Form
import type { Actions } from './$types';


export const load: PageServerLoad = async ({ params }) => {
  if (!params || !params.eventId) return error(404, 'Event not found');
  const eventId = Number(params.eventId);

  const eventResult: Event = await getEventById(eventId);
  const venue: Venue = await getVenueById(eventResult.venue_id);
  const schedule: Schedule = await getScheduleByEventId(eventId);
  const bookingsResult: Booking[] = await getBookingsByEventId(eventId)
  let numBookings = 0;
  let referrer = navigating.from

  for (let i = 0; i < bookingsResult.length; i++) {
    numBookings += bookingsResult[i].numberOfPeople
  }

  // console.log('eventResult', eventResult);
  // console.log('schedule', schedule);
  // console.log('venue', venue);

  return {
    eventResult,
    schedule,
    venue,
    numBookings,
    referrer
  }
}


export const actions: Actions = {
  default: async (formEvent) => {
    const formData = await formEvent.request.formData()
    if (!formData.has("numPeople")) {
      return fail(400, {
        message: "Please enter number of people"
      });
    }

    if (!formData.has("event")) {
      console.error("uhhhhhh this aint supposed to happen, event is empty in register event booking route")
    }

    const numPeople = Number.parseInt(
      formData.get("numPeople") as string
    );
    const event: Event = JSON.parse(
      formData.get("event") as string
    );
    const venue: Venue = JSON.parse(
      formData.get("venue") as string
    );
    const bookings: Booking[] = await getBookingsByEventId(event.id);
    let currentNumberOfBookings = 0;
    for (const _ of bookings) {
      currentNumberOfBookings += 1;
    }


    if (numPeople < 0) {
      return fail(400, {
        message: "you cannot register negative people"
      })
    }

    let attendeesCeiling = 0;
    if (event.max_attendees > venue.capacity) {
      attendeesCeiling = venue.capacity - currentNumberOfBookings;
    } else {
      attendeesCeiling = event.max_attendees - currentNumberOfBookings;
    }

    if (numPeople >= attendeesCeiling) {
      return fail(400, {
        message: `Maximum booking limit is ${attendeesCeiling}`
      })
    }

    const booking: CreateBookingInterface = {
      userId: formEvent.locals.user?.id!,
      eventId: event.id,
      numberOfPeople: numPeople,
    }
    await createBooking(booking)
    return redirect(303, `${formEvent.url.toString()}/success`)
  }
}
