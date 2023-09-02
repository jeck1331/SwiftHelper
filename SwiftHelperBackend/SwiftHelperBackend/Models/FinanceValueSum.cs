using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.Models;

public class FinanceValueSum
{
    public decimal Value { get; set; }
    public FinanceHistoryType Type { get; set; }
}