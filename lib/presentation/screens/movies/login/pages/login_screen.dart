import 'package:cinemapedia/domain/entities/login_entities/usuario.dart';
import 'package:cinemapedia/infrastructure/datasources/userbackend_datasource.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login-screen';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserBackendDatasource _datasource = UserBackendDatasource();

  void _signIn() async {
    final user = _userController.text;
    final password = _passwordController.text;
    Usuario usuario = Usuario(usuario: user, password: password);
    try {
      final isValidUser = await _datasource.validarUsuario(usuario);

      if (isValidUser) {
        // Usuario válido, realizar acciones adicionales aquí
        // Por ejemplo, navegar a la siguiente pantalla
        // Navigator.pushNamed(context, NextScreen.name);
        print('Inicio de sesión exitoso');
      } else {
        // Usuario no válido, mostrar mensaje de error o realizar acciones adicionales
        print('Credenciales inválidas');
      }
    } catch (error) {
      // Error al validar el usuario, mostrar mensaje de error o realizar acciones adicionales
      print('Error al validar el usuario: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: 'User',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
