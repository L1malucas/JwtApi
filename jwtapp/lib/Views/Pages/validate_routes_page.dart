// ignore_for_file: avoid_print, use_build_context_synchronously

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
  static const apiUrl = 'https://minimalapijwt.azurewebsites.net';

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Teste das rotas',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 12),
                  inputWidget(),
                  ElevatedButton(
                    onPressed: () async => testAnonymousRoute(),
                    child: const Text('Anonymous'),
                  ),
                  const SizedBox(height: 12),
                  inputWidget(),
                  ElevatedButton(
                    onPressed: () async => testAuthRoute(),
                    child: const Text('Authenticated'),
                  ),
                  const SizedBox(height: 12),
                  inputWidget(),
                  ElevatedButton(
                    onPressed: () async => testAdminRoute(),
                    child: const Text('Admin'),
                  ),
                  const SizedBox(height: 12),
                  inputWidget(),
                  ElevatedButton(
                    onPressed: () async => testEmployeeRoute(),
                    child: const Text('Employee'),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputWidget() {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 12),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // contentPadding: EdgeInsets.symmetric(vertical: 40),
              ),
              textAlign: TextAlign.justify,
              maxLines: 20,
              controller: _tokenController,
            ),
          ),
        ],
      ),
    );
  }

  Future dialog(int statusCode) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resposta da request'),
        content: Text(
          'Status Code: $statusCode',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> testAnonymousRoute() async {
    print("ENTROU NO METODO");
    final response = await http.get(
      Uri.parse('$apiUrl/anonymous'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        print('Resposta vazia');
        dialog(response.statusCode);
      }
    } else {
      print('Erro: ${response.statusCode}');
      dialog(response.statusCode);
    }
  }

  Future<void> testAuthRoute() async {
    print("ENTROU NO METODO");
    final response = await http.get(
      Uri.parse('$apiUrl/authenticated'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        print('Resposta vazia');
        dialog(response.statusCode);
      }
    } else {
      print('Erro: ${response.statusCode}');
      dialog(response.statusCode);
    }
  }

  Future<void> testAdminRoute() async {
    print("ENTROU NO METODO");
    final response = await http.get(
      Uri.parse('$apiUrl/admin'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        print('Resposta vazia');
        dialog(response.statusCode);
      }
    } else {
      print('Erro: ${response.statusCode}');
      dialog(response.statusCode);
    }
  }

  Future<void> testEmployeeRoute() async {
    print("ENTROU NO METODO");
    final response = await http.get(
      Uri.parse('$apiUrl/employee'),
      headers: {
        'Authorization': 'Bearer ${_tokenController.text}',
      },
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        print('Resposta vazia');
        dialog(response.statusCode);
      }
    } else {
      print('Erro: ${response.statusCode}');
      dialog(response.statusCode);
    }
  }
}
