namespace SwiftHelperBackend.DAL.Models;

public class HealthLifeActivity : IdBase
{
    public string Title { get; set; } = null!;
    
    public string UserId { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    public ApplicationUser User { get; set; } = null!;
    
    public long HealthActivityCategoryId { get; set; }
    public HealthActivityCategory HealthActivityCategory { get; set; } = null!;
}