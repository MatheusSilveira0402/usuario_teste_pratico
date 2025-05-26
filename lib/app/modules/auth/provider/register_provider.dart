import 'package:flutter/cupertino.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';
import 'package:usuario_teste_pratico/app/modules/auth/store/register_store.dart';
import 'package:uuid/uuid.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterStore registerStore;
  RegisterProvider({
    required this.registerStore,
  });

  Future<bool> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    bool succeso = false;

    succeso = await registerStore
        .signUp(UserModel(id:Uuid().v4(), email: email, firstName: firstName, lastName: lastName, password: password));
    return succeso;
  }
}
