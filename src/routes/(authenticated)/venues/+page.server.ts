import type { PageServerLoad } from "./$types";
import { getAllVenues, type Venue } from "$lib/events/venues";
// import { getEventsByVenueId } from "$lib/events/events";

export const load: PageServerLoad = async () => {
  const eventSearchResult = await getAllVenues();

  let venues: Venue[] = [];
  for (let i = 0; i <= eventSearchResult.length - 1; i++) {
    const newVenue: Venue = {
      id: eventSearchResult[i].id,
      address: eventSearchResult[i].address,
      capacity: eventSearchResult[i].capacity,
      city: eventSearchResult[i].city,
      name: eventSearchResult[i].name,
      phone: eventSearchResult[i].phone,
      state: eventSearchResult[i].state,
      website: eventSearchResult[i].website,
      zip: eventSearchResult[i].zip,
    }

    venues.push(newVenue);
  };

  // for (let i = 0; i < venues.length; i++) {
  //   const bookingSearchResult = await getEventsByVenueId(venues[i].id);
  // }

  return {
    venues
  }
}
