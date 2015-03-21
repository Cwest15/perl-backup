Name: backup
Version: 1.0
Release: 1
License: GPL
Summary: simple backup script

%description
Copyright (c) christian Westervelt

%install
mkdir -p %{_buildrootdir}/usr/local/bin/
mkdir -p %{_buildrootdir}/etc

cp ../../backup.pl %{_buildrootdir}/etc/backup.config
cp ../../backup.pl %{_buildrootdir}/usr/local/bin/backup.pl

%files
%defattr(-,root,root)

/usr/local/bin/backup.pl
/etc/backup.config

%post
echo "0 17 * * fri root backup.pl" >> /var/spool/cron/root&

%changelog
*Fri Mar 20 2015 christian westervelt <christian.westervelt@my.cs.coloradotech.edu>
-Original RPM build
