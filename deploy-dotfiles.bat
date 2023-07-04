@echo OFF

setlocal

set src=%~dp0
set dst=%src%..\

for %%i in (bin\git-branch-gc bin\git-branch-list .gitconfig .gitignore.global .tmux.conf .uncrustify.cfg .vim) do (
    if exist %src%%%i\ (
        mklink /d %dst%%%i %src%%%i
    ) else (
        mklink %dst%%%i %src%%%i
    )
)
mklink /d %dst%vimfiles %src%.vim
xcopy /s /i /y %src%nvim %dst%AppData\Local\nvim
pause
