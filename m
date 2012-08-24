From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTNG bug when running on single user (root) system
Date: Fri, 24 Aug 2012 09:03:30 -0400
Message-ID: <20120824130330.GB21676__25105.7305992164$1345813450$gmane$org@Krystal>
References: <CAGya9MmN7Y4m2RTpMuibqAke4ny64d=Oix0uEEoqatsh4Yruig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T4tXx-0004GQ-Gc
	for lttng-dev@lists.lttng.org; Fri, 24 Aug 2012 09:03:33 -0400
Content-Disposition: inline
In-Reply-To: <CAGya9MmN7Y4m2RTpMuibqAke4ny64d=Oix0uEEoqatsh4Yruig@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Henrik Hautakoski <henrik@fiktivkod.org>
Cc: lttng-dev@lists.lttng.org, Stefan Karlsson S12 <skn07007@student.mdh.se>, Alf Larsson <alf.larsson@ericsson.com>, David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* Henrik Hautakoski (henrik@fiktivkod.org) wrote:
> LTTng seems to work only when sessiond and the lttng process are owned
> by different users!

Please make sure that, when you test from a user account (not root), you
don't have a per-user sessiond running. If a user is not part of the
tracing group, it will spawn its own lttng-sessiond to trace its own
application. This would explain why you don't see anything in the root
sessiond debug log.

Also, there seems to be an issue with starting the 32-bit consumerd, as
far as I understand the logs. I'll let David look into this further.

Best regards,

Mathieu

