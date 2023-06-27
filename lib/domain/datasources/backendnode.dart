
import 'package:cinemapedia/domain/entities/login_entities/usuario.dart';

abstract class UsuarioDatasource {

  
  Future<bool> validarUsuario(Usuario user);
  
}
