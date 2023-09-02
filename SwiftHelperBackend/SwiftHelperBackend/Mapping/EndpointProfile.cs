using AutoMapper;
using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.Models.Finance;
using SwiftHelperBackend.Models.Health;
using SwiftHelperBackend.Models.Note;
using SwiftHelperBackend.Models.Plan;
using SwiftHelperBackend.Models.User;

namespace SwiftHelperBackend.Mapping;

public class EndpointProfile : Profile
{
    public EndpointProfile()
    {
        CreateMap<ApplicationUser, UserDTO>()
            .ReverseMap()
            .ForMember(dest => dest.TwoFactorEnabled, o => o.Ignore())
            .ForMember(dest => dest.SecurityStamp, o => o.Ignore())
            .ForMember(dest => dest.PhoneNumberConfirmed, o => o.Ignore())
            .ForMember(dest => dest.PasswordHash, o => o.Ignore())
            .ForMember(dest => dest.NormalizedEmail, o => o.Ignore())
            .ForMember(dest => dest.NormalizedUserName, o => o.Ignore())
            .ForMember(dest => dest.LockoutEnd, o => o.Ignore())
            .ForMember(dest => dest.LockoutEnabled, o => o.Ignore())
            .ForMember(dest => dest.EmailConfirmed, o => o.Ignore())
            .ForMember(dest => dest.ConcurrencyStamp, o => o.Ignore())
            .ForMember(dest => dest.AccessFailedCount, o => o.Ignore());
        
        CreateMap<FinanceHistory, FinanceHistoryDTO>()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());

        CreateMap<FinanceHistory, FinanceHistoryViewDTO>()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ForMember(dest => dest.AccountName, o => o.MapFrom(src => src.Account.AccountName))
            .ForMember(dest => dest.AccountValute, o => o.MapFrom(src => src.Account.Valute))
            .ForMember(dest => dest.CategoryShopName, o => o.MapFrom(src => src.Category.ShopCategoryName))
            .ReverseMap()
            .ForMember(dest => dest.CategoryShopId, o => o.Ignore())
            .ForMember(dest => dest.AccountId, o => o.Ignore())
            .ForMember(dest => dest.UserId, o => o.Ignore());

        CreateMap<FinanceAccount, FinanceAccountDTO>()
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());

        CreateMap<FinanceShopCategory, FinanceShopCategoryDTO>()
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());
        
        CreateMap<HealthActivityCategory, HealthActivityCategoryDTO>()
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<HealthEatCategory, HealthEatCategoryDTO>()
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<HealthEat, HealthEatDTO>()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ForMember(dest => dest.CategoryId, o => o.MapFrom(src => src.EatCategoryId))
            .ReverseMap()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ForMember(dest => dest.EatCategoryId, o => o.MapFrom(src => src.CategoryId))
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<HealthLifeActivity, HealthLifeActivityDTO>()
            .ForMember(dest => dest.CategoryId, o => o.MapFrom(src => src.HealthActivityCategoryId))
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ReverseMap()
            .ForMember(dest => dest.HealthActivityCategoryId, o => o.MapFrom(src => src.CategoryId))
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<HealthWater, HealthWaterDTO>()
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<NoteDetail, NoteDetailDataDTO>()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<NoteEntry, NoteEntryDTO>()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ReverseMap()
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<PlanStageEntry, PlanStageEntryDTO>()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ReverseMap()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ForMember(dest => dest.UserId, o => o.Ignore());
        CreateMap<PlanEntry, PlanEntryDTO>()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ReverseMap()
            .ForMember(dest => dest.CreatedDate, o => o.MapFrom(src => src.CreatedDate.ToUniversalTime()))
            .ForMember(dest => dest.UserId, o => o.Ignore());
    }
}