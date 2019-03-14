$logger
#Logging
function logging( [string]$msg ) {
    #logのメッセージ
    $log = Get-Date -Format "yyyy/MM/dd HH:mm:ss.fff"
    $log = $log + " [" + $msg + "]"
    #logファイル無かったら作る
    if( $null -eq $logger ) {
        $parm = Get-Date -Format "yyyyMMdd_HH.mm.ss.fff"
        $logname = "LOG" + "_" + $parm + ".log"
        $logger = New-Item $logname -Force
    }
    #log出力
    Write-Output $log | Out-File -FilePath $logger -Encoding Default -append
    return $log
}
#ファイル処理する関数だよ
function doCopy( $1 ) {
    #dupがついてない元ファイルを作成するよ
    $sourceFile = $1.FullName.Substring( 0, $1.FullName.Length - 4 )
    #dupが無いファイルがあるか確認するよ
    if( Test-Path $sourceFile ) {
        #ファイルコピー
        Copy-Item $1 $sourceFile
        #loggingする
        logging "COPY : "$1 + " to " + $sourceFile
    }
}
#フォルダ指定するダイアログ表示
function Select-Folder(
    [string]$Path = ".",
    [string]$Description,
    [switch]$ShowNewFolder)
{
    Add-Type -assemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = $Description
    #[新しいフォルダ]ボタンを表示するか？
    $dialog.ShowNewFolderButton = $ShowNewFolder
    # ダイアログを表示
    if($dialog.ShowDialog() -eq "OK")
    {
      #入力されたファイル名を返す
      return $dialog.SelectedPath
    }
}
#logging start
logging -msg "hoge"
#ダイアログ表示
$clonepath = Select-Folder -$Description "クローンしたforce-appディレクトリを指定してください。"
$metapath = Select-Folder -$Description "メタデータのforce-appディレクトリを指定してください。"
#NULLチェック、ディレクトリ指定してるかどうか
if( $null -eq $clonepath ) {
    Write-Host "クローンのパスを指定してください。"
    exit
}
if( $null -eq $metapath ) {
    Write-Host "メタデータのパスを指定してください。"
    exit
}
#まずdupファイルがあればdup無しにコピーする
$files = Get-ChildItem -Path $metapath -Recurse -Filter *.dup
#取り出したdupを回す。
$files | ForEach-Object -Begin {"### Go! ###"} -Process {doCopy $_} -End {"### Finish! ###"}
