import 'package:flutter/material.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';
import 'package:usuario_teste_pratico/app/modules/users/store/users_store.dart';
import 'package:uuid/uuid.dart';

class UsersProvider extends ChangeNotifier {
  final UsersStore usersStore;
  UsersProvider({required this.usersStore});

  List<UserModel> _users = [];
  bool _isLoading = false;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> getUsers() async {
    _isLoading = true;
    notifyListeners();

    _users = await usersStore.getListUser();

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
        password: password));
    getUsers();
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
        password: password));
    getUsers();
  }

  Future<void> delteUser(
    String id,
  ) async {
    await usersStore.deleteUser(id);
    getUsers();
  }

  bool checkEmail(String email) {
    return users.any((user) => user.email == email);
  }
}
