import 'package:cinemapedia/presentation/screens/movies/login/pages/forgot_pass_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';



final appRouter = GoRouter(
  initialLocation: '/login', // Cambiamos la ubicación inicial a la página de inicio de sesión
  routes: [
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => LoginScreen(key: UniqueKey()),
    ),
    GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => RegisterScreen(key: UniqueKey()),
    ),
    GoRoute(
      path: '/fpass',
      name: ForgotPassScreen.name,
      builder: (context, state) => ForgotPassScreen(key: UniqueKey()),
    ),

    GoRoute(
      path: '/home/:page', // Asegúrate de agregar un slash al inicio de la ruta
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.params['page'] ?? '0');

        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:id', // ¡Eliminamos la barra diagonal al inicio de la ruta!
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.params['id'] ?? 'no-id';

            return MovieScreen(movieId: movieId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/', // Asegúrate de agregar un slash al inicio de la ruta
      redirect: (context, state) => Future.value('/login'), // Redirigimos la ruta raíz a la página de inicio de sesión
    ),
  ],
);


