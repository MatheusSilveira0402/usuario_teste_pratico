import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/core/extension_size.dart';
import 'package:usuario_teste_pratico/app/core/utils/auth_error_handler.dart';
import 'package:usuario_teste_pratico/app/models/user_model.dart';
import 'package:usuario_teste_pratico/app/modules/users/provider/users_provider.dart';
import 'package:usuario_teste_pratico/app/widgets/custom_button.dart';
import 'package:usuario_teste_pratico/app/widgets/custom_text_field.dart';

class UsersFormPage extends StatefulWidget {
  const UsersFormPage({super.key});

  @override
  State<UsersFormPage> createState() => _UsersFormPageState();
}

class _UsersFormPageState extends State<UsersFormPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  final userProvider = Modular.get<UsersProvider>();
  final _formKey = GlobalKey<FormState>();
  late UserModel? userModel;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    userModel = Modular.args.data;
    isEditing = userModel != null && userModel!.id.isNotEmpty;
    if (isEditing) {
      _firstNameController.text = userModel!.firstName.toString();
      _lastNameController.text = userModel!.lastName.toString();
      _emailController.text = userModel!.email.toString();
      _passwordController.text = userModel!.password.toString();
    }
  }

  void _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        if (userProvider.checkEmail(_emailController.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-mail já cadastrado')),
          );
          return;
        }
        if (isEditing) {
          await userProvider.updateUser(userModel!.id, _firstNameController.text,
              _lastNameController.text, _emailController.text, _passwordController.text);
        } else {
          await userProvider.createUser(_firstNameController.text,
              _lastNameController.text, _emailController.text, _passwordController.text);
        }
        if (!context.mounted) return;
        Modular.to.pop();
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
    );
  }
}
