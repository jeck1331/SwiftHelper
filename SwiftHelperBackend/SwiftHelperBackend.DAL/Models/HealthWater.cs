namespace SwiftHelperBackend.DAL.Models;

public class HealthWater : IdBase
{
    public double Volume { get; set; }
    public DateTime CreatedDate { get; set; }
    
    public string UserId { get; set; } = null!;
    public ApplicationUser User { get; set; } = null!;
}