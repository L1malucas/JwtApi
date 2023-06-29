namespace jwtApi.Models
{
    public class User
    {
        // create attributes of user
        public int Id { get; set; }
        public String Username { get; set; } = string.Empty;
        public String Password { get; set; } = string.Empty;
        public String Role { get; set; } = string.Empty;
    }
}