import 'database_connection.dart';
import 'dart:io';
import 'dart:async';

// Function to handle the admin login process
Future adminLogin() async {
  // Establish a database connection
  var conn = await getDbConnection();

  // Print welcome message and prompt for authorization
  print("#" * 30);
  print("#${" Welcome to Admin Panel ".padLeft(15).padRight(28)}#");
  print("#" * 30);
  print("");
  print("Please Authorize your Administrative Identity");
  print("");

  // Prompt user for username
  stdout.write("Enter Your Username: ");
  var userUsername = stdin.readLineSync();

  // Prompt user for password (with input hidden)
  stdout.write("Enter Your Password: ");
  stdin.echoMode = false;
  var userPassword = stdin.readLineSync();
  stdin.echoMode = true;

  // Extract list of usernames from the database
  var dbUsernames = await conn.query("SELECT username FROM users");
  var userList = [];
  for (var user in dbUsernames) {
    userList.add(user.first.toString());
  }

  // Check if the entered username exists in the database
  if (userList.contains(userUsername)) {
    var uUsername = userUsername;

    // Extract the password for the provided username from the database
    var dbPassword = await conn
        .query("SELECT password FROM users WHERE username=?", [uUsername]);
    var names = [];
    var dbNames =
        await conn.query("select * from users where username=?", [uUsername]);

    // Extract user details (name) from the database
    for (var name in dbNames.toList()) {
      names.add(name[0].toString());
      names.add(name[1].toString());
    }
    var realPassword = dbPassword.toList()[0][0];

    // Extract the role for the provided username from the database
    var dbRole = await conn
        .query("SELECT role FROM users WHERE username=?", [uUsername]);
    // var dbRoles =
    //     await conn.query("select * from users where username=?", [uUsername]);
    // for (var role in dbRoles.toList()) {
    //   names.add(role[0].toString());
    //   names.add(role[1].toString());
    // }
    var realRole = dbRole.toList()[0][0];

    // Verify the user's identity by comparing password and role
    if (realPassword.toString() == userPassword.hashCode.toString() &&
        realRole == "Admin") {
      print("");
      print("welcome ${names[0]} ${names[1]}");
      // mkuuu(); // Call function for authenticated users
    }
  } else {
    // Print message if username is not found in the database
    print("Wewe sio Mkuu");
  }
}
