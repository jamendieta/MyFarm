using DataTransferObjects.Entities;
using Logic.Intefaces;
using UnitOfWork.Interfaces;

namespace Logic.Implementations
{
    public class AnimalLogic : IAnimalLogic
    {
        private readonly IUnitOfWork unitOfWork;
        public AnimalLogic(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }
        public async Task<bool> CreateAnimal(AnimalDto animalDto)
        {
            bool result = await unitOfWork.AnimalRepository.CreateAnimal(animalDto);
            return result;
        }

        public async Task<bool> DeleteAnimal(int animalId)
        {
            bool result = await unitOfWork.AnimalRepository.DeleteAnimal(animalId);
            return result;
        }

        public async Task<IEnumerable<AnimalDto>> FilterAnimals(int? animalId, string? name, bool? sex, bool? status)
        {
            IEnumerable<AnimalDto> animalDtos = await unitOfWork.AnimalRepository.FilterAnimals(animalId, name, sex, status);
            return animalDtos;
        }

        public async Task<bool> UpdateAnimal(int animalId, AnimalDto animalDto)
        {
            bool result = await unitOfWork.AnimalRepository.UpdateAnimal(animalId, animalDto);
            return result;
        }
    }
}
