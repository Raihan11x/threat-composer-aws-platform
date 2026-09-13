FROM --platform=$BUILDPLATFORM node:22.23.2-bookworm-slim AS build

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile --non-interactive

COPY . .

ENV GENERATE_SOURCEMAP=false

RUN yarn build

FROM nginxinc/nginx-unprivileged:1.30.4-alpine3.24 AS runtime

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 8080