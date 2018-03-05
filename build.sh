export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1
export DOTNET_MULTILEVEL_LOOKUP=0
DotNetCliVersion="2.1.300-preview1-008174"
DotNetRoot=".dotnet"
DotNetInstallScript="$DotNetRoot/dotnet-install.sh"
Dotnet="$DotNetRoot/dotnet"

function CreateDirectory {
  if [ ! -d "$1" ]
  then
    mkdir -p "$1"
  fi
}

if [ ! -d "$DotNetInstallScript" ]; then
  CreateDirectory "$DotNetRoot"
  curl "https://dot.net/v1/dotnet-install.sh" -sSL -o "$DotNetInstallScript"
	bash "$DotNetInstallScript" --version $DotNetCliVersion --install-dir $DotNetRoot
fi

export PATH="$DotNetRoot:$PATH"

dotnet build TRex.sln -r win10-x64
dotnet pack t-rex/t-rex.csproj /p:packTool=true
