namespace SwiftHelperBackend.DAL.Models;

public class NoteRefToAccess : IdBase
{
    public string UserId { get; set; } = null!;
    public ApplicationUser User { get; set; } = null!;
    
    public long NoteId { get; set; }
    public NoteEntry Note { get; set; } = null!;
    
    public string RefUserId { get; set; }
    public ApplicationUser UserRef { get; set; } = null!;
}