namespace SwiftHelperBackend.DAL.Models;

public class HealthActivityCategory : IdBase
{
    public string Title { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    
    public string UserId { get; set; } = null!;
    
    public ApplicationUser User { get; set; } = null!;
    public ICollection<HealthLifeActivity> HealthActivities { get; set; } = null!;
}