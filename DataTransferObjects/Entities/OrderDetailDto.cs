namespace DataTransferObjects.Entities
{
    public class OrderDetailDto
    {
        public string? AnimalName { get; set; }
        public string? AnimalBreed { get; set; }
        public string? AnimalSex { get; set; }
        public string? CustomerName { get; set; }
        public string? CustomerLastName { get; set; }
        public string? CustomerEmail { get; set; }
        public string? CustomerPhone { get; set; }
        public int OrderQuantity { get; set; }
        public decimal OrderUnits { get; set; }
        public decimal OrderTotal { get; set; }
        public decimal OrderDiscount { get; set; }
        public decimal OrderFreight { get; set; }
        public decimal OrderTotalAmount { get; set; }
    }
}
