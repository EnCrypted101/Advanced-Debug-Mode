@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Administrator privileges required. Please run as administrator.
    pause
    exit
)

set "title=Advanced Debug Mode V1.0.0"
set "color=17"
set "log_file=%cd%\debug_log.txt"

:continue
title %title%
color %color%
cls

echo Welcome to %title%
echo.

:menu
echo Select an option:
echo 1. Display Comprehensive System Information
echo 2. Perform CHKDSK with File System Repair and Recovery
echo 3. View Running Processes with Extended Details
echo 4. Open an Elevated Command Prompt
echo 5. Check Network Connectivity and Latency
echo 6. Create Detailed System Restore Point
echo 7. Manage Services and Startup Types
echo 8. Backup Files and Folders with Compression
echo 9. Launch Windows Registry Editor
echo 10. Generate Comprehensive System Report
echo 11. Clean Temporary Files and Cached Data
echo 12. View Application and System Event Logs
echo 13. Manage Startup Programs and Delay Timers
echo 14. Run Comprehensive Hardware Diagnostic Tests
echo 15. Check Disk Space Usage and File Distribution
echo 16. Uninstall Software and Remove Residual Data
echo 17. Check Detailed Driver Information
echo 18. Execute Custom Script
echo 19. Access Remote Command Line
echo 20. Analyze Network Traffic
echo 21. Monitor CPU and Memory Usage
echo 22. Control Power Settings
echo 23. Exit

set /p choice=Enter your choice: 

