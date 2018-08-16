FROM alpine
RUN apk update && apk add ruby
COPY . /app
WORKDIR /app
CMD ["cd", "/app"]
CMD ["gem", "install bundler"]
CMD ["bundle", "install"]

