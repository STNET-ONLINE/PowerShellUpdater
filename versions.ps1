<#
	Namespace: versions
	Author: Alexander Kuprin
	Licence: MIT Licence
#>
import-module bitstransfer
$path 		= Get-Location
$file 		= "" + $path + "\versions.csv"
start-bitstransfer "https://forum.1163.ru/launcher/versions.csv" -destination $file
$trys		= 0
$copyright  = "Author: Alexander Kuprin. CMD, GIT: Vodka. Project: NET Online - 2023"
Write-Host $copyright -ForegroundColor gray
if(Test-Path $file){
	$versions	= Import-Csv $file -Delimiter ";"
	$i			= 1
	$error_versions = $null
	$check		= $false
	function checksum{
		param($checksum_hash,$checksum_file,$is_webclient)
		$checksum_tmp = Get-FileHash $checksum_file
		if($is_webclient -eq $true){
			$wc 				= [System.Net.WebClient]::new()
			$checksum_hash 		= Get-FileHash -InputStream ($wc.OpenRead($checksum_hash))
			$checksum_hash		= $checksum_hash.Hash
		}
		if($checksum_hash -ieq $checksum_tmp.Hash){
			return $true
		}
		return $false
	}
	function install{
		param($error_version)
		if($error_version -ne $null){
			$name 	= $error_version.Version
			$files  = @($error_version.Files.Split(" "))
			$hash	= @($error_version.Hash.Split(" "))
			$link	= $error_version.Link
			$zip	= $error_version.Zip
			$tmp	= "[INSTALL] " + $name + " - " + $files + " ["+$link+"]"
			Write-Host $tmp -ForegroundColor Blue
			$tmp = ""+$path+$zip
			$result = Test-Path $tmp
			if($result -eq $false){
				start-bitstransfer $link -destination $tmp
			}
			Write-Host $tmp
			if(Test-Path $tmp){
				if(checksum $link $tmp $true){
					$dir = [System.IO.Path]::GetDirectoryName($tmp)
					Expand-Archive -Path $tmp -Destination $dir -Force
				}
				else{
					$tmp = "[ERROR] Checksum - "+$file
					Write-Host $tmp -ForegroundColor red
					Remove-Item -Path $tmp
				}
			}
		}
	}
	function get_version{
		foreach($version in $versions){
			$name 	= $version.Version
			$files  = @($version.Files.Split(" "))
			$hash	= @($version.Hash.Split(" "))
			$link	= $version.Link
			$tmp	= "`n[CHECK] " + $name + " - " + $files + " ["+$link+"]"
			$zip	= $version.Zip
			Write-Host $tmp -ForegroundColor Blue
			$i = 0
			foreach($file in $files){
				$dir = [System.IO.Path]::GetDirectoryName($zip)
				$tmp = "" + $path + "\" + $dir + "\" + $file
				if(Test-Path $tmp){
					if(checksum $hash[$i] $tmp){
						$tmp = "[OK] Checksum - "+$file
						Write-Host $tmp -ForegroundColor green
						$tmp = ""+$path+$zip
						if(Test-Path $tmp){
							Remove-Item -Path $tmp
						}
					}
					else{
						$tmp = "[ERROR] Checksum - "+$file
						Write-Host $tmp -ForegroundColor red
						install $version
						return $false
					}
					$i++
				}
				else{
					install $version
					return $false
				}
			}
		}
		return $true
	}
	while($check -eq $false -and $trys -lt 10){
		$error_versions = $null
		$check = get_version
		if($error_versions -ine 0){
			install $error_versions
		}
	<#	$error_versions = 

		if($error_versions -ieq 1){
			echo $check
			$check = install $error_versions
		}
		else{
			$check = $true
		}
		$error_versions = $null#>
		Start-Sleep 2
		$trys++
	}
	$tmp = "`n[OK] Latest update installed"
	Write-Host $tmp -ForegroundColor green
}
else{
	$tmp = "`n[ERROR] No versions file found!"
	Write-Host $tmp -ForegroundColor red
}