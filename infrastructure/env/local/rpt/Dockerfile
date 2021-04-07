FROM node:alpine
WORKDIR /app
COPY ./repos/rpt /app
RUN rm -f package-lock.json yarn.lock
RUN yarn install
CMD ["yarn", "dev"]
