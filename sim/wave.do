# set external editor
proc external_editor {filename linenumber} {exec "F:/VS code/Microsoft VS Code/Code.exe" -g $filename:$linenumber}
set PrefSource(altEditor) external_editor