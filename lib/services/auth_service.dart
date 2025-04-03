class AuthService {
  // Este método simula la autenticación de un usuario.
  static Future<bool> login(String email, String password) async {
    try {
      // Lógica de ejemplo (autenticación simulada):
      if (email == "test@example.com" && password == "password123") {
        return true; // Login exitoso
      }
      return false; // Login fallido
    } catch (e) {
      print("Error en la autenticación: $e");
      return false; // Si ocurre un error, retornamos false
    }
  }

  // Este método simula el registro de un usuario.
  static Future<bool> register(String email, String password) async {
    try {
      // Lógica de ejemplo para el registro (puedes conectarlo con una base de datos o una API)
      if (email.isNotEmpty && password.isNotEmpty) {
        // Simulación de registro exitoso
        print("Usuario registrado exitosamente: $email");
        return true; // Registro exitoso
      } else {
        return false; // Si los campos están vacíos, no se puede registrar
      }
    } catch (e) {
      print("Error en el registro: $e");
      return false; // Si ocurre un error, retornamos false
    }
  }
}
