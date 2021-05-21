#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 5001
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["ItemService.csproj", "."]
RUN dotnet restore "./ItemService.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "ItemService.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ItemService.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ItemService.dll"]