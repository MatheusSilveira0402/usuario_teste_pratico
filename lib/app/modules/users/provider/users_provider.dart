import 'package:flutter/material.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';
import 'package:usuario_teste_pratico/app/modules/users/store/users_store.dart';
import 'package:uuid/uuid.dart';

class UsersProvider extends ChangeNotifier {
  final UsersStore usersStore;
  UsersProvider({required this.usersStore});

  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];
  bool _isLoading = false;

  List<UserModel> get users => _filteredUsers.isEmpty ? _users : _filteredUsers;
  bool get isLoading => _isLoading;

  Future<void> getUsers() async {
    _isLoading = true;
    notifyListeners();

    _users = await usersStore.getListUser();
    _filteredUsers.clear(); 
    _isLoading = false;
    notifyListeners();
  }

  Future<void> createUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    await usersStore.createUser(UserModel(
      id: Uuid().v4(),
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
    ));
    await getUsers();
  }

  Future<void> updateUser(
    String id,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    await usersStore.updateUser(UserModel(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
    ));
    await getUsers();
  }

  Future<void> delteUser(String id) async {
    _users.removeWhere((element) => element.id == id);
    _filteredUsers.removeWhere((element) => element.id == id);
    notifyListeners();
    await usersStore.deleteUser(id);
  }

  bool checkEmail(String email) {
    return _users.any((user) => user.email == email);
  }

  /// Filtra a lista de usuários pelo e-mail (mínimo de 4 caracteres)
  void filterUsersByEmail(String query) {
    if (query.length > 1) {
      final lowerQuery = query.toLowerCase();
      _filteredUsers = _users
          .where((user) => user.email.toLowerCase().contains(lowerQuery))
          .toList();
    } else {
      _filteredUsers.clear();
    }
    notifyListeners();
  }
}

