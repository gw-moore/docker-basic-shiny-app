# Docker Basic Shiny App

This repo provides a working example of how to use Docker to locally host a Shiny app with a Shiny server image

If you have you own app, replace the */app* directory with you own.

## Building the Shiny server image
To build the Shiny server image, run the following in the */basic_shiny_app* directory:
```
docker build -t basic_shiny_app .
```

This command initiates a new image build, which will build and tag an image based on the files in the current directory. The blueprint of the image is specified in t
he *Dockerfile*. The first build will take a few miniutes as you have to download base Shiny server image.

## Run the Shiny server
To create and excutue Shiny server container, run the following:

```
docker run -p 3838:3838 basic_shiny_app
```

`docker run` is a convenience command that wraps two seperate *Docker* steps into one. First is creating a container from the underlying image, which can be done wit
h `docker create`. Second is execute the container, which can be seperately with `docker start`

`-p` is an option of `docker run` which maps a container's port(s) from the container to the host.

To view the app, navigate to `127.0.0.1:3838` of the host machine.
