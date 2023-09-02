using System.ComponentModel.DataAnnotations;

namespace SwiftHelperBackend.Security.Models;

public class RegisterModel : LoginModel
{
    [Required] public string Email { get; set; } = null!;
    public string? PhoneNumber { get; set; } = null!;
    [Required] public string ConfirmPassword { get; set; } = null!;
}