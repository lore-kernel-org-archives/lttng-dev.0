From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a module (driver)
Date: Tue, 26 Nov 2013 18:32:03 +0100
Message-ID: <5294DB13.3010307__15007.1212593049$1385487162$gmane$org@gmx.de>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.19])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1VlMU1-0006E5-Pu
	for lttng-dev@lists.lttng.org; Tue, 26 Nov 2013 12:31:43 -0500
Received: from [192.168.178.21] ([94.217.80.178]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0MY4Ls-1W7JB12Pbc-00UqdX for
	<lttng-dev@lists.lttng.org>; Tue, 26 Nov 2013 18:31:27 +0100
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Am 25.11.2013 20:22, schrieb Thibault, Daniel:
>> Date: Mon, 25 Nov 2013 12:00:14 -0500
>> From: J?r?mie Galarneau <jeremie.galarneau@efficios.com>
>>>     Aha!  There is one crucial mistake in the ibm.com document: he inst=
alls the packages in the wrong order.  lttng-tools must be installed AFTER =
lttng-modules and lttng-ust.  lttng-modules can be installed before, during=
 or after lttng-ust, but userspace-rcu must be installed before lttng-ust.
>>>     The problem is that the configure of lttng-tools detects the presen=
ce or absence of lttng-modules and also detects the presence or absence of =
lttng-ust, and adjusts to both.  By installing lttng-tools before lttng-mod=
ules, you've built an lttng-tools set that CANNOT be used to trace the kern=
el.
>>>
>>>     So, try again from scratch, making sure to install lttng-tools last.
>> lttng-tools checks for kernel modules at run time, not at configure time=
. You can safely install lttng-modules after lttng-tools and still use kern=
el tracing.
>>
>> Regards,
>> J=E9r=E9mie
>     Dang, you're right.  The build of lttng-tools reacts to the presence =
or absence of lttng-ust, but is indifferent to the presence or absence of l=
ttng-modules.  (Only liblttng-ctl.a is different, probably some internal ti=
mestamps or some such)
>
>> klaus@ubuntu:~$ sudo lttng -vvv start
>> DEBUG2 [2854/2854]: Config file path found: /home/klaus (in get_session_=
name() at utils.c:57)
>> DEBUG1 [2854/2854]: Session name found: auto-20131124-091639 (in get_ses=
sion_name() at utils.c:58)
>> DEBUG1 [2854/2854]: Starting tracing for session auto-20131124-091639 (i=
n start_tracing() at commands/start.c:81)
>> DEBUG1 [2854/2854]: LSM cmd type : 16 (in send_session_msg() at lttng-ct=
l.c:131)
>> 'ctrl c'
>> klaus@ubuntu:~$
>     Let's try to identify the module responsible.  First, make sure lttng=
-sessiond is NOT running.  Then, do this in one shell:
>
> $ sudo -H lttng-sessiond -vvv
>
>     It should fail after loading one of the modules.
>
>     You can also try:
>
> $ sudo -H lttng-sessiond -vvv --no-kernel
>
>     In which case you should be able to do any lttng command except those=
 involving the kernel.  For example, 'lttng list -u'.
here the output:
klaus@ubuntu:~$ sudo -H lttng-sessiond -vvv
[sudo] password for klaus:
DEBUG3 [2643/2643]: Creating LTTng run directory: /var/run/lttng (in =

create_lttng_rundir() at main.c:4267)
DEBUG2 [2643/2643]: Kernel consumer err path: =

/var/run/lttng/kconsumerd/error (in main() at main.c:4708)
DEBUG2 [2643/2643]: Kernel consumer cmd path: =

/var/run/lttng/kconsumerd/command (in main() at main.c:4710)
DEBUG1 [2643/2643]: Client socket path =

/var/run/lttng/client-lttng-sessiond (in main() at main.c:4763)
DEBUG1 [2643/2643]: Application socket path =

/var/run/lttng/lttng-ust-sock-5 (in main() at main.c:4764)
DEBUG1 [2643/2643]: Application wait path /lttng-ust-wait-5 (in main() =

at main.c:4765)
DEBUG1 [2643/2643]: LTTng run directory path: /var/run/lttng (in main() =

at main.c:4766)
DEBUG2 [2643/2643]: UST consumer 32 bits err path: =

/var/run/lttng/ustconsumerd32/error (in main() at main.c:4775)
DEBUG2 [2643/2643]: UST consumer 32 bits cmd path: =

/var/run/lttng/ustconsumerd32/command (in main() at main.c:4777)
DEBUG2 [2643/2643]: UST consumer 64 bits err path: =

/var/run/lttng/ustconsumerd64/error (in main() at main.c:4786)
DEBUG2 [2643/2643]: UST consumer 64 bits cmd path: =

/var/run/lttng/ustconsumerd64/command (in main() at main.c:4788)
DEBUG3 [2643/2643]: Created hashtable size 4 at 0x9355080 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG3 [2643/2643]: Created hashtable size 4 at 0x9355270 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG3 [2643/2643]: Created hashtable size 4 at 0x9355498 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG3 [2643/2643]: Created hashtable size 4 at 0x93556c0 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG2 [2643/2643]: Creating consumer directory: =

/var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:4309)
Warning: No tracing group detected
DEBUG1 [2643/2643]: Modprobe successfully lttng-tracer (in =

modprobe_lttng_control() at modprobe.c:192)
DEBUG2 [2643/2643]: Kernel tracer version validated (major version 2) =

