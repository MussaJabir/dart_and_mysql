import 'database_connection.dart';
import 'dart:async';
import 'dart:io';
import 'login.dart';

Future userRegister() async {
  var conn = await getDbConnection();

  print("=====WELCOME TO OUR REGISTRATION =====");
  print("");

  stdout.write("====1. Enter your first name: ");
  var firstName = stdin.readLineSync();

  stdout.write("====2. Enter your last name: ");
  var lastName = stdin.readLineSync();

  print("===== Select Your Gender =====");
  print("===== 1. Male            ======");
  print("===== 2. Female          =====");
  stdout.write("Press (1) for Male or (2) for Female: ");
  var userGender = stdin.readLineSync();

  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var Gender;
  if (userGender == '1') {
    Gender = 'Male';
  } else if (userGender == '2') {
    Gender = 'Female';
  }

  stdout.write("====3. Enter your username: ");
  var username = stdin.readLineSync();

  stdout.write("====4. Enter your course name: ");
  var courseName = stdin.readLineSync();

  stdout.write("====5. Enter your institution name: ");
  var institutionName = stdin.readLineSync();

  stdout.write("====6. Enter your year of completion: ");
  var yearCompletion = stdin.readLineSync();

  stdout.write("====7. Enter your GPA: ");
  var gPa = stdin.readLineSync();

  // Password validation loop
  String password;
  while (true) {
    stdout.write("====8. Enter your password: ");
    stdin.echoMode = false;
    password = stdin.readLineSync()!;
    stdin.echoMode = true;
    print("");

    // Check password complexity
    if (!isValidPassword(password)) {
      print("Password must be at least 8 characters long, contain letters, numbers, and at least one symbol.");
    } else {
      break;
    }
  }

  stdout.write("====9. Enter your password to verify: ");
  stdin.echoMode = false;
  var verPassword = stdin.readLineSync();
  stdin.echoMode = true;
  print("");

  if (password != verPassword) {
    print("Passwords did not match, try again later.");
    exit(0);
  }

  var hashedPassword = password.hashCode;
  var urole = "Normal";

  // Insert user data into the database
  await conn.query(
    'INSERT INTO users VALUES(?,?,?,?,?,?)',
    [firstName, lastName, Gender, username, hashedPassword, urole]
  );

  await conn.query(
    'INSERT INTO academic_details VALUES(?,?,?,?,?)',
    [username, courseName, institutionName, yearCompletion, gPa]
  );

  await conn.close();

  print("===== You are successfully registered =====");
  print("");
  print(" ______________________________________ ");
  print("#                                      #");
  print("You want to login...?");
  print("1. Yes");
  print("2. No");

  // Prompt user to decide if they want to log in
  stdout.write("Press (1) to accept login page or (2) to cancel: ");
  var userAcception = stdin.readLineSync();
  if (userAcception == "1") {
    login(); // Call login function if user wants to log in
  } else {
    exit(0); // Exit the program if user does not want to log in
  }
}

// Function to validate password complexity
bool isValidPassword(String password) {
  // Check length, letters, digits, and symbols
  bool hasMinLength = password.length >= 8;
  bool hasLetter = password.contains(RegExp(r'[A-Za-z]'));
  bool hasDigit = password.contains(RegExp(r'\d'));
  bool hasSymbol = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  return hasMinLength && hasLetter && hasDigit && hasSymbol;
}
