import 'package:flutter/material.dart';
import 'package:usuario_teste_pratico/app/core/extension_size.dart';
import 'package:usuario_teste_pratico/app/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        width: context.screenWidth,
        height: context.screenHeight,
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: TextEditingController(),
              label: "E-email",
              icon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um email';
                }
                return null;
              },
            ),
            CustomTextField(
              controller: TextEditingController(),
              label: "Senha",
              icon: Icons.lock_outline,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma senha';
                }
                return null;
              },
            )
          ],
        ),
      ),
    );
  }
}
