import 'dart:convert';

import 'package:mobile/modules/configs/configs.service.dart';
import 'package:mobile/modules/users/logic/users.model.dart';
import 'package:http/http.dart' as http;

class UsersService {
  final config = ConfigService();
  final client = http.Client();

  Future<List<User>> findAll() async {
    try {
      final url = '${config.apiUrl}/users';
      final response = await client.get(url);
      final Iterable json = jsonDecode(response.body);
      final List<User> users =
          List.from(json.map((model) => User.fromJson(model)));

      return users;
    } catch (e) {
      throw e;
    }
  }

  Future<User> findOne(int id) async {
    try {
      final url = '${config.apiUrl}/users/$id';
      final response = await client.get(url);
      final User user = User.fromJson(jsonDecode(response.body));

      return user;
    } catch (e) {
      throw e;
    }
  }
}
