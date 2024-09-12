import 'dart:io';
import 'database_connection.dart';

// Function to view academic details for a user
Future acDetails() async {
  // Establish a database connection
  var conn = await getDbConnection();
  
  // Print welcome message and prompt for user identity authorization
  print("===  Welcome to Our Viewing Academic Details Page  ===");
  print("===  Please Authorize Your Identity  ===");
  
  // Prompt user for their username
  stdout.write("Enter your username: ");
  var userUsername = stdin.readLineSync();
  print("");
  
  // Extract list of usernames from the academic details table
  var dbusernames = await conn.query("SELECT username FROM academic_details");
  var userList = [];
  for (var user in dbusernames) {
    userList.add(user.first.toString());
  }
  
  // Check if the entered username exists in the academic details table
  if (userList.contains(userUsername)) {
    var uusername = userUsername;
    var names = [];
    
    // Retrieve academic details for the provided username
    var dbnames = await conn.query("SELECT * FROM academic_details WHERE username=?", [uusername]);

    for (var name in dbnames.toList()) {
      names.add(name[0].toString()); // Add username
      names.add(name[1].toString()); // Add course name
      names.add(name[2].toString()); // Add institution name
      names.add(name[3].toString()); // Add year of completion
      names.add(name[4].toString()); // Add GPA
    }
    
    // Print the retrieved academic details
    print("Your username is '${names[0]}', Course name '${names[1]}', Institution name '${names[2]}', "
      "year of completion '${names[3]}', and GPA is '${names[4]}'.");
    
    await conn.close(); // Close the database connection
  } else {
    print("Username not found in academic details.");
    await conn.close(); // Close the database connection
  }
}
