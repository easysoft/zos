cd /sources/
tar xvf sysklogd*.gz
cd sysklogd*

pkg watch /mnt/lfs

sed -i '/Error loading kernel symbols/{n;n;d}' ksym_mod.c
make
make BINDIR=/sbin install

cat > /etc/syslog.conf << "EOF"
# Begin /etc/syslog.conf

auth,authpriv.* -/var/log/auth.log
*.*;auth,authpriv.none -/var/log/sys.log
daemon.* -/var/log/daemon.log
kern.* -/var/log/kern.log
mail.* -/var/log/mail.log
user.* -/var/log/user.log
*.emerg *

# End /etc/syslog.conf
EOF

pkg savelog sysklogd