import 'package:cinemapedia/domain/datasources/backendnode.dart';
import 'package:cinemapedia/domain/entities/login_entities/usuario.dart';
import 'package:dio/dio.dart';

class UserBackendDatasource extends UsuarioDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.18.27:4000',
  ));

@override
Future<bool> validarUsuario(Usuario user) async {
  try {
    // Realizar la solicitud HTTP para validar las credenciales de usuario
    Response response = await _dio.post(
      '/validate',
      data: {
        'username': user.usuario,
        'password': user.password,
      },
      options: Options(contentType: Headers.jsonContentType),
    );

    // Verificar el estado de la respuesta HTTP
    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON
      Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

      // Verificar si la autenticación fue exitosa en la respuesta del servidor
      bool authenticated = responseData['authenticated'] ?? false;
      String message = responseData['message'] ?? '';

      // Mostrar el mensaje en la consola
      if (authenticated) {
        print('Usuario válido');
      } else {
        print('Usuario no válido: $message');
      }

      return authenticated;
    } else {
      // Si el servidor responde con cualquier otro código, se considera que el usuario no es válido
      print('Error en la solicitud HTTP: ${response.statusCode}');
      return false;
    }
  } catch (error) {
    // Mostrar el error en la consola
    print('Error al validar el usuario: $error');
    throw Exception('Error al validar el usuario: $error');
  }
}







}
