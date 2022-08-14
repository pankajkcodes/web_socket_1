import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = TextEditingController();
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );
  List messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Web Socket 1"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(11))
                ),
                padding: const EdgeInsets.all(11),
                margin: const EdgeInsets.all(11),
                child: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: "Type..."),
                ),
              ),
              StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    log(snapshot.data.toString());
                    if (snapshot.hasData) {
                      messages.add(snapshot.data);
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.78,
                      child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.yellow,
                                    width: 2
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                              ),
                              padding: const EdgeInsets.all(11),
                              margin: const EdgeInsets.all(4),
                              child: Text(messages[index],style: TextStyle(
                                fontWeight: FontWeight.bold,color: Colors.black
                              ),),
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: sendMessage,
          child: const Icon(Icons.send_rounded),
        ));
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      channel.sink.add(controller.text);
      controller.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
    messages.clear();
  }
}
