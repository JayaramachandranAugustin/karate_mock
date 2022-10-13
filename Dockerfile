FROM adoptopenjdk/openjdk11:alpine-slim

ENV PORT = 5000
COPY . ./
CMD exec java -jar karate-1.2.1.RC1.jar -m bookmock.feature -p $PORT