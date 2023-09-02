namespace SwiftHelperBackend.DAL.Models;

public class HealthEatCategory : IdBase
{
    public string Title { get; set; } = null!;
    
    public string UserId { get; set; } = null!;
    public ApplicationUser User { get; set; } = null!;
    
    public ICollection<HealthEat> HealthEats { get; set; } = null!;
}