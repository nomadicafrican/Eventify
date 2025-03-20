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
  }
}


