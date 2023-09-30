#!/bin/sh

# Fetch the latest Defold version and SHA1 from the URL
INFO_URL="http://d.defold.com/stable/info.json"
LATEST_INFO=$(curl -s "$INFO_URL")
LATEST_VERSION=$(echo "$LATEST_INFO" | jq -r '.version')
LATEST_SHA1=$(echo "$LATEST_INFO" | jq -r '.sha1')

# Update the Dockerfile with the new version and SHA1
DOCKERFILE_PATH="Dockerfile"
sed -i "s/ENV DEFOLD_VERSION .*/ENV DEFOLD_VERSION $LATEST_VERSION/" "$DOCKERFILE_PATH"
sed -i "s/ENV DEFOLD_VERSION_SHA1 .*/ENV DEFOLD_VERSION_SHA1 $LATEST_SHA1/" "$DOCKERFILE_PATH"

echo "Updated DEFOLD_VERSION to $LATEST_VERSION"
echo "Updated DEFOLD_VERSION_SHA1 to $LATEST_SHA1"