(in kernel_validate_version() at kernel.c:700)
DEBUG1 [2643/2643]: Modprobe successfully lttng-ftrace (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-kprobes (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-kretprobes (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-lib-ring-buffer (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully =

lttng-ring-buffer-client-discard (in modprobe_lttng_data() at =

modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully =

lttng-ring-buffer-client-overwrite (in modprobe_lttng_data() at =

modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully =

lttng-ring-buffer-metadata-client (in modprobe_lttng_data() at =

modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully =

lttng-ring-buffer-client-mmap-discard (in modprobe_lttng_data() at =

modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully =

lttng-ring-buffer-client-mmap-overwrite (in modprobe_lttng_data() at =

modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully =

lttng-ring-buffer-metadata-mmap-client (in modprobe_lttng_data() at =

modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-types (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-asoc (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-block (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-btrfs (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-compaction (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-ext3 (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-ext4 (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-gpio (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-irq (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-jbd (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-jbd2 (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-kmem (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-kvm (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-kvm-x86 (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-kvm-x86-mmu (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-lock (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-module (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-napi (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-net (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-power (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-printk (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-random (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-rcu (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-regmap (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-regulator (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-rpm (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-sched (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-scsi (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-signal (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-skb (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-sock (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-statedump (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-sunrpc (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-timer (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-udp (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-vmscan (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-workqueue (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Modprobe successfully lttng-probe-writeback (in =

modprobe_lttng_data() at modprobe.c:228)
DEBUG1 [2643/2643]: Kernel tracer fd 6 (in init_kernel_tracer() at =

main.c:2364)
DEBUG2 [2643/2643]: Creating consumer directory: =

/var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:4309)
DEBUG2 [2643/2643]: Creating consumer directory: =

/var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4309)
DEBUG3 [2643/2643]: Session daemon client socket 9 and application =

socket 10 created (in init_daemon_socket() at main.c:4175)
DEBUG1 [2643/2643]: All permissions are set (in set_permissions() at =

main.c:4255)
DEBUG3 [2643/2643]: Created hashtable size 4 at 0x9357148 of type 2 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG3 [2643/2643]: Global buffer per UID registry initialized (in =

buffer_reg_init_uid_registry() at buffer-registry.c:99)
DEBUG3 [2643/2643]: Created hashtable size 4 at 0x9357370 of type 2 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG3 [2643/2643]: Global buffer per PID registry initialized (in =

buffer_reg_init_pid_registry() at buffer-registry.c:220)
DEBUG1 [2643/2643]: epoll set max size is 327869 (in =

compat_epoll_set_max_size() at compat-epoll.c:280)
DEBUG1 [2643/2643]: Command subsystem initialized (in cmd_init() at =

cmd.c:3056)
DEBUG1 [2643/2643]: Pid 2643 written in file =

/var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at =

utils.c:437)
DEBUG1 [2643/2643]: Pid 5345 written in file /var/run/lttng/jul.port (in =

utils_create_pid_file() at utils.c:437)
DEBUG1 [2643/2643]: TCP inet operation timeout set to 216 sec (in =

lttcomm_inet_init() at inet.c:529)
DEBUG1 [2643/2643]: Health check time delta in seconds set to 236 (in =

health_init() at health.c:73)
DEBUG1 [2643/2743]: [thread] Manage health check started (in =

thread_manage_health() at main.c:3511)
DEBUG1 [2643/2744]: [thread] Manage client started (in =

thread_manage_clients() at main.c:3695)
DEBUG1 [2643/2745]: [thread] Dispatch UST command started (in =

thread_dispatch_ust_registration() at main.c:1543)
DEBUG1 [2643/2747]: [thread] Manage application started (in =

thread_manage_apps() at main.c:1256)
DEBUG1 [2643/2746]: [thread] Manage application registration started (in =

thread_registration_apps() at main.c:1766)
DEBUG1 [2643/2742]: [ht-thread] startup. (in thread_ht_cleanup() at =

ht-cleanup.c:35)
DEBUG3 [2643/2742]: [ht-thread] Polling on 2 fds. (in =

thread_ht_cleanup() at ht-cleanup.c:59)
DEBUG1 [2643/2746]: Notifying applications of session daemon state: 1 =

(in notify_ust_apps() at main.c:593)
DEBUG1 [2643/2746]: Got the wait shm fd 24 (in get_wait_shm() at shm.c:115)
DEBUG1 [2643/2746]: Futex wait update active 1 (in futex_wait_update() =

at futex.c:63)
DEBUG1 [2643/2744]: Accepting client command ... (in =

thread_manage_clients() at main.c:3747)
DEBUG1 [2643/2743]: Health check ready (in thread_manage_health() at =

main.c:3574)
DEBUG1 [2643/2746]: Accepting application registration (in =

thread_registration_apps() at main.c:1803)
DEBUG1 [2643/2749]: [jul-thread] Manage JUL application registration. =

(in jul_thread_manage_registration() at jul-thread.c:250)
DEBUG3 [2643/2749]: URI string: tcp://localhost (in uri_parse() at =

uri.c:291)
DEBUG1 [2643/2748]: [ust-thread] Manage application notify command (in =

ust_thread_manage_notify() at ust-thread.c:38)
DEBUG3 [2643/2748]: [ust-thread] Manage notify polling on 2 fds (in =

ust_thread_manage_notify() at ust-thread.c:63)
DEBUG2 [2643/2749]: IP address resolved to 127.0.0.1 (in =

set_ip_address() at uri.c:132)
DEBUG1 [2643/2745]: Futex n to 1 prepare done (in futex_nto1_prepare() =

at futex.c:75)
DEBUG1 [2643/2745]: Woken up but nothing in the UST command queue (in =

thread_dispatch_ust_registration() at main.c:1566)
DEBUG1 [2643/2747]: Apps thread polling on 2 fds (in =

thread_manage_apps() at main.c:1286)
DEBUG1 [2643/2750]: [thread] Thread manage kernel started (in =

thread_manage_kernel() at main.c:794)
DEBUG1 [2643/2750]: Updating kernel poll set (in update_kernel_poll() at =

main.c:654)
DEBUG1 [2643/2750]: Thread kernel polling on 2 fds (in =

thread_manage_kernel() at main.c:839)
DEBUG3 [2643/2749]: URI dtype: 1, proto: 1, host: localhost, subdir: , =

ctrl: 0, data: 0 (in uri_parse() at uri.c:505)
DEBUG1 [2643/2749]: [jul-thread] Listening on TCP port 5345 and socket =

28 (in init_tcp_socket() at jul-thread.c:153)
DEBUG3 [2643/2749]: [jul-thread] Manage JUL polling on 2 fds (in =

jul_thread_manage_registration() at jul-thread.c:278)

---Terminal 2
klaus@ubuntu:~$ sudo lttng create
[sudo] password for klaus:
Session auto-20131126-090721 created.
Traces will be written in /home/klaus/lttng-traces/auto-20131126-090721
---


DEBUG1 [2643/2744]: Wait for client response (in thread_manage_clients() =

at main.c:3789)
DEBUG1 [2643/2744]: Receiving data from client ... (in =

thread_manage_clients() at main.c:3834)
DEBUG1 [2643/2744]: Nothing recv() from client... continuing (in =

thread_manage_clients() at main.c:3838)
DEBUG1 [2643/2744]: Clean command context structure (in =

clean_command_ctx() at main.c:573)
DEBUG1 [2643/2744]: Accepting client command ... (in =

thread_manage_clients() at main.c:3747)
DEBUG1 [2643/2744]: Wait for client response (in thread_manage_clients() =

at main.c:3789)
DEBUG1 [2643/2744]: Receiving data from client ... (in =

thread_manage_clients() at main.c:3834)
DEBUG1 [2643/2744]: Processing client command 8 (in process_client_msg() =

at main.c:2603)
DEBUG1 [2643/2744]: Waiting for 1 URIs from client ... (in =

process_client_msg() at main.c:3167)
DEBUG2 [2643/2744]: Trying to find session by name auto-20131126-090721 =

(in session_find_by_name() at session.c:133)
DEBUG3 [2643/2744]: Created hashtable size 4 at 0xb3305a28 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG1 [2643/2744]: Tracing session auto-20131126-090721 created with ID =

0 by UID 0 GID 0 (in session_create() at session.c:234)
DEBUG2 [2643/2744]: Trying to find session by name auto-20131126-090721 =

(in session_find_by_name() at session.c:133)
DEBUG3 [2643/2744]: Created hashtable size 4 at 0xb330aca0 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG2 [2643/2744]: Setting trace directory path from URI to =

/home/klaus/lttng-traces/auto-20131126-090721 (in add_uri_to_consumer() =

at cmd.c:481)
DEBUG1 [2643/2744]: Sending response (size: 16, retcode: Success) (in =

thread_manage_clients() at main.c:3883)
DEBUG1 [2643/2744]: Clean command context structure (in =

clean_command_ctx() at main.c:573)
DEBUG1 [2643/2744]: Accepting client command ... (in =

thread_manage_clients() at main.c:3747)

---Terminal 2
klaus@ubuntu:~$ sudo lttng enable-event -k -a
All Kernel events are enabled in channel channel0
---


DEBUG1 [2643/2744]: Wait for client response (in thread_manage_clients() =

at main.c:3789)
DEBUG1 [2643/2744]: Receiving data from client ... (in =

thread_manage_clients() at main.c:3834)
DEBUG1 [2643/2744]: Nothing recv() from client... continuing (in =

thread_manage_clients() at main.c:3838)
DEBUG1 [2643/2744]: Clean command context structure (in =

clean_command_ctx() at main.c:573)
DEBUG1 [2643/2744]: Accepting client command ... (in =

thread_manage_clients() at main.c:3747)
DEBUG1 [2643/2744]: Wait for client response (in thread_manage_clients() =

at main.c:3789)
DEBUG1 [2643/2744]: Receiving data from client ... (in =

thread_manage_clients() at main.c:3834)
DEBUG1 [2643/2744]: Processing client command 6 (in process_client_msg() =

at main.c:2603)
DEBUG1 [2643/2744]: Getting session auto-20131126-090721 by name (in =

process_client_msg() at main.c:2682)
DEBUG2 [2643/2744]: Trying to find session by name auto-20131126-090721 =

(in session_find_by_name() at session.c:133)
DEBUG1 [2643/2744]: Creating kernel session (in create_kernel_session() =

at main.c:2519)
DEBUG3 [2643/2744]: Created hashtable size 4 at 0xb33038b0 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG1 [2643/2744]: Kernel session created (fd: 30) (in =

kernel_create_session() at kernel.c:109)
DEBUG3 [2643/2744]: Copying tracing session consumer output in kernel =

session (in copy_session_consumer() at main.c:2414)
DEBUG3 [2643/2744]: Created hashtable size 4 at 0xb3303ad8 of type 1 (in =

lttng_ht_new() at hashtable.c:127)
DEBUG3 [2643/2744]: Copy session consumer subdir /kernel (in =

copy_session_consumer() at main.c:2450)
DEBUG3 [2643/2744]: mkdir() recursive =

/home/klaus/lttng-traces/auto-20131126-090721 with mode 504 for uid 0 =

and gid 0 (in run_as_mkdir_recursive() at runas.c:294)
DEBUG1 [2643/2744]: Using run_as_clone (in run_as() at runas.c:277)
DEBUG3 [2643/2742]: [ht-thread] Polling on 2 fds. (in =

thread_ht_cleanup() at ht-cleanup.c:59)
DEBUG1 [2643/2744]: Spawning consumerd (in spawn_consumerd() at main.c:2120)
DEBUG2 [2643/2744]: Consumer pid 2866 (in start_consumerd() at main.c:2306)
DEBUG2 [2643/2744]: Spawning consumer control thread (in =

start_consumerd() at main.c:2309)
DEBUG1 [2643/2867]: [thread] Manage consumer started (in =

thread_manage_consumer() at main.c:959)
DEBUG3 [2866/2866]: Looking for a kernel consumer at these locations: =

(in spawn_consumerd() at main.c:2139)
DEBUG3 [2866/2866]:     1)  (in spawn_consumerd() at main.c:2140)
DEBUG3 [2866/2866]:     2) /usr/local/lib/lttng/libexec/lttng-consumerd =

(in spawn_consumerd() at main.c:2141)
DEBUG3 [2866/2866]:     3) /usr/local/lib/lttng/libexec/lttng-consumerd =

(in spawn_consumerd() at main.c:2142)
DEBUG3 [2866/2866]: Found location #2 (in spawn_consumerd() at main.c:2147)
DEBUG1 [2866/2866]: Using kernel consumer at: =

/usr/local/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at =

main.c:2156)
DEBUG2 [2643/2867]: Receiving code from consumer err_sock (in =

thread_manage_consumer() at main.c:1044)
DEBUG1 [2643/2867]: Consumer command socket ready (fd: 33 (in =

thread_manage_consumer() at main.c:1079)
DEBUG1 [2643/2867]: Consumer metadata socket ready (fd: 34) (in =

thread_manage_consumer() at main.c:1081)
DEBUG3 [2643/2744]: Consumer socket created (fd: 33) and added to output =

(in consumer_create_socket() at consumer.c:299)
DEBUG1 [2643/2744]: Setting relayd for session auto-20131126-090721 (in =

cmd_setup_relayd() at cmd.c:722)
DEBUG1 [2643/2744]: Trying to find channel channel0 (in =

trace_kernel_get_channel_by_name() at trace-kernel.c:48)
DEBUG1 [2643/2744]: Enabling channel  for session auto-20131126-090721 =

(in cmd_enable_channel() at cmd.c:910)
DEBUG1 [2643/2744]: Trying to find channel channel0 (in =

trace_kernel_get_channel_by_name() at trace-kernel.c:48)
DEBUG3 [2643/2744]: Kernel create channel  with attr: 0, 262144, 4, 0, =

200000, 0, 0 (in kernel_create_channel() at kernel.c:143)
Warning: No tracing group detected
DEBUG1 [2643/2744]: Kernel channel channel0 created (fd: 35) (in =

kernel_create_channel() at kernel.c:165)
DEBUG1 [2643/2744]: Kernel quiescent wait on 6 (in =

kernel_wait_quiescent() at kernel.c:429)
DEBUG1 [2643/2750]: Updating kernel poll set (in update_kernel_poll() at =

main.c:654)
DEBUG1 [2643/2744]: Trying to find channel channel0 (in =

trace_kernel_get_channel_by_name() at trace-kernel.c:48)
DEBUG1 [2643/2744]: Found channel by name channel0 (in =

trace_kernel_get_channel_by_name() at trace-kernel.c:52)
DEBUG1 [2643/2744]: Event  created (fd: 36) (in kernel_create_event() at =

kernel.c:236)
DEBUG1 [2643/2744]: Kernel quiescent wait on 6 (in =

kernel_wait_quiescent() at kernel.c:429)
DEBUG1 [2643/2744]: Sending response (size: 16, retcode: Success) (in =

thread_manage_clients() at main.c:3883)
DEBUG1 [2643/2744]: Clean command context structure (in =

clean_command_ctx() at main.c:573)
DEBUG1 [2643/2744]: Accepting client command ... (in =

thread_manage_clients() at main.c:3747)
DEBUG1 [2643/2750]: Channel fd 35 added to kernel set (in =

update_kernel_poll() at main.c:672)
DEBUG1 [2643/2750]: Thread kernel polling on 3 fds (in =

thread_manage_kernel() at main.c:839)
DEBUG1 [2643/2750]: Updating kernel streams for channel fd 35 (in =

update_kernel_stream() at main.c:698)
DEBUG1 [2643/2750]: Channel found, updating kernel streams (in =

update_kernel_stream() at main.c:711)
DEBUG1 [2643/2750]: Kernel stream channel0_0 created (fd: 29, state: 0) =

(in kernel_open_channel_stream() at kernel.c:562)
DEBUG1 [2643/2750]: Kernel stream channel0_1 created (fd: 37, state: 0) =

(in kernel_open_channel_stream() at kernel.c:562)
DEBUG1 [2643/2750]: Thread kernel polling on 3 fds (in =

thread_manage_kernel() at main.c:839)

---Terminal 2
klaus@ubuntu:~$ sudo lttng start
now Terminal 2 hangs
----

DEBUG1 [2643/2744]: Wait for client response (in thread_manage_clients() =

at main.c:3789)
DEBUG1 [2643/2744]: Receiving data from client ... (in =

thread_manage_clients() at main.c:3834)
DEBUG1 [2643/2744]: Nothing recv() from client... continuing (in =

thread_manage_clients() at main.c:3838)
DEBUG1 [2643/2744]: Clean command context structure (in =

clean_command_ctx() at main.c:573)
DEBUG1 [2643/2744]: Accepting client command ... (in =

thread_manage_clients() at main.c:3747)
DEBUG1 [2643/2744]: Wait for client response (in thread_manage_clients() =

at main.c:3789)
DEBUG1 [2643/2744]: Receiving data from client ... (in =

thread_manage_clients() at main.c:3834)
DEBUG1 [2643/2744]: Processing client command 16 (in =

process_client_msg() at main.c:2603)
DEBUG1 [2643/2744]: Getting session auto-20131126-090721 by name (in =

process_client_msg() at main.c:2682)
DEBUG2 [2643/2744]: Trying to find session by name auto-20131126-090721 =

(in session_find_by_name() at session.c:133)
DEBUG1 [2643/2744]: Kernel metadata opened (fd: 39) (in =

kernel_open_metadata() at kernel.c:389)
DEBUG1 [2643/2744]: Kernel metadata stream created (fd: 40) (in =

kernel_open_metadata_stream() at kernel.c:586)
DEBUG1 [2643/2744]: Sending session stream to kernel consumer (in =

kernel_consumer_send_session() at kernel-consumer.c:338)
DEBUG1 [2643/2744]: Sending metadata 40 to kernel consumer (in =

kernel_consumer_add_metadata() at kernel-consumer.c:158)
DEBUG3 [2643/2744]: mkdir() recursive =

/home/klaus/lttng-traces/auto-20131126-090721/kernel with mode 504 for =

uid 0 and gid 0 (in run_as_mkdir_recursive() at runas.c:294)
DEBUG1 [2643/2744]: Using run_as_clone (in run_as() at runas.c:277)
DEBUG3 [2643/2744]: Kernel local consumer tracefile path: =

/home/klaus/lttng-traces/auto-20131126-090721/kernel (in =

create_channel_path() at kernel-consumer.c:60)
DEBUG1 [2643/2744]: Sending streams of channel channel0 to kernel =

consumer (in kernel_consumer_send_channel_stream() at kernel-consumer.c:288)
DEBUG1 [2643/2744]: Kernel consumer adding channel channel0 to kernel =

consumer (in kernel_consumer_add_channel() at kernel-consumer.c:98)
DEBUG3 [2643/2744]: mkdir() recursive =

/home/klaus/lttng-traces/auto-20131126-090721/kernel with mode 504 for =

uid 0 and gid 0 (in run_as_mkdir_recursive() at runas.c:294)
DEBUG1 [2643/2744]: Using run_as_clone (in run_as() at runas.c:277)
DEBUG3 [2643/2744]: Kernel local consumer tracefile path: =

/home/klaus/lttng-traces/auto-20131126-090721/kernel (in =

create_channel_path() at kernel-consumer.c:60)
DEBUG1 [2643/2744]: Sending stream 37 of channel channel0 to kernel =

consumer (in kernel_consumer_add_stream() at kernel-consumer.c:239)
DEBUG1 [2643/2744]: Sending stream 29 of channel channel0 to kernel =

consumer (in kernel_consumer_add_stream() at kernel-consumer.c:239)
DEBUG1 [2643/2744]: Kernel consumer FDs of metadata and channel streams =

sent (in kernel_consumer_send_session() at kernel-consumer.c:359)

--Terminal 2
strg C
klaus@ubuntu:~$
--

--Terminal 1
no more message
strg C
DEBUG1 [2643/2643]: SIGINT caught (in sighandler() at main.c:4374)
DEBUG1 [2643/2643]: Terminating all threads (in stop_threads() at =

main.c:370)
DEBUG1 [2643/2643]: Futex n to 1 wake done (in futex_nto1_wake() at =

futex.c:104)
DEBUG1 [2643/2750]: Kernel thread dying (in thread_manage_kernel() at =

main.c:921)
DEBUG1 [2643/2748]: Application notify communication apps thread cleanup =

complete (in ust_thread_manage_notify() at ust-thread.c:175)
DEBUG1 [2643/2747]: Application communication apps thread cleanup =

complete (in thread_manage_apps() at main.c:1394)
DEBUG3 [2643/2749]: [jul-thread] 1 fd ready (in =

jul_thread_manage_registration() at jul-thread.c:293)
DEBUG3 [2643/2749]: [jul-thread] Destroy TCP socket on port 5345 (in =

destroy_tcp_socket() at jul-thread.c:171)
DEBUG1 [2643/2749]: [jul-thread] is cleaning up and stopping. (in =

jul_thread_manage_registration() at jul-thread.c:356)
DEBUG3 [2643/2749]: [jul-thread] Cleaning JUL apps ht (in =

clean_jul_apps_ht() at jul-thread.c:100)
DEBUG1 [2643/2867]: consumer thread cleanup completed (in =

thread_manage_consumer() at main.c:1241)
DEBUG1 [2643/2742]: [ust-thread] cleanup complete. (in =

thread_ht_cleanup() at ht-cleanup.c:130)
DEBUG1 [2643/2746]: Notifying applications of session daemon state: 0 =

(in notify_ust_apps() at main.c:593)
DEBUG1 [2643/2743]: Health check thread dying (in thread_manage_health() =

at main.c:3668)
DEBUG1 [2643/2746]: Got the wait shm fd 5 (in get_wait_shm() at shm.c:115)
DEBUG1 [2643/2746]: Futex wait update active 0 (in futex_wait_update() =

at futex.c:63)
DEBUG1 [2643/2745]: Futex n to 1 wait done (in futex_nto1_wait() at =

futex.c:90)
DEBUG1 [2643/2745]: Dispatch thread dying (in =

thread_dispatch_ust_registration() at main.c:1743)
DEBUG1 [2643/2643]: SIGINT caught (in sighandler() at main.c:4374)
DEBUG1 [2643/2643]: Terminating all threads (in stop_threads() at =

main.c:370)
DEBUG1 [2643/2643]: Futex n to 1 wake done (in futex_nto1_wake() at =

futex.c:104)
DEBUG1 [2643/2746]: UST Registration thread cleanup complete (in =

thread_registration_apps() at main.c:1959)
DEBUG1 [2643/2643]: Cleaning up (in cleanup() at main.c:435)
DEBUG1 [2643/2643]: Removing sessiond and consumerd content of directory =

/var/run/lttng (in cleanup() at main.c:454)
DEBUG1 [2643/2643]: Removing /var/run/lttng/lttng-sessiond.pid (in =

cleanup() at main.c:460)
DEBUG1 [2643/2643]: Removing /var/run/lttng/jul.port (in cleanup() at =

main.c:465)
DEBUG1 [2643/2643]: Removing /var/run/lttng/kconsumerd/error (in =

cleanup() at main.c:472)
DEBUG1 [2643/2643]: Removing directory /var/run/lttng/kconsumerd (in =

cleanup() at main.c:478)
DEBUG1 [2643/2643]: Removing /var/run/lttng/ustconsumerd32/error (in =

cleanup() at main.c:485)
DEBUG1 [2643/2643]: Removing directory /var/run/lttng/ustconsumerd32 (in =

cleanup() at main.c:491)
DEBUG1 [2643/2643]: Removing /var/run/lttng/ustconsumerd64/error (in =

cleanup() at main.c:498)
DEBUG1 [2643/2643]: Removing directory /var/run/lttng/ustconsumerd64 (in =

cleanup() at main.c:504)
DEBUG1 [2643/2643]: Cleaning up all sessions (in cleanup() at main.c:515)
DEBUG1 [2643/2643]: Tearing down kernel session (in =

kernel_destroy_session() at kernel.c:755)
DEBUG1 [2643/2643]: [trace] Closing session fd 30 (in =

trace_kernel_destroy_session() at trace-kernel.c:450)
DEBUG1 [2643/2643]: [trace] Closing metadata stream fd 40 (in =

trace_kernel_destroy_session() at trace-kernel.c:460)
DEBUG1 [2643/2643]: [trace] Closing metadata fd 39 (in =

trace_kernel_destroy_metadata() at trace-kernel.c:423)

Terminal 1 hangs now !!
in other terminal now no lttng call are work!

when i repeat the comand in other terminal:
klaus@ubuntu:~$ sudo -H lttng-sessiond -vvv
[sudo] password for klaus:
DEBUG3 [3012/3012]: Creating LTTng run directory: /var/run/lttng (in =

create_lttng_rundir() at main.c:4267)
DEBUG2 [3012/3012]: Kernel consumer err path: =

/var/run/lttng/kconsumerd/error (in main() at main.c:4708)
DEBUG2 [3012/3012]: Kernel consumer cmd path: =

/var/run/lttng/kconsumerd/command (in main() at main.c:4710)
DEBUG1 [3012/3012]: Client socket path =

/var/run/lttng/client-lttng-sessiond (in main() at main.c:4763)
DEBUG1 [3012/3012]: Application socket path =

/var/run/lttng/lttng-ust-sock-5 (in main() at main.c:4764)
DEBUG1 [3012/3012]: Application wait path /lttng-ust-wait-5 (in main() =

at main.c:4765)
DEBUG1 [3012/3012]: LTTng run directory path: /var/run/lttng (in main() =

at main.c:4766)
DEBUG2 [3012/3012]: UST consumer 32 bits err path: =

/var/run/lttng/ustconsumerd32/error (in main() at main.c:4775)
DEBUG2 [3012/3012]: UST consumer 32 bits cmd path: =

/var/run/lttng/ustconsumerd32/command (in main() at main.c:4777)
DEBUG2 [3012/3012]: UST consumer 64 bits err path: =

/var/run/lttng/ustconsumerd64/error (in main() at main.c:4786)
DEBUG2 [3012/3012]: UST consumer 64 bits cmd path: =

/var/run/lttng/ustconsumerd64/command (in main() at main.c:4788)
Error: Already running daemon.

before i use the command sudo lttng start
all other lttng command's are work's!

Regards,
Klaus



> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
