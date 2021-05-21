@echo OFF
goto MAIN_MENU

:MAIN_MENU
title USB Deployment and Backup Utility
cls
color 71
echo.
echo ===============================================================================
echo = USB Deployment and Backup Utility ===========================================
echo ===============================================================================
echo.
echo Otions:
echo.
echo 1 - Deploy (MASTER to USB)
echo 2 - Backup (USB to MASTER)
echo 3 - D2D (USB to USB)
echo 4 - Terminate Program
echo.
echo ===============================================================================
set /p option=
if %option%==1 goto DEPLOY
if %option%==2 goto BACKUP
if %option%==3 goto D2D
if %option%==4 goto END_PROGRAM

:END_PROGRAM
exit

:NCON
cls
color 04
echo Operation cancelled successfully
echo.
pause
goto MAIN_MENU

:CON_ERROR
cls
color 04
echo ! - Error: 
echo.
echo Invalid Syntax.
echo - Expected y/n reply from user.
echo.
echo Safely return to the main menu.
pause
gotO MAIN_MENU

:D2D
cls
echo.
echo ===============================================================================
echo = USB to USB Deployment =======================================================
echo ===============================================================================
echo.
exit 

:BACKUP
cls
echo.
echo ===============================================================================
echo = USB to MASTER Backup ========================================================
echo ===============================================================================
echo.
echo This operation will backup the contents of the target drive to the local master location.
echo.
echo Which drive letter is the USB to be backed up assigned to?
set /P COPY_DRIVE=
echo You want to backup drive %COPY_DRIVE%? (y/n)
set /p CONFIRM=
if %CONFIRM%==n (
    goto NCON
)
if %CONFIRM%==y (
    echo Target drive location confirmed. 
    echo.
    echo Backing up...
    robocopy "%COPY_DRIVE%:" "D:\usb\usb_master" /s /nfl /ndl /purge
    echo.
    echo Backup complete. Please check the process completed correctly.
    echo.
    pause
) else (
    goto CON_ERROR
)

:DEPLOY
cls
echo.
echo ===============================================================================
echo = MASTER to USB Deployment ====================================================
echo ===============================================================================
echo.
echo This operation will deploy (copy) the contents of local master location to the target USB.
echo.
echo What drive letter is the target USB assigned to?
set /P TARGET_DRIVE=
echo You want to deploy to drive %TARGET_DRIVE%? (y/n)
set /p CONFIRM=
if %CONFIRM%==n (
    goto NCON
)
if %CONFRIRM%==y (
    Target drive location confirmed.
    echo.
    echo Backing up...
    robocopy "D:\usb\usb_master" "%TARGET_DRIVE%:" /s /nfl /ndl /purge
    echo.
    echo Deployment complete. Please check the process completed correctly.
    echo.
    pause
    exit
) else (
    goto CON_ERROR
)