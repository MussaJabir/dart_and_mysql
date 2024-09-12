import 'dart:io';
import 'user_registration.dart';
import 'login.dart';
import 'admin.dart';



void main() async {
  // Print welcome message and options
  print("=" * 30);
  print("=    Welcome to Our System    =");
  print("=" * 30);
  print("");
  print("=== Select an option below ===");
  print("=== 1. Login                ===");
  print("=== 2. Register             ===");

  // Prompt user to select an option
  stdout.write("Press (1) to Login or Press (2) to register: ");
  var userSelection = stdin.readLineSync();

  // Handle user selection for login or registration
  if (userSelection == "1") {
    // Prompt user to choose login role
    print("Who are you?");
    print("1. Normal User");
    print("2. Mkuu");
    stdout.write("Press 1 or 2: ");

    var loginRole = stdin.readLineSync();

    // Call appropriate login function based on role
    if (loginRole == "1") {
      login(); // Call function to handle normal user login
    } else if (loginRole == "2") {
      adminLogin(); // Call function to handle admin login
    }
  } else if (userSelection == "2") {
    userRegister(); // Call function to handle user registration
  }
}
