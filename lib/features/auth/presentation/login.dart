import 'package:flutter/material.dart';
import 'package:test_case/wrapper.dart';
import '../../../core/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() => _isLoading = true);

    try {
      await authService.value.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      // Clear stack and go to home
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeWrapper()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ------------------------------------------------
                // App Title
                // ------------------------------------------------
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                // ------------------------------------------------
                // Email field
                // ------------------------------------------------
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                const SizedBox(height: 16),

                // ------------------------------------------------
                // Password field
                // ------------------------------------------------
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                const SizedBox(height: 24),

                // ------------------------------------------------
                // Login button
                // ------------------------------------------------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary, // Neutral main
                      foregroundColor: colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              colorScheme.onPrimary, // adapts to theme
                            ),
                          )
                        : const Text('Login'),
                  ),
                ),

                const SizedBox(height: 16),

                // ------------------------------------------------
                // Sign up button
                // ------------------------------------------------
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary, // accent or neutral
                  ),
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary, // Use onPrimary color from the theme
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
