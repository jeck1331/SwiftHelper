using Microsoft.AspNetCore.Identity;

namespace SwiftHelperBackend.DAL.Models;

public class ApplicationUser : IdentityUser
{
    public DateTime CreatedDate { get; set; }
    
    public ICollection<FinanceHistory>? FinanceHistories { get; set; } = null!;
    public ICollection<FinanceAccount>? FinanceAccounts { get; set; } = null!;
    public ICollection<FinanceShopCategory>? FinanceShopCategories { get; set; } = null!;
    public ICollection<HealthEat>? HealthEats { get; set; } = null!;
    public ICollection<HealthEatCategory>? HealthEatCategories { get; set; } = null!;
    public ICollection<HealthWater>? HealthWaters { get; set; } = null!;
    public ICollection<HealthLifeActivity>? HealthLifeActivities { get; set; } = null!;
    public ICollection<HealthActivityCategory>? HealthActivityCategories { get; set; } = null!;
    public ICollection<PlanEntry>? PlanEntries { get; set; } = null!;
    public ICollection<PlanStageEntry>? PlanStageEntries { get; set; } = null!;
    public ICollection<NoteEntry>? NoteEntries { get; set; } = null!;
    public ICollection<NoteDetail>? NoteDetailData { get; set; } = null!;
    public ICollection<NoteRefToAccess>? NoteReferences { get; set; } = null!;
}