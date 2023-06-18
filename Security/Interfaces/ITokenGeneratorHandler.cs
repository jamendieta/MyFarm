namespace Security.Interfaces
{
    public interface ITokenGeneratorHandler
    {
        Task<string> GenerateJsonWebToken(string email);
    }
}
