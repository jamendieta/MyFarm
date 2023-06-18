using DataTransferObjects.Entities;

namespace Logic.Intefaces
{
    public interface IOrderLogic
    {
        Task<string> CreateOrder(OrderDto orderDto);
        Task<OrderDetailDto> GetOrder(int orderId);
    }
}
