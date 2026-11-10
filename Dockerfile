FROM eclipse-temurin:25-jdk-jammy

# https://d.defold.com/stable/info.json
# ENV DEFOLD_VERSION 1.7.0
# ENV DEFOLD_VERSION_SHA1 bf4dc66ab5fbbafd4294d32c2797c08b630c0be5

ARG DEFOLD_VERSION
ARG DEFOLD_VERSION_SHA1

# Copy shortcut scripts
COPY ./scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# Download bob.jar
RUN curl -L -o /usr/local/bin/bob.jar https://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/bob/bob.jar && \
    echo "https://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/bob/bob.jar"

# Download dmengine_headless
RUN curl -L -o /usr/local/bin/dmengine_headless https://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/engine/x86_64-linux/dmengine_headless && \
    chmod +x /usr/local/bin/dmengine_headless && \
    echo "https://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/engine/x86_64-linux/dmengine_headless"

# Install butler
RUN curl -fL --retry 2 --retry-delay 1 --retry-all-errors --connect-timeout 20 \
    -o /tmp/butler.zip https://broth.itch.zone/butler/linux-amd64/LATEST/archive/default && \
    cd /usr/local/bin && jar xf /tmp/butler.zip && \
    rm /tmp/butler.zip && \
    chmod +x /usr/local/bin/butler

# Update file permissions
RUN chown root:root /usr/local/bin/*

# Install dependencies
# https://forum.defold.com/t/spine-4-1/72923/2
RUN apt-get update && \
    apt-get install -y --no-install-recommends libopenal-dev libgl1-mesa-dev libglw1-mesa-dev freeglut3-dev zip && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "bob" ]
CMD [ "butler" ]
