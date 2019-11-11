@echo OFF

setlocal

set dst=%~dp0
set src=%dst%dotfiles\

for %%i in (bin\git-branch-gc bin\git-branch-list bin\git-diff-commit .gitconfig .gitignore.global .tmux.conf .uncrustify.cfg .vim) do (
    if exist %src%%%i\ (
        mklink /d %dst%%%i %src%%%i
    ) else (
        mklink %dst%%%i %src%%%i
    )
)
pause
