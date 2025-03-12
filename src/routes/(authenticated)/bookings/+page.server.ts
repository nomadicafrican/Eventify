import { onMount } from 'svelte';
import { toast } from 'svelte-french-toast'; // For notifications
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
    toast.error('Failed to load bookings.');
  } finally {
    loading = false;
  }
}

async function cancelBooking(id: string) {
  if (!confirm('Are you sure you want to cancel this booking?')) return;

  try {
    await deleteBooking(id);
    bookings = bookings.filter((booking) => booking.id !== id);
    toast.success('Booking cancelled.');
  } catch (error) {
    console.error(error);
    toast.error('Failed to cancel booking.');
  }
}


