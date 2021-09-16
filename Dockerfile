# -----------------------------------------------------------------------------
FROM openjdk:8-jre-alpine3.9 as builder
# -----------------------------------------------------------------------------

LABEL RUNNER MAINTENER

WORKDIR /builder

# copy the packaged jar file into our docker image
COPY target/hello-1.1.jar /builder/hello.jar

# set the startup command to execute the jar
CMD ["java", "-jar", "/hello.jar"]

# -----------------------------------------------------------------------------
FROM nginx:1.13.12-alpine as prod
# -----------------------------------------------------------------------------

# Advance user login details 

# RUN apk add --no-cache \
#     curl \
#     tar \
#     bash \
#     procps \
#     apache2-proxy \
#     apache2-ssl \
#     apache2-utils 

#RUN htpasswd /etc/apache2/.htpasswd manas > ./httpd.conf
#COPY ./httpd.conf /etc/apache2/httpd.conf 
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder  /builder/ /usr/share/nginx/html/



