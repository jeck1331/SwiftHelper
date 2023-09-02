using SwiftHelperBackend.DAL.Models;

namespace SwiftHelperBackend.Models.Health;

public class HealthLifeActivityDTO : IdBase
{
    public string Title { get; set; }
    public DateTime CreatedDate { get; set; }
    public long CategoryId { get; set; }
    public string CategoryName { get; set; }
}