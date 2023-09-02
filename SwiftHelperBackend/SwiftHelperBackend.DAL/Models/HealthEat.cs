namespace SwiftHelperBackend.DAL.Models;

public class HealthEat : IdBase
{
    public string Title { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    
    public long EatCategoryId { get; set; }
    public string UserId { get; set; } = null!;
    
    public ApplicationUser User { get; set; } = null!;
    public HealthEatCategory EatCategory { get; set; } = null!;
}