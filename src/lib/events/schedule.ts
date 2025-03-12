import { sql } from 'bun';

export type Schedule = {
  id: number,
  event_id: number,
  startTime: Date,
  endTime: Date
}

export async function getScheduleById(id: number): Promise<Schedule> {
  const scheduleResult = await sql`
    SELECT * FROM schedule WHERE id = ${id}
  `;

  const schedule: Schedule = {
    id: scheduleResult[0].id,
    event_id: scheduleResult[0].event_id,
    startTime: scheduleResult[0].start_time,
    endTime: scheduleResult[0].end_time
  }

  return schedule;
}

export async function getScheduleByEventId(eventId: number): Promise<Schedule[]> {
  const scheduleResult = await sql`
    SELECT * FROM schedule WHERE event_id = ${eventId}
  `;

  let schedules: Schedule[] = [];

  for (let i = 0; i < scheduleResult.length; i++) {
    const schedule: Schedule = {
      id: scheduleResult[i].id,
      event_id: scheduleResult[i].event_id,
      startTime: scheduleResult[i].start_time,
      endTime: scheduleResult[i].end_time
    }

    schedules.push(schedule);
  }

  return schedules;
}

export async function getScheduleByStartTime(startTime: Date) {
  const dateInISO = startTime.toISOString();
  const scheduleResult = await sql`
    SELECT * FROM schedule WHERE start_time = ${dateInISO}
  `;

  let schedules: Schedule[] = [];

  for (let i = 0; i < scheduleResult.length; i++) {
    const schedule: Schedule = {
      id: scheduleResult[i].id,
      event_id: scheduleResult[i].event_id,
      startTime: scheduleResult[i].start_time,
      endTime: scheduleResult[i].end_time
    }

    schedules.push(schedule);
  }

  return schedules;
}


export async function getScheduleByEndTime(endTime: Date) {
  const dateInISO = endTime.toISOString();
  const scheduleResult = await sql`
    SELECT * FROM schedule WHERE end_time = ${dateInISO}
  `;

  let schedules: Schedule[] = [];

  for (let i = 0; i < scheduleResult.length; i++) {
    const schedule: Schedule = {
      id: scheduleResult[i].id,
      event_id: scheduleResult[i].event_id,
      startTime: scheduleResult[i].start_time,
      endTime: scheduleResult[i].end_time
    }

    schedules.push(schedule);
  }

  return schedules;
}

export async function createSchedule(eventId: number, startTime: Date, endTime: Date): Promise<Schedule> {
  const scheduleResult = await sql`
    INSERT INTO schedule (event_id, start_time, end_time) VALUES (${eventId}, ${startTime}, ${endTime}) RETURNING *
  `;

  const schedule: Schedule = {
    id: scheduleResult[0].id,
    event_id: scheduleResult[0].event_id,
    startTime: scheduleResult[0].start_time,
    endTime: scheduleResult[0].end_time
  }

  return schedule;
}
