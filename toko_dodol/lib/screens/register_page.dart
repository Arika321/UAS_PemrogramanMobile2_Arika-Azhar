import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  register() async {
    await Supabase.instance.client.auth.signUp(
      email: email.text,
      password: password.text,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade700, Colors.brown.shade300],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Daftar Sekarang",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Nikmati dodol terbaik nusantara!",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: email,
                decoration: input("Email"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: password,
                obscureText: true,
                decoration: input("Password"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: register,
                child: const Text("DAFTAR"),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration input(String text) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
