# PowerShellUpdater
The script allows you to download ZIP archives with a checksum check of both the archives themselves and their declared contents.
## Configuring CSV-file
1. **Version** - Any name that will later be indicated to the user when downloading the archive
2. **Files** - Files in the archive that need to be checked (Separated by a space)
3. **Hash** - Checksums of files from the archive to be checked (The position of the value must be the same as the file whose value it is. Separated by a space)
4. **Link** - Link to the archive (URL)
5. **Zip** - Path to file (Does not support going beyond the directory from which the script was launched. Example: `/update.zip` means that the file will have path `[the directory from which the script is launched]/update.zip`)
## Developers
* Alexander Kuprin - Сode developer
* Dmitry Anazirov - Author of idea
## Documentation used
- [Microsoft Powershell](https://learn.microsoft.com/en-us/powershell/)
