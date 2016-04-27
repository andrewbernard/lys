#
# Regular cron jobs for the lys package
#
0 4	* * *	root	[ -x /usr/bin/lys_maintenance ] && /usr/bin/lys_maintenance
