// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'pages/register_page.dart';
import 'pages/home_screen.dart';
import 'pages/main_navigation.dart';

void main() {
  runApp(const MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Planchita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomeScreen(),
        '/menu': (context) => const MainNavigation(initialPage: 1),
        '/ventas': (context) => const MainNavigation(initialPage: 2),
        '/historicos': (context) => const MainNavigation(initialPage: 3),
        '/planifica': (context) => const MainNavigation(initialPage: 4),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // ignore: duplicate_ignore
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/logo.jpg'),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Bienvenido a",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "La Planchita",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.4),
                            offset: const Offset(2, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _userController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white70),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    MouseRegion(
                      onEnter: (_) => setState(() => _hovering = true),
                      onExit: (_) => setState(() => _hovering = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow:
                              _hovering
                                  ? [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.6),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : [],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            String usuario = _userController.text.trim();
                            String contrasena = _passwordController.text.trim();

                            if (usuario == "admin" && contrasena == "12345") {
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: '¡Bienvenido!',
                                  message: 'Acceso exitoso como administrador.',
                                  contentType: ContentType.success,
                                ),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);

                              Future.delayed(
                                const Duration(milliseconds: 1300),
                                () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                },
                              );
                            } else {
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Acceso denegado',
                                  message: 'Usuario o contraseña incorrectos.',
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 100,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Ingreso',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        '¿No tienes cuenta? Crear una',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // recuperación de contraseña futuro
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: GoogleFonts.roboto(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
