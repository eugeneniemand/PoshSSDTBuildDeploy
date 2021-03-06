function Install-VsBuildTools2017 {
    param ( [string] $WorkingFolder
)
    $download = "https://download.visualstudio.microsoft.com/download/pr/100285490/e64d79b40219aea618ce2fe10ebd5f0d/vs_BuildTools.exe"
    $MSBuildPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
    if (!(Test-Path $MSBuildPath)) {
        Write-Warning "no msbuild. Am attempting to install."
        $MSBuildInstaller = Join-Path -Path $WorkingFolder -ChildPath "vs_BuildTools.exe"
        Invoke-WebRequest -Uri $download -OutFile  $MSBuildInstaller 
        If ((Test-Path $MSBuildInstaller)) {
            "File downloaded!"
        }
        else {
            "Oh dear!"
        }
        "attempting to install..."
        try {
            $args = " --quiet --norestart --wait --add Microsoft.VisualStudio.Workload.MSBuildTools"
            $installVs2017BuildTools = Start-Process $MSBuildInstaller -ArgumentList $args -Wait -PassThru -WorkingDirectory $WorkingFolder -NoNewWindow
        }
        catch {
            $_.Exception
        }
        if ($installVs2017BuildTools.ExitCode -eq 0) {
            Write-Host "Install Successful!" -ForegroundColor DarkGreen -BackgroundColor White
        }
        else {
            Write-Error "Something went wrong in installing Visual Studio Build Tools."
        }
    }
    else{
        Write-Host "VS Build Tools 2017 Installed!" -ForegroundColor White -BackgroundColor DarkCyan
    }
}