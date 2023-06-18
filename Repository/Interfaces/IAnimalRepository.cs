using DataTransferObjects.Entities;

namespace Repository.Interfaces
{
    public interface IAnimalRepository
    {
        Task<bool> CreateAnimal(AnimalDto animalDto);
        Task<bool> DeleteAnimal(int animalId);
        Task<IEnumerable<AnimalDto>> FilterAnimals(int? animalId, string? name, bool? sex, bool? status);
        Task<bool> UpdateAnimal(int animalId, AnimalDto animalDto);
    }
}
