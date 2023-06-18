using DataTransferObjects.Configuration;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Security.Interfaces;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Security.Implementations
{
    public class TokenGeneratorHandler : ITokenGeneratorHandler
    {
        private readonly TokenConfiguration jwtConfiguration;

        public TokenGeneratorHandler(IOptions<TokenConfiguration> jwtConfiguration)
        {
            this.jwtConfiguration = jwtConfiguration.Value;
        }

        public async Task<string> GenerateJsonWebToken(string email)
        {
            return await Task.Run(() =>
            {
                JwtSecurityTokenHandler tokenHandler = new();
                byte[] key = Encoding.UTF8.GetBytes(jwtConfiguration.Secret!);
                SecurityTokenDescriptor tokenDescriptor = new()
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                        new Claim("email", email
                    ),
                    }),
                    Expires = DateTime.Now.AddDays(jwtConfiguration.TimeInDays),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256)
                };
                SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);
                string stringToken = tokenHandler.WriteToken(token);
                return stringToken;
            });
        }
    }
}
