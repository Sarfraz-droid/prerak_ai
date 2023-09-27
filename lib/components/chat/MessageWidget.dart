import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prerak_ai/services/MessageWidget.class.dart';

class MessageWidget extends HookWidget {
  const MessageWidget({super.key, 
    required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {

    final messageState = useState<Message>(message);

    useEffect(() {
      messageState.value = message;
    }, [message]);

    if(messageState.value.role == "user") {
      return BubbleNormal(
            text: messageState.value.content,
            isSender: messageState.value.role == "user" ? true : false,
            color: messageState.value.role == "user" ? Colors.blue : Colors.grey[800] ?? Colors.grey,
            tail: true,
            textStyle: TextStyle(
              color: Colors.white
            ),
      );

    }

    return Container(
      child: Row(
        mainAxisAlignment: messageState.value.role == "user" ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          messageState.value.role != "user" ? ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(  
              'https://picsum.photos/250?image=9',
              width: 50,         
              height: 50,
            ),
          ) : Container(),
          BubbleNormal(
            text: messageState.value.content,
            isSender: messageState.value.role == "user" ? true : false,
            color: messageState.value.role == "user" ? Colors.blue : Colors.grey[800] ?? Colors.grey,
            tail: true,
            textStyle: TextStyle(
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}