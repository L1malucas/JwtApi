namespace jwtApi.Middleware
{
    public class JwtMiddleware
    {
        private readonly RequestDelegate _next;

        public JwtMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            // Aqui você pode adicionar o código para processar as informações do token JWT
            // Verifique o token, decodifique as informações, etc.

            await _next(context);
        }
    }

    // Método de extensão para registrar o middleware na aplicação
    public static class JwtMiddlewareExtensions
    {
        public static IApplicationBuilder UseJwtMiddleware(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<JwtMiddleware>();
        }
    }
}
