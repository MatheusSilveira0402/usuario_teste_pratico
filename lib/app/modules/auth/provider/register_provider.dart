import 'package:flutter/cupertino.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';
import 'package:usuario_teste_pratico/app/modules/auth/store/register_store.dart';
import 'package:usuario_teste_pratico/app/modules/users/provider/users_provider.dart';
import 'package:uuid/uuid.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterStore registerStore;
  final UsersProvider usersProvider;

  RegisterProvider({
    required this.registerStore,
    required this.usersProvider,
  });

  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    final sucesso = await registerStore.signUp(
      UserModel(
        id: Uuid().v4(),
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
      ),
    );
    return sucesso;
  }

  Future<bool> checkEmail(String email) async {
    await usersProvider.getUsers();
    return usersProvider.checkEmail(email);
  }
}

