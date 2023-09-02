using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SwiftHelperBackend.DAL;
using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.Extensions;
using SwiftHelperBackend.Models.Plan;

namespace SwiftHelperBackend.Controllers;

[Route("api/[controller]")]
[Authorize]
public class PlanController : Controller
{
    private readonly AppDbContext _dbContext;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IMapper _mapper;

    public PlanController(AppDbContext dbContext, IMapper mapper, UserManager<ApplicationUser> userManager)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _userManager = userManager;
    }

    [HttpGet]
    public async Task<List<PlanEntryDTO>> GetPlans()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.PlanEntries
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? ""))
            .Select(x => new PlanEntryDTO
            {
                Id = x.Id,
                Description = x.Description,
                Title = x.Title,
                CreatedDate = x.CreatedDate.ToLocalTime()
            })
            .ToListAsync();

        var result = _mapper.Map<List<PlanEntryDTO>>(items);

        return result;
    }

    [HttpPost]
    public async Task<IActionResult> PlanEntryAdd([FromBody] PlanEntryDTO model)
    {
        var item = _mapper.Map<PlanEntry>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;

        await _dbContext.PlanEntries.AddAsync(item);
        await _dbContext.SaveChangesAsync();

        return StatusCode(200);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> PlanEntryDelete(long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.PlanEntries.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
        if (item == null)
            return StatusCode(500);

        _dbContext.Remove(item);
        await _dbContext.SaveChangesAsync();

        return StatusCode(200);
    }

    [HttpGet("stages/{id}")]
    public async Task<List<PlanStageEntryDTO>> GetPlanStages(long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.PlanStageEntries
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? "") && x.PlanEntryId == id)
            .Select(x => new PlanStageEntryDTO
            {
                Id = x.Id,
                Data = x.Data,
                Title = x.Title,
                Priority = x.Priority,
                Status = x.Status,
                PlanEntryId = x.PlanEntryId,
                CreatedDate = x.CreatedDate.ToLocalTime()
            })
            .ToListAsync();

        var result = _mapper.Map<List<PlanStageEntryDTO>>(items);

        return result;
    }


    [HttpPost("stage")]
    public async Task<IActionResult> StageAdd([FromBody] PlanStageEntryDTO model)
    {
        var item = _mapper.Map<PlanStageEntry>(model);
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;

        try
        {
            await _dbContext.PlanStageEntries.AddAsync(item);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }
    
    [HttpGet("stage/{id}")]
    public async Task<PlanStageEntryDTO?> GetPlanStage(long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.PlanStageEntries.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
        return _mapper.Map<PlanStageEntryDTO>(item);
    }
    
    [HttpPut("stage/detail")]
    public async Task<IActionResult> ChangePlanStage([FromBody] PlanStageEntryDTO model)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = _mapper.Map<PlanStageEntry>(model);
        var dbItem = await _dbContext.PlanStageEntries.Where(x => x.Id == item.Id && x.UserId == userId)
            .Select(x => new PlanStageEntry
            {
                Id = x.Id,
                User = x.User,
                UserId = x.UserId,
                PlanEntry = x.PlanEntry,
                CreatedDate = item.CreatedDate,
                Data = item.Data,
                Priority = item.Priority,
                Status = item.Status,
                PlanEntryId = item.PlanEntryId,
                Title = item.Title
            }).SingleOrDefaultAsync();
        if (dbItem == null)
            return StatusCode(500);
        
        try
        {
            _dbContext.PlanStageEntries.Update(dbItem);
            await _dbContext.SaveChangesAsync();

            return StatusCode(200);
        }
        catch (Exception e)
        {
            return StatusCode(500);
        }
    }

    [HttpDelete("stage/{id}")]
    public async Task<IActionResult> PlanStageDelete(long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.PlanStageEntries.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
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