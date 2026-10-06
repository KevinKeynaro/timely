import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timely/login_page.dart';

const double _fieldHeight = 54;
const double _radius = 14;
const Color _border = Color(0xFFE0E0E0);
const Color _hint = Color(0xFF9E9E9E);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  bool _obscureReenterText = true;

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/timely-logo.png',
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Timely',
                        style: GoogleFonts.irishGrover(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Create your account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 32),

                  _label('Your email address'),
                  const SizedBox(height: 8),
                  _field(
                    secondary: secondary,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'email@example.com',
                  ),

                  const SizedBox(height: 20),

                  _label('Choose your password'),
                  const SizedBox(height: 8),
                  _field(
                    secondary: secondary,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    hintText: 'Minimum 8 characters',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => _obscureText = !_obscureText),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _label('Re-enter the password'),
                  const SizedBox(height: 8),
                  _field(
                    secondary: secondary,
                    obscureText: _obscureReenterText,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    hintText: 'Re-enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureReenterText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => setState(
                        () => _obscureReenterText = !_obscureReenterText,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _button(
                    backgroundColor: secondary,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: _buttonLabel('Create Account', color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: secondary,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      );

  Widget _field({
    required Color secondary,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool autocorrect = true,
    bool enableSuggestions = true,
    Widget? suffixIcon,
  }) {
    final borderRadius = BorderRadius.circular(_radius);
    return SizedBox(
      height: _fieldHeight,
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: _hint, fontSize: 16),
          suffixIcon: suffixIcon,
          suffixIconColor: _hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: _border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: secondary, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _button({
    required VoidCallback onPressed,
    required Widget child,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return SizedBox(
      height: _fieldHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            final base = backgroundColor ?? Colors.white;
            if (!states.contains(WidgetState.hovered)) return base;
            return backgroundColor != null
                ? Color.alphaBlend(Colors.black.withValues(alpha: 0.12), base)
                : const Color(0xFFF5F5F5);
          }),
          foregroundColor: WidgetStatePropertyAll(
            foregroundColor ??
                (backgroundColor != null ? Colors.white : Colors.black),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(color: backgroundColor ?? _border),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buttonLabel(String text, {Color? color}) => Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      );
}
