import 'package:web_socket_channel/web_socket_channel.dart';

class OrdersSocketService {
  WebSocketChannel? _channel;

  // بنفتح الاتصال
  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  Stream get stream => _channel?.stream ?? const Stream.empty();

  void close() {
    _channel?.sink.close();
    _channel = null;
  }
}
