import 'dart:async';
import 'dart:io';
import 'register_registrar.dart';
import 'user_registration.dart';

// Function to handle actions for "mkuu" (admin)
Future mkuuAct() async {
  // Print options for registering different types of users
  print("What do you want?");
  print("1. Register Registrar");
  print("2. Register Normal User");

  // Prompt user to select an option
  stdout.write("Press 1 to Register Registrar or 2 for Normal user: ");
  var userInput = stdin.readLineSync();

  // Call appropriate registration function based on user input
  if (userInput == "1") {
    registrarRegister(); // Call function to register a registrar
  } else if (userInput == "2") {
    userRegister(); // Call function to register a normal user
  }
}

// Function to be called when an admin logs in successfully
Future mkuuu() async {
  mkuuAct(); // Call the function to handle admin actions
}
