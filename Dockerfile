# Start with a base stage
FROM golang:1.22 as base

WORKDIR /app
#dependencies are stored here

COPY go.mod ./
#any new dependencies can be handled 

RUN go mod download
# all the go app files are copied
COPY . .
#main artifact is created in docker file

RUN go build -o main .
#distroless image - final stage

FROM gcr.io/distroless/base
# copy binary from previous stage
COPY --from=base /app/main .

#copy to static content to  static folder
COPY --from=base /app/static ./static


EXPOSE 8080

CMD ["./main"]
