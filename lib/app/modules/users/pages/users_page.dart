import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:usuario_teste_pratico/app/core/extension_size.dart';
import 'package:usuario_teste_pratico/app/modules/users/provider/users_provider.dart';
import 'package:usuario_teste_pratico/app/modules/users/widgets/users_card.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    final usersProvider = context.read<UsersProvider>();
    Future.microtask(() {
      if (mounted) {
        usersProvider.getUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerUser = context.watch<UsersProvider>();
    if (providerUser.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final users = providerUser.users;
    if (users.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Nenhum usuário encontrado')),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: context.screenWidth,
            height: context.screenHeight,
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(user: user);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF52B2AD),
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          onPressed: () {
            Modular.to.pushNamed('/users/form');
          }),
    );
  }
}
