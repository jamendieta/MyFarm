using DataTransferObjects.Entities;
using Logic.Intefaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class OrdersController : ControllerBase
    {
        private readonly IOrderLogic orderLogic;
        public OrdersController(IOrderLogic orderLogic)
        {
            this.orderLogic = orderLogic;
        }

        [HttpPost]
        public async Task<ActionResult<string>> CreateOrder([FromBody] OrderDto orderDto)
        {
            string result = await orderLogic.CreateOrder(orderDto);
            if (!string.IsNullOrEmpty(result))
                return Ok(result);
            else
                return BadRequest();
        }

        [HttpGet]
        public async Task<ActionResult<OrderDetailDto>> GetOrder(int orderId)
        {
            OrderDetailDto result = await orderLogic.GetOrder(orderId);
            if (result != null)
                return Ok(result);
            else
                return BadRequest();
        }

    }
}
