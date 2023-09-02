using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.Models.Finance;

public class FinanceHistoryViewDTO : IdBase
{
    public string ItemName { get; set; } = null!;
    public decimal ItemValue { get; set; }
    public DateTime CreatedDate { get; set; }
    public FinanceHistoryType Type { get; set; } 

    public string CategoryShopName { get; set; } = null!;
    public string AccountName { get; set; } = null!;
    public string AccountValute { get; set; } = null!;
}
