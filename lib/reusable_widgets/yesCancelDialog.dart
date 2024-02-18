import '../features/authentication/presentation/views/signin_screen.dart';
import 'package:flutter/material.dart';

Future<void> yesCancelDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              "Are you sure?".toUpperCase(),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            content: const Text("Do you want to log out?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInView(),
                        ),
                        (route) => false);
                  },
                  child: const Text("Yes"))
            ],
          ));
}
