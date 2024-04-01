## Docker image to build a Defold project and deploy on Itch.io using butler

Docker image at docker hub
https://hub.docker.com/r/secuter/defold-ci

Built on top of openjdk:17-jdk-bullseye, it includes intalled in path:
- bob
- butler
- zip (not needed for deploy on Itch.io)

To use butler you have to set the env variable BUTLER_API_KEY with your Itch.io api key (for the login).
It's recommended to save it as a secret on the platform you use.
