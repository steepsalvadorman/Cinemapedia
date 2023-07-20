import 'package:cinemapedia/domain/entities/login_entities/usuario.dart';
import 'package:cinemapedia/infrastructure/datasources/userbackend_datasource.dart';
import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

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

  void signIn(BuildContext context) {
    final user = _userController.text;
    final password = _passwordController.text;
    Usuario usuario = Usuario(usuario: user, password: password);

    _datasource.validarUsuario(usuario).then((isValidUser) {
      if (isValidUser) {
        // Usuario válido, realizar acciones adicionales aquí
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(pageIndex: 0),
          ),
        );
      } else {
        // Usuario no válido, mostrar mensaje de error en un cuadro de diálogo    
      }
    }).catchError((error) {
      // Error al validar el usuario, mostrar mensaje de error o realizar acciones adicionales
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Credenciales inválidas. Por favor, verifica tus datos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
    });
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
                  '¡Bienvenido a Cinemapedia!',
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

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () => context.push('/fpass'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '¿Has olvidado tu contraseña?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: () {
                    signIn(
                        context); // Pasamos el contexto actual del widget al llamar a la función signIn
                  },
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No es un miembro?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => context.push('/register'),
                      child: const Text(
                        'Regístrate ahora',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
