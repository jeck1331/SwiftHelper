using SwiftHelperBackend.DAL.Models;

namespace SwiftHelperBackend.Models.Plan;

public class PlanEntryDTO : IdBase
{
    public string Title { get; set; }
    public string Description { get; set; }
    public DateTime CreatedDate { get; set; }
}