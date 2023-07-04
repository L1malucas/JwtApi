# JWT API
![Imagem com logo do .net e jwt](https://referbruv.com/wp-content/uploads/2022/05/jwt-dotnetcore-banner.png)
  ## Documentação da Minimal API

  Esta api possui duas políticas de acesso, ***Admin*** e ***Employee***, checagem de token por usuário
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
  Para testes com um endpoint real, use [https://minimalapijwt.azurewebsites.net/](https://minimalapijwt.azurewebsites.net/)

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

