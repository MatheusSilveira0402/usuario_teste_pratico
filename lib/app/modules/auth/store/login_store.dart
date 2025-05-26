import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usuario_teste_pratico/app/core/env.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';

class LoginStore {
  Future<bool> signIn(String email, String password) async {

    final url = Uri.parse(
      '${Env.apiUrl}/users?email=$email',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      if (data.isEmpty) {
        throw Exception('Usuário não encontrado');
      }

      final user = UserModel.fromJson(data.first);

      if (user.password != password) {
        throw Exception('Senha incorreta');
      }

      return true;
    } else {
      final data = jsonDecode(response.body);
      final error = data['error'] ?? 'Erro desconhecido';
      throw Exception('Falha no login: $error');
    }
  }
}
