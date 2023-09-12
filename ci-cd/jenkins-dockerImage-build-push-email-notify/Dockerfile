# Use an official Nginx base image
FROM nginx:alpine

# Copy your HTML files into the Nginx default web directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 for web traffic (Nginx default)
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
##
