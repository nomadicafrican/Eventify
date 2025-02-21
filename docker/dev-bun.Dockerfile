FROM oven/bun:1.2.2

WORKDIR /app/eventify

COPY bun.lockb ./
COPY package.json ./

RUN bun i
RUN bun i vite

COPY . .
CMD ["bun", "--bun", "run", "dev", "--host"]
