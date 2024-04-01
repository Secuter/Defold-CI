FROM openjdk:17-jdk-bullseye

# http://d.defold.com/stable/info.json
ENV DEFOLD_VERSION 1.7.0
ENV DEFOLD_VERSION_SHA1 bf4dc66ab5fbbafd4294d32c2797c08b630c0be5

# copy shortcut scripts
COPY ./scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# download bob.jar
RUN curl -L -o /usr/local/bin/bob.jar http://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/bob/bob.jar

# download dmengine_headless
RUN curl -L -o /usr/local/bin/dmengine_headless http://d.defold.com/archive/${DEFOLD_VERSION_SHA1}/engine/x86_64-linux/dmengine_headless \
    && chmod +x /usr/local/bin/dmengine_headless

# install butler
RUN curl -L -o /tmp/butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default \
 && unzip -q /tmp/butler.zip -d /usr/local/bin/ && rm /tmp/butler.zip \
 && chmod +x /usr/local/bin/butler

# update file permissions
RUN chown root:root /usr/local/bin/*

# install dependencies
# https://forum.defold.com/t/spine-4-1/72923/2
RUN apt-get update \
 && apt-get install -y --no-install-recommends libopenal-dev libgl1-mesa-dev libglw1-mesa-dev freeglut3-dev zip \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD [ "bob" ]
CMD [ "butler" ]
