#NoEnv
#SingleInstance force
#NoTrayIcon
;@Ahk2Exe-ConsoleApp
; must have the directive for console app
; to compile:
; "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe" /in trash.ahk /out trash.exe

; according to https://www.autohotkey.com/docs/v1/lib/FileRecycle.htm
; it uses SHFileOperation
; see also https://stackoverflow.com/a/1646493/2292993 
; but recycle.exe from the link above does not cause a chagne in recycle bin icon if a file is deleted

SetBatchLines -1

; https://www.reddit.com/r/AutoHotkey/comments/rf9krl/stdout_to_console/
; https://www.reddit.com/r/AutoHotkey/comments/uw0dr2/how_to_output_to_console/
if %0% = 0
{
    ; ; alternative solution: `n  new line   * stdout
    ; FileAppend Please specify one or more files (supporting wildcard)`n, *
    ; FileAppend     or folder (without trailing backslash) to delete.`n, *
    ; FileAppend Usage: `n, *
    ; FileAppend     recycle.exe "C:\temp files\*.tmp" "folder" ...`n, *

    out := 0
    stdout := FileOpen("*", "w", "UTF-8")
    stdout.Write("Please indicate which file(s) or folder(s) you would like to delete`n")
    stdout.Write("Use wildcards if necessary.`n")
    stdout.Write("Do not include a backslash at the end of the folder name.`n")
    stdout.Write("`n")
    stdout.Write("Usage: `n")
    ; Double up the quotes to escape them.
    stdout.Write("    trash.exe ""C:\temp files\*.tmp"" ""folder"" ...`n")
    stdout.Close()
    ExitApp % out
}

; https://www.autohotkey.com/docs/v1/lib/FileRecycle.htm
Loop %0%
{
    file := %A_Index%
    FileRecycle, %file%
}
SoundPlay *64
ExitApp
