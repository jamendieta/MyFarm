using DataTransferObjects.Entities;

namespace Logic.Intefaces
{
    public interface IAnimalLogic
    {
        Task<bool> CreateAnimal(AnimalDto animalDto);
        Task<bool> DeleteAnimal(int animalId);
        Task<IEnumerable<AnimalDto>> FilterAnimals(int? animalId, string? name, bool? sex, bool? status);
        Task<bool> UpdateAnimal(int animalId, AnimalDto animalDto);
    }
}
