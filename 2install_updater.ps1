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
	echo "�������� ���� ���������"
	if($filehash = $ziphash){
		Expand-Archive -Path $zip -Destination $path -Force
		echo "����������� ���������"
		if(Test-Path $zip){
			Remove-Item �path $zip -recurse
			echo "�������� ���� ���������"
		}
	}
	else{
		echo "[ERROR] ���-����� ����� ���������� �� �������� �����"
	}
}
else{
	echo "[ERROR] ����� �� ������� �������"
}