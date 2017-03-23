# pshell_mysql_svn_backup
A PowerShell script to dump all MySQL databases on a windows machine and commit them to an svn repository

Requirements: you will need an svn command line client installed on your machine I use tortoise svn

*initial setup

*create a directory for the database files
*place the script in the directory and run it once 
*you get a bunch of errors but thats ok.
*back up a directory then run 
*  svn import  the_dir_containing_the_files  https://yoursvnserver/yourrepo --username=svnuser  --password=svnpass -m"Initial import of db backup"
*then delete the folder and run 
*  svn co https://yoursvnserver/yourrepo the_dir_containing_the_files --username=svnuser  --password=svnpass
  
*Now each time you run the script it will dump and update the repo
*I created a task scheduler task to run it once a day



