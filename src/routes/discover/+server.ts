import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

interface Location {
  id: number;
  name: string;
  lat: number;
  lng: number;
  description?: string;
}

// This would typically come from a database
const locations: Location[] = [
  {
    id: 1,
    name: 'Musée du Louvre',
    lat: 48.8606,
    lng: 2.3376,
    description: "Found something more I bite it tail. Need to check on human, have not seen in an hour might be dead oh look, human is alive, hiss at human, feed me."
  },
  { id: 2, name: 'Eiffel Tower', lat: 48.8584, lng: 2.2945 },
  { id: 3, name: 'Notre-Dame', lat: 48.8530, lng: 2.3499 },
  { id: 4, name: 'Sacré-Cœur', lat: 48.8867, lng: 2.3431 },
  { id: 5, name: 'Centre Pompidou', lat: 48.8606, lng: 2.3522 }
];

export const GET: RequestHandler = async ({ url }) => {
  // Get query parameters
  const search = url.searchParams.get('search')?.toLowerCase() || '';
  const locationFilter = url.searchParams.get('location') || '';

  // Filter locations based on search query and location filter
  let filteredLocations = locations;

  if (search) {
    filteredLocations = filteredLocations.filter(
      location => location.name.toLowerCase().includes(search)
    );
  }

  if (locationFilter) {
    console.log(`Filtering for location: ${locationFilter}`);
  }

  return json(filteredLocations);
};
