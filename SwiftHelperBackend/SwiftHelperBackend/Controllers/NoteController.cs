using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SwiftHelperBackend.DAL;
using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.Extensions;
using SwiftHelperBackend.Models.Note;

namespace SwiftHelperBackend.Controllers;

[Route("api/[controller]")]
[Authorize]
public class NoteController: Controller
{
    private readonly AppDbContext _dbContext;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IMapper _mapper;

    public NoteController(AppDbContext dbContext, IMapper mapper, UserManager<ApplicationUser> userManager)
    {
        _dbContext = dbContext;
        _mapper = mapper;
        _userManager = userManager;
    }

    [HttpGet("notes")]
    public async Task<List<NoteEntryDTO>> AllNote()
    {
        var userId = HttpContext.UserId(_userManager);
        var items = await _dbContext.NoteEntries
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? ""))
            .Select(x => new NoteEntryDTO
            {
                Id = x.Id,
                CreatedDate = x.CreatedDate.ToLocalTime(),
                Description = x.Description,
                Title = x.Title,
                Type = x.Type,
                NoteDetailId = x.NoteDetailId,
                RefNoteId = x.RefNoteId,
                RefUserId = x.RefUserId
            })
            .ToListAsync();

        var result = _mapper.Map<List<NoteEntryDTO>>(items);
        
        return result;
    }
    
    [HttpGet("note/{id}")]
    public async Task<NoteDetailDataDTO> DetailNote(long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.NoteDetailData
            .AsNoTracking()
            .Where(x => x.UserId == (userId ?? "") && x.Id == id)
            .Select(x => new NoteDetailDataDTO
            {
                Id = x.Id,
                CreatedDate = x.CreatedDate.ToLocalTime(),
                Type = x.Type,
                Data = x.Data,
                NoteEntryId = x.NoteEntryId
            })
            .FirstOrDefaultAsync();

        var result = _mapper.Map<NoteDetailDataDTO>(item);

        return result;
    }
    
    [HttpPost("note/detail")]
    public async Task<IActionResult> AddDetailNote([FromBody] NoteDetailDataDTO model)
    {
        var item = _mapper.Map<NoteDetail>(model);
        item.CreatedDate = DateTime.UtcNow;
        var userId = HttpContext.UserId(_userManager);
        if (userId == null)
            return StatusCode(500);

        item.UserId = userId;

        if (await _dbContext.NoteDetailData.AnyAsync(x => x.Id == model.Id))
        { 
            _dbContext.NoteDetailData.Update(item);
        }
        else
        {
            await _dbContext.NoteDetailData.AddAsync(item);
        }

        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }

    [HttpPost("note")]
    public async Task<IActionResult> AddNote([FromBody] NoteEntryDTO model)
    {
        var item = _mapper.Map<NoteEntry>(model);
        item.CreatedDate = DateTime.UtcNow;
        var userId = HttpContext.UserId(_userManager);
        if (item == null || userId == null)
            return StatusCode(500);

        item.UserId = userId;

        await _dbContext.NoteEntries.AddAsync(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }
    
    [HttpDelete("note")]
    public async Task<IActionResult> DeleteNote([FromQuery] long id)
    {
        var userId = HttpContext.UserId(_userManager);
        var item = await _dbContext.NoteEntries.FirstOrDefaultAsync(x => x.Id == id && x.UserId == userId);
        if (item == null)
            return StatusCode(500);

        _dbContext.Remove(item);
        await _dbContext.SaveChangesAsync();
        
        return StatusCode(200);
    }
}