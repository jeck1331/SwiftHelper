using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.Models.Plan;

public class PlanStageEntryDTO : IdBase
{
    public string Title { get; set; } = null!;
    public StagePriority Priority { get; set; } = StagePriority.Empty;
    public StageStatus Status { get; set; } = StageStatus.New;
    public string Data { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    public long PlanEntryId { get; set; }
}