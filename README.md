# Harcapp Song Server (Unofficial proposal)
Here is a proposal for a song server for the Harcapp application. It is written in dart, allowing code to be shared with the application.

A [Shelf](https://pub.dev/packages/shelf) package is used for communication, and data is transmitted in JSON format.

Tags are renamed and new classes are defined: `Song`, `Stenza`, `Line` and `Chord`, that are another version of the song notation. However, the old format is supported (for now only for song uploads). 

## Routes
Currently defined routes and methods are following:

|            Route | GET          | POST           | PUT | PATCH | DELETE |
| ---------------: | ------------ | -------------- | --- | ----- | ------ |
|   `/v3.0/songs/` | ❌ songlist   | ✅ add new song | ❌   | ❌     | ❌      |
| `/v3.0/song/$id` | ✅ song by id | ❌              | ❌   | ❌     | ❌      |

# Running

## Running from cmd

Running with dartSDK
```
$ flutter run bin/server.dart
```

Latest versions of flutter come with dart, so you can run dart programs without anything else.
To tun server with flutter use:

```
$ flutter run bin/server.dart
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```

# Developing
Dart uses generators, that have to run before anything else.
Before development run:
```
$ pub run build_runner watch
or
$ flutter run build_runner watch
```
It'll watch changes in files and rebuild generated files on every update.
Then run normally or use [Nodemon](https://nodemon.io/) node.js package to watch for changes

```
$ nodemon -e dart -x dart run .\bin\server.dart
```

