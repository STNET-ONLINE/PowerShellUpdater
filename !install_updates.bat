chcp 1251
cls

@echo off
title [NET Online] Install Updates

echo ��������� ��������...
REG ADD HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell /v ExecutionPolicy /t REG_SZ /d Bypass

timeout 3 >nul

echo ��������� ����������� ������� ����������...
powershell -file 2install_updater.ps1

timeout 3 >nul

echo �������� ����������...
powershell -file 3install_updates.ps1

timeout 3 >nul

REM MOVE xpatch_09.db patches
REM MOVE xpatch_10.db patches
REM MOVE xpatch_11.db patches
REM MOVE xpatch_12.db patches
REM MOVE xpatch_13.db patches
REM MOVE xpatch_14.db patches
REM MOVE xpatch_15.db patches
REM MOVE xpatch_16.db patches
REM MOVE xpatch_17.db patches
REM MOVE xpatch_18.db patches
REM MOVE xpatch_19.db patches

REM MOVE zaton.db mp
REM MOVE test_map.db mp
REM MOVE community_map_1.db mp
REM MOVE community_map_2.db mp
REM MOVE community_map_3.db mp
REM MOVE community_map_4.db mp
REM MOVE community_map_5.db mp
REM MOVE community_map_6.db mp
REM MOVE community_map_7.db mp
REM MOVE community_map_8.db mp
REM MOVE community_map_9.db mp

timeout 2 >nul

echo ��������� ���������� ���������.

timeout 2 >nul
echo ����������� ������� ����.

echo �������� ������� ����������...
DEL 3install_updates.ps1

timeout 2 >nul
echo �������� ���������� ����������...
DEL versions.csv

timeout 2 >nul
echo ��� ����� �� ������������, �� ������ ������� �������� ������ PowerShell.

timeout 3 >nul

REG DELETE HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell /v ExecutionPolicy

cls

echo [Direct Play] ���������/��������

timeout 2 >nul
dism /online /Enable-Feature /FeatureName:DirectPlay /All

timeout 5 >nul
echo ���� �� �������� ������, ���������� DirectPlay � ������ ������.
timeout 2 >nul
echo ���������� ������������ �� ������ ����:
timeout 1 >nul
echo https://discord.com/channels/603519515611103275/976787361172181032/977857278889852939
timeout 3 >nul

echo ������ ���� ����� ������������� ������� ����� 5 ������.
timeout 1 >nul
echo ��������� ���������.
timeout 5 >nul