namespace SwiftHelperBackend.DAL.Models;

public class FinanceAccount : IdBase
{
    public string AccountName { get; set; } = null!;
    public string? Valute { get; set; } = null!;
    
    public string UserId { get; set; } = null!;
    
    public ApplicationUser User { get; set; } = null!;
    public ICollection<FinanceHistory> Histories { get; set; } = null!;
}