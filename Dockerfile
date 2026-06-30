FROM node:20-slim

# Install Python 3 and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files and install Node dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy the rest of the app
COPY . .

# Create data directories
RUN mkdir -p data/uploads data/tmp

EXPOSE 3000

CMD ["node", "server.js"]
