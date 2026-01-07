import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool _isLoading = false;

  void _signUp() async {
    if (passwordController.text.trim() != confirmController.text.trim()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Passwords do not match"),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await authService.value.createAccount(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: 'driver',
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signup failed: $e"),
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
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              Text(
                'App Name', // Your App's name here
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 64),
              Text(
                'Create an account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your email to sign up',
                style: TextStyle(
                  fontSize: 14,
                  // ignore: deprecated_member_use
                  color: colorScheme.onSurface.withAlpha(179),
                ),
              ),
              const SizedBox(height: 24),

              // Email field
              TextFormField(
                controller: emailController,
                cursorColor: colorScheme.onPrimary,
                decoration: InputDecoration(
                  hintText: "email@domain.com",
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colorScheme.primaryContainer),
                  ),
                ),
                style: TextStyle(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 16),

              // Password field
              TextFormField(
                controller: passwordController,
                cursorColor: colorScheme.onPrimary,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colorScheme.primaryContainer),
                  ),
                ),
                style: TextStyle(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 16),

              // Confirm Password field
              TextFormField(
                controller: confirmController,
                cursorColor: colorScheme.onPrimary,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "confirm password",
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: colorScheme.primaryContainer),
                  ),
                ),
                style: TextStyle(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 24),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary, // neutral main color
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            colorScheme.onPrimary,
                          ),
                        )
                      : const Text("Continue"),
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 16),

              // Already have an account? Login
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // so it doesn’t add extra padding
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