> 
> 
> Summary:
> sessiond   enable-enevent   WORKS?
> user user NO
> root user YES (No output in sessiond window)
> root root NO
> user root YES (No output in sessiond window)
> 
> 
> 
> Details:
> 
> sudo apt-get -F install uuid-dev libpopt-dev autoconf  automake libtool
>     mkdir ltt
>     cd ltt/
>     git clone git://git.lttng.org/lttng-ust.git
>     git clone git://git.lttng.org/lttng-tools.git
>     git clone git://git.lttng.org/userspace-rcu.git
>     cd userspace-rcu/
>     ./bootstrap
>     ./configure
>     make
>     sudo make install
>     cd ..
>     cd lttng-ust/
>     ./bootstrap
>     ./configure
>     make
>     sudo make install
>     cd ..
>     cd lttng-tools/
>     ./bootstrap
>     ./configure
>     make
>     sudo make install
> ===========================================================================
> Testing as normal user(daemon normal, lttng normnal):
> ============================================================================
> dfm01@ubuntu:~$ lsof | grep ltt
>   bash       2342      dfm01  cwd       DIR        8,1     4096
> 353314 /home/dfm01/ltt/lttng-tools
>  gedit     13840      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> 
> dfm01@ubuntu:~$ export LD_LIBRARY_PATH=/usr/local/lib
> dfm01@ubuntu:~$ lttng-sessiond --no-kernel -vvv --verbose-consumer
> --consumerd32-path /usr/local/lib
> 
> dfm01@ubuntu:~/ltt/lttng-tools/tests$ lttng create
> Trace(s) output set to /home/dfm01/lttng-traces/auto-20120823-102454
> Session created with default name auto-20120823-102454
> 
> Daemon log:
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Nothing recv() from client... continuing [in
> thread_manage_clients() at main.c:3035]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Processing client command 8 [in process_client_msg() at main.c:2004]
> DEBUG1: Waiting for 1 URIs from client ... [in process_client_msg() at
> main.c:2505]
> DEBUG2: Trying to find session by name auto-20120823-102454 [in
> session_find_by_name() at session.c:122]
> DEBUG1: Tracing session auto-20120823-102454 created in (null) with ID
> 0 by UID 1000 GID 1000 [in session_create() at session.c:236]
> DEBUG2: Trying to find session by name auto-20120823-102454 [in
> session_find_by_name() at session.c:122]
> DEBUG3: Created hashtable size 4 at 0xb440a928 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: Setting trace directory path from URI to
> /home/dfm01/lttng-traces/auto-20120823-102454 [in
> add_uri_to_consumer() at cmd.c:395]
> DEBUG1: Sending response (size: 16, retcode: Success) [in
> thread_manage_clients() at main.c:3082]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> 
> 
> 
> dfm01@ubuntu:~/ltt/lttng-tools/tests$ lttng enable-event -u all
> Error: Event all: 32-bit UST consumer start failed (channel channel0,
> session auto-20120823-102454)
> Warning: Some command(s) went wrong
> 
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Nothing recv() from client... continuing [in
> thread_manage_clients() at main.c:3035]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Processing client command 6 [in process_client_msg() at main.c:2004]
> DEBUG1: Getting session auto-20120823-102454 by name [in
> process_client_msg() at main.c:2074]
> DEBUG2: Trying to find session by name auto-20120823-102454 [in
> session_find_by_name() at session.c:122]
> DEBUG1: Creating UST session [in create_ust_session() at main.c:1891]
> DEBUG3: Created hashtable size 4 at 0xb440ba70 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb440bb90 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb440bcb0 of type 0 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb4410e18 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: UST trace session create successful [in
> trace_ust_create_session() at trace-ust.c:143]
> DEBUG3: Copying tracing session consumer output in UST session [in
> copy_session_consumer() at main.c:1840]
> DEBUG3: Created hashtable size 4 at 0xb4415f80 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb44160a0 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: Consumer subdir set to /auto-20120823-102454 [in
> consumer_set_subdir() at consumer.c:689]
> DEBUG3: Copy session consumer subdir /ust [in copy_session_consumer()
> at main.c:1861]
> DEBUG1: Spawning consumerd [in spawn_consumerd() at main.c:1547]
> DEBUG2: Consumer pid 10564 [in start_consumerd() at main.c:1718]
> DEBUG2: Spawning consumer control thread [in start_consumerd() at main.c:1721]
> DEBUG1: Using 32-bit UST consumer at: /usr/local/lib [in
> spawn_consumerd() at main.c:1665]
> Error: Spawning consumerd failed
> DEBUG1: Sending response (size: 16, retcode: 32-bit UST consumer start
> failed) [in thread_manage_clients() at main.c:3082]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> DEBUG1: [thread] Manage consumer started [in thread_manage_consumer()
> at main.c:802]
> 
> Fails
> 
> 
> 
> dfm01@ubuntu:~$ lsof | grep ltt
> bash       2342      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> lttng-ses  8435      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> lttng-ses  8435      dfm01  rtd       DIR        8,1     4096       2 /
> lttng-ses  8435      dfm01  txt       REG        8,1   660624  927277
> /usr/local/bin/lttng-sessiond
> lttng-ses  8435      dfm01  mem       REG        8,1    92016  405535
> /lib/i386-linux-gnu/libnsl-2.15.so
> lttng-ses  8435      dfm01  mem       REG        8,1    16833  917842
> /usr/local/lib/liburcu-common.so.1.0.0
> lttng-ses  8435      dfm01  mem       REG        8,1    42652  405540
> /lib/i386-linux-gnu/libnss_nis-2.15.so
> lttng-ses  8435      dfm01  mem       REG        8,1    47040  405538
> /lib/i386-linux-gnu/libnss_files-2.15.so
> lttng-ses  8435      dfm01  mem       REG        8,1    62218  925784
> /usr/local/lib/liburcu-bp.so.1.0.0
> lttng-ses  8435      dfm01  mem       REG        8,1    54778  925752
> /usr/local/lib/liburcu.so.1.0.0
> lttng-ses  8435      dfm01  mem       REG        8,1  1713640  405529
> /lib/i386-linux-gnu/libc-2.15.so
> lttng-ses  8435      dfm01  mem       REG        8,1   393957  921931
> /usr/local/lib/liblttng-ctl.so.0.0.0
> lttng-ses  8435      dfm01  mem       REG        8,1   572112  926835
> /usr/local/lib/liblttng-ust-ctl.so.0.0.0
> lttng-ses  8435      dfm01  mem       REG        8,1    30684  405545
> /lib/i386-linux-gnu/librt-2.15.so
> lttng-ses  8435      dfm01  mem       REG        8,1   134344  393277
> /lib/i386-linux-gnu/ld-2.15.so
> lttng-ses  8435      dfm01  mem       REG        8,1   124663  405543
> /lib/i386-linux-gnu/libpthread-2.15.so
> lttng-ses  8435      dfm01  mem       REG        8,1    30520  405536
> /lib/i386-linux-gnu/libnss_compat-2.15.so
> lttng-ses  8435      dfm01  mem       REG       0,18     4096   71410
> /run/shm/lttng-ust-apps-wait-1000
> lttng-ses  8435      dfm01    0u      CHR      136,2      0t0       5 /dev/pts/2
> lttng-ses  8435      dfm01    1u      CHR      136,2      0t0       5 /dev/pts/2
> lttng-ses  8435      dfm01    2u      CHR      136,2      0t0       5 /dev/pts/2
> lttng-ses  8435      dfm01    3r     FIFO        0,8      0t0   97133 pipe
> lttng-ses  8435      dfm01    4w     FIFO        0,8      0t0   97133 pipe
> lttng-ses  8435      dfm01    5u     unix 0x00000000      0t0   97134
> /home/dfm01/.lttng/ustconsumerd64/error
> lttng-ses  8435      dfm01    6u     unix 0x00000000      0t0   97135
> /home/dfm01/.lttng/ustconsumerd32/error
> lttng-ses  8435      dfm01    7u     unix 0x00000000      0t0   97136
> /home/dfm01/.lttng/client-lttng-sessiond
> lttng-ses  8435      dfm01    8u     unix 0x00000000      0t0   97137
> /home/dfm01/.lttng/apps-lttng-sessiond
> lttng-ses  8435      dfm01    9r     FIFO        0,8      0t0   97138 pipe
> lttng-ses  8435      dfm01   10w     FIFO        0,8      0t0   97138 pipe
> lttng-ses  8435      dfm01   11r     FIFO        0,8      0t0   97139 pipe
> lttng-ses  8435      dfm01   12w     FIFO        0,8      0t0   97139 pipe
> lttng-ses  8435      dfm01   13u     0000        0,9        0    4765 anon_inode
> lttng-ses  8435      dfm01   14u     0000        0,9        0    4765 anon_inode
> lttng-ses  8435      dfm01   15u     0000        0,9        0    4765 anon_inode
> lttng-ses  8435      dfm01   16u     unix 0x00000000      0t0   97140
> /home/dfm01/.lttng/health.sock
> lttng-ses  8435      dfm01   17u     0000        0,9        0    4765 anon_inode
> lttng-ses  8435      dfm01   18u     0000        0,9        0    4765 anon_inode
> gedit     13840      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> 
> 
> ================================================================================
> As root: for daemon
> ================================================================================
> 
> root@ubuntu:~$    export LD_LIBRARY_PATH=/usr/local/lib
> root@ubuntu:~$    sudo lttng-sessiond --no-kernel -vvv
> --verbose-consumer --consumerd32-path /usr/local/lib
> 
>  dfm01@ubuntu:~/ltt/lttng-tools$ lsof | grep ltt
> bash       2342      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> lttng-ses  8494       root  cwd   unknown
> /proc/8494/cwd (readlink: Permission denied)
> lttng-ses  8494       root  rtd   unknown
> /proc/8494/root (readlink: Permission denied)
> lttng-ses  8494       root  txt   unknown
> /proc/8494/exe (readlink: Permission denied)
> lttng-ses  8494       root NOFD
> /proc/8494/fd (opendir: Permission denied)
> lsof       8504      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> grep       8505      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> lsof       8506      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> gedit     13840      dfm01  cwd       DIR        8,1     4096  353314
> /home/dfm01/ltt/lttng-tools
> 
> sudo lsof | grep ltt
> 
> dfm01@ubuntu:~/ltt/lttng-tools$ sudo lsof | grep ltt
> [sudo] password for dfm01:
> lsof: WARNING: can't stat() fuse.gvfs-fuse-daemon file system /home/dfm01/.gvfs
>       Output information may be incomplete.
> bash       2342      dfm01  cwd       DIR        8,1     4096
> 353314 /home/dfm01/ltt/lttng-tools
> lttng-ses  8494       root  cwd       DIR        8,1     4096
> 270695 /home/dfm01
> lttng-ses  8494       root  rtd       DIR        8,1     4096          2 /
> lttng-ses  8494       root  txt       REG        8,1   660624
> 927277 /usr/local/bin/lttng-sessiond
> lttng-ses  8494       root  mem       REG        8,1    92016
> 405535 /lib/i386-linux-gnu/libnsl-2.15.so
> lttng-ses  8494       root  mem       REG        8,1    47040
> 405538 /lib/i386-linux-gnu/libnss_files-2.15.so
> lttng-ses  8494       root  mem       REG        8,1    62218
> 925784 /usr/local/lib/liburcu-bp.so.1.0.0
> lttng-ses  8494       root  mem       REG        8,1   134344
> 393277 /lib/i386-linux-gnu/ld-2.15.so
> lttng-ses  8494       root  mem       REG        8,1    42652
> 405540 /lib/i386-linux-gnu/libnss_nis-2.15.so
> lttng-ses  8494       root  mem       REG        8,1  1713640
> 405529 /lib/i386-linux-gnu/libc-2.15.so
> lttng-ses  8494       root  mem       REG        8,1    30684
> 405545 /lib/i386-linux-gnu/librt-2.15.so
> lttng-ses  8494       root  mem       REG        8,1   124663
> 405543 /lib/i386-linux-gnu/libpthread-2.15.so
> lttng-ses  8494       root  mem       REG        8,1    30520
> 405536 /lib/i386-linux-gnu/libnss_compat-2.15.so
> lttng-ses  8494       root  mem       REG        8,1    16833
> 917842 /usr/local/lib/liburcu-common.so.1.0.0
> lttng-ses  8494       root  mem       REG        8,1   572112
> 926835 /usr/local/lib/liblttng-ust-ctl.so.0.0.0
> lttng-ses  8494       root  mem       REG        8,1    54778
> 925752 /usr/local/lib/liburcu.so.1.0.0
> lttng-ses  8494       root  mem       REG        8,1   393957
> 921931 /usr/local/lib/liblttng-ctl.so.0.0.0
> lttng-ses  8494       root  mem       REG       0,18     4096
> 98026 /run/shm/lttng-ust-apps-wait
> lttng-ses  8494       root    0u      CHR      136,3      0t0
> 6 /dev/pts/3
> lttng-ses  8494       root    1u      CHR      136,3      0t0
> 6 /dev/pts/3
> lttng-ses  8494       root    2u      CHR      136,3      0t0
> 6 /dev/pts/3
> lttng-ses  8494       root    3r     FIFO        0,8      0t0      98007 pipe
> lttng-ses  8494       root    4w     FIFO        0,8      0t0      98007 pipe
> lttng-ses  8494       root    5u     unix 0xf53d86c0      0t0
> 98010 /var/run/lttng/kconsumerd/error
> lttng-ses  8494       root    6u     unix 0xf53d9440      0t0
> 98013 /var/run/lttng/ustconsumerd64/error
> lttng-ses  8494       root    7u     unix 0xf53d9d40      0t0
> 98016 /var/run/lttng/ustconsumerd32/error
> lttng-ses  8494       root    8u     unix 0xf53d9b00      0t0
> 98018 /var/run/lttng/client-lttng-sessiond
> lttng-ses  8494       root    9u     unix 0xf53da1c0      0t0
> 98020 /var/run/lttng/apps-lttng-sessiond
> lttng-ses  8494       root   10r     FIFO        0,8      0t0      98024 pipe
> lttng-ses  8494       root   11w     FIFO        0,8      0t0      98024 pipe
> lttng-ses  8494       root   12r     FIFO        0,8      0t0      98025 pipe
> lttng-ses  8494       root   13w     FIFO        0,8      0t0      98025 pipe
> lttng-ses  8494       root   14u     0000        0,9        0
> 4765 anon_inode
> lttng-ses  8494       root   15u     0000        0,9        0
> 4765 anon_inode
> lttng-ses  8494       root   16u     0000        0,9        0
> 4765 anon_inode
> lttng-ses  8494       root   17u     0000        0,9        0
> 4765 anon_inode
> lttng-ses  8494       root   18u     unix 0xf53d9680      0t0
> 98027 /var/run/lttng/health.sock
> lttng-ses  8494       root   19u     0000        0,9        0
> 4765 anon_inode
> sudo       8517       root  cwd       DIR        8,1     4096
> 353314 /home/dfm01/ltt/lttng-tools
> grep       8518      dfm01  cwd       DIR        8,1     4096
> 353314 /home/dfm01/ltt/lttng-tools
> lsof       8519       root  cwd       DIR        8,1     4096
> 353314 /home/dfm01/ltt/lttng-tools
> lsof       8520       root  cwd       DIR        8,1     4096
> 353314 /home/dfm01/ltt/lttng-tools
> gedit     13840      dfm01  cwd       DIR        8,1     4096
> 353314 /home/dfm01/ltt/lttng-tools
> 
> ===========================================================================
> Testing as normal user(daemon is run as root, lttng as normnal):
> ============================================================================
> dfm01@ubuntu:~/ltt/lttng-tools/tests$ lttng create
> Trace(s) output set to /home/dfm01/lttng-traces/auto-20120823-102111
> Session created with default name auto-20120823-102111
> dfm01@ubuntu:~/ltt/lttng-tools/tests$ lttng enable-event -u all
> UST event all created in channel channel0
> 
> Interesting, no DEBUG messages whatsoever in daemon window.
> 
> 
> 
> =========== Test that fails: ==========================
> root@ubuntu:/home/dfm01/ltt/lttng-tools/tests# lttng create
> Trace(s) output set to /root/lttng-traces/auto-20120823-100802
> Session created with default name auto-20120823-100802
> 
> Daemon log:
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Nothing recv() from client... continuing [in
> thread_manage_clients() at main.c:3035]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Processing client command 8 [in process_client_msg() at main.c:2004]
> DEBUG1: Waiting for 1 URIs from client ... [in process_client_msg() at
> main.c:2505]
> DEBUG2: Trying to find session by name auto-20120823-101733 [in
> session_find_by_name() at session.c:122]
> DEBUG1: Tracing session auto-20120823-101733 created in (null) with ID
> 2 by UID 0 GID 0 [in session_create() at session.c:236]
> DEBUG2: Trying to find session by name auto-20120823-101733 [in
> session_find_by_name() at session.c:122]
> DEBUG3: Created hashtable size 4 at 0xb4416780 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: Setting trace directory path from URI to
> /root/lttng-traces/auto-20120823-101733 [in add_uri_to_consumer() at
> cmd.c:395]
> DEBUG1: Sending response (size: 16, retcode: Success) [in
> thread_manage_clients() at main.c:3082]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> 
> 
> root@ubuntu:/home/dfm01/ltt/lttng-tools/tests# lttng enable-event -u all
> Error: Event all: 32-bit UST consumer start failed (channel channel0,
> session auto-20120823-100802)
> Warning: Some command(s) went wrong
> 
> 
> Daemon log:
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Nothing recv() from client... continuing [in
> thread_manage_clients() at main.c:3035]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> DEBUG1: Wait for client response [in thread_manage_clients() at main.c:2992]
> DEBUG1: Receiving data from client ... [in thread_manage_clients() at
> main.c:3031]
> DEBUG1: Processing client command 6 [in process_client_msg() at main.c:2004]
> DEBUG1: Getting session auto-20120823-101733 by name [in
> process_client_msg() at main.c:2074]
> DEBUG2: Trying to find session by name auto-20120823-101733 [in
> session_find_by_name() at session.c:122]
> DEBUG1: Creating UST session [in create_ust_session() at main.c:1891]
> DEBUG3: Created hashtable size 4 at 0xb44231b8 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb44232d8 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb44233f8 of type 0 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb4428560 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: UST trace session create successful [in
> trace_ust_create_session() at trace-ust.c:143]
> DEBUG3: Copying tracing session consumer output in UST session [in
> copy_session_consumer() at main.c:1840]
> DEBUG3: Created hashtable size 4 at 0xb442d6c8 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb442d7e8 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: Consumer subdir set to /auto-20120823-101733 [in
> consumer_set_subdir() at consumer.c:689]
> DEBUG3: Copy session consumer subdir /ust [in copy_session_consumer()
> at main.c:1861]
> DEBUG2: Trace UST channel channel0 not found by name [in
> trace_ust_find_channel_by_name() at trace-ust.c:52]
> DEBUG1: Enabling channel channel0 for session auto-20120823-101733 [in
> cmd_enable_channel() at cmd.c:743]
> DEBUG2: Trace UST channel channel0 not found by name [in
> trace_ust_find_channel_by_name() at trace-ust.c:52]
> DEBUG3: Created hashtable size 4 at 0xb442edd0 of type 0 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG3: Created hashtable size 4 at 0xb442eef0 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: Trace UST channel channel0 created [in
> trace_ust_create_channel() at trace-ust.c:205]
> DEBUG2: Channel channel0 being created in UST global domain [in
> channel_ust_create() at channel.c:267]
> DEBUG2: UST app adding channel channel0 to global domain for session
> id 2 [in ust_app_create_channel_glb() at ust-app.c:1984]
> DEBUG2: Channel channel0 created successfully [in channel_ust_create()
> at channel.c:292]
> DEBUG2: Trace UST channel channel0 found by name [in
> trace_ust_find_channel_by_name() at trace-ust.c:47]
> DEBUG2: Trace UST event NOT found by name all [in
> trace_ust_find_event_by_name() at trace-ust.c:79]
> DEBUG3: Created hashtable size 4 at 0xb442d908 of type 1 [in
> lttng_ht_new() at hashtable.c:96]
> DEBUG2: Trace UST event all, loglevel (0,-1) created [in
> trace_ust_create_event() at trace-ust.c:284]
> DEBUG1: UST app creating event all for all apps for session id 2 [in
> ust_app_create_event_glb() at ust-app.c:2108]
> DEBUG1: Event UST all created in channel channel0 [in
> event_ust_enable_tracepoint() at event.c:486]
> DEBUG1: Sending response (size: 16, retcode: Success) [in
> thread_manage_clients() at main.c:3082]
> DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:465]
> DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:2950]
> 
> -- 
> Henrik Hautakoski
> henrik@fiktivkod.org
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
