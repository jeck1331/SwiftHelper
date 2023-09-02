using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.DAL.Models.Enums;

namespace SwiftHelperBackend.Models.Note;

public class NoteDetailDataDTO : IdBase
{
    public string Data { get; set; } = null!;
    public DateTime? CreatedDate { get; set; }
    public NoteType Type { get; set; }
    public long NoteEntryId { get; set; }
}