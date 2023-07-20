import 'package:cinemapedia/domain/entities/login_entities/usuario.dart';
import 'package:cinemapedia/infrastructure/datasources/userbackend_datasource.dart';
import 'package:cinemapedia/presentation/screens/movies/login/components/my_button_registar.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';
import '../components/square_tile.dart';




class RegisterScreen extends StatefulWidget {
  static const String name = 'register-screen';

  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserBackendDatasource _datasource = UserBackendDatasource();

  void signIn() async {
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
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.black,
                ),

                const SizedBox(height: 50),

                // welcome text
                Text(
                  'Registrar una cuenta',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: _userController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: _passwordController,
                  hintText: 'Repeat Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

               
               

                const SizedBox(height: 25),

                // sign in button
                MyButtonR(
                  onTap: signIn,
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Continuar con',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'assets/images/apple.png')
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
