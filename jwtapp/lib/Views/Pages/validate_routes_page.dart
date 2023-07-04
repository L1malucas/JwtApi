import 'package:flutter/material.dart';

class ValidateRoutesPage extends StatefulWidget {
  const ValidateRoutesPage({required this.token, super.key});
  final String token;
  @override
  State<ValidateRoutesPage> createState() => _ValidateRoutesPageState();
}

class _ValidateRoutesPageState extends State<ValidateRoutesPage> {
  final TextEditingController _tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tokenController.text = widget.token;
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Teste das rotas',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(height: 40),
                inputWidget('Anony'),
                const SizedBox(height: 40),
                inputWidget('Auth'),
                const SizedBox(height: 40),
                inputWidget('Admin'),
                const SizedBox(height: 40),
                inputWidget('Employee'),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputWidget(String route) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextField(
              maxLines: 25,
              controller: _tokenController,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(route),
          ),
        ],
      ),
    );
  }
}
