import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fullName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool loading = false;

  Future<void> register() async {
    if (fullName.text.isEmpty ||
        username.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty) {
      showMsg("Semua field wajib diisi");
      return;
    }

    setState(() => loading = true);

    try {
      // REGISTER AUTH
      final res = await Supabase.instance.client.auth.signUp(
        email: email.text,
        password: password.text,
      );

      final user = res.user;

      if (user == null) {
        showMsg("Gagal membuat akun");
        return;
      }

      // SIMPAN PROFILE
      await Supabase.instance.client.from('profiles').insert({
        'id': user.id,
        'full_name': fullName.text,
        'username': username.text,
        'email': email.text,
      });

      showMsg("Registrasi berhasil, silakan login");

      Navigator.pop(context);
    } catch (e) {
      showMsg("Registrasi gagal");
    }

    setState(() => loading = false);
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: fullName,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: username,
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : register,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("DAFTAR"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
