namespace SwiftHelperBackend.DAL.Models;

public class PlanEntry : IdBase
{
    public string Title { get; set; } = null!;
    public string Description { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    
    public string UserId { get; set; } = null!;
    public ApplicationUser? User { get; set; }
    public ICollection<PlanStageEntry>? PlanStageEntries { get; set; }
}