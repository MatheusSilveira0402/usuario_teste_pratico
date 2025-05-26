import 'package:flutter/material.dart';
import 'package:usuario_teste_pratico/app/core/extension_size.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [

          ],
        ),
      ),
    );
  }
}