import 'dart:async';
import './message.dart';
import './options.dart';
import './impl.dart';
import './subscription.dart';

/// A connection to a NATS server.
///
/// Use [publish] to publish a messages.
/// Use [subscribe] to subscribe to messages.
abstract class Nats {
  /// Publish message [data] to [subject]. Optionally specify a [replyTo]
  /// subject for the receiver to reach the sender.
  Future<void> publish(
      String subject,
      /* String | Iterable<int> | dynamic */ data,
      {String replyTo});

  Future<Message> request(
      String subject,
      /* String | Iterable<int> | dynamic */ data);

  /// Subscribe to messages by [subject]. Optionally specify a [queueGroup].
  Future<Subscription> subscribe(String subject, {String queueGroup});

  /// Unsubscribe the [subscription].
  Future<void> unsubscribe(Subscription subscription);

  /// Connects to NATS server using the provided connection [options] and returns
  /// an instance of [Nats].
  static Future<Nats> connect(
      {ConnectionOptions options: const ConnectionOptions()}) async {
    var ret = NatsImpl(options);
    await ret.waitForConnection();
    return ret;
  }

  Future<void> close();
}
