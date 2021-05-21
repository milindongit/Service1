using System.ComponentModel.DataAnnotations;

namespace ItemService.Models
{
    public class Fruit
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }
    }
}
