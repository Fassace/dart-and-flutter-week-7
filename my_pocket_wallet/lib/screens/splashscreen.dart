import 'package:flutter/material.dart';
import 'package:my_pocket_wallet/screens/loginscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen(
      {super.key}); // Fixed: Converted 'key' to a super parameter.

  @override
  SplashscreenState createState() =>
      SplashscreenState(); // Fixed: Made the class public.
}

class SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Initialize the fade animation
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Start the animation
    _animationController.forward();

    // Navigate to LoginScreen after a delay with mounted check
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Ensure widget is still in the widget tree
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade500,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Splash Image
              Center(
                child: Image.asset(
                  "assets/images/splash.png",
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              // Welcome Text
              const Text(
                "Welcome to My Pocket Wallet",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              // Subtitle Text
              const Text(
                "Your personal finance companion",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
