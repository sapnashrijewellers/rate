FROM node:20-slim

# Set working directory
WORKDIR /app

RUN apt-get update && apt-get install -y \        
    git \
    cron \
    ca-certificates \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*



COPY package.json package-lock.json ./

RUN npm install

COPY app/ .

# Set timezone to IST
ENV TZ=Asia/Kolkata
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo "$TZ" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# Copy crontab
COPY ./app/crontab.txt /etc/cron.d/generator-cron

# Apply permissions
RUN chmod 0644 /etc/cron.d/generator-cron && \
    chmod +x /app/*.sh

# Run entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
