# Use an official Node base image
FROM node:18 AS dependencies

WORKDIR /app
COPY package.json ./
RUN npm install

FROM node:18-slim

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.docker.cmd="docker run -d -p 3000:3000 --name node_timeoff"

# Add a system user and set up the app
RUN useradd --system --home /app app
USER app
WORKDIR /app

COPY . ./
COPY --from=dependencies /app/node_modules ./node_modules

EXPOSE 3000
CMD ["npm", "start"]
