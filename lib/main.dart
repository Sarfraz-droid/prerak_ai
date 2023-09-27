import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:prerak_ai/pages/Chat.dart';
import 'package:prerak_ai/pages/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    final _router = GoRouter(
      routes: [
        GoRoute(
          name: 'home',
          path: '/',
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          name: 'chat',
          path: '/chat/:name/:designation',
          builder: (context, state) => ChatScreen(
            name: state.pathParameters["name"] ?? "",
            designation: state.pathParameters["designation"] ?? "",            
          ),
        ),
      ],
    );

    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          background: Color.fromARGB(255,6,21,43),
          primary: Colors.white
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        )        

      ),
      routerConfig: _router,
    );

  }
}
