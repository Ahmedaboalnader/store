#!/bin/sh
#
# This script is executed when the container starts.
# It replaces a placeholder in the static files with the actual API URL.
#

set -e

# Default API URL if not set
API_URL=${API_URL:-"http://localhost:5000"}

echo "Replacing placeholder with API URL: $API_URL"

# Find all JavaScript files in the /usr/share/nginx/html/static/js directory
# and replace the placeholder __API_URL__ with the value of the API_URL variable.
for file in /usr/share/nginx/html/static/js/*.js;
do
  echo "Processing $file ...";
  # Use sed to replace the placeholder. The | separator is used to avoid issues with URLs containing slashes.
  sed -i "s|__API_URL__|$API_URL|g" $file
done

# Start Nginx in the foreground
nginx -g 'daemon off;'
