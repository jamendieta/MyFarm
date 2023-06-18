namespace DataTransferObjects.Entities
{
    public class AnimalDto
    {
        public int AnimalId { get; set; }
        public string? Name { get; set; }
        public string? Breed { get; set; }
        public DateTime BirthDate { get; set; }
        public bool Sex { get; set; }
        public decimal Price { get; set; }
        public bool Status { get; set; }

    }
}
