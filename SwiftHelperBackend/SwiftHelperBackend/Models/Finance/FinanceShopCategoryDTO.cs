using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.Models.Finance;

public class FinanceShopCategoryDTO : IdBase
{
    public string ShopCategoryName { get; set; }
    public string? Icon { get; set; }
    public ChartColors Color { get; set; }
}