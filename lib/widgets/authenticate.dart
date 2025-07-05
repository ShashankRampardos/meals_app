import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meals_app/screens/tabs.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final LocalAuthentication auth = LocalAuthentication();
  bool? canAuthenticate;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool isDeviceSupported = await auth.isDeviceSupported();
    setState(() {
      canAuthenticate = canAuthenticateWithBiometrics || isDeviceSupported;
    });
  }

  Future<void> _authenticateUser() async {
    try {
      final bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Authenticate to unlock the app',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (isAuthenticated && mounted) {
        Navigator.pop(context); // close bottom sheet
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const TabsScreen()),
        );
      }
    } catch (e) {
      // optional: snackbar ya toast dikha error ka
      print('Auth failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20), // thoda top spacing
          Text(
            'Unlock Now',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          if (canAuthenticate == null)
            CircularProgressIndicator()
          else if (canAuthenticate == true)
            Text(
              'Biometric authentication is available.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
          else
            Text(
              'Biometric authentication is not available.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          SizedBox(height: 20),
          IconButton(
            icon: Icon(Icons.fingerprint, size: 64),
            onPressed: (_authenticateUser),
          ),
        ],
      ),
    );
  }
}
