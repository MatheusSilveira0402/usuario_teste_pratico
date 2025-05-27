import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:usuario_teste_pratico/app/core/env.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';

class UsersStore {
  Future<List<UserModel>> getListUser() async {
    final url = Uri.parse(
      '${Env.apiUrl}/users',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isEmpty) {
        return [];
      }

      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      final data = jsonDecode(response.body);
      final error = data['error'] ?? 'Erro desconhecido';
      throw Exception('Falha no login: $error');
    }
  }

  Future<bool> createUser(UserModel userModel) async {
    final url = Uri.parse('${Env.apiUrl}/users');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userModel.toMap()),
    );
    final body = jsonDecode(response.body);
    if (body is Map<String, dynamic>) {
      final id = body['id'];
      final token = body['token'] ?? 'sem token';
      debugPrint('Usuário registrado! ID: $id | Token: $token');
      return true;
    } else {
      final data = jsonDecode(response.body);
      final error = data['error'] ?? 'Erro desconhecido';
      throw Exception('Falha no registro: $error');
    }
  }

  Future<bool> updateUser(UserModel userModel) async {
    final url = Uri.parse('${Env.apiUrl}/users/${userModel.id}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userModel.toMap()),
    );
    final body = jsonDecode(response.body);
    if (body is Map<String, dynamic>) {
      final id = body['id'];
      final token = body['token'] ?? 'sem token';
      debugPrint('Usuário registrado! ID: $id | Token: $token');
      return true;
    } else {
      final data = jsonDecode(response.body);
      final error = data['error'] ?? 'Erro desconhecido';
      throw Exception('Falha no registro: $error');
    }
  }

  Future<bool> deleteUser(String id) async {
    final url = Uri.parse('${Env.apiUrl}/users/$id');

    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    final body = jsonDecode(response.body);
    if (body is Map<String, dynamic>) {
      final id = body['id'];
      final token = body['token'] ?? 'sem token';
      debugPrint('Usuário registrado! ID: $id | Token: $token');
      return true;
    } else {
      final data = jsonDecode(response.body);
      final error = data['error'] ?? 'Erro desconhecido';
      throw Exception('Falha no registro: $error');
    }
  }
}
