FROM node:alpine
WORKDIR /app
COPY ./repos/youtube-website /app
RUN rm -f package-lock.json yarn.lock
RUN yarn install
CMD ["yarn", "dev"]
