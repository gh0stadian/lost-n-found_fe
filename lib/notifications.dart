import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:flutter_socket_io/flutter_socket_io.dart';
// import 'package:flutter_socket_io/socket_io_manager.dart';
import 'auth.dart';
import 'package:get/get.dart';

List<GlobalKey<_NotificationProviderState>> _keys = [];

class NotificationProvider extends StatefulWidget {
  final Widget child;

  final GlobalKey<_NotificationProviderState> key;

  NotificationProvider({
    this.child,
    Key key,
  })  : key = GlobalKey(),
        super(key: key);


  @override
  State<StatefulWidget> createState() => _NotificationProviderState();
}

class _NotificationProviderState extends State<NotificationProvider> {
  IO.Socket socket;


  @override

  void initState() {
    super.initState();
    _keys.add(widget.key);
    createSocket();
  }

  void createSocket() {
    socket = IO.io("http://"+GlobalData.serverAddress, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

    socket.onConnect((_) {
      print('connect');
    });

    socket.connect();

    socket.onDisconnect((_) => print('disconnect'));

    socket.on('notification', (data) => handleNotification(data));

    // socket.subscribe('notification', handleNotification);
  }

  void handleNotification(data) {
    var item = data["item"];
    if (data["type"] == "lost") {
      Get.snackbar("You have a match!", "Someone is looking for $item..");
    } else {
      Get.snackbar(
          "You have a match!", "Someone has found $item, similar to yours..");
    }
  }

  void _authenticate() {
    socket.emit("message", "Hello!");
    socket.emit("authenticate", GlobalData.jwt);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

void authenticate() {
  if (_keys.isNotEmpty) {
    var key = _keys.first;
    key.currentState?._authenticate();
  }
}