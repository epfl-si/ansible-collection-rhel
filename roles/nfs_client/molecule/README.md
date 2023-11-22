I don't know why, but molecule on RHEL8 with Podman doesn't let me boot the nfs server. Sometimes it boot, other it fails with 'exportfs: /var/nfs/nfs_server does not support NFS export'.
Verify stage passed when it worked. So I may release the role as such, but our future CI won't be happy. We need to find the root cause.
