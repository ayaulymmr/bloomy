import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/login_view_model.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Аккаунт')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: loginVM.isLoggedIn
            ? _buildAccountInfo(context, loginVM)
            : _buildLoginForm(context, loginVM),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginViewModel loginVM) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Вход', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Введите email';
              }
              if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$')
                  .hasMatch(value.trim())) {
                return 'Некорректный email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Пароль'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Введите пароль';
              }
              if (value.trim().length < 6) {
                return 'Минимум 6 символов';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                loginVM.login(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              }
            },
            child: const Text('Войти'),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfo(BuildContext context, LoginViewModel loginVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/images/girl-cute-cartoon-small-fresh-avatar-character_2718518.png!sw800.jpeg'),
        ),
        const SizedBox(height: 16),
        Text(
          'Добро пожаловать,',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          loginVM.email,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        const Text('Дата регистрации: 01.01.2023'), // Заглушка
        const SizedBox(height: 24),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.receipt_long),
          title: const Text('Мои заказы'),
          onTap: () {
            Navigator.pushNamed(context, '/orders');
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Настройки'),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: const Text('Поддержка'),
          onTap: () {
            Navigator.pushNamed(context, '/support');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Выйти', style: TextStyle(color: Colors.red)),
          onTap: () {
            loginVM.logout();
          },
        ),
      ],
    );
  }
}

