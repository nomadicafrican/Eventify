import { sql } from 'bun';

export type Venue = {
  id: number,
  name: string,
  address: string,
  city: string,
  state: string,
  zip: string,
  phone: string,
  capacity: number,
  website: string,
}

export async function getVenueById(id: number): Promise<Venue> {
  const venueResult = await sql`
    SELECT * FROM venue WHERE id = ${id}
  `;

  const venue: Venue = {
    id: venueResult[0].id,
    name: venueResult[0].name,
    address: venueResult[0].address,
    city: venueResult[0].city,
    state: venueResult[0].state,
    zip: venueResult[0].zip,
    phone: venueResult[0].phone,
    capacity: venueResult[0].capacity,
    website: venueResult[0].website,
  }

  return venue;
}

export async function getVenueByName(name: string): Promise<Venue> {
  const venueResult = await sql`
    SELECT * FROM venue WHERE name = ${name}
  `;

  const venue: Venue = {
    id: venueResult[0].id,
    name: venueResult[0].name,
    address: venueResult[0].address,
    city: venueResult[0].city,
    state: venueResult[0].state,
    zip: venueResult[0].zip,
    phone: venueResult[0].phone,
    capacity: venueResult[0].capacity,
    website: venueResult[0].website,
  }

  return venue;
}

export async function getVenuesByCity(city: string): Promise<Venue[]> {
  const venueResult = await sql`
    SELECT * FROM venue WHERE city = ${city}
  `;

  let venues: Venue[] = [];

  for (let i = 0; i < venueResult.length; i++) {
    const venue: Venue = {
      id: venueResult[i].id,
      name: venueResult[i].name,
      address: venueResult[i].address,
      city: venueResult[i].city,
      state: venueResult[i].state,
      zip: venueResult[i].zip,
      phone: venueResult[i].phone,
      capacity: venueResult[i].capacity,
      website: venueResult[i].website,
    }

    venues.push(venue);
  }

  return venues;
}


export async function getVenuesByState(state: string): Promise<Venue[]> {
  const venueResult = await sql`
    SELECT * FROM venue WHERE state = ${state}
  `;

  let venues: Venue[] = [];

  for (let i = 0; i < venueResult.length; i++) {
    const venue: Venue = {
      id: venueResult[i].id,
      name: venueResult[i].name,
      address: venueResult[i].address,
      city: venueResult[i].city,
      state: venueResult[i].state,
      zip: venueResult[i].zip,
      phone: venueResult[i].phone,
      capacity: venueResult[i].capacity,
      website: venueResult[i].website,
    }

    venues.push(venue);
  }

  return venues;
}

export async function getVenuesByZip(zip: string): Promise<Venue[]> {
  const venueResult = await sql`
    SELECT * FROM venue WHERE zip = ${zip}
  `;

  let venues: Venue[] = [];

  for (let i = 0; i < venueResult.length; i++) {
    const venue: Venue = {
      id: venueResult[i].id,
      name: venueResult[i].name,
      address: venueResult[i].address,
      city: venueResult[i].city,
      state: venueResult[i].state,
      zip: venueResult[i].zip,
      phone: venueResult[i].phone,
      capacity: venueResult[i].capacity,
      website: venueResult[i].website,
    }

    venues.push(venue);
  }

  return venues;
}

export async function getVenuesByCapacity(capacity: number): Promise<Venue[]> {
  const venueResult = await sql`
    SELECT * FROM venue WHERE capacity = ${capacity}
  `;

  let venues: Venue[] = [];

  for (let i = 0; i < venueResult.length; i++) {
    const venue: Venue = {
      id: venueResult[i].id,
      name: venueResult[i].name,
      address: venueResult[i].address,
      city: venueResult[i].city,
      state: venueResult[i].state,
      zip: venueResult[i].zip,
      phone: venueResult[i].phone,
      capacity: venueResult[i].capacity,
      website: venueResult[i].website,
    }

    venues.push(venue);
  }

  return venues;
}

export async function createVenue(venue: Venue): Promise<Venue> {
  const venueResult = await sql`
    INSERT INTO venue (name, address, city, state, zip, phone, capacity, website)
    VALUES (${venue.name}, ${venue.address}, ${venue.city}, ${venue.state}, ${venue.zip}, ${venue.phone}, ${venue.capacity}, ${venue.website})
    RETURNING *
  `;

  const newVenue: Venue = {
    id: venueResult[0].id,
    name: venueResult[0].name,
    address: venueResult[0].address,
    city: venueResult[0].city,
    state: venueResult[0].state,
    zip: venueResult[0].zip,
    phone: venueResult[0].phone,
    capacity: venueResult[0].capacity,
    website: venueResult[0].website,
  }

  return newVenue;
}
