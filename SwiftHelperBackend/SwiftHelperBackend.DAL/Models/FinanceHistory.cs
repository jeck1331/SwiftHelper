using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.DAL.Models;

public class FinanceHistory : IdBase
{
    public string? ItemName { get; set; } = null!;
    public decimal ItemValue { get; set; }
    public DateTime CreatedDate { get; set; }
    public FinanceHistoryType Type { get; set; } 
    
    public long CategoryShopId { get; set; }
    public long AccountId { get; set; }
    public string UserId { get; set; } = null!;
    
    public ApplicationUser User { get; set; } = null!;
    public FinanceAccount Account { get; set; } = null!;
    public FinanceShopCategory Category { get; set; } = null!;
}