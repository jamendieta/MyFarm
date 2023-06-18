using DataTransferObjects.Entities;
using Logic.Intefaces;
using UnitOfWork.Interfaces;

namespace Logic.Implementations
{
    public class OrderLogic : IOrderLogic
    {
        private readonly IUnitOfWork unitOfWork;
        public OrderLogic(IUnitOfWork unitOfWork)
        {
            this.unitOfWork = unitOfWork;
        }

        public async Task<string> CreateOrder(OrderDto orderDto)
        {
            string result = await unitOfWork.OrderRepository.CreateOrder(orderDto);
            return result;
        }

        public async Task<OrderDetailDto> GetOrder(int orderId)
        {
            OrderDetailDto result = await unitOfWork.OrderRepository.GetOrder(orderId);
            return result;
        }
    }
}
