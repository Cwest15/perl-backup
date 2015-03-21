#! /usr/bin/perl

#Open the backup configuration file or die letting the user know the config file doesn't exist
open IN, '< /etc/backup/backup.config' or die "No backup configuration file \n";

#create timestamp variable
$time = %Y +%m +%d;

#Copy the config file to an array
@backuplist = <IN>;
close(IN);

#check to see if backup directory exists if it does not create it
if (! -d "/etc/backup")
{
    mkdir "/etc/backup";
}

#create the .tar backup file
`tar -cvf /etc/backup/backup$time.tar backup.config`;

#read the config file and move the contents to the /backup folder
while($n < @backuplist)
{
    chomp($b = @backuplist[$n]);
    if (-f "$b")
    {
        printf "backing up file: @backuplist[$n] \n";
        `tar rvf /etc/backup/backup.tar ./$b`;
    }
    else
    {
        printf "file $b does not exist. \n"
    }
    $n += 1;
}

#compressing the backup with bzip
`bzip2 -z /etc/backup/backup.tar`;
