import type { ParamMatcher } from "@sveltejs/kit";
import { sql } from "bun";

export const match: ParamMatcher = async (value: number) => {
  const userRange = await getVenueIdRange();
  return /^\d+$/.test(value.toString()) &&
    (userRange.low <= value && value <= userRange.high);
};

interface rangeObject {
  low: number;
  high: number;
}

export async function getVenueIdRange(): Promise<rangeObject> {
  const result = await sql`
    SELECT id
    FROM venue
    ORDER BY 1 ASC
  `;
  return { low: result[0].id, high: result[result.length - 1].id }
}

