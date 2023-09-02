using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.DAL.Models;

public class NoteEntry : IdBase
{
    public string Title { get; set; } = null!;
    public string Description { get; set; } = null!;
    public DateTime CreatedDate { get; set; }
    public NoteType Type { get; set; }
    
    public string UserId { get; set; } = null!;
    public ApplicationUser User { get; set; } = null!;

    public long? RefUserId { get; set; }
    public ICollection<ApplicationUser> RefUsers { get; set; } = null!;
    
    public long? RefNoteId { get; set; }
    public ICollection<NoteRefToAccess> RefNotes { get; set; } = null!;
    
    public long? NoteDetailId { get; set; }
    public ICollection<NoteDetail> NoteDetailData { get; set; } = null!;
}