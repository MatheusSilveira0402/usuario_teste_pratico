import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/core/extension_size.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';
import 'package:usuario_teste_pratico/app/modules/users/provider/users_provider.dart';

class UsersModelDelete extends StatelessWidget {
  final UserModel user;

  const UsersModelDelete({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Modular.get<UsersProvider>();
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: context.widthPct(0.9),
          height: context.heightPct(0.18),
          padding: EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Deseja excluir esse Usuário?",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 10,
                  children: [
                    TextButton(
                        child: Text("Não"),
                        onPressed: () async {
                          Modular.to.pop();
                        }),
                    TextButton(
                        child: Text("Sim"),
                        onPressed: () async {
                          usersProvider.delteUser(user.id);
                          Modular.to.pop();
                        }),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
