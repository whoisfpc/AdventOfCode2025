@echo off
if [%4]==[] goto debug

if [%4]==[-speed] goto speed

:debug
echo run debug
odin run src -debug -sanitize:address  -- %1 %2 %3
goto :done

:speed
echo run speed
odin run src -o:speed  -- %1 %2 %3
goto :done

:done