import 'package:flutter/material.dart';
import 'package:jwtapp/Views/Pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});
  final Uri _urlLinkedinProfile =
      Uri.parse('https://www.linkedin.com/in/limalucasdev/');
  final Uri _urlGithubRepo = Uri.parse('https://github.com/L1malucas/JwtApi');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Aplicação para testes de API com JWT e políticas de acesso",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 100),
            const Text(
              "Apenas dois usuários estão disponíves:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              child: DataTable(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  columnSpacing: (MediaQuery.of(context).size.width / 10) * 0.5,
                  columns: const [
                    DataColumn(
                      label: Text('ID'),
                    ),
                    DataColumn(
                      label: Text('Name'),
                    ),
                    DataColumn(
                      label: Text('Password'),
                    ),
                    DataColumn(
                      label: Text('Role'),
                    ),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('1')),
                      DataCell(Text('batman')),
                      DataCell(Text('batman')),
                      DataCell(Text('admin')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('2')),
                      DataCell(Text('robin')),
                      DataCell(Text('robin')),
                      DataCell(Text('employee')),
                    ])
                  ]),
            ),
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text("Navegue teste de LOGIN"),
            ),
          ],
        ),
      )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: InkWell(
              hoverColor: Colors.transparent,
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/174/174857.png',
                width: 48,
                height: 48,
              ),
              onTap: () => launchUrl(_urlLinkedinProfile,
                  mode: LaunchMode.externalApplication),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              hoverColor: Colors.transparent,
              child: Image.network(
                'https://img.icons8.com/?size=512&id=12599&format=png',
                width: 48,
                height: 48,
              ),
              onTap: () => launchUrl(_urlGithubRepo,
                  mode: LaunchMode.externalApplication),
            ),
          )
        ],
      ),
    );
  }
}
