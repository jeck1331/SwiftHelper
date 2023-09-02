namespace SwiftHelperBackend.Models.User;

public class UserDTO
{
    public string Id { get; set; }

    public string UserName { get; set; }
    public string Email { get; set; }
    public string PhoneNumber { get; set; }
    public DateTime CreatedDate { get; set; }

    public long FinanceHistoryId { get; set; }
    public long FinanceAccountId { get; set; }
    public long FinanceShopCategoryId { get; set; }
    public long HealthEatId { get; set; }
    public long HealthEatCategoryId { get; set; }
    public long HealthWaterId { get; set; }
    public long HealthLifeActivityId { get; set; }
    public long HealthActivityCategoryId { get; set; }
    public long PlanEntryId { get; set; }
    public long PlanDetailId { get; set; }
    public long NoteEntryId { get; set; }
    public long NoteDetailId { get; set; }
    public long NoteRefsId { get; set; }
}