if "%choice%"=="1" (
    systeminfo /FO CSV > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="2" (
    echo Running CHKDSK with file system repair and bad sector recovery...
    chkdsk C: /f /r > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="3" (
    tasklist /V > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="4" (
    echo Opening an elevated Command Prompt...
    powershell -command "Start-Process cmd -ArgumentList '/k', 'cd %cd%', '-noexit', '-verb runas'"
    goto menu
) else if "%choice%"=="5" (
    echo Checking Network Connectivity and Latency using extended ping...
    ping google.com -t > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="6" (
    echo Creating a Detailed System Restore Point with description...
    set /p restore_description=Enter a description for the restore point: 
    wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "%restore_description%", 100, 7
    echo System Restore Point created successfully. >> %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="7" (
    :services
    echo Manage Services and Startup Types:
    echo 1. List all services
    echo 2. Start a service
    echo 3. Stop a service
    echo 4. Restart a service
    echo 5. Change startup type of a service
    echo 6. Go back to the main menu

    set /p service_choice=Enter your choice: 

    if "%service_choice%"=="1" (
        net start > %log_file%
        notepad %log_file%
        goto services
    ) else if "%service_choice%"=="2" (
        set /p service_name=Enter the name of the service to start: 
        net start "%service_name%" > %log_file%
        echo Service "%service_name%" started successfully. >> %log_file%
        notepad %log_file%
        goto services
    ) else if "%service_choice%"=="3" (
        set /p service_name=Enter the name of the service to stop: 
        net stop "%service_name%" > %log_file%
        echo Service "%service_name%" stopped successfully. >> %log_file%
        notepad %log_file%
        goto services
    ) else if "%service_choice%"=="4" (
        set /p service_name=Enter the name of the service to restart: 
        net stop "%service_name%" > %log_file%
        net start "%service_name%" > %log_file%
        echo Service "%service_name%" restarted successfully. >> %log_file%
        notepad %log_file%
        goto services
    ) else if "%service_choice%"=="5" (
        set /p service_name=Enter the name of the service to change startup type: 
        set /p startup_type=Enter new startup type (AUTO, MANUAL, DISABLED): 
        sc config "%service_name%" start=%startup_type% > %log_file%
        echo Startup type of service "%service_name%" changed to %startup_type%. >> %log_file%
        notepad %log_file%
        goto services
    ) else if "%service_choice%"=="6" (
        goto menu
    ) else {
        echo Invalid choice. Please select a valid option.
        pause
        goto services
    }
) else if "%choice%"=="8" (
    :backup
    echo Backup Files and Folders with Compression:
    echo 1. Create a compressed backup of a file or folder
    echo 2. Restore a backup
    echo 3. Go back to the main menu

    set /p backup_choice=Enter your choice: 

    if "%backup_choice%"=="1" (
        set /p source_path=Enter the path of the file or folder to backup: 
        set /p backup_location=Enter the backup location: 
        set /p compression_level=Enter compression level (FASTEST, FAST, NORMAL, MAXIMUM, ULTRA): 
        set /p overwrite=Do you want to overwrite existing backup? (YES/NO): 
        7z a -t7z -mx=%compression_level% -r -y "%backup_location%\backup.7z" "%source_path%" > %log_file%
        echo Content at "%source_path%" backed up to "%backup_location%\backup.7z" with compression level %compression_level%. >> %log_file%
        if "%overwrite%"=="YES" (
            copy /y "%backup_location%\backup.7z" "%backup_location%\backup_latest.7z" > %log_file%
            echo Overwritten the latest backup. >> %log_file%
        )
        notepad %log_file%
        goto backup
    ) else if "%backup_choice%"=="2" (
        set /p backup_path=Enter the path of the backup to restore: 
        set /p restore_location=Enter the restore location: 
        set /p overwrite=Do you want to overwrite existing files during restore? (YES/NO): 
        7z x -y "%backup_path%" -o"%restore_location%" > %log_file%
        echo Backup at "%backup_path%" restored to "%restore_location%" with overwrite set to %overwrite%. >> %log_file%
        notepad %log_file%
        goto backup
    ) else if "%backup_choice%"=="3" (
        goto menu
    ) else {
        echo Invalid choice. Please select a valid option.
        pause
        goto backup
    }
) else if "%choice%"=="9" (
    echo Launching Windows Registry Editor...
    regedit
    goto menu
) else if "%choice%"=="10" (
    echo Generating Comprehensive System Report with hardware details...
    msinfo32 /report "%cd%\SystemReport.txt" > %log_file%
    echo System Report generated and saved to %cd%\SystemReport.txt. >> %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="11" (
    echo Cleaning Temporary Files and Cached Data...
    del /s /q /f "%temp%\*" > %log_file%
    del /s /q /f "%localappdata%\Temp\*" >> %log_file%
    echo Temporary files and cached data cleaned. >> %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="12" (
    :eventlogs
    echo View Application and System Event Logs:
    echo 1. View Application Event Logs
    echo 2. View System Event Logs
    echo 3. Go back to the main menu

    set /p event_choice=Enter your choice: 

    if "%event_choice%"=="1" (
        eventvwr.exe /c:Application > %log_file%
        notepad %log_file%
        goto eventlogs
    ) else if "%event_choice%"=="2" (
        eventvwr.exe /c:System > %log_file%
        notepad %log_file%
        goto eventlogs
    ) else if "%event_choice%"=="3" (
        goto menu
    ) else {
        echo Invalid choice. Please select a valid option.
        pause
        goto eventlogs
    }
) else if "%choice%"=="13" (
    :startup
    echo Manage Startup Programs and Delay Timers:
    echo 1. View Startup Programs
    echo 2. Disable a Startup Program
    echo 3. Enable a Startup Program
    echo 4. Change delay timer for a Startup Program
    echo 5. Go back to the main menu

    set /p startup_choice=Enter your choice: 

    if "%startup_choice%"=="1" (
        wmic startup get Caption, Command > %log_file%
        notepad %log_file%
        goto startup
    ) else if "%startup_choice%"=="2" (
        set /p program_name=Enter the name of the program to disable: 
        wmic startup where "Caption='!program_name!'" call disable > %log_file%
        echo Startup program "%program_name%" disabled successfully. >> %log_file%
        notepad %log_file%
        goto startup
    ) else if "%startup_choice%"=="3" (
        set /p program_name=Enter the name of the program to enable: 
        wmic startup where "Caption='!program_name!'" call enable > %log_file%
        echo Startup program "%program_name%" enabled successfully. >> %log_file%
        notepad %log_file%
        goto startup
    ) else if "%startup_choice%"=="4" (
        set /p program_name=Enter the name of the program to change delay timer: 
        set /p delay_time=Enter the new delay time in seconds: 
        reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupDelayInMSec" /v "%program_name%" /t REG_DWORD /d %delay_time% /f > %log_file%
        echo Delay timer for "%program_name%" changed to %delay_time% seconds. >> %log_file%
        notepad %log_file%
        goto startup
    ) else if "%startup_choice%"=="5" (
        goto menu
    ) else {
        echo Invalid choice. Please select a valid option.
        pause
        goto startup
    }
) else if "%choice%"=="14" (
    echo Running Comprehensive Hardware Diagnostic Tests...
    echo Running memory test and hard drive check... > %log_file%
    mdsched.exe >> %log_file%
    chkdsk C: /f /r >> %log_file%
    echo Diagnostic tests completed. >> %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="15" (
    echo Checking Disk Space Usage and File Distribution...
    wmic logicaldisk get Caption, FreeSpace, Size, VolumeName > %log_file%
    dir /s /a > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="16" (
    :uninstall
    echo Uninstall Software and Remove Residual Data:
    echo 1. List installed software
    echo 2. Uninstall a program and remove residual data
    echo 3. Go back to the main menu

    set /p uninstall_choice=Enter your choice: 

    if "%uninstall_choice%"=="1" (
        wmic product get Name, Version > %log_file%
        notepad %log_file%
        goto uninstall
    ) else if "%uninstall_choice%"=="2" (
        set /p program_name=Enter the name of the program to uninstall: 
        wmic product where "Name='!program_name!'" call uninstall > %log_file%
        rmdir /s /q "C:\Program Files\!program_name!" > %log_file%
        echo Program "%program_name%" uninstalled and residual data removed. >> %log_file%
        notepad %log_file%
        goto uninstall
    ) else if "%uninstall_choice%"=="3" (
        goto menu
    ) else {
        echo Invalid choice. Please select a valid option.
        pause
        goto uninstall
    }
) else if "%choice%"=="17" (
    echo Checking Detailed Driver Information...
    driverquery /v > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="18" (
    echo Executing Custom Script...
    set /p script_path=Enter the path to the script: 
    call "%script_path%" > %log_file%
    echo Custom script executed. >> %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="19" (
    echo Accessing Remote Command Line...
    set /p remote_ip=Enter the IP address of the remote machine: 
    set /p remote_user=Enter the username: 
    set /p remote_password=Enter the password: 
    psexec \\%remote_ip% -u %remote_user% -p %remote_password% cmd
    goto menu
) else if "%choice%"=="20" (
    echo Analyzing Network Traffic...
    netstat -ano > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="21" (
    echo Monitoring CPU and Memory Usage...
    typeperf "\Processor(_Total)\% Processor Time" "\Memory\Available MBytes" -si 5 -sc 10 > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="22" (
    echo Controlling Power Settings...
    powercfg /L > %log_file%
    notepad %log_file%
    goto menu
) else if "%choice%"=="23" (
    echo Exiting Advanced Debug Mode.
    exit
) else {
    echo Invalid choice. Please select a valid option.
    pause
    goto menu
}
