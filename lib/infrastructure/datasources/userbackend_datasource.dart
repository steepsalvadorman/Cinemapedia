import 'package:cinemapedia/domain/datasources/backendnode.dart';
import 'package:cinemapedia/domain/entities/login_entities/usuario.dart';
import 'package:dio/dio.dart';

class UserBackendDatasource extends UsuarioDatasource {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.0.108:8000',
  ));

  @override
Future<bool> validarUsuario(Usuario user) async {
  try {
    // Realizar la solicitud HTTP para validar las credenciales de usuario
    Response response = await _dio.post(
      '/user/validate',
      data: {
        'user': user.usuario,
        'password': user.password,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    // Verificar el estado de la respuesta HTTP
    if (response.statusCode == 200) {
      // Verificar si el campo "email" está presente en la respuesta JSON
      return response.data.containsKey('email');
    } else {
      // Manejar el caso en que la respuesta no sea exitosa
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (error) {
    // Mostrar el error en la consola
    print('Error al validar el usuario: $error');
    throw Exception('Error al validar el usuario: $error');
  }
}




}
