FROM adoptopenjdk/openjdk11:alpine-slim

COPY . ./
CMD exec java -jar karate-1.2.1.RC1.jar -m bookmock.feature -p 5000