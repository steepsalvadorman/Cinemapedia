class Usuario {
  int id;
  final String usuario;
  final String password;
  final String? email;

  Usuario({
    this.id = 0,
    required this.usuario,
    required this.password,
    this.email,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] ?? 0,
      usuario: json['usuario'],
      password: json['password'],
      email: json.containsKey('email') ? json['email'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario': usuario,
      'password': password,
      'email': email,
    };
  }
}


