import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/core/extension_size.dart';
import 'package:usuario_teste_pratico/app/core/utils/register_error_handler.dart';
import 'package:usuario_teste_pratico/app/modules/auth/provider/register_provider.dart';
import 'package:usuario_teste_pratico/app/widgets/custom_button.dart';
import 'package:usuario_teste_pratico/app/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final registerProvider = Modular.get<RegisterProvider>();
  final _formKey = GlobalKey<FormState>();

  void _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await registerProvider.register(_firstNameController.text,
            _lastNameController.text, _emailController.text, _passwordController.text);
        Modular.to.navigate('/users');
      } catch (e) {
        if (!context.mounted) return;

        final errorMessage = getRegisterErrorMessage(e);

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
      appBar: AppBar(
        toolbarHeight: context.heightPct(0.15),
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text("Registrei"),
        centerTitle: true,
      ),
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          padding:EdgeInsets.all(5),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10.0,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _firstNameController,
                  label: "Primeiro nome",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um email';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _lastNameController,
                  label: "Sobrenome",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma senha';
                    }
                    return null;
                  },
                ),
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
                CustomButton(
                    text: "Registrar",
                    onPressed: () async {
                      _register(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
