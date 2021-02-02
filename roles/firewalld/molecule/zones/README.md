Molecule scenario - Zones
=========================

With this molecule scenario we will test that our zones works.

zone1 will act as a server
zone2 will act as a trusted remote server
zone3 will act as a untrusted remote server

zone2 should be able to connect to zone1 via ssh
zone3 should be able to connect to zone1 mysqld
