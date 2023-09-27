import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:faker/faker.dart';

class CharacterCard extends HookWidget {
  const CharacterCard({super.key,
    this.name,
    this.career,
  });

  final String? name;
  final String? career;



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(0)
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily
            
          )
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(38, 224, 224, 224)
        ),
      ),
      clipBehavior: Clip.none,
      onPressed: () {
        context.goNamed('chat', pathParameters: {
          "name": name ?? "",
          "designation": career ?? ""
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 250,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(  
                         faker.image.image(
                            keywords: ["person", "people"],
                            random: true,
                            width: 75,
                            height: 75,
                         ),
                         width: 75,         
                         height: 75,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(name ?? "Unknown",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(career ?? "Unknown",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("@Admin",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6)
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text("2h ago",
                                        style: TextStyle(
                        color: Colors.white.withOpacity(0.6)
                      ),
              )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}