#define MyAppName "Pritunl"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "Pritunl"
#define MyAppURL "https://pritunl.com/"
#define MyAppExeName "pritunl.exe"

[Setup]
AppId={#MyAppName}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
MinVersion=6.2.9200
PrivilegesRequired=admin
DisableProgramGroupPage=yes
OutputDir=..\build\
OutputBaseFilename={#MyAppName}
SetupIconFile=..\client\www\img\logo.ico
UninstallDisplayName=Pritunl Client
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma
SolidCompression=yes
CloseApplications=yes
CloseApplicationsFilter=*.exe,*.dll,*.chm

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce

[Files]
Source: "..\build\win\pritunl-win32\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; BeforeInstall: PreInstall
Source: "..\tuntap_win\*"; DestDir: "{app}\tuntap"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\openvpn_win\*"; DestDir: "{app}\openvpn"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\service_win\nssm.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\service\service.exe"; DestDir: "{app}"; DestName: "pritunl-service.exe"; Flags: ignoreversion recursesubdirs createallsubdirs

[Code]
procedure PreInstall();
begin
    Exec('net.exe', 'stop pritunl', '', SW_HIDE, ewWaitUntilTerminated);
    Exec('taskkill.exe', '/F /IM pritunl.exe', '', SW_HIDE, ewWaitUntilTerminated);
end;

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[InstallDelete]
Type: filesandordirs; Name: "{app}"

[Run]
Filename: "{app}\nssm.exe"; Parameters: "remove pritunl confirm"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\tuntap\tuntap.exe"; Parameters: "uninstall"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\tuntap\tuntap.exe"; Parameters: "install"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\tuntap\tuntap.exe"; Parameters: "install"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\tuntap\tuntap.exe"; Parameters: "install"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\tuntap\tuntap.exe"; Parameters: "install"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\nssm.exe"; Parameters: "install pritunl ""{app}\pritunl-service.exe"""; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\nssm.exe"; Parameters: "set pritunl DisplayName ""Pritunl Helper Service"""; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\nssm.exe"; Parameters: "set pritunl Start SERVICE_AUTO_START"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\nssm.exe"; Parameters: "set pritunl AppStdout C:\ProgramData\Pritunl\service.log"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\nssm.exe"; Parameters: "set pritunl AppStderr C:\ProgramData\Pritunl\service.log"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\nssm.exe"; Parameters: "start pritunl"; Flags: runhidden; StatusMsg: "Configuring Pritunl..."
Filename: "{app}\{#MyAppExeName}"; Description: "Start the Pritunl Client"; Flags: postinstall nowait

[UninstallRun]
Filename: "taskkill.exe"; Parameters: "/F /IM {#MyAppExeName}"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "taskkill.exe"; Parameters: "/F /IM {#MyAppExeName}"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "taskkill.exe"; Parameters: "/F /IM {#MyAppExeName}"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "timeout.exe"; Parameters: "/t 3"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "taskkill.exe"; Parameters: "/F /IM openvpn.exe"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "taskkill.exe"; Parameters: "/F /IM openvpn.exe"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "taskkill.exe"; Parameters: "/F /IM openvpn.exe"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "timeout.exe"; Parameters: "/t 3"; Flags: runascurrentuser runhidden skipifdoesntexist
Filename: "{app}\nssm.exe"; Parameters: "remove pritunl confirm"; Flags: runhidden
Filename: "{app}\nssm.exe"; Parameters: "stop pritunl"; Flags: runhidden
Filename: "{app}\tuntap\tuntap.exe"; Parameters: "uninstall"; Flags: runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
Type: filesandordirs; Name: "C:\ProgramData\Pritunl"
