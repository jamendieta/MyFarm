using Repository.Interfaces;

namespace Repository.Implementations
{
    public abstract class Repository : IRepository
    {
        protected string _connectionString;
        public Repository(string connectionString)
        {
            _connectionString = connectionString;
        }
    }
}
