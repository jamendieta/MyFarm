using Logic.Intefaces;
using Security.Interfaces;

namespace Logic.Implementations
{
    public class AuthenticationLogic : IAuthenticationLogic
    {
        private readonly ITokenGeneratorHandler tokenHandler;
        public AuthenticationLogic(ITokenGeneratorHandler tokenHandler)
        {
            this.tokenHandler = tokenHandler;
        }
        public async Task<string> GetToken(string email)
        {
            string token = await tokenHandler.GenerateJsonWebToken(email);
            return token;
        }
    }
}
