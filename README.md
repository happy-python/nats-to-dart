# nats-to-dart

```dart
// nats 客户端
Future<Nats> natsClient() async {
  final connect = Nats.connect(options: ConnectionOptions(host: "localhost", port: 4222));
  return await connect;
}

var client = await natsClient();
var msg = await client.request(subject, data);
```
