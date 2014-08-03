vagrant_oracle_database_12.1.0.2_EE_on_Linux
============================================

Configuration files to create a VirtualBox image with Oracle Database 12.1.0.2 on Oracle Linux 6.5 (64 bit) using nothing more  than Vagrant and the two database installation files

Download linuxamd64_12102_database_1of2.zip and linuxamd64_12102_database_2of2.zip from OTN (http://www.oracle.com/technetwork/database/enterprise-edition/downloads/database12c-linux-download-2240591.html)

Store these files in a directory that you then map in the Vagrantfile to /software in the guest.

Note: These configuration files are based on the work done by Edwin Biemond and use his Oradb Puppet Module (see https://github.com/biemond/biemond-oradb)
