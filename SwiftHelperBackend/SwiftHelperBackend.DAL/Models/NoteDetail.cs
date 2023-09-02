using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.DAL.Models;

public class NoteDetail : IdBase
{
    public string Data { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    public NoteType Type { get; set; }
    
    public string UserId { get; set; } = null!;
    public ApplicationUser User { get; set; } = null!;
    
    public long NoteEntryId { get; set; }
    public NoteEntry NoteEntry { get; set; } = null!;
}