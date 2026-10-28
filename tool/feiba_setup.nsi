Unicode true
!include "MUI2.nsh"

!define APP_NAME "Feiba"
!define APP_VERSION "0.1.0"
!define APP_EXE "feiba.exe"
!define SOURCE_DIR "..\build\windows\x64\runner\Release"
!define OUTPUT_DIR "..\build\installer"

Name "${APP_NAME}"
OutFile "${OUTPUT_DIR}\${APP_NAME}-Setup-${APP_VERSION}.exe"
InstallDir "$PROGRAMFILES64\${APP_NAME}"
InstallDirRegKey HKLM "Software\${APP_NAME}" "InstallDir"
RequestExecutionLevel admin
SetCompressor /SOLID lzma
VIProductVersion "0.1.0.0"
VIAddVersionKey "ProductName" "${APP_NAME}"
VIAddVersionKey "CompanyName" "GrounzerLiu"
VIAddVersionKey "FileDescription" "${APP_NAME} installer"
VIAddVersionKey "FileVersion" "0.1.0.0"
VIAddVersionKey "ProductVersion" "0.1.0.0"
VIAddVersionKey "LegalCopyright" "MIT"

!define MUI_ICON "..\windows\runner\resources\app_icon.ico"
!define MUI_UNICON "..\windows\runner\resources\app_icon.ico"

!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

Section "Feiba" SecMain
  SetOutPath "$INSTDIR"
  File /r /x "feiba.exe.WebView2" /x "webview2_data" "${SOURCE_DIR}\*.*"

  WriteUninstaller "$INSTDIR\uninstall.exe"
  CreateShortcut "$SMPROGRAMS\Feiba.lnk" "$INSTDIR\${APP_EXE}"
  CreateShortcut "$DESKTOP\Feiba.lnk" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Feiba" "DisplayName" "${APP_NAME}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Feiba" "DisplayVersion" "${APP_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Feiba" "Publisher" "GrounzerLiu"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Feiba" "DisplayIcon" "$INSTDIR\${APP_EXE}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Feiba" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\${APP_NAME}" "InstallDir" "$INSTDIR"
SectionEnd

Section "Uninstall"
  Delete "$SMPROGRAMS\Feiba.lnk"
  Delete "$DESKTOP\Feiba.lnk"
  RMDir /r "$INSTDIR"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Feiba"
  DeleteRegKey HKLM "Software\${APP_NAME}"
SectionEnd