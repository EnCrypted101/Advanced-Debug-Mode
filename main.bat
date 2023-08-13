@echo off
cls
net session >nul 2>&1
if %errorLevel% == 0 (
    goto :continue
) else (
    echo This script requires administrator privileges. Please run it as an administrator.
    pause
    exit
)

:continue
title Advanced Debug Mode V1.0.0
color 17
cls

echo Welcome to Advanced Debug Mode V1.0.0
echo.

:menu
echo Select an option:
echo 1. Display System Information
echo 2. Run CHKDSK
echo 3. View Running Processes
echo 4. Open Command Prompt as Administrator
echo 5. Check Network Connectivity
echo 6. Create System Restore Point
echo 7. Manage Services
echo 8. Backup Files
echo 9. Launch Registry Editor
echo 10. Generate System Report
echo 11. Clean Temporary Files
echo 12. View Event Logs
echo 13. Manage Startup Programs
echo 14. Run Diagnostic Tests
echo 15. Check Disk Space
echo 16. Uninstall Software
echo 17. Check Driver Information
echo 18. Exit

set /p choice=Enter your choice: 

if "%choice%"=="1" (
    systeminfo
    pause
    goto menu
) else if "%choice%"=="2" (
    echo Running CHKDSK...
    chkdsk C: /f
    pause
    goto menu
) else if "%choice%"=="3" (
    tasklist
    pause
    goto menu
) else if "%choice%"=="4" (
    echo Opening Command Prompt as Administrator...
    powershell -command "Start-Process cmd -ArgumentList '/k', 'cd %cd%', '-noexit', '-verb runas'"
    goto menu
) else if "%choice%"=="5" (
    echo Checking Network Connectivity...
    ping google.com
    pause
    goto menu
) else if "%choice%"=="6" (
    echo Creating System Restore Point...
    wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Advanced Debug Mode Restore Point", 100, 7
    pause
    goto menu
) else if "%choice%"=="7" (
    :services
    echo Manage Services:
    echo 1. List all services
    echo 2. Start a service
    echo 3. Stop a service
    echo 4. Restart a service
    echo 5. Go back to the main menu

    set /p service_choice=Enter your choice: 

    if "%service_choice%"=="1" (
        net start
        pause
        goto services
    ) else if "%service_choice%"=="2" (
        set /p service_name=Enter the service name to start: 
        net start "%service_name%"
        pause
        goto services
    ) else if "%service_choice%"=="3" (
        set /p service_name=Enter the service name to stop: 
        net stop "%service_name%"
        pause
        goto services
    ) else if "%service_choice%"=="4" (
        set /p service_name=Enter the service name to restart: 
        net stop "%service_name%"
        net start "%service_name%"
        pause
        goto services
    ) else if "%service_choice%"=="5" (
        goto menu
    ) else (
        echo Invalid choice. Please select a valid option.
        pause
        goto services
    )
) else if "%choice%"=="8" (
    :backup
    echo Backup Files:
    echo 1. Create a backup of a file
    echo 2. Restore a backup
    echo 3. Go back to the main menu

    set /p backup_choice=Enter your choice: 

    if "%backup_choice%"=="1" (
        set /p source_file=Enter the path of the file to backup: 
        set /p backup_location=Enter the backup location: 
        xcopy "%source_file%" "%backup_location%" /E /C /H /R /K /Y
        echo Backup completed.
        pause
        goto backup
    ) else if "%backup_choice%"=="2" (
        set /p backup_file=Enter the path of the backup to restore: 
        set /p restore_location=Enter the restore location: 
        xcopy "%backup_file%" "%restore_location%" /E /C /H /R /K /Y
        echo Restore completed.
        pause
        goto backup
    ) else if "%backup_choice%"=="3" (
        goto menu
    ) else (
        echo Invalid choice. Please select a valid option.
        pause
        goto backup
    )
) else if "%choice%"=="9" (
    echo Launching Registry Editor...
    regedit
    goto menu
) else if "%choice%"=="10" (
    echo Generating System Report...
    msinfo32 /report "%cd%\SystemReport.txt"
    echo System Report generated.
    pause
    goto menu
) else if "%choice%"=="11" (
    echo Cleaning Temporary Files...
    rd /s /q "%temp%"
    mkdir "%temp%"
    echo Temporary files cleaned.
    pause
    goto menu
) else if "%choice%"=="12" (
    :eventlogs
    echo View Event Logs:
    echo 1. View Application Logs
    echo 2. View System Logs
    echo 3. Go back to the main menu

    set /p event_choice=Enter your choice: 

    if "%event_choice%"=="1" (
        eventvwr.exe /c:Application
        pause
        goto eventlogs
    ) else if "%event_choice%"=="2" (
        eventvwr.exe /c:System
        pause
        goto eventlogs
    ) else if "%event_choice%"=="3" (
        goto menu
    ) else (
        echo Invalid choice. Please select a valid option.
        pause
        goto eventlogs
    )
) else if "%choice%"=="13" (
    :startup
    echo Manage Startup Programs:
    echo 1. View Startup Programs
    echo 2. Disable a Startup Program
    echo 3. Enable a Startup Program
    echo 4. Go back to the main menu

    set /p startup_choice=Enter your choice: 

    if "%startup_choice%"=="1" (
        wmic startup get Caption, Command
        pause
        goto startup
    ) else if "%startup_choice%"=="2" (
        set /p program_name=Enter the name of the program to disable: 
        wmic startup where "Caption='%program_name%'" call disable
        echo Startup program disabled.
        pause
        goto startup
    ) else if "%startup_choice%"=="3" (
        set /p program_name=Enter the name of the program to enable: 
        wmic startup where "Caption='%program_name%'" call enable
        echo Startup program enabled.
        pause
        goto startup
    ) else if "%startup_choice%"=="4" (
        goto menu
    ) else (
        echo Invalid choice. Please select a valid option.
        pause
        goto startup
    )
) else if "%choice%"=="14" (
    echo Running Diagnostic Tests...
    echo Running memory test...
    mdsched.exe
    echo Diagnostic tests completed.
    pause
    goto menu
) else if "%choice%"=="15" (
    echo Checking Disk Space...
    wmic logicaldisk get Caption, FreeSpace, Size
    pause
    goto menu
) else if "%choice%"=="16" (
    :uninstall
    echo Uninstall Software:
    echo 1. List installed software
    echo 2. Uninstall a program
    echo 3. Go back to the main menu

    set /p uninstall_choice=Enter your choice: 

    if "%uninstall_choice%"=="1" (
        wmic product get Name, Version
        pause
        goto uninstall
    ) else if "%uninstall_choice%"=="2" (
        set /p program_name=Enter the name of the program to uninstall: 
        wmic product where "Name='%program_name%'" call uninstall
        echo Program uninstalled.
        pause
        goto uninstall
    ) else if "%uninstall_choice%"=="3" (
        goto menu
    ) else (
        echo Invalid choice. Please select a valid option.
        pause
        goto uninstall
    )
) else if "%choice%"=="17" (
    echo Checking Driver Information...
    driverquery
    pause
    goto menu
) else if "%choice%"=="18" (
    echo Exiting Advanced Debug Mode.
    exit
) else (
    echo Invalid choice. Please select a valid option.
    pause
    goto menu
)
