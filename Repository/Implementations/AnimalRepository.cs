using Dapper;
using DataTransferObjects.Entities;
using Repository.Interfaces;
using System.Data.SqlClient;

namespace Repository.Implementations
{
    public class AnimalRepository : Repository, IAnimalRepository
    {
        public AnimalRepository(string connectionString) : base(connectionString) { }

        public async Task<bool> CreateAnimal(AnimalDto animalDto)
        {
            string procedureName = "InsertAnimal";
            var parameters = new DynamicParameters();
            parameters.Add("@Name", animalDto.Name);
            parameters.Add("@Breed", animalDto.Breed);
            parameters.Add("@BirthDate", animalDto.BirthDate);
            parameters.Add("@Sex", animalDto.Sex);
            parameters.Add("@Price", animalDto.Price);
            parameters.Add("@Status", animalDto.Status);
            using SqlConnection conexion = new(_connectionString);
            int result = await conexion.ExecuteAsync(procedureName, parameters, commandType: System.Data.CommandType.StoredProcedure, commandTimeout: int.MaxValue);
            return result > 0;
        }

        public async Task<bool> DeleteAnimal(int animalId)
        {
            string procedureName = "DeleteAnimal";
            var parameters = new DynamicParameters();
            parameters.Add("@AnimalId", animalId);
            using SqlConnection conexion = new(_connectionString);
            int result = await conexion.ExecuteAsync(procedureName, parameters, commandType: System.Data.CommandType.StoredProcedure, commandTimeout: int.MaxValue);
            return result > 0;
        }

        public async Task<IEnumerable<AnimalDto>> FilterAnimals(int? animalId, string? name, bool? sex, bool? status)
        {
            string procedureName = "FilterAnimals";
            var parameters = new DynamicParameters();
            parameters.Add("@AnimalId", animalId);
            parameters.Add("@Name", name);
            parameters.Add("@Sex", sex);
            parameters.Add("@Status", status);
            using SqlConnection conexion = new(_connectionString);
            IEnumerable<AnimalDto> animalsDtos = await conexion.QueryAsync<AnimalDto>(procedureName, parameters, commandType: System.Data.CommandType.StoredProcedure, commandTimeout: int.MaxValue);
            return animalsDtos;
        }

        public async Task<bool> UpdateAnimal(int animalId, AnimalDto animalDto)
        {
            string procedureName = "UpdateAnimal";
            var parameters = new DynamicParameters();
            parameters.Add("@AnimalId", animalId);
            parameters.Add("@Name", animalDto.Name);
            parameters.Add("@Breed", animalDto.Breed);
            parameters.Add("@BirthDate", animalDto.BirthDate);
            parameters.Add("@Sex", animalDto.Sex);
            parameters.Add("@Price", animalDto.Price);
            parameters.Add("@Status", animalDto.Status);
            using SqlConnection conexion = new(_connectionString);
            int result = await conexion.ExecuteAsync(procedureName, parameters, commandType: System.Data.CommandType.StoredProcedure, commandTimeout: int.MaxValue);
            return result > 0;
        }
    }
}
