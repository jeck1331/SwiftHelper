using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.Models.Note;

public class NoteEntryDTO : IdBase
{
    public string Title { get; set; }
    public string Description { get; set; }
    public DateTime CreatedDate { get; set; }
    public NoteType Type { get; set; }
    public long? RefUserId { get; set; }
    public long? RefNoteId { get; set; }
    public long? NoteDetailId { get; set; }
}