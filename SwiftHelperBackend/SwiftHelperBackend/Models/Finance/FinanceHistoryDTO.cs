using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.Models.Finance;

public class FinanceHistoryDTO : IdBase
{
    public string ItemName { get; set; }
    public decimal ItemValue { get; set; }
    public DateTime? CreatedDate { get; set; }
    public FinanceHistoryType Type { get; set; } 

    public long CategoryShopId { get; set; }
    public long AccountId { get; set; }
}