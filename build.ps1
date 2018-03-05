$env:DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
$env:DOTNET_MULTILEVEL_LOOKUP=0
$DotNetCliVersion = "2.1.300-preview1-008174"
$DotNetRoot = ".dotnet"
$DotNetInstallScript = Join-Path $DotNetRoot "dotnet-install.ps1"
$Dotnet = Join-Path $DotNetRoot "dotnet"

if (!(Test-Path $DotNetRoot)) {
    New-Item -ItemType directory -Path $DotNetRoot
    Invoke-WebRequest "https://dot.net/v1/dotnet-install.ps1" -UseBasicParsing -OutFile $DotNetInstallScript
    Invoke-Expression -Command "$DotNetInstallScript -Version $DotNetCliVersion -InstallDir $DotNetRoot"
}

Write-Information "dotnet SDK exists skip"
$env:PATH = "$DotNetRoot;$env:PATH"

dotnet build TRex.sln -r win10-x64
dotnet pack t-rex/t-rex.csproj /p:packTool=true