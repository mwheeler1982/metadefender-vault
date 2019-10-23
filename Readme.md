# metadefender-vault

### MetaDefender Vault Dockerized
This should include everything needed to run the MetaDefender Vault software in a Windows docker container. This assumes the following:
- Docker host is configured for WCOW (Windows Containers on Windows). See [Docker on windows documentation](https://docs.docker.com/docker-for-windows/#switch-between-windows-and-linux-containers) for more information.
- Docker host is either Windows 10 or Windows Server 2019, build 1903. You may need to update the [Dockerfile](vault/Dockerfile) to reflect your required version
- You are able to run in containers process isolation mode. You may need to modify the [docker-compose.yml](docker-compose.yml) file to change the isolation mode to hyperv.

##### Getting started
- Clone this repository: `git clone https://github.com/mwheeler1982/metadefender-vault.git C:\your\path`
- Create a text file containing your OPSWAT MetaDefender Vault activation key, and place it at `vault/src/vault_activation.key`
- Optional: modify the [.env](.env) file to specify the version of MetaDefender Vault you wish to run
- Build and start the container: `docker-compose up -d`
- Optional: monitor logs with `docker-compose logs -f` 
- Log in to your vault instance at: (http://localhost:8010/) .
  - The default username/password is admin/admin

##### Todo for the future
- Right now, several items are hard-coded:
  - Default admin account credentials
  - Admin account's name and email address
- License is not automatically freed up when container is deleted
