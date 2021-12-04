import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'classes.dart';

Map<String, Song> songCache = {};

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/v3.0/song/<id>', _songHandler)
  ..post('/v3.0/songs/', _newSongHandler);

Response _rootHandler(Request req) {
  return Response.ok("ok");
}

Response _songHandler(Request req) {
  final id = req.params['id'];
  if (id == null) return Response.forbidden("Id must be given");

  return Response.ok(json.encode(songCache.putIfAbsent(id, () {
    File file = File('data/$id.hrcs');
    return Song.fromJson(json.decode(file.readAsStringSync()));
  })));
}

Future<Response> _newSongHandler(Request req) async {
  return req.readAsString().then((String body) {
    Song song = Song.fromJson(json.decode(body));
    var file = File('data/${song.id}.hrcs');
    file.createSync(recursive: true);
    file.writeAsStringSync(jsonEncode(song));
    return Response.ok(jsonEncode(song));
  });
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}
