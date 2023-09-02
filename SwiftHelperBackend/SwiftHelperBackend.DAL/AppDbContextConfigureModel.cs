using Microsoft.EntityFrameworkCore;
using SwiftHelperBackend.DAL.Models;

namespace SwiftHelperBackend.DAL;

public sealed partial class AppDbContext
{
    static partial void ConfigureModel(ModelBuilder builder)
    {
        void EntitiesHasData()
        {
            builder.Entity<FinanceHistory>()
                .HasKey(i => i.Id);
            builder.Entity<FinanceHistory>()
                .HasOne(x => x.User)
                .WithMany(x => x.FinanceHistories)
                .HasForeignKey(x => x.UserId);
            builder.Entity<FinanceHistory>()
                .HasOne(x => x.Account)
                .WithMany(x => x.Histories)
                .HasForeignKey(x => x.AccountId);
            builder.Entity<FinanceHistory>()
                .HasOne(x => x.Category)
                .WithMany(x => x.Histories)
                .HasForeignKey(x => x.CategoryShopId);

            builder.Entity<FinanceAccount>()
                .HasKey(i => i.Id);
            builder.Entity<FinanceAccount>()
                .HasOne(x => x.User)
                .WithMany(x => x.FinanceAccounts)
                .HasForeignKey(x => x.UserId);
            
            builder.Entity<FinanceShopCategory>()
                .HasKey(i => i.Id);
            builder.Entity<FinanceShopCategory>()
                .HasOne(x => x.User)
                .WithMany(x => x.FinanceShopCategories)
                .HasForeignKey(x => x.UserId);
            
            builder.Entity<HealthEat>()
                .HasKey(i => i.Id);
            builder.Entity<HealthEat>()
                .HasOne(x => x.User)
                .WithMany(x => x.HealthEats)
                .HasForeignKey(x => x.UserId);
            builder.Entity<HealthEat>()
                .HasOne(x => x.EatCategory)
                .WithMany(x => x.HealthEats)
                .HasForeignKey(x => x.EatCategoryId);

            builder.Entity<HealthEatCategory>()
                .HasKey(i => i.Id);
            builder.Entity<HealthEatCategory>()
                .HasOne(x => x.User)
                .WithMany(x => x.HealthEatCategories)
                .HasForeignKey(x => x.UserId);
            
            builder.Entity<HealthWater>()
                .HasKey(i => i.Id);
            builder.Entity<HealthWater>()
                .HasOne(x => x.User)
                .WithMany(x => x.HealthWaters)
                .HasForeignKey(x => x.UserId);
            
            builder.Entity<HealthLifeActivity>()
                .HasKey(i => i.Id);
            builder.Entity<HealthLifeActivity>()
                .HasOne(x => x.User)
                .WithMany(x => x.HealthLifeActivities)
                .HasForeignKey(x => x.UserId);
            builder.Entity<HealthLifeActivity>()
                .HasOne(x => x.HealthActivityCategory)
                .WithMany(x => x.HealthActivities)
                .HasForeignKey(x => x.HealthActivityCategoryId);
            
            builder.Entity<HealthActivityCategory>()
                .HasKey(i => i.Id);
            builder.Entity<HealthActivityCategory>()
                .HasOne(x => x.User)
                .WithMany(x => x.HealthActivityCategories)
                .HasForeignKey(x => x.UserId);
            
            builder.Entity<PlanEntry>()
                .HasKey(i => i.Id);
            builder.Entity<PlanEntry>()
                .HasOne(x => x.User)
                .WithMany(x => x.PlanEntries)
                .HasForeignKey(x => x.UserId)
                .OnDelete(DeleteBehavior.Cascade);
                
            
            builder.Entity<PlanStageEntry>()
                .HasKey(i => i.Id);
            builder.Entity<PlanStageEntry>()
                .HasOne(x => x.User)
                .WithMany(x => x.PlanStageEntries)
                .HasForeignKey(x => x.UserId);
            builder.Entity<PlanStageEntry>()
                .HasOne(x => x.PlanEntry)
                .WithMany(x => x.PlanStageEntries)
                .HasForeignKey(x => x.PlanEntryId);

            builder.Entity<NoteRefToAccess>()
                .HasKey(i => i.Id);
            builder.Entity<NoteRefToAccess>()
                .HasOne(x => x.User)
                .WithMany(x => x.NoteReferences)
                .HasForeignKey(x => x.UserId);
            builder.Entity<NoteRefToAccess>()
                .HasOne(x => x.Note)
                .WithMany(x => x.RefNotes)
                .HasForeignKey(x => x.NoteId);

            builder.Entity<NoteEntry>()
                .HasKey(i => i.Id);
            builder.Entity<NoteEntry>()
                .HasOne(x => x.User)
                .WithMany(x => x.NoteEntries)
                .HasForeignKey(x => x.UserId)
                .OnDelete(DeleteBehavior.Cascade);
            
            builder.Entity<NoteDetail>()
                .HasKey(i => i.Id);
            builder.Entity<NoteDetail>()
                .HasOne(x => x.User)
                .WithMany(x => x.NoteDetailData)
                .HasForeignKey(x => x.UserId);
            builder.Entity<NoteDetail>()
                .HasOne(x => x.NoteEntry)
                .WithMany(x => x.NoteDetailData)
                .HasForeignKey(x => x.NoteEntryId);
        }

        EntitiesHasData();
    }
}