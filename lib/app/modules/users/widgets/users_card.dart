import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';
import 'package:usuario_teste_pratico/app/modules/users/widgets/users_model_delete.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          hoverColor: const Color.fromARGB(176, 248, 248, 248),
          onTap: () {
            Modular.to.pushNamed('/users/form', arguments: user);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.firstName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              IconButton(onPressed: (){
                showDialog(context: context, builder: (chid){
                  return UsersModelDelete(user: user,);
                });
              }, icon: Icon(Icons.delete_forever))
            ],
          ),
        ),
      ),
    );
  }
}
