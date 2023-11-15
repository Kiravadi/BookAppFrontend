# FROM node:16-alpine

# ENV PORT=3000

# WORKDIR /bookapp-react-js
# COPY . /bookapp-react-js
# RUN npm run build
# EXPOSE ${PORT}
# CMD ["npm", "start"]

FROM node:17.1-alpine as build-stage
WORKDIR /bookapp-react-js
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.22.1-alpine as prod-stage
COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
