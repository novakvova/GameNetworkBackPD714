FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base

#install application for get HW info
RUN apt-get update

# install System.Drawing native dependencies
RUN apt-get update
RUN apt-get install -y --allow-unauthenticated 
RUN apt-get install -y libc6-dev 
RUN apt-get install -y libgdiplus
RUN apt-get install -y libx11-dev 


RUN apt-get install -y mc
RUN apt-get install -y curl
RUN apt-get install -y hwinfo
RUN apt-get install -y busybox
RUN apt-get install -y iputils-ping
RUN apt-get install -y nodejs


#National Language (locale) data
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
RUN apt-get install -y locales
RUN locale-gen uk_UA.UTF-8
ENV LC_ALL uk_UA.UTF-8
ENV LANG uk_UA.UTF-8

WORKDIR /app
EXPOSE 80
RUN curl -sL https://deb.nodesource.com/setup_12.x |  bash -
RUN apt-get install -y nodejs

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build

RUN curl -sL https://deb.nodesource.com/setup_12.x |  bash -
RUN apt-get install -y nodejs

WORKDIR /src
COPY ["ServerMD/ServerMD.csproj", "ServerMD/"]
RUN dotnet restore "ServerMD/ServerMD.csproj"
COPY . .
WORKDIR "/src/ServerMD"
RUN dotnet build "ServerMD.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ServerMD.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ServerMD.dll"]