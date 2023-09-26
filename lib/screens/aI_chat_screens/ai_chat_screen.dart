import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laws/constants/constants.dart';
import 'package:laws/models/chat_model.dart';
import 'package:laws/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_provider.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({Key? key}) : super(key: key);

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  List<ChatModel> chatList = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    Timer(const Duration(milliseconds: 100), () {
      controller.jumpTo(controller.position.maxScrollExtent + 100);
    });
    super.initState();
  }

  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      chatList
          .add(ChatModel(sentByMe: true, message: _textEditingController.text));
      _textEditingController.clear();
      controller.animateTo(
        controller.position.maxScrollExtent + 250,
        duration: const Duration(milliseconds: 500),
        // Adjust the duration as per your preference
        curve: Curves.easeOut, // Adjust the curve for the scrolling animation
      );
      Provider.of<ChatProvider>(context, listen: false)
          .chatQuestions(_textEditingController.text)
          .then((value) {
        chatList.add(ChatModel(
            sentByMe: false,
            message: Provider.of<ChatProvider>(context, listen: false).reply));
        setState(() {});
        controller.animateTo(
          controller.position.maxScrollExtent + 250,
          duration: const Duration(milliseconds: 500),
          // Adjust the duration as per your preference
          curve: Curves.easeOut, // Adjust the curve for the scrolling animation
        );
        // controller.jumpTo(controller.position.maxScrollExtent + 100);
      });
    }
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
          builder: (ctx, provider, child) => Container(
                padding: const EdgeInsets.all(25),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: chatList.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return !chatList[index].sentByMe
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(10)),
                                          child: Image.asset(
                                            'images/bot.png',
                                            height: 40,
                                            width: 40,
                                          ),
                                        ),
                                        Card(
                                          margin: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15),
                                          color: Colors.brown.shade500,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              chatList[index].message.trim(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10)),
                                          child: provider.currentUser ==
                                                  null || provider.currentUser!.image == null
                                              ? Image.asset(
                                                  'images/user.jpg',
                                                  height: 40,
                                                  width: 40,
                                                )
                                              : Image.network(
                                                  provider.currentUser!.path +
                                                      provider
                                                          .currentUser!.image!,
                                                  height: 40,
                                                  width: 40,
                                                ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Colors.brown.shade500,
                                                  width: 1.5),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20))),
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            chatList[index].message,
                                            style: TextStyle(
                                                color: Colors.brown.shade500),
                                          ),
                                        ),
                                      ],
                                    );
                            },
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Legal Advisor AI',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.shade500),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: Divider(
                              thickness: 1.5,
                              color: Colors.brown.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.075, top: 10),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: Colors.brown.shade500),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: Colors.brown.shade500),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: 'Enter text',
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: _sendMessage,
                                child: Ink(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.brown.shade500,
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}
