# jwtApi

  ## Documentação da Minimal API
  Adicionando Políticas de Autorização   
    
    builder.Services.AddAuthorization(options => {
    options.AddPolicy("Admin", policy => policy.RequireRole("manager"));
    options.AddPolicy("Employee", policy => policy.RequireRole("employee"));
    });

  </code></pre>
    Configurando Autenticação e Autorização
    
   <pre><code> 
  app.UseAuthentication();
  app.UseAuthorization();
  </code></pre>

  Autenticação do Usuário
    
    
    app.MapPost("/login", (User model) =&gt; {
    // Implemente a lógica de autenticação do usuário aqui  });
  </code></pre>

  Método Anônimo
    
    app.MapGet("/anonymous", () =&gt; {
    // Implemente o comportamento do método anônimo aqui  });
  </code></pre>

  Verificação de Usuário Autenticado
    
    app.MapGet("/authenticated", (ClaimsPrincipal user) =&gt; {
    // Implemente a lógica para retornar informações do usuário autenticado aqui
    }).RequireAuthorization();
  </code></pre>

  Acesso por Política de Admin e Employee
  
    app.MapGet("/manager", (ClaimsPrincipal user) =&gt; {
    // Implemente o comportamento para o acesso de um gerente (admin) aqui
    }).RequireAuthorization("Admin");
    
    app.MapGet("/employee", (ClaimsPrincipal user) =&gt; {
    // Implemente o comportamento para o acesso de um funcionário (employee) aqui
    }).RequireAuthorization("Employee");
  </code></pre>

  ## Build do projeto

      dotnet run ou dotnet watch 
  </code></pre>
  dotnet watch observa as modificações do código e faz o build automaticamente
  </body>
</html>
