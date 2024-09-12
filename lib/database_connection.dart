import 'package:mysql1/mysql1.dart';
import 'dart:async';

Future getDbConnection() async {
  var con = ConnectionSettings(
    host: '127.0.0.1',
    port: 3306,
    user: 'root',
    db: 'project_one_db',
  );

  var conn = await MySqlConnection.connect(con);
  
  return conn;
}
