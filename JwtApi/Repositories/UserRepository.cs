using jwtApi.Models;

namespace jwtApi.Repositories;

public static class UserRepository
{
    public static User Get(string username, string password)
    {
        var users = new List<User>
        {
            new User { Id = 1, Username = "batman", Password = "batman", Role = "admin" },
            new User { Id = 2, Username = "robin", Password = "robin", Role = "employee" },
        };

        return users.FirstOrDefault(x => x.Username.ToLower() == username.ToLower() && x.Password == password);
    }
}
