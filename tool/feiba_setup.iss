; Feiba Windows installer.
; Build the release app first:
;   flutter build windows --release
; Then compile from this directory:
;   "C:\Program Files\Inno Setup 7\ISCC.exe" tool\feiba_setup.iss

#define SourceDir "..\build\windows\x64\runner\Release"
#define OutputDir "..\build\installer"

[Setup]
AppId={{8A9D4E5B-2C7A-4B18-9E3F-6D1A7C5E9B42}
AppName=Feiba
AppVersion=0.1.0
AppVerName=Feiba 0.1.0
AppPublisher=GrounzerLiu
AppPublisherURL=https://github.com/GrounzerLiu/Feiba
AppSupportURL=https://github.com/GrounzerLiu/Feiba/issues
AppUpdatesURL=https://github.com/GrounzerLiu/Feiba/releases
DefaultDirName={localappdata}\Programs\Feiba
DefaultGroupName=Feiba
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputDir={#OutputDir}
OutputBaseFilename=Feiba-Setup-0.1.0
SetupIconFile=..\windows\runner\resources\app_icon.ico
UninstallDisplayIcon={app}\feiba.exe
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
VersionInfoVersion=0.1.0.0
VersionInfoCompany=GrounzerLiu
VersionInfoDescription=Feiba installer
VersionInfoProductName=Feiba
CloseApplications=yes

[Languages]
Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "创建桌面快捷方式"; GroupDescription: "附加任务:"; Flags: unchecked

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Feiba"; Filename: "{app}\feiba.exe"; WorkingDir: "{app}"
Name: "{group}\卸载 Feiba"; Filename: "{uninstallexe}"
Name: "{autodesktop}\Feiba"; Filename: "{app}\feiba.exe"; WorkingDir: "{app}"; Tasks: desktopicon

[Run]
Filename: "{app}\feiba.exe"; Description: "启动 Feiba"; Flags: nowait postinstall skipifsilent
