import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(130),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 233, 147, 148),
                          offset: Offset(12.9, 12.9),
                          blurRadius: 40,
                          spreadRadius: 0.0,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(255, 250, 202, 184),
                          offset: Offset(-12.9, -12.9),
                          blurRadius: 30,
                          spreadRadius: 0.0,
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 236, 118, 120),
                          Color.fromARGB(255, 246, 180, 155)
                        ],
                        transform: GradientRotation(0.7),
                      )),
                  height: 500,
                  width: 300,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(70),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  child: Transform.translate(
                    offset: const Offset(-40, -90),
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 247, 141, 143),
                              Color(0xffed9397),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(130),
                            topLeft: Radius.circular(130),
                            bottomLeft: Radius.circular(140),
                            bottomRight: Radius.circular(140),
                          )),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(50, 0),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 190, 103, 103),
                          offset: Offset(12.9, 12.9),
                          blurRadius: 30,
                          spreadRadius: 0.0,
                        ),
                      ],
                      // color: Colors.red,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(23, -35),
                  child: Image.asset(
                    'assets/images/bread.png',
                    height: 140,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 170),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Breakfast',
                        style: GoogleFonts.raleway(
                            fontSize: 34,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Bread,',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Peanut Butter,',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Apple',
                        style: GoogleFonts.raleway(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: '525', style: TextStyle(fontSize: 60)),
                        TextSpan(
                          text: '  kcal',
                          style: GoogleFonts.raleway(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ]))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
