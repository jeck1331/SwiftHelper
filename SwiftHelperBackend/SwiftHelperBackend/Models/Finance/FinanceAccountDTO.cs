using SwiftHelperBackend.DAL.Models;

namespace SwiftHelperBackend.Models.Finance;

public class FinanceAccountDTO : IdBase
{
    public string AccountName { get; set; }
    public string? Valute { get; set; }
}