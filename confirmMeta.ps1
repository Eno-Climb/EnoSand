$files = Get-ChildItem 
#ファイル処理する関数だよ
function doCopy( $1 ) {
    #dupがついてない元ファイルを作成するよ
    $sourceFile = $1.FullName.Substring( 0, $1.FullName.Length - 4 )
    #dupが無いファイルがあるか確認するよ
    $1.DirectoryName + "っす"
    $sourceFile
    $1.FullName + " だよ"
}
#ファイル分ループさせる
$files | ForEach-Object -Begin {"### Go! ###"} -Process {doCopy $_} -End {"### Finish! ###"}
