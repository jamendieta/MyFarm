using Dapper;
using DataTransferObjects.Entities;
using Repository.Interfaces;
using System.Data.SqlClient;

namespace Repository.Implementations
{
    public class OrderRepository : Repository, IOrderRepository
    {
        public OrderRepository(string connectionString) : base(connectionString) { }

        public async Task<string> CreateOrder(OrderDto orderDto)
        {
            string procedureName = "CreateOrder";
            var parameters = new DynamicParameters();
            parameters.Add("@CustomerId", orderDto.CustomerId);
            parameters.Add("@AnimalId", orderDto.AnimalId);
            parameters.Add("@Quantity", orderDto.Quantity);
            using SqlConnection conexion = new(_connectionString);
            string result = await conexion.QueryFirstAsync<string>(procedureName, parameters, commandType: System.Data.CommandType.StoredProcedure, commandTimeout: int.MaxValue);
            return result;
        }

        public async Task<OrderDetailDto> GetOrder(int orderId)
        {
            string procedureName = "GetOrder";
            var parameters = new DynamicParameters();
            parameters.Add("@OrderId", orderId);
            using SqlConnection conexion = new(_connectionString);
            OrderDetailDto result = await conexion.QueryFirstAsync<OrderDetailDto>(procedureName, parameters, commandType: System.Data.CommandType.StoredProcedure, commandTimeout: int.MaxValue);
            return result;
        }
    }
}
