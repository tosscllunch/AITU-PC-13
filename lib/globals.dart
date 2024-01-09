library my_prj.globals;

import 'package:postgres/postgres.dart';

connection() {
  var connection = PostgreSQLConnection(
      "62.84.121.141", // hostURL
      5432, // port
      "mua_db_v2", // databaseName
      username: "postgres",
      password: "admin",
      useSSL: false);

  return connection;
}

// connection() {
//   var connection = PostgreSQLConnection(
//       "158.160.10.54", // hostURL
//       5432, // port
//       "mua_db_v1", // databaseName
//       username: "postgres",
//       password: "admin",
//       useSSL: false);

//   return connection;
// }

final List userInfoFinal = <String>[
  "aaaa@aaa.com",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  ""
];
