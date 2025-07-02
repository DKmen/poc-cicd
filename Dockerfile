# ----------- Build Stage -----------
FROM node:20-alpine AS build

WORKDIR /usr/src/app

# Copy package files and install all dependencies (including dev)
COPY package*.json ./
RUN npm ci

# Copy the rest of the source code
COPY . .

# (Optional) Run build scripts here if you have any, e.g.:
# RUN npm run build

# ----------- Deploy Stage -----------
FROM node:20-alpine AS deploy

WORKDIR /usr/src/app

# Copy only package files and install production dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy built app and source code from build stage
COPY --from=build /usr/src/app .

EXPOSE 3000
CMD ["npm", "start"]
