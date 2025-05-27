import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/core/extension_size.dart';
import 'package:usuario_teste_pratico/app/core/utils/auth_error_handler.dart';
import 'package:usuario_teste_pratico/app/modules/auth/provider/login_provider.dart';
import 'package:usuario_teste_pratico/app/widgets/custom_button.dart';
import 'package:usuario_teste_pratico/app/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final loginProvider = Modular.get<LoginProvider>(); 
  final _formKey = GlobalKey<FormState>();

  
  /// Função responsável por realizar o login do usuário.
  ///
  /// Caso o login seja bem-sucedido, redireciona para a página principal (`/users`).
  /// Em caso de erro, exibe uma mensagem apropriada.
  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await loginProvider.login(_emailController.text, _passwordController.text);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("login sucesso")),
        );
        Modular.to.pushNamed('/users');
      } catch (e) {
        if (!context.mounted) return;

        final errorMessage = getAuthErrorMessage(e);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _emailController,
                label: "E-mail",
                icon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _passwordController,
                label: "Senha",
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha';
                  }
                  return null;
                },
              ),
              CustomButton(text: "Entrar", onPressed: () async {
                _login(context);
              }),
              TextButton(onPressed: (){
                Modular.to.pushNamed('/register');
              }, child: Text("Cria conta", style: TextStyle(color: Color(0xFF52B2AD)),))
            ],
          ),
        ),
      ),
    );
  }
}
