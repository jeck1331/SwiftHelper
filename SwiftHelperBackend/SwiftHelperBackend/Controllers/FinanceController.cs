using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SwiftHelperBackend.Extensions;
using SwiftHelperBackend.Models.Finance;
using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.DAL;
using SwiftHelperBackend.Models;
using SwiftHelperBackend.Services;

namespace SwiftHelperBackend.Controllers;

[Route("api/[controller]")]
[Authorize]
public class FinanceController : Controller
{
    private readonly AppDbContext _dbContext;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IMapper _mapper;
    private readonly FinanceService _financeService;

    public FinanceController(AppDbContext dbContext, IMapper mapper, UserManager<ApplicationUser> userManager, FinanceService financeService)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _userManager = userManager;
        _financeService = financeService;
    }

    [HttpPost("history")]
    public async Task<IActionResult> AddHistory([FromBody] FinanceHistoryDTO model)
    {
        var item = _mapper.Map<FinanceHistory>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;
        item.CreatedDate = DateTime.UtcNow;

        var items = await _dbContext.FinanceHistories.Where(x => x.UserId == userId && x.AccountId == model.AccountId).ToListAsync();

        var result = _financeService.getSumAccount(items.Select(x => new FinanceValueSum
        {
            Type = x.Type,
            Value = x.ItemValue
        }).ToList());

        if (_financeService.isAdd(result, model.ItemValue, model.Type))
        {
            await _dbContext.FinanceHistories.AddAsync(item);
            await _dbContext.SaveChangesAsync();
        
            return StatusCode(200);
        }

        return StatusCode(409);
    }

    [HttpGet("histories")]
    public async Task<List<FinanceHistoryViewDTO>?> GetAllHistories()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.FinanceHistories
            .Where(x => x.UserId == (userId ?? ""))
            .Select(x => new FinanceHistoryViewDTO
            {
                AccountName = x.Account.AccountName,
                Id = x.Id,
                Type = x.Type,
                CreatedDate = x.CreatedDate.ToLocalTime(),
                AccountValute = x.Account.Valute ?? "",
                ItemName = x.ItemName ?? "",
                CategoryShopName = x.Category.ShopCategoryName,
                ItemValue = x.ItemValue
            })
            .ToListAsync();

        var result = _mapper.Map<List<FinanceHistoryViewDTO>>(items);

        return result;
    }
    
    [HttpGet("histories/{id}")]
    public async Task<List<FinanceHistoryViewDTO>?> GetHistoriesByAccount(long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.FinanceHistories
            .Include(x => x.Account)
            .Include(x => x.Category)
            .Where(x => x.UserId == (userId ?? "") && x.AccountId == id)
            .Select(x => new FinanceHistoryViewDTO
            {
                AccountName = x.Account.AccountName,
                Id = x.Id,
                Type = x.Type,
                CreatedDate = x.CreatedDate.ToLocalTime(),
                AccountValute = x.Account.Valute ?? "",
                ItemName = x.ItemName ?? "",
                CategoryShopName = x.Category.ShopCategoryName,
                ItemValue = x.ItemValue
            })
            .ToListAsync();

        var result = _mapper.Map<List<FinanceHistoryViewDTO>>(items);

        return result;
    }

    [HttpPut("history")]
    public async Task<IActionResult> ChangeHistory([FromBody] FinanceHistoryDTO model)
    {
        var requestItem = _mapper.Map<FinanceHistory>(model);
        var item = await _dbContext.FinanceHistories.FirstOrDefaultAsync(x => x.Id == model.Id);

        if (requestItem == null || item == null)
            return StatusCode(500);

        try
        {
            _dbContext.FinanceHistories.Update(requestItem);
            await _dbContext.SaveChangesAsync();
        
            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
        
    }
    
    [HttpDelete("history/{id}")]
    public async Task<IActionResult> DeleteHistory(long id)
    {
        var item = await _dbContext.FinanceHistories.FirstOrDefaultAsync(x => x.Id == id);

        if (item == null)
        {
            await HttpContext.SendErrorWithMessage("Item is null");
            return StatusCode(400);
        }
        
        try
        {
            _dbContext.FinanceHistories.Remove(item);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }

    [HttpPost("account")]
    public async Task<IActionResult> AddAccount([FromBody] FinanceAccountDTO model)
    {
        var item = _mapper.Map<FinanceAccount>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;
        
        await _dbContext.FinanceAccounts.AddAsync(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }

    [HttpGet("account")]
    public async Task<FinanceAccountDTO?> GetAccountById([FromQuery] IdBase model)
    {
        var item = await _dbContext.FinanceAccounts.FirstOrDefaultAsync(x => x.Id == model.Id);

        if (item == null)
        {
            await HttpContext.SendErrorWithMessage("Item is null");
            return null;
        }

        var result = _mapper.Map<FinanceAccountDTO>(item);

        return result;
    }
    
    [HttpPut("account")]
    public async Task<IActionResult> ChangeAccount([FromBody] FinanceAccountDTO model)
    {
        var requestItem = _mapper.Map<FinanceAccount>(model);
        var item = await _dbContext.FinanceAccounts.FirstOrDefaultAsync(x => x.Id == model.Id);

        if (requestItem == null || item == null)
            return StatusCode(500);

        try
        {
            _dbContext.FinanceAccounts.Update(requestItem);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }
    
    [HttpDelete("account/{id}")]
    public async Task<IActionResult> DeleteAccount(long id)
    {
        var item = await _dbContext.FinanceAccounts.FirstOrDefaultAsync(x => x.Id == id);

        if (item == null)
        {
            await HttpContext.SendErrorWithMessage("Item is null");
            return StatusCode(400);
        }
        
        try
        {
            _dbContext.FinanceAccounts.Remove(item);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }
    
    [HttpPost("category")]
    public async Task<IActionResult> AddCategory([FromBody] FinanceShopCategoryDTO model)
    {
        var item = _mapper.Map<FinanceShopCategory>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;

        await _dbContext.FinanceShopCategories.AddAsync(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }
    
    [HttpPut("category")]
    public async Task<IActionResult> ChangeCategory([FromBody] FinanceShopCategoryDTO model)
    {
        var requestItem = _mapper.Map<FinanceShopCategory>(model);
        var item = await _dbContext.FinanceShopCategories.FirstOrDefaultAsync(x => x.Id == model.Id);

        if (requestItem == null || item == null)
            return StatusCode(500);
        
        try
        {
            _dbContext.FinanceShopCategories.Update(requestItem);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }

    [HttpGet("category")]
    public async Task<FinanceShopCategoryDTO?> GetCategoryById([FromQuery] IdBase model)
    {
        var item = await _dbContext.FinanceShopCategories.FirstOrDefaultAsync(x => x.Id == model.Id);

        if (item == null)
        {
            await HttpContext.SendErrorWithMessage("Item is null");
            return null;
        }

        var result = _mapper.Map<FinanceShopCategoryDTO>(item);

        return result;
    }
    
    [HttpDelete("category")]
    public async Task<IActionResult> DeleteCategory([FromQuery] IdBase model)
    {
        var item = await _dbContext.FinanceShopCategories.FirstOrDefaultAsync(x => x.Id == model.Id);

        if (item == null)
        {
            await HttpContext.SendErrorWithMessage("Item is null");
            return StatusCode(400);
        }

        try
        {
            _dbContext.FinanceShopCategories.Remove(item);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }

    [HttpGet("accounts/view")]
    public async Task<List<FinanceAccountDTO>> GetFinanceAccountView()
    {
        var items = await _dbContext.FinanceAccounts.ToListAsync();
        var result = _mapper.Map<List<FinanceAccountDTO>>(items);
        return result;
    }

    [HttpGet("categories/view")]
    public async Task<List<FinanceShopCategoryDTO>> GetFinanceShopCategoriesView()
    {
        var items = await _dbContext.FinanceShopCategories.ToListAsync();
        var result = _mapper.Map<List<FinanceShopCategoryDTO>>(items);
        return result;
    }

    [HttpGet("categories")]
    public async Task<List<FinanceShopCategory>> GetFinanceShopCategories()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.FinanceShopCategories
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? "")).ToListAsync();

        var result = _mapper.Map<List<FinanceShopCategory>>(items);

        return result;
    }
    
    [HttpGet("accounts")]
    public async Task<List<FinanceAccount>> GetFinanceAccount()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.FinanceAccounts
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? "")).ToListAsync();

        var result = _mapper.Map<List<FinanceAccount>>(items);

        return result;
    }
    
    [HttpPost("accounts/ids")]
    public async Task<List<FinanceAccount>> GetFinanceAccountsByIds([FromBody] long[] ids)
    {
        var histories = await _dbContext.FinanceHistories.Where(x => ids.Contains(x.Id)).ToListAsync();
        var uniqueAccountIds = histories.Select(history => history.AccountId).Distinct().ToList();
        
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.FinanceAccounts
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? "") && uniqueAccountIds.Contains(x.Id)).ToListAsync();

        var result = _mapper.Map<List<FinanceAccount>>(items);

        return result;
    }
    
    [HttpPost("categories/ids")]
    public async Task<List<FinanceShopCategoryDTO>> GetFinanceCategoriesByIds([FromBody] long[] ids)
    {
        var histories = await _dbContext.FinanceHistories.Where(x => ids.Contains(x.Id)).ToListAsync();
        var uniqueCategoryIds = histories.Select(category => category.CategoryShopId).Distinct().ToList();
        
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.FinanceShopCategories
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? "") && uniqueCategoryIds.Contains(x.Id)).ToListAsync();

        var result = _mapper.Map<List<FinanceShopCategoryDTO>>(items);

        return result;
    }
}