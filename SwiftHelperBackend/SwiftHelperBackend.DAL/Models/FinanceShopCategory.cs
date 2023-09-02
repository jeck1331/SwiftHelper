using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.DAL.Models;

public class FinanceShopCategory : IdBase
{
    public string ShopCategoryName { get; set; } = null!;
    public string? Icon { get; set; } = null!;
    public ChartColors Color { get; set; }
    
    public string UserId { get; set; } = null!;    
    
    public ApplicationUser User { get; set; } = null!;
    public ICollection<FinanceHistory> Histories { get; set; } = null!;
}