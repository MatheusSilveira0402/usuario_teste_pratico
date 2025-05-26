import 'package:flutter/cupertino.dart';
import 'package:usuario_teste_pratico/app/modules/auth/store/login_store.dart';

class LoginProvider extends ChangeNotifier {
  final LoginStore loginStore;
  LoginProvider({
    required this.loginStore,
  });
  

   Future<bool> login(email, password) async {
      bool succeso = false;
      succeso = await loginStore.signIn(email, password);
     return succeso;
   }

}