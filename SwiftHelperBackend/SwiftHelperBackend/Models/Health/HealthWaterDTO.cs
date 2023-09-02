using SwiftHelperBackend.DAL.Models;

namespace SwiftHelperBackend.Models.Health;

public class HealthWaterDTO : IdBase
{
    public double Volume { get; set; }
    public DateTime CreatedDate { get; set; }
}