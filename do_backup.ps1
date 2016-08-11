$bdate = Get-Date -Format s
$svnuser = 'xxxxx'
$svnpass = 'xxxxx'
$sqluser = 'xxxxx'
$sqlpass = 'xxxxx'

$list_dbs_command = "mysql -u$sqluser -p$sqlpass -s -e 'show databases'"
#Invoke-Expression -Command:$list_dbs_command
## dump each database
ForEach ($dbtable in Invoke-Expression -Command:$list_dbs_command ) {
    #Write-Host $dbtable
    if( $dbtable.Equals('mysql')){
        $dump_cmd = "mysqldump --single-transaction --events -u$sqluser -p$sqlpass $dbtable >$dbtable.sql"
    }else{
        $dump_cmd = "mysqldump --single-transaction -u$sqluser -p$sqlpass $dbtable >$dbtable.sql"
    }
    Invoke-Expression -Command:$dump_cmd

}
## and any new files
ForEach ($fstat in Invoke-Expression -Command:'svn status' ) {
    if( $fstat.StartsWith('?')){
        $fstat = $fstat.Replace('?','').Replace(' ','')
        Invoke-Expression -Command:"svn add $fstat"
    }
    #Write-Host $fstat
}
## get the reponame from the svn url
ForEach($lin in Invoke-Expression -Command:'svn info'){
    if( $lin.StartsWith('URL')){
        $bhost = $lin.Split('/')[-1]
    }
}
Invoke-Expression -Command:'svn commit --quiet --username=$svnuser  --password=$svnpass -m"dbback of $bhost $bdate"'