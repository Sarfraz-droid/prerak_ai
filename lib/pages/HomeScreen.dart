import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prerak_ai/components/home/CharacterCard.dart';
import 'package:prerak_ai/components/home/PostCard.dart';

class HomeScreen extends HookWidget {
  HomeScreen({super.key});

  final List genres = ['All', 'Bollywood Actors', 'Bollywood Actresses', 'Musicians', 'Sports Personalities', 'Television Personalities', 'Fashion Icons', 'Business Magnates', 'Historical Figures', 'Celebrity Chefs', 'National Leaders', 'YouTubers', 'Comedians', 'Authors', 'Reel Characters'];

  final List Characters = [
    {
        "Name": "John Doe",
        "Employment": "Software Engineer"
    },
    {
        "Name": "Alice Smith",
        "Employment": "Marketing Manager"
    },
    {
        "Name": "David Johnson",
        "Employment": "Teacher"
    },
    {
        "Name": "Emily Brown",
        "Employment": "Nurse"
    },
    {
        "Name": "Michael Wilson",
        "Employment": "Accountant"
    }
];

  @override
  Widget build(BuildContext context) {

    final isSearching = useState(false);

    final selectedGenre = useState(0);


    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                        itemCount: genres.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                selectedGenre.value = index;
                              },
                              child: Text(genres[index], 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.poppins().fontFamily
                                )
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  selectedGenre.value == index ? Color.fromARGB(255, 140, 82, 255) : Color.fromARGB(255, 43, 52,65)
                                ),
                                elevation: MaterialStateProperty.all<double>(
                                  0
                                ),
                                shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1
                                    )
                                  ),
                                ),

                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                    color: Colors.white
                                  )
                                )
                              ),
                            ),                            
                            const SizedBox(width: 4)
                      ],
                  ),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: Characters.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      CharacterCard(
                        name: Characters[index]["Name"],
                        career: Characters[index]["Employment"],
                      ),
                      const SizedBox(width: 16)
                    ],
                  ),
                  scrollDirection: Axis.horizontal
                ),
              ),
                        const SizedBox(height: 16),
          Divider(
              color: Colors.white
            ),
          const SizedBox(height: 16),

              Container(
                height: MediaQuery.of(context).size.height - 400,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        PostCard(),
                        const SizedBox(height: 32),
                        Divider(
                          color: Colors.white24
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          )
        )
      )
    );
  }
}