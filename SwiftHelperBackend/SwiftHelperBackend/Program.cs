using System.Net;
using SwiftHelperBackend;

public static class Program
{
    public static void Main(string[] args) =>
        CreateHostBuilder(args).Build().Run();

    public static IHostBuilder CreateHostBuilder(string[] args) =>
        Host.CreateDefaultBuilder(args)
            .ConfigureWebHostDefaults(options =>
                {
                    options.UseKestrel(o =>
                    {
                        o.Listen(IPAddress.Any, 443);
                        o.Listen(IPAddress.Any, 80);
                    });
                    options.UseStartup<Startup>();
                }
            );
}