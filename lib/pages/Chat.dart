import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prerak_ai/components/chat/MessageWidget.dart';
import 'package:prerak_ai/services/MessageWidget.class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class ChatScreen extends HookWidget {
  const ChatScreen({super.key,
    this.name = "",
    this.designation = ""
  });


  final String name;
  final String designation;

  @override
  Widget build(BuildContext context) {

  final ScrollController _scroll_controller = ScrollController();
    final _controller = TextEditingController();
    final isSearching = useState(false);


    final messageState = useState<List<Message>>([
      Message("Hello there! This is $name. I'm a $designation", "system")
    ]);

    useEffect(() {
      print("Message State");
        print(_scroll_controller.hasClients);

        if(_scroll_controller.hasClients){
          _scroll_controller.animateTo(
            _scroll_controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }

    }, [messageState.value]);

    final isFetching = useState(false);

    final text = useState("");

    useEffect(() {
      print("Message State");
      print(messageState.value);
    },[messageState]);

    void onAddMessage() async {
      try{
        FocusScope.of(context).unfocus();

        _scroll_controller.animateTo(
          _scroll_controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );


      messageState.value.add(Message(_controller.text, "user"));
      _controller.clear();
      text.value = "";
      final List messages = messageState.value.map((e) => e.toJson()).toList();
      messageState.value.add(Message("Thinking...", "system"));  
      isFetching.value = true;

      print("Sending request");

      Object body= {
        "model": "gpt-3.5-turbo",
        "messages": messages,    
      };

      print(body);
      


      final _key = dotenv.env['OPEN_AI_API'];

      print(_key);

      var response = await http.post(
        // Uri.parse('https://api.openai.com/v1/chat/completions'),
        Uri.https('api.openai.com','v1/chat/completions'),
        headers: <String,String>{
          "Authorization": "Bearer $_key",
          "Content-Type": "application/json"
        },
        body: jsonEncode(body)
      );

      print(response.body);

      var data = jsonDecode(response.body);

      messageState.value.removeLast();

      if(data['choices'][0]['message'] != null) {
        messageState.value.add(Message(data['choices'][0]['message']['content'], "system"));
      } else {
        messageState.value.add(Message("Sorry, I didn't get that. Can you please rephrase?", "system"));
      }

      messageState.value = [
        ...messageState.value
      ];

      _scroll_controller.animateTo(
          _scroll_controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
      );


      isFetching.value = false;

      } catch(e) {
        print(e);
      }

    }
    


    // useEffect(() {

    // },[m]);

    return WillPopScope(
      onWillPop: () async {
        context.goNamed('home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: isSearching.value ? 
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: TextStyle(
                  color: Colors.white
                ),
              )
           : Image.network(
              'https://res.cloudinary.com/confused-bachlors/image/upload/v1695798930/Logo.51a02919_ugcpix.png',
              width: 100,
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              isSearching.value = !isSearching.value;
            },
            icon: isSearching.value ? Icon(Icons.delete) : Icon( Icons.search),
          ),
          elevation: 0,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey[400]!.withOpacity(0.2),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex:2,
                        child: Center(
                          child: Container(
                            child: IconButton.outlined(onPressed: () {
                              context.goNamed('home');
                            },
                              icon: Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                // fontFamily: GoogleFonts.getFont('Poppins')?.fontFamily
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("Created by @Admin",
                              style: TextStyle(
                                // fontFamily: GoogleFonts.getFont('Poppins')?.fontFamily
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Center(
                            child: IconButton.outlined(onPressed: () {
                              Clipboard.setData(ClipboardData(text: name));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Copied to clipboard"),
                                  duration: Duration(milliseconds: 500),
                                )
                              );
                            }, 
                              icon: Icon(Icons.copy),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Scrollbar(
    
                        child: ListView(
                          controller: _scroll_controller,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 43, 52, 65),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("Remember: Everything the character says can be made up!",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.6)
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),  
                            SizedBox(height: 16),
                            for (var i = 0; i < messageState.value.length; i++) 
                              MessageWidget(
                                message: messageState.value[i],
                              ),
                              SizedBox(height: 16),
                                                      if(messageState.value.length == 1) 
                              Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 16),
                                      Text("No messages yet. Start the conversation!",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _controller.text = "What is your name?";
                                          onAddMessage();
                                        }, 
                                        child: Text("What is your name?",
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            Color.fromARGB(119, 47, 47, 47)
                                          ),
                                          
                                        ),
                                      ),
                                      ElevatedButton(                                      onPressed: () {
                                          _controller.text = "What is your designation?";
                                          onAddMessage();
                                        }, child: Text("What is your designation?",
                                        style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            Color.fromARGB(119, 47, 47, 47)
                                          ),
                                          
                                        )),
                                      ElevatedButton(                                      
                                        onPressed: () {
                                          _controller.text = "What is your age?";
                                          onAddMessage();
                                        },
                                        child: Text("What is your age?",                                        style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                            Color.fromARGB(119, 47, 47, 47)
                                          ),                                        
                                        ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
    
                          ],
                        ),
                      ),
                    )
                  )
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _controller,      
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Enter your username',
                                hintText: "Enter Text..",
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                fillColor: Colors.white12,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 0, color: Colors.transparent),
                                       //<-- SEE HERE
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder( //<-- SEE HERE
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent), 
                                  borderRadius: BorderRadius.circular(50.0),
    
                                ),
    
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          onAddMessage();
                        },
                      )
                    ],
                  ),
                )              
                
              ],
            )
          ),
        )
      ),
    );
  }
}