FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

ENV ASPNETCORE_URLS=https://+:5000
ENV ASPNETCORE_URLS=http://+:80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY SwiftHelperBackend/SwiftHelperBackend.csproj SwitHelperBackend/
COPY SwiftHelperBackend.DAL/SwiftHelperBackend.DAL.csproj SwiftHelperBackend.DAL/
COPY . .

RUN dotnet restore SwiftHelperBackend/SwiftHelperBackend.csproj

WORKDIR /src/SwiftHelperBackend
RUN dotnet build SwiftHelperBackend.csproj -c Release -o /app/build

FROM build AS publish
RUN dotnet publish SwiftHelperBackend.csproj -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SwiftHelperBackend.dll"]
