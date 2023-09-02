using FastEndpoints;
using Microsoft.AspNetCore.Identity;
using SwiftHelperBackend.DAL.Models;

namespace SwiftHelperBackend.Extensions;

public static class EndpointExtensions
{
    public static async Task SendOkWithMessage(this HttpContext context, string message, CancellationToken ct)
    {
        await context.Response.SendAsync(new {message}, cancellation: ct);
    }

    public static async Task SendErrorWithMessage(this HttpContext context, string message, CancellationToken ct)
    {
        await context.Response.SendAsync(new {message}, 400, cancellation: ct);
    }

    public static async Task SendErrorWithMessage(this HttpContext context, string message)
    {
        await context.Response.SendAsync(new {message}, 400);
    }

    public static async Task SendOkWithMessage(this HttpContext context, string message)
    {
        await context.Response.SendAsync(new {message});
    }

    public static string? UserId(this HttpContext context, UserManager<ApplicationUser> userManager)
    {
        var userIdentity = context.User.Identity;
        if (userIdentity is null)
            return null;
        var user = userManager.FindByNameAsync(userIdentity.Name).Result;
        return user?.Id;
    }
}