import 'package:flutter/material.dart';
import '/services/auth_service.dart'; // Asegúrate de que AuthService esté correctamente implementado
import '/screens/home_screen.dart'; // Asegúrate de que la pantalla home_screen.dart exista

class LoginScreen extends StatelessWidget {
  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de texto para el correo electrónico
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            // Campo de texto para la contraseña
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Obtener los valores de los controladores de texto
                String email = _emailController.text;
                String password = _passwordController.text;

                // Verificar que el correo y la contraseña no estén vacíos
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter email and password')),
                  );
                  return;
                }

                // Intentar iniciar sesión con AuthService
                bool success = await AuthService.login(email, password);

                // Si el inicio de sesión fue exitoso, navegar a la pantalla de inicio
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Mostrar mensaje de error si el inicio de sesión falló
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login Failed')),
                  );
                }
              },
              child: Text('Login'),
            ),
            // Opción para ir a la pantalla de registro
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
