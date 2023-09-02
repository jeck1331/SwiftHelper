using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SwiftHelperBackend.DAL.Models;

namespace SwiftHelperBackend.DAL;

public partial class AppDbContext : IdentityDbContext<ApplicationUser>
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
        Database.Migrate();
    }

    public DbSet<FinanceHistory> FinanceHistories { get; set; } = null!;
    public DbSet<FinanceAccount> FinanceAccounts { get; set; } = null!;
    public DbSet<FinanceShopCategory> FinanceShopCategories { get; set; } = null!;
    public DbSet<HealthLifeActivity> HealthActivities { get; set; } = null!;
    public DbSet<HealthActivityCategory> HealthActivityCategories { get; set; } = null!;
    public DbSet<HealthEat> HealthEats { get; set; } = null!;
    public DbSet<HealthEatCategory> HealthEatCategories { get; set; } = null!;
    public DbSet<NoteEntry> NoteEntries { get; set; } = null!;
    public DbSet<NoteDetail> NoteDetailData { get; set; } = null!;
    public DbSet<HealthWater> HealthWaters { get; set; } = null!;
    public DbSet<NoteRefToAccess> NoteReferences { get; set; } = null!;
    public DbSet<PlanEntry> PlanEntries { get; set; } = null!;
    public DbSet<PlanStageEntry> PlanStageEntries{ get; set; } = null!;


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        ConfigureModel(modelBuilder);
    }

    static partial void ConfigureModel(ModelBuilder modelBuilder);
}