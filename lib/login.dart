import 'database_connection.dart';
import 'dart:io';
import 'view_academic_details.dart';
import 'reset_password.dart';  

Future login() async {
  var conn = await getDbConnection();

  print("=== Welcome to Our Login Page ===");
  print("=== Please Authorize Your Identity ===");

  stdout.write("Enter your username: ");
  var userUsername = stdin.readLineSync();

  stdout.write("Enter your password: ");
  stdin.echoMode = false;
  var userpassword = stdin.readLineSync();
  stdin.echoMode = true;
  print("");

  var dbusernames = await conn.query("SELECT username FROM users");
  var userList = [];
  for (var user in dbusernames) {
    userList.add(user.first.toString());
  }

  if (userList.contains(userUsername)) {
    var uusername = userUsername;
    var dbpassword = await conn
        .query("SELECT password FROM users WHERE username=?", [uusername]);
    var names = [];
    var dbnames =
        await conn.query("select * from users where username=?", [uusername]);

    for (var name in dbnames.toList()) {
      names.add(name[0].toString());
      names.add(name[1].toString());
    }
    var realPassword = dbpassword.toList()[0][0];
    int failedAttempts = 0;

    while (failedAttempts < 3) {
      if (realPassword.toString() == userpassword.hashCode.toString()) {
        print("Welcome, ${names[0]} ${names[1]}!");
        print('Would you like to view your academic details?');
        stdout.write(
            "Press (1) to accept viewing academic information or (2) to cancel: ");
        var userChoice = stdin.readLineSync();
        if (userChoice == '1') {
          acDetails();
        } else {
          exit(0);
        }
        await conn.close();
        return;
      } else {
        failedAttempts++;
        if (failedAttempts < 3) {
          print("Incorrect password. Please try again.");
          stdout.write("Enter your password: ");
          stdin.echoMode = false;
          userpassword = stdin.readLineSync();
          stdin.echoMode = true;
          print("");
        } else {
          print("You have entered an incorrect password 3 times.");
          int resetAttempts = 0;
          while (resetAttempts < 2) {
            stdout.write("Would you like to reset your password? (yes/no): ");
            var resetChoice = stdin.readLineSync()?.toLowerCase();
            if (resetChoice == 'yes') {
              await resetPassword();
              return;
            } else if (resetChoice == 'no') {
              print("Login process terminated. Please try again later.");
              exit(0);
            } else {
              resetAttempts++;
              if (resetAttempts < 2) {
                print("Invalid input. Please answer 'yes' or 'no'.");
              }
            }
          }
          print("Too many invalid attempts. Please try again later.");
          exit(0);
        }
      }
    }
  } else {
    print("Incorrect password or username");
  }

  await conn.close();
}
