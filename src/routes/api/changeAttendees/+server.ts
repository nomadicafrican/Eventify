import { updateBookingParticipants, type Booking } from "$lib/events/bookings";
import { error } from "@sveltejs/kit";
import type { RequestEvent, RequestHandler } from "./$types";

export const PUT: RequestHandler = (async ({ url, request }: RequestEvent) => {
  try {
    const numAttendees = Number.parseInt(
      url.searchParams.get("numAttendees") as string
    );

    const newBooking: Booking = await request.json()
    newBooking.numberOfPeople = numAttendees;

    await updateBookingParticipants(newBooking)
    return new Response("true")
  } catch (e) {
    console.log(`Error on changing attendant numbers for booking \nRequest: ${request} \nurl: ${url}`)
    console.log(e)
    return error(500, {
      message: "Error updating booking, please contact supoprt"
    })
  }
})
