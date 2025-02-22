# Step 1: Build the Angular app
FROM node:18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npx nx run ecommerce-store:build:production

# Step 2: Serve the Angular app using NGINX
FROM nginx:stable
COPY --from=build /app/dist/ecommerce-store/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the default NGINX port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]