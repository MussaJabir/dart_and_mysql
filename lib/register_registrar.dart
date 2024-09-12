 // ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'login.dart';
import 'database_connection.dart';

// Function to handle the registration of a registrar
Future registrarRegister() async {
  // Establish a database connection
  var conn = await getDbConnection();

  // Print registration introduction
  print("===== WELCOME TO OUR REGISTRATION ====="); 
  print("");

// Prompt user for their first name
  stdout.write("1. Enter your first name: ");
  var fName = stdin.readLineSync();

// Prompt user for their last name
  stdout.write("2. Enter your last name: ");
  var lName = stdin.readLineSync();

// Prompt user to select their gender
  print("");
  print("===== Select Your Gender =====");
  print("1. Male");
  print("2. Female");

  stdout.write("Press (1) for Male or (2) for Female: ");
  var userGender = stdin.readLineSync();

  // Determine gender based on user input
  // ignore: prefer_typing_uninitialized_variables
  var gender;
  if (userGender == "1") {
    gender = "MALE";
  } else if (userGender == "2") {
    gender = "FEMALE";
  }

  // Prompt user for a username
  stdout.write("====3. Enter your username: ");
  var username = stdin.readLineSync();

  // Prompt user for a password (input hidden)
  stdout.write("====4. Enter your password: ");
  stdin.echoMode = false;
  var password = stdin.readLineSync().hashCode;
  stdin.echoMode = true;
  print("");

  // Prompt user to verify their password (input hidden)
  stdout.write("====5. Enter your password to verify: ");
  stdin.echoMode = false;
  var verPassword = stdin.readLineSync().hashCode;
  stdin.echoMode = true;
  print("");

  // Set user role to "registrar"
  var urole = "registrar";
  // ignore: prefer_typing_uninitialized_variables
  var pasword;

  // Check if the passwords match
  if (password == verPassword) {
    pasword = verPassword;

    // Insert user data into the database
    // ignore: unused_local_variable
    var userDataInsert = await conn.query(
        'INSERT INTO users VALUES(?,?,?,?,?,?)',
        [fName, lName, gender, username, pasword, urole]);

    await conn.close(); // Close the database connection

    // Print success message and prompt user for login
    print("Thank you for using our registration menu");
    print("=====You are successfully registered=====");
    print(" ______________________________________ ");
    print("#______________________________________#");
    print("You Want to login...?: ");
    print("1. Yes");
    print("2. No");

    // Prompt user to decide if they want to log in
    stdout.write("Press (1) to accept login page or (2) to cancel ");
    var userAcception = stdin.readLineSync();
    if (userAcception == "1") {
      login(); // Call login function if user wants to log in
    } else {
      exit(0); // Exit the program if user does not want to log in
    }
  } else {
    // Print error message if passwords do not match
    print("Password did not match, try again later");
    exit(0); // Exit the program on failure
  }
}
