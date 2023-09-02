using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SwiftHelperBackend.DAL;
using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.Extensions;
using SwiftHelperBackend.Models.Health;

namespace SwiftHelperBackend.Controllers;

[Route("api/[controller]")]
[Authorize]
public class HealthController: Controller
{
    private readonly AppDbContext _dbContext;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IMapper _mapper;

    public HealthController(AppDbContext dbContext, IMapper mapper, UserManager<ApplicationUser> userManager)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _userManager = userManager;
    }
    
    [HttpGet("eats")]
    public async Task<List<HealthEatDTO>> AllEat()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.HealthEats
            .AsNoTracking()
            .Include(x => x.EatCategory)
            .Where(x => x.UserId == (userId ?? ""))
            .Select(x => new HealthEatDTO
            {
                Id = x.Id,
                Title = x.Title,
                CreatedDate = x.CreatedDate.ToLocalTime(),
                CategoryId = x.EatCategoryId,
                CategoryName = x.EatCategory.Title
            })
            .ToListAsync();

        var result = _mapper.Map<List<HealthEatDTO>>(items);

        return result;
    }

    [HttpPost("eat")]
    public async Task<IActionResult> AddEat([FromBody] HealthEatDTO model)
    {
        var item = _mapper.Map<HealthEat>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;

        await _dbContext.HealthEats.AddAsync(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }
    
    [HttpDelete("eat/{id}")]
    public async Task<IActionResult> DeleteEat(long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.HealthEats.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
        if (item == null)
            return StatusCode(500);

        try
        {
            _dbContext.Remove(item);
            await _dbContext.SaveChangesAsync();
        
            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }
    
    [HttpGet("eat/categories")]
    public async Task<List<HealthEatCategoryDTO>> AllEatCategories()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.HealthEatCategories.AsNoTracking().Where(x => x.UserId == (userId ?? "")).ToListAsync();

        var result = _mapper.Map<List<HealthEatCategoryDTO>>(items);

        return result;
    }

    [HttpPost("eat/category")]
    public async Task<IActionResult> AddEatCategory([FromBody] HealthEatCategoryDTO model)
    {
        var item = _mapper.Map<HealthEatCategory>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;

        await _dbContext.HealthEatCategories.AddAsync(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }
    
    [HttpDelete("eat/category/{id}")]
    public async Task<IActionResult> DeleteEatCategory([FromQuery] long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.HealthEatCategories.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
        if (item == null)
            return StatusCode(500);

        try
        {
            _dbContext.Remove(item);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }
    
    [HttpGet("sports")]
    public async Task<List<HealthLifeActivityDTO>> AllSport()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.HealthActivities
            .AsNoTracking()
            .Include(x => x.HealthActivityCategory)
            .Where(x => x.UserId == (userId ?? ""))
            .Select(x => new HealthLifeActivityDTO
            {
                Id = x.Id,
                Title = x.Title,
                CategoryId = x.HealthActivityCategoryId,
                CategoryName = x.HealthActivityCategory.Title,
                CreatedDate = x.CreatedDate.ToLocalTime()
            })
            .ToListAsync();

        var result = _mapper.Map<List<HealthLifeActivityDTO>>(items);

        return result;
    }

    [HttpPost("sport")]
    public async Task<IActionResult> AddSport([FromBody] HealthLifeActivityDTO model)
    {
        var item = _mapper.Map<HealthLifeActivity>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;

        await _dbContext.HealthActivities.AddAsync(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }
    
    [HttpDelete("sport/{id}")]
    public async Task<IActionResult> DeleteSport([FromQuery] long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.HealthActivities.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
        if (item == null)
            return StatusCode(500);

        try
        {
            _dbContext.Remove(item);
            await _dbContext.SaveChangesAsync();
        
            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }
    
    [HttpGet("sport/categories")]
    public async Task<List<HealthActivityCategoryDTO>> AllSportCategories()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.HealthActivityCategories.AsNoTracking().Where(x => x.UserId == (userId ?? "")).ToListAsync();

        var result = _mapper.Map<List<HealthActivityCategoryDTO>>(items);

        return result;
    }

    [HttpPost("sport/category")]
    public async Task<IActionResult> AddSportCategory([FromBody] HealthActivityCategoryDTO model)
    {
        var item = _mapper.Map<HealthActivityCategory>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;
        item.CreatedDate = DateTime.UtcNow;

        await _dbContext.HealthActivityCategories.AddAsync(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }
    
    [HttpDelete("sport/category/{id}")]
    public async Task<IActionResult> DeleteSportCategory([FromQuery] long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.HealthActivityCategories.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
        if (item == null)
            return StatusCode(500);

        try
        {
            _dbContext.Remove(item);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }
}