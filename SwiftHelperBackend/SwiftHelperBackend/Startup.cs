using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using OpenIddict.Abstractions;
using OpenIddict.Validation.AspNetCore;
using SwiftHelperBackend.DAL;
using SwiftHelperBackend.DAL.Models;
using SwiftHelperBackend.Mapping;
using SwiftHelperBackend.Services;

namespace SwiftHelperBackend;

public class Startup
{
    public Startup(IConfiguration configuration)
        => Configuration = configuration;

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddCors(options =>
        {
            options.AddPolicy("AllowAll", builder =>
            {
                builder.AllowAnyOrigin() 
                    .AllowAnyMethod()
                    .AllowAnyHeader();
            });
        });
        
        //Registering services
        services.AddScoped<FinanceService>();
        
        services.AddAutoMapper(typeof(EndpointProfile));
        services.AddControllersWithViews();

        services.AddSwaggerGen(options =>
        {
            options.SwaggerDoc("v1", new OpenApiInfo{ Title = "SwiftHelper API", Version = "V1" });
            options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
            {
                In = ParameterLocation.Header,
                Description = "Please enter a valid token",
                Name = "Authorization",
                Type = SecuritySchemeType.ApiKey,
                BearerFormat = "JWT",
                Scheme = "Bearer"
            });
            options.AddSecurityRequirement(new OpenApiSecurityRequirement
            {
                {
                    new OpenApiSecurityScheme
                    {
                        Reference = new OpenApiReference
                        {
                            Type = ReferenceType.SecurityScheme,
                            Id = "Bearer"
                        }
                    },
                    new string[]{}
                }
            });
        });

        services.AddAutoMapper(typeof(EndpointProfile));

        services.AddDbContext<AppDbContext>(options =>
        {
            options.UseNpgsql(Configuration.GetConnectionString(nameof(AppDbContext)));
            options.UseOpenIddict();
        });

        services.AddIdentity<ApplicationUser, IdentityRole>()
            .AddEntityFrameworkStores<AppDbContext>()
            .AddDefaultTokenProviders();

        services.AddOpenIddict()
            .AddCore(options => options.UseEntityFrameworkCore().UseDbContext<AppDbContext>())
            .AddServer(options =>
            {
                options.SetAccessTokenLifetime(TimeSpan.FromHours(6))
                    .SetRefreshTokenLifetime(TimeSpan.FromDays(5));

                options.UseDataProtection();

                options.RegisterScopes(OpenIddictConstants.Scopes.Profile, OpenIddictConstants.Scopes.Email, OpenIddictConstants.Scopes.OfflineAccess);
                
                // Enable the token endpoint.
                options.SetTokenEndpointUris("/connect/token")
                    .SetUserinfoEndpointUris("/connect/userinfo")
                    .SetLogoutEndpointUris("/connect/logout");
                       

                options.UseReferenceAccessTokens()
                    .UseReferenceRefreshTokens();
                // Enable the password and the refresh token flows.
                options.AllowPasswordFlow()
                    .AllowRefreshTokenFlow();

                // Accept anonymous clients (i.e clients that don't send a client_id).
                options.AcceptAnonymousClients();

                // Register the signing and encryption credentials.
                options.AddDevelopmentEncryptionCertificate()
                    .AddDevelopmentSigningCertificate();

                // Register the ASP.NET Core host and configure the ASP.NET Core-specific options.
                options.UseAspNetCore()
                    .DisableTransportSecurityRequirement()
                    .EnableTokenEndpointPassthrough()
                    .EnableUserinfoEndpointPassthrough()
                    .EnableLogoutEndpointPassthrough();
            })
            .AddValidation(options =>
            {
                options.UseLocalServer();
                options.UseAspNetCore();
                options.EnableTokenEntryValidation();
                options.UseDataProtection();
            });

        services.AddAuthorization(options =>
        {
            options.DefaultPolicy = new AuthorizationPolicyBuilder()
                .RequireAuthenticatedUser()
                .Build();
        });

        services.AddAuthentication(options =>
        {
            options.DefaultScheme = OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme;
            options.DefaultChallengeScheme = OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme;
            options.DefaultAuthenticateScheme = OpenIddictValidationAspNetCoreDefaults.AuthenticationScheme;
        });
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        app.UseDeveloperExceptionPage();

        app.UseCors("AllowAll");
        app.UseRouting();
        
        //app.UseHttpsRedirection();

        app.UseAuthentication();
        app.UseAuthorization();

        app.UseStaticFiles();
        
        app.UseSwagger();
        app.UseSwaggerUI();

        // if (env.IsDevelopment())
        // {
        //     app.UseSwagger();
        //     app.UseSwaggerUI();
        // }

        app.UseEndpoints(options =>
        {
            options.MapControllers();
            options.MapDefaultControllerRoute();
        });
    }
}