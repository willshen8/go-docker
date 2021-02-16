# go-docker
This is a template for dockerise your Go application, and the intended audience is engineer who wants to build their go application without much experience of Docker.

*[Installation Guide] (#installation)

## Installation

1. You'll need to install [docker](https://docs.docker.com/get-docker/) first by following this page.
2. Once you've completed the install, you've need to set up a free account.
3. Ensure docker is running in the background and you are logged in.

## Set up your project
1. Clone the directory
```
$ git clone https://github.com/willshen8/go-docker.git my-app
```

You can rename `my-app` to the name of your application

## Explanation of the project files

1. We use [Go Modules](https://blog.golang.org/using-go-modules) to manage dependencies, and there is a  `go.mod` file.
2. The `main.go` is a simple web server which starts the server on port `8081`, and when user makes a request to`localhost:8081`, it outputs a message `Hello world!`. 
3. To test it out, run:
```
go run main.go
```
from your terminal, and from a different terminal type:
```
$ curl localhost:8081
```
and you'll see the message `Hello World!`

Isn't that wonderful? For 3-4 lines of code and you've a web server that handles request.

## Explanation of Dockerfile
Let's go through the file line by line:

```
FROM golang:latest
```
This command is telling docker to pull the latest version of golang from the docker repository.


```
LABEL maintainer="Will Shen"
```
A label is a way of adding meta-data into the docker object. It's always a key-value combination. See [official documentation[(https://docs.docker.com/config/labels-custom-metadata/)] for more details:

```
RUN mkdir /app
```
This command tells the docker to create a directory called `app`

```
ADD . /app
```
It then issues this command to moves all the project files into the `app` folder we just created.

```
WORKDIR /app
```
This command tells the docker that `app` is used as the working directory. See this [page](https://www.educative.io/edpresso/what-is-the-workdir-command-in-docker) for more information

```
RUN go build -o app/main .
```
This command builds the docker image for you

```
CMD ["./app/main"]
```
Lastly the docker image when running will run the go into the directory `app` and run the application.

## Build the docker image
Great, now that we are all set and let's build the image using the command below:
```
docker build -t my-go-app .
```
This will create a docker image called `my-go-app`, but feel free to name anything you like.

a successful build will look like this:
```
Sending build context to Docker daemon  6.949MB
Step 1/7 : FROM golang:latest
 ---> 05499cedca62
Step 2/7 : LABEL maintainer="Will Shen"
 ---> Using cache
 ---> 7fc3fa7a9dba
Step 3/7 : RUN mkdir /app
 ---> Using cache
 ---> 5c81a0aa7a2e
Step 4/7 : ADD . /app
 ---> 00b9d554abca
Step 5/7 : WORKDIR /app
 ---> Running in 1376b0376a40
Removing intermediate container 1376b0376a40
 ---> 5c84b933baeb
Step 6/7 : RUN go build -o app/main .
 ---> Running in 3abf9f551274
Removing intermediate container 3abf9f551274
 ---> 0dedc7df6bbb
Step 7/7 : CMD ["./app/main"]
 ---> Running in 2d0797920c69
Removing intermediate container 2d0797920c69
 ---> 914ed7f39b48
Successfully built 914ed7f39b48
Successfully tagged my-go-app:latest
```

You can verify your docker image by type:
```
docker images
```
and you will see something like below:
```
REPOSITORY              TAG             IMAGE ID       CREATED              SIZE
my-go-app               latest          914ed7f39b48   About a minute ago   853MB
```
To run your docker application, simply type:
```
docker run -p 8080:8081 -it my-go-app
```
Command `it` means run in interactive mode and `-p 8080:8081` means we are mapping the host port 8080 to the docker port 8081.

To test it out, in another terminal type:
```
$ curl localhost:8080
```
and you'll get the following response back:
```
$ Hello World!
```

To stop the docker application, simply type `ctrl-c`. 