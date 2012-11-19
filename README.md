check-grub:
-----------
This Nagios check examines the MBR of sda
 and sdb. If Grub looks for the Stage2 bootloader
anywhere but on the same drive in the boot
partition, then this check will be critical.
Anaconda installs to sda, looking for a specific
sector number on sda.  If Anaconda installs
to sdb, it also looks for Stage2 on sda at the
specific sector number.

To fix this, run the command with the '--fixup'
option. This will rewrite the MBR of any
misconfigured drive to look for Stage2 in /grub/stage2
of it's own root partition (that's /boot once the system
is up and filesystems are mounted.

 Note: grub-install will also fix sda, but won't fix sdb.
       This check looks for that also.

check_nginx_backend.rb:
-----------------------
This reads the nginx status page, and alerts based on how
many backend servers are down.

ldap-showservicesearches:
-------------------------
some services will block waiting on libnss to return a result
from ldap. In an ldap outage, this can cause the service to 
exhibit severe latency, or become unavailable.  This check
watches for those services and alerts when one is found, so
it can be added to the filter.
