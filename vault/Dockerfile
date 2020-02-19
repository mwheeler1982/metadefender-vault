FROM mcr.microsoft.com/windows/servercore:ltsc2019

ARG vault_installer_file

# Expose port
EXPOSE 8000/tcp
EXPOSE 8010/tcp

# Copy over required files
COPY src/* /OPSWAT/

# Set Powershell as our shell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Download vault installer file
RUN Invoke-WebRequest -Uri https://metascanbucket.s3.amazonaws.com/SFT/$env:vault_installer_file -Outfile C:\\OPSWAT\\$env:vault_installer_file

# MetaDefender Core Installer
RUN Start-Process C:\\OPSWAT\\$env:vault_installer_file -Wait -ArgumentList "/install", "/passive", "/quiet", "/norestart" ;

# Define entrypoint
ENTRYPOINT ["powershell.exe", "C:\\OPSWAT\\start.ps1"]
