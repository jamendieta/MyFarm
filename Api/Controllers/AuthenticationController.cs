using Logic.Intefaces;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthenticationController : ControllerBase
    {
        private readonly IAuthenticationLogic authenticationLogic;
        public AuthenticationController(IAuthenticationLogic authenticationLogic)
        {
            this.authenticationLogic = authenticationLogic;
        }

        [HttpGet]
        public async Task<ActionResult<string>> Get(string email)
        {
            if (email == null)
                return NotFound();
            else
            {
                string token = await authenticationLogic.GetToken(email);
                return Ok(token);
            }
        }
    }
}
