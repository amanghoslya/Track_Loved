import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_loved/LoginScreen/OtpVerifyScreen.dart';
import 'package:track_loved/core/AuthService/AuthServiceProvider.dart';
import 'package:track_loved/core/Utils/showMessage.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameConatroller = TextEditingController();
  final _phoneConatroller = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _nameConatroller.dispose();
    _emailController.dispose();
    _phoneConatroller.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF0F3D38),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0F3D38), Color(0xFF072420), Color(0xFF031210)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt_1,
                      size: 48,
                      color: Color(0xFFD4AF37),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Join TrackLovedOnes',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),

                    customTextField(
                      controller: _nameConatroller,
                      labelText: 'Enter Your Name',
                      hintText: 'Enter your name',
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    customTextField(
                      controller: _emailController,
                      labelText: 'Email Address',
                      hintText: 'Enter email address',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    customTextField(
                      controller: _phoneConatroller,
                      labelText: 'Phone Number',
                      hintText: 'Enter phone number',
                      prefixIcon: Icons.call,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    customTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: !isPasswordVisible,
                      showVisibilityIcon: true,
                      onVisibilityTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: const Color(0xFF072420),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        onPressed: isLoading
                            ? null
                            : () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final service = ref.read(authServiceProvider);
                                  final response = await service.registerData(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    name: _nameConatroller.text.trim(),
                                    phone: _phoneConatroller.text.trim(),
                                  );
                                  if (response.success == true) {
                                    if (response.success == true) {
                                      showSuccessSnackBar(
                                        response.message ?? "Sucess",
                                      );
                                      if (context.mounted) {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                OtpVerifyScreen(
                                                  email: _emailController.text
                                                      .trim(),
                                                ),
                                          ),
                                          (route) => false,
                                        );
                                      }
                                    }
                                  }
                                } catch (e) {
                                  log(e.toString());
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },

                        child: isLoading
                            ? Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : Text(
                                'SEND VERIFICATION CODE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField({
    required TextEditingController controller,
    required String hintText,
    String? labelText,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    VoidCallback? onVisibilityTap,
    bool showVisibilityIcon = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: -0.2,
      ),
      decoration: InputDecoration(
        isDense: true,
        labelText: labelText,
        hintText: hintText,
        labelStyle: const TextStyle(color: Colors.white60),
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white60,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.white60)
            : null,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        suffixIcon: showVisibilityIcon
            ? InkWell(
                onTap: onVisibilityTap,
                child: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 22,
                  color: Colors.white,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC5A038)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
