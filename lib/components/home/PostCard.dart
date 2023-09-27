import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostCard extends HookWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(  
                      faker.image.image(
                        keywords: ['people', 'nature'],
                        random: true,
                        width: 75,
                        height: 75,
                      ),
                      width: 75,         
                      height: 75,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(faker.person.name(), 
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(faker.job.title(),
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              const SizedBox(width: 16), 
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(faker.lorem.sentence(), 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white
                        ),

                      ),
                    ),
                    color: Color.fromARGB(38, 224, 224, 224),  
                    width: MediaQuery.of(context).size.width,  
                  ),
                ),
              ),
              SizedBox(height: 16),
                          Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(faker.lorem.sentence(), 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white
                        ),

                      ),
                    ),
                    color: Color.fromARGB(38, 224, 224, 224),  
                    width: MediaQuery.of(context).size.width,  
                  ),
                ),
              ),
              SizedBox(height: 16),
                            Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(faker.lorem.sentence(), 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                    color: Color.fromARGB(38, 224, 224, 224),  
                    width: MediaQuery.of(context).size.width,  
                  ),
                ),
              ),
            ],
          )
          
        ],
      )
    );
  }
}