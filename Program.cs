using System.Security.Claims;
using System.Text;
using jwtApi;
using jwtApi.Models;
using jwtApi.Repositories;
using jwtApi.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;

var builder = WebApplication.CreateBuilder(args);
// secret key config as byte array
var key = Encoding.ASCII.GetBytes(Settings.Secret);

// authentication settings
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    // validation api setup
}).AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false,
    };
});

// create policy of authorization (roles manager and employee)
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("Admin", policy => policy.RequireRole("manager"));
    options.AddPolicy("Employee", policy => policy.RequireRole("employee"));
});
var app = builder.Build();

// must be this oreder! first looks for authentication and then looks for authorization
app.UseAuthentication();
app.UseAuthorization();

// user authentication
app.MapPost("/login", (User model) =>
{
    var user = UserRepository.Get(model.Username, model.Password);
    if (user == null)
        return Results.NotFound(new
        {
            message = "Usuário ou senha inválidos!"
        });
    // if everything is right, generate token
    var token = TokenService.GenerateToken(user);
    // hide password
    user.Password = "";
    return Results.Ok(new
    {
        user = user,
        token = token
    });

});

// anonymous method
app.MapGet("/anonymous", () => { Results.Ok("anonymous"); }).AllowAnonymous();

// verify authenticated user
app.MapGet("/authenticated", (ClaimsPrincipal user) =>
{
    Results.Ok(new
    {
        message = $"Authenticated as {user.Identity.Name}"
    });
}).RequireAuthorization();

//  acess by policy admin and employee, with require authorization
app.MapGet("/manager", (ClaimsPrincipal user) =>
{
    Results.Ok(new
    {
        message = $"Authenticated as {user.Identity.Name}"
    });
}
).RequireAuthorization("Admin");

app.MapGet("/employee", (ClaimsPrincipal user) =>
{
    Results.Ok(new
    {
        message = $"Authenticated as {user.Identity.Name}"
    });
}
).RequireAuthorization("Employee");

app.MapGet("/docs", () =>
{
    var filePath = Path.Combine(builder.Environment.ContentRootPath, "views/docs.html");
    return Results.File(filePath, "text/html");
});


app.MapGet("/", () =>
{
    var filePath = Path.Combine(builder.Environment.ContentRootPath, "views/home.html");
    return Results.File(filePath, "text/html");
});
app.Run();
