using Repository.Interfaces;

namespace UnitOfWork.Interfaces
{
    public interface IUnitOfWork
    {
        IAnimalRepository AnimalRepository { get; }
        IOrderRepository OrderRepository { get; }
    }
}
