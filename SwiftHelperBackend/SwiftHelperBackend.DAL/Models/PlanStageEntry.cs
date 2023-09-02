using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.DAL.Models;

public class PlanStageEntry: IdBase
{
    public string Title { get; set; } = null!;
    public StagePriority Priority { get; set; } = StagePriority.Empty;
    public StageStatus Status { get; set; } = StageStatus.New;
    public string Data { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    
    public string UserId { get; set; } = null!;
    public ApplicationUser User { get; set; } = null!;
    
    public long PlanEntryId { get; set; }
    public PlanEntry PlanEntry { get; set; } = null!;
}