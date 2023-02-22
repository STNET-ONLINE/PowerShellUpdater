import-module bitstransfer
$path = Get-Location
$file = "https://github.com/VodkaNET/stnet-17-patches/raw/main/utils/updater.zip"
start-bitstransfer $file -destination $path
$wc = [System.Net.WebClient]::new()
$pkgurl = $file
$zip = "" + $path + "\updater.zip"
$filehash = Get-FileHash -InputStream ($wc.OpenRead($pkgurl))
if(Test-Path $zip){
	$ziphash = Get-FileHash $zip
	echo $filehash $ziphash
	echo "Проверка хэша завершена"
	if($filehash = $ziphash){
		Expand-Archive -Path $zip -Destination $path -Force
		echo "Расспаковка завершена"
		if(Test-Path $zip){
			Remove-Item –path $zip -recurse
			echo "Удаление кэша завершено"
		}
	}
	else{
		echo "[ERROR] Хеш-сумма файла отличается от сетевого файла"
	}
}
else{
	echo "[ERROR] Архив не удалось скачать"
}