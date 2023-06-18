using DataTransferObjects.Entities;

namespace Repository.Interfaces
{
    public interface IOrderRepository
    {
        Task<string> CreateOrder(OrderDto orderDto);
        Task<OrderDetailDto> GetOrder(int orderId);
    }
}
