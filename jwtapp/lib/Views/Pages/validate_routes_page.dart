import 'dart:convert';
import 'package:http/http.dart' as http;
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
                inputWidget('Anony', testAnonymousRoute),
                const SizedBox(height: 40),
                inputWidget('Auth', testAuthenticatedRoute),
                const SizedBox(height: 40),
                inputWidget('Admin', testAdminRoute),
                const SizedBox(height: 40),
                inputWidget('Employee', testEmployeeRoute),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputWidget(String route, Function httpMethod) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.justify,
              maxLines: 25,
              controller: _tokenController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              httpMethod;
            },
            child: Text(route),
          ),
        ],
      ),
    );
  }

  Future<void> testAnonymousRoute() async {
    print("ENTROU NO METODO");
    final response = await http.get(
      Uri.parse('http://your-api-url/anonymous'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print('Erro: ${response.statusCode}');
    }
  }

  Future<void> testAuthenticatedRoute() async {
    final response = await http.get(
      Uri.parse('http://your-api-url/authenticated'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data); // Exibe o resultado da rota "/authenticated"
    } else {
      print('Erro: ${response.statusCode}');
    }
  }

  Future<void> testAdminRoute() async {
    final response = await http.get(
      Uri.parse('http://your-api-url/admin'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data); // Exibe o resultado da rota "/admin"
    } else {
      print('Erro: ${response.statusCode}');
    }
  }

  Future<void> testEmployeeRoute() async {
    final response = await http.get(
      Uri.parse('http://your-api-url/employee'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data); // Exibe o resultado da rota "/employee"
    } else {
      print('Erro: ${response.statusCode}');
    }
  }
}
