FROM alpine:3.10  
RUN apk add --no-cache curl
CMD ["echo", "Hello RHACS Lab"]
