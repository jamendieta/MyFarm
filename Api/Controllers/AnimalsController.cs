using DataTransferObjects.Entities;
using Logic.Intefaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class AnimalsController : ControllerBase
    {
        private readonly IAnimalLogic animalLogic;
        public AnimalsController(IAnimalLogic animalLogic)
        {
            this.animalLogic = animalLogic;
        }

        [HttpPost]
        public async Task<ActionResult<bool>> CreateAnimal([FromBody] AnimalDto animalDto)
        {
            bool result = await animalLogic.CreateAnimal(animalDto);
            if (result)
                return Ok("Animal created successfully");
            else
                return BadRequest();
        }

        [HttpPut("{animalId}")]
        public async Task<ActionResult<bool>> UpdateAnimal(int animalId, AnimalDto animalDto)
        {
            bool result = await animalLogic.UpdateAnimal(animalId, animalDto);
            if (result)
                return Ok("Animal updated successfully");
            else
                return BadRequest();
        }

        [HttpDelete("{animalId}")]
        public async Task<ActionResult<bool>> DeleteAnimal(int animalId)
        {
            bool result = await animalLogic.DeleteAnimal(animalId);
            if (result)
                return Ok("Animal deleted successfully");
            else
                return BadRequest();
        }

        [HttpGet("filter")]
        public async Task<IActionResult> FilterAnimals(int? animalId, string? name, bool? sex, bool? status)
        {
            IEnumerable<AnimalDto> result = await animalLogic.FilterAnimals(animalId, name, sex, status);
            if (result.Any())
                return Ok(result);
            else
                return NotFound();
        }
    }
}
