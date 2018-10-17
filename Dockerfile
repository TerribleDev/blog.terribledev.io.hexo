FROM node:8 as build
WORKDIR /build
COPY ["package.json", "package-lock.json", "./"]
RUN npm install
COPY . .
RUN npm run clean && npm run generate

FROM nginx:mainline as runtime
COPY --from=build /build/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf