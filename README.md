# JWT API

![Imagem com logo do .net e jwt](https://github.com/L1malucas/BlazorDash/blob/main/logo.png)

## Minimal API com JWT, em .NET e Flutter

Esta api tem propóstio de auxiliar desesenvolvedores que estejam estudando: autenticação, perfis de usuários, JWT, minimal API, backend em .NET e chamadas http em flutter e procurem conteúdos em português e atualizado.

## Ferramentas

- [Flutter](https://flutter.dev/) - Framework mobile multiplataforma, construído com Dart.
- [.NET](https://dotnet.microsoft.com/pt-br/download) - Gratuito. Multiplataforma. Código aberto.
- [JWT](https://jwt.io/) - Padrão da Internet para a criação de dados com assinatura opcional e/ou criptografia.

#### Setup da API

Adicionando Políticas de Autorização:

    builder.Services.AddAuthorization(options => {
      <!-- Adicione políticas aqui -->
    options.AddPolicy("Admin", policy => policy.RequireRole("manager"));
    options.AddPolicy("Employee", policy => policy.RequireRole("employee"));
    });

Endpoint de Autenticação do Usuário:

    app.MapPost("/login", (User model) =>
    {
        //implemente mais validações ou uma lógica diferente, caso use em produção
        var user = UserRepository.Get(model.Username, model.Password);
        if (user == null)
            return Results.NotFound(new
            {
                message = "Usuário ou senha inválidos!"
            });

        // se tudo ocorre certo, gera o token
        var token = TokenService.GenerateToken(user);

        // esconde a senha no body da resposta
        user.Password = "";

        return Results.Ok(new
        {
            user,
            token
        });
    });

Método Anônimo:

    app.MapGet("/anonymous", () => { Results.Ok("anonymous"); }).AllowAnonymous();

Verificação de Usuário Autenticado:

    app.MapGet("/authenticated", (ClaimsPrincipal user) =>
    {
      // altere o retorno para o seu propósito
      Results.Ok(new
      {
          message = $"Authenticated as {user.Identity.Name}"
      });
    }).RequireAuthorization();

Acesso por Política:

    app.MapGet("/admin", (ClaimsPrincipal user) =>
    {
      // experimente retorna uma view diferente ou redirecionar para um painel
        Results.Ok(new
        {
            message = $"Authenticated as {user.Identity.Name}"
        });
    }
    ).RequireAuthorization("Admin");

    app.MapGet("/employee", (ClaimsPrincipal user) =>
    {
      // altere o retorno para o seu propósito
        Results.Ok(new
        {
            message = $"Authenticated as {user.Identity.Name}"
        });
    }
    ).RequireAuthorization("Employee");

#### Lista de EndPoints

Para testes com um endpoint real, use [https://minimalapijwt.azurewebsites.net](https://minimalapijwt.azurewebsites.net/)

    1. "/" => um JSON com informações do repositório e do autor.

    2. "/docs" => outro JSON com os metódos, caso do usuário queira tratar as informações exibidas em outra aplicação.

    3. "/login" => POST aceitando apenas usuários registrados no arquivo *UserRepository.cs*.

    4. "/admin" => checa o token de autenticação do *admin* e retorna 200 ou 403.

    5. "/employee" => checa o token de autenticação do *employee* e retorna 200 ou 403.

## Build

#### Rode o Projeto em localhost

Dotnet watch observa as modificações do código e faz o build automaticamente, toda vez que necessário.

      dotnet watch --project . run

Em caso de erros:

Apague a pasta de settings da ide.

    Exclua **.vs**, caso use o visual studio

    Exclua **.vscode** caso use o visual studio code

Faça o **clean** da aplicação e em seguida o **build**

    dotnet clean

    dotnet run

#### Execute a Aplicação Flutter

Para executar o aplicativo em seu celular ou emulador android, é necessário checar as versões mínimas:

1. **Flutter** 3.10.5
2. **Dart** 3.0.5
3. **Sdk** ">=3.0.0-290.0.dev <4.0.0"

Após a checagem, atualize os pacotes

    flutter run pub get

Em seguida, execute no device escolhido.

#### Documentação da Aplicação

Requisição de login:

    Future<Map<String, dynamic>> loginUser(
    String username, String password) async {
      username = username.trim();
      password = password.trim();
      const apiUrl = 'https://minimalapijwt.azurewebsites.net/login';

      print("LOGINUSER");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      print("ENVIA POST");
      if (response.statusCode == 200) {
        print("STATUSCODE200");
        final responseData = json.decode(response.body);
        final token = responseData['token'];
        final id = responseData['user']['id'];
        final role = responseData['user']['role'];
        userToken = token;
        return {
          'token': token,
          'id': id,
          'role': role,
        };
      } else {
        throw Exception('Failed to login');
      }
    }

Checagem de Autenticação:

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
          //lógica para exibir ao usuário em caso de sucesso
          print('Resposta vazia');
          dialog(response.statusCode);
        }
      } else {
        print('Erro: ${response.statusCode}');
        dialog(response.statusCode);
      }
    }

  Todos demais metódos funcionam da mesma forma, alterando apenas a rota, altere o que deseja exibir ao usuário ou navegar para outra tela.

  Na aplicação é exibido uma caixa de diálogo com o status code recebido:

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
## Desenvolvimento

#### Quer contribuir? Ótimo!

Para corrigir um bug ou aprimorar um módulo existente, siga estes passos:

- Faça um fork do repositório
- Crie um novo branch (`git checkout -b improve-feature`)
- Faça as alterações apropriadas nos arquivos
- Adicione as alterações para refletir as mudanças feitas
- Faça um commit das suas alterações (`git commit -am 'Improve feature'`)
- Faça o push para o branch (`git push origin improve-feature`)
- Crie uma Pull Request

#### Bug / Solicitação de Funcionalidadet

Se você encontrar um bug, por favor, abra uma issue [aqui](https://github.com/L1malucas/JwtApi/issues) incluindo sua consulta de pesquisa e o resultado esperado.

Se você gostaria de solicitar uma nova função, sinta-se à vontade para fazê-lo abrindo uma issue [aqui](https://github.com/L1malucas/JwtApi/issues). Por favor, inclua exemplos de consultas e seus resultados correspondentes.

## Time

[Lucas Lima](https://github.com/L1malucas)

## License

[MIT ©](https://github.com/L1malucas/JwtApi/blob/main/LICENSE.md)
