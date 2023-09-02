using SwiftHelperBackend.DAL.Models.Enums;
using SwiftHelperBackend.Models;

namespace SwiftHelperBackend.Services;

public class FinanceService
{
    public decimal getSumAccount(List<FinanceValueSum> values)
    {
        decimal result = 0;
        foreach (var item in values)
        {
            if (item.Type == FinanceHistoryType.Expense)
            {
                result += item.Value;
            }
            else
            {
                result -= item.Value;
            }
        }

        return result;
    }

    public bool isAdd(decimal sum, decimal newValue, FinanceHistoryType type) => type == FinanceHistoryType.Expense || sum > newValue;
}