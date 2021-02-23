import 'dart:async';
import './dart_nats.dart';
import './message.dart';

class Subscription {
  final String subscriptionId;

  final String subject;

  final String queueGroup;

  final _controller = StreamController<Message>();

  final Nats _connection;

  Stream<Message> _onMessage;

  Stream<Message> get onMessage => _onMessage;

  StreamController<Message> get controller => _controller;

  Nats get connection => _connection;

  Subscription.init(
      this._connection, this.subscriptionId, this.subject, this.queueGroup) {
    _onMessage = _controller.stream.asBroadcastStream();
  }

  // TODO automatic unsubscribe

  /// Stop listening to the subject
  Future<void> unsubscribe() async {
    await _controller.close();
    await _connection.unsubscribe(this);
  }

  /// Indicates whether the subscription is still active. This will return false
  /// if the subscription has already been closed.
  bool get isValid => _controller.isClosed;
}
