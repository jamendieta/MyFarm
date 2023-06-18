namespace Logic.Intefaces
{
    public interface IAuthenticationLogic
    {
        Task<string> GetToken(string email);
    }
}
