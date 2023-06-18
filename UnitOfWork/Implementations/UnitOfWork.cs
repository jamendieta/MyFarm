using Repository.Implementations;
using Repository.Interfaces;
using UnitOfWork.Interfaces;

namespace UnitOfWork.Implementations
{
    public class UnitOfWork : IUnitOfWork
    {
        public UnitOfWork(string connectionString)
        {
            AnimalRepository = new AnimalRepository(connectionString);
            OrderRepository = new OrderRepository(connectionString);
        }
        public IAnimalRepository AnimalRepository { get; private set; }

        public IOrderRepository OrderRepository { get; private set; }
    }
}
