import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blue, Colors.white70])),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("#eceeae"),
            hexStringToColor("#94bbe9"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: logoWidget("assets/images/logo2.png")),
              ),
              SizedBox(height: 80),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Lost And Found Office at International University: ',
                      style: TextStyle(
                        color: Colors.black, // Light style color
                        fontWeight:
                            FontWeight.normal, // Light style font weight
                      ),
                    ),
                    TextSpan(
                      text: 'A2.306',
                      style: TextStyle(
                        color: Colors.black, // Bold style color
                        fontWeight: FontWeight.bold, // Bold style font weight
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 40,),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Lost and Found Page: ',
                      style: TextStyle(
                        color: Colors.black, // Light style color
                        fontWeight:
                            FontWeight.normal, // Light style font weight
                      ),
                    ),
                    TextSpan(
                      text: 'https://www.fb.com/IU.Lost.and.Found', 
                      style: TextStyle(
                        color: Colors.black, // Bold style color
                        fontWeight: FontWeight.bold, // Bold style font weight
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )),
        ));
  }
}
