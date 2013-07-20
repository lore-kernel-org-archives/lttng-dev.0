From: Cao Gao <caogao@umich.edu>
Subject: LTTng on Android: no session daemon available
Date: Sat, 20 Jul 2013 15:49:27 -0400
Message-ID: <CAFvbycV0UvcWBqKrHfawfDKEen8PSziX92eKf3bHoMDtts=+sg__23570.0164376341$1374349852$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2021080163=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <petergao3721@gmail.com>) id 1V0dA9-0002uO-2N
	for lttng-dev@lists.lttng.org; Sat, 20 Jul 2013 15:49:58 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so12149902ieb.16
	for <lttng-dev@lists.lttng.org>; Sat, 20 Jul 2013 12:49:47 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2021080163==
Content-Type: multipart/alternative; boundary=047d7bdca4cee1099e04e1f6be3a

--047d7bdca4cee1099e04e1f6be3a
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

I=92m trying to use LTTng on Android 4.0.4 with Linux kernel version of
3.0.15.
I cross-compiled the LTTng modules and tools on my Ubuntu 12.04 machine.

First I installed all the LTTng modules using *insmod*, because there is no
*modprobe* in Android. It worked fine.
However, when I tried to run *lttng*, it failed due to "No session daemon
is available" error. I tried to run* lttng-sessiond*, then it just kept
hanging and cannot finish.
 Even I kept *lttng-sessiond* hanging in a new terminal session and ran *
lttng* in a separate terminal, it gave the same error.

I'm posting the log below.

Any help would be greatly appreciated!

Thanks,
Cao

*root@android:/data/lttng/bin # ./lttng -vvv list -k*

    DEBUG1 [2016/2016]: Session daemon at: /data/lttng/bin/lttng-sessiond
> (in check_sessiond() at lttng.c:381)
>     Spawning a session daemon
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-tracer
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-lib-ring-buffer
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-discard
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-overwrite
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-metadata-client
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-mmap-discard
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-mmap-overwrite
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-metadata-mmap-client
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-probe-lttng
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     sh: /sbin/modprobe: not found
>     Warning: No tracing group detected
>     DEBUG1 [2016/2016]: SIGUSR1 caught (in sighandler() at lttng.c:204)
>     DEBUG2 [2016/2016]: Session name: (null) (in cmd_list() at
> commands/list.c:743)
>     DEBUG1 [2016/2016]: Getting kernel tracing events (in
> list_kernel_events() at commands/list.c:433)
>     Error: Unable to list kernel events: No session daemon is available
>     Error: Command error
>     DEBUG1 [2016/2016]: Clean exit (in clean_exit() at lttng.c:175)



*root@android:/data/lttng/bin # ./lttng-sessiond -vvv*

>
>     DEBUG3 [2132/2132]: Creating LTTng run directory: /data/lttng (in
> create_lttng_rundir() at main.c:3853)
>     DEBUG2 [2132/2132]: Kernel consumer err path:
> /data/lttng/kconsumerd/error (in main() at main.c:4140)
>     DEBUG2 [2132/2132]: Kernel consumer cmd path:
> /data/lttng/kconsumerd/command (in main() at main.c:4142)
>     DEBUG1 [2132/2132]: Client socket path
> /data/lttng/client-lttng-sessiond (in main() at main.c:4195)
>     DEBUG1 [2132/2132]: Application socket path
> /data/lttng/lttng-ust-sock-4 (in main() at main.c:4196)
>     DEBUG1 [2132/2132]: Application wait path /lttng-ust-wait-4 (in main(=
)
> at main.c:4197)
>     DEBUG1 [2132/2132]: LTTng run directory path: /data/lttng (in main()
> at main.c:4198)
>     DEBUG2 [2132/2132]: UST consumer 32 bits err path:
> /data/lttng/ustconsumerd32/error (in main() at main.c:4207)
>     DEBUG2 [2132/2132]: UST consumer 32 bits cmd path:
> /data/lttng/ustconsumerd32/command (in main() at main.c:4209)
>     DEBUG2 [2132/2132]: UST consumer 64 bits err path:
> /data/lttng/ustconsumerd64/error (in main() at main.c:4218)
>     DEBUG2 [2132/2132]: UST consumer 64 bits cmd path:
> /data/lttng/ustconsumerd64/command (in main() at main.c:4220)
>     DEBUG2 [2132/2132]: Creating consumer directory:
> /data/lttng/kconsumerd (in set_consumer_sockets() at main.c:3895)
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-tracer
>     DEBUG2 [2132/2132]: Kernel tracer version validated (major version 2)
> (in kernel_validate_version() at kernel.c:688)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-ftrace (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-kprobes (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-kretprobes (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-lib-ring-buffer
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-discard
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-overwrite
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-metadata-client
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-mmap-discard
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-client-mmap-overwrite
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-ring-buffer-metadata-mmap-client
>     sh: /sbin/modprobe: not found
>     Error: Unable to load module lttng-probe-lttng
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-types (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-asoc (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-block (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-btrfs (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-compaction (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-ext3 (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-ext4 (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-gpio (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-irq (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-jbd (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-jbd2 (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-kmem (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-kvm (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-lock (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-module (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-napi (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-net (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-power (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-printk (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-random (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-rcu (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-regmap (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-regulator (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-rpm (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-sched (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-scsi (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-signal (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-skb (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-sock (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-statedump (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-sunrpc (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-timer (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-udp (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-vmscan (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-workqueue (in
> modprobe_lttng_data() at modprobe.c:227)
>     sh: /sbin/modprobe: not found
>     DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-writeback (in
> modprobe_lttng_data() at modprobe.c:227)
>     DEBUG1 [2132/2132]: Kernel tracer fd 6 (in init_kernel_tracer() at
> main.c:2139)
>     DEBUG2 [2132/2132]: Creating consumer directory:
> /data/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:3895)
>     DEBUG2 [2132/2132]: Creating consumer directory:
> /data/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:3895)
>     DEBUG1 [2132/2132]: Signal handler set for SIGTERM, SIGPIPE and SIGIN=
T
> (in set_signal_handler() at main.c:3987)
>     DEBUG3 [2132/2132]: Session daemon client socket 10 and application
> socket 11 created (in init_daemon_socket() at main.c:3757)
>     Warning: No tracing group detected
>     DEBUG3 [2132/2132]: Created hashtable size 4 at 0x1250208 of type 2
> (in lttng_ht_new() at hashtable.c:112)
>     DEBUG3 [2132/2132]: Global buffer per UID registry initialized (in
> buffer_reg_init_uid_registry() at buffer-registry.c:98)
>     DEBUG3 [2132/2132]: Created hashtable size 4 at 0x1250360 of type 1
> (in lttng_ht_new() at hashtable.c:112)
>     DEBUG3 [2132/2132]: Global buffer per PID registry initialized (in
> buffer_reg_init_pid_registry() at buffer-registry.c:219)
>     DEBUG1 [2132/2132]: epoll set max size is 153106 (in
> compat_epoll_set_max_size() at compat-epoll.c:270)
>     DEBUG1 [2132/2132]: Command subsystem initialized (in cmd_init() at
> cmd.c:2146)
>     DEBUG1 [2132/2132]: Pid 2132 written in file
> /data/lttng/lttng-sessiond.pid (in utils_create_pid_file() at utils.c:237=
)
>     DEBUG1 [2132/2182]: [thread] Manage health check started (in
> thread_manage_health() at main.c:3106)
>     DEBUG1 [2132/2182]: Health check ready (in thread_manage_health() at
> main.c:3148)
>     DEBUG1 [2132/2185]: [thread] Manage application registration started
> (in thread_registration_apps() at main.c:1542)
>     DEBUG1 [2132/2185]: Notifying applications of session daemon state: 1
> (in notify_ust_apps() at main.c:507)
>     DEBUG1 [2132/2185]: Got the wait shm fd 21 (in get_wait_shm() at
> shm.c:122)
>     DEBUG1 [2132/2185]: Futex wait update active 1 (in futex_wait_update(=
)
> at futex.c:63)
>     DEBUG1 [2132/2185]: Accepting application registration (in
> thread_registration_apps() at main.c:1579)
>     DEBUG1 [2132/2183]: [thread] Manage client started (in
> thread_manage_clients() at main.c:3303)
>     DEBUG1 [2132/2183]: Accepting client command ... (in
> thread_manage_clients() at main.c:3349)
>     DEBUG1 [2132/2186]: [thread] Manage application started (in
> thread_manage_apps() at main.c:1152)
>     DEBUG1 [2132/2186]: Apps thread polling on 2 fds (in
> thread_manage_apps() at main.c:1182)
>     DEBUG1 [2132/2188]: [thread] Thread manage kernel started (in
> thread_manage_kernel() at main.c:702)
>     DEBUG1 [2132/2188]: Updating kernel poll set (in update_kernel_poll()
> at main.c:568)
>     DEBUG1 [2132/2188]: Thread kernel polling on 2 fds (in
> thread_manage_kernel() at main.c:747)
>     DEBUG1 [2132/2184]: [thread] Dispatch UST command started (in
> thread_dispatch_ust_registration() at main.c:1352)
>     DEBUG1 [2132/2184]: Futex n to 1 prepare done (in futex_nto1_prepare(=
)
> at futex.c:75)
>     DEBUG1 [2132/2184]: Woken up but nothing in the UST command queue (in
> thread_dispatch_ust_registration() at main.c:1365)

--047d7bdca4cee1099e04e1f6be3a
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I=92m trying to use LTTn=
g on Android 4.0.4 with Linux kernel version of 3.0.15.</div><div>I cross-c=
ompiled the LTTng modules and tools on my Ubuntu 12.04 machine.</div><div><=
br>



</div><div>First I installed all the LTTng modules using <i>insmod</i>, bec=
ause there is no <i>modprobe</i> in Android. It worked fine.=A0</div><div>H=
owever, when I tried to run <i>lttng</i>, it failed due to &quot;No session=
 daemon is available&quot; error. I tried to run<i> lttng-sessiond</i>, the=
n it just kept hanging and cannot finish.=A0<br>


</div>
<div>Even I kept <i>lttng-sessiond</i>=A0hanging in a new terminal session =
and ran <i>lttng</i> in a separate terminal, it gave the same error.<br></d=
iv><div><br></div><div>I&#39;m posting the log below.</div><div><br></div>



<div>Any help would be greatly appreciated!</div><div><br></div><div>Thanks=
,</div><div>Cao</div><div><br></div><div><b>root@android:/data/lttng/bin # =
./lttng -vvv list -k</b></div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-col=
or:rgb(204,204,204);border-left-style:solid;padding-left:1ex">



=A0 =A0 DEBUG1 [2016/2016]: Session daemon at: /data/lttng/bin/lttng-sessio=
nd (in check_sessiond() at lttng.c:381)<br>=A0 =A0 Spawning a session daemo=
n<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to load=
 module lttng-tracer<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe:=
 not found<br>=A0 =A0 Error: Unable to load module lttng-lib-ring-buffer<br=
>=A0 =A0 sh: /sbin/modprobe: not found<br>



=A0 =A0 Error: Unable to load module lttng-ring-buffer-client-discard<br>=
=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to load modu=
le lttng-ring-buffer-client-overwrite<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 Error: Unable to load module lttng-ring-buffer-metadata-clie=
nt<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to load modu=
le lttng-ring-buffer-client-mmap-discard<br>=A0 =A0 sh: /sbin/modprobe: not=
 found<br>=A0 =A0 Error: Unable to load module lttng-ring-buffer-client-mma=
p-overwrite<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to load modu=
le lttng-ring-buffer-metadata-mmap-client<br>=A0 =A0 sh: /sbin/modprobe: no=
t found<br>=A0 =A0 Error: Unable to load module lttng-probe-lttng<br>=A0 =
=A0 sh: /sbin/modprobe: not found<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe:=
 not found<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/mo=
dprobe: not found<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe:=
 not found<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/mo=
dprobe: not found<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe:=
 not found<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/mo=
dprobe: not found<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe:=
 not found<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/mo=
dprobe: not found<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe:=
 not found<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/mo=
dprobe: not found<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe: not fo=
und<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 sh: /sbin/modprobe:=
 not found<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Warning: No =
tracing group detected<br>



=A0 =A0 DEBUG1 [2016/2016]: SIGUSR1 caught (in sighandler() at lttng.c:204)=
<br>=A0 =A0 DEBUG2 [2016/2016]: Session name: (null) (in cmd_list() at comm=
ands/list.c:743)<br>=A0 =A0 DEBUG1 [2016/2016]: Getting kernel tracing even=
ts (in list_kernel_events() at commands/list.c:433)<br>



=A0 =A0 Error: Unable to list kernel events: No session daemon is available=
<br>=A0 =A0 Error: Command error<br>=A0 =A0 DEBUG1 [2016/2016]: Clean exit =
(in clean_exit() at lttng.c:175)</blockquote><div><br></div><div><br></div>=
<div><b>root@android:/data/lttng/bin # ./lttng-sessiond -vvv</b></div>



<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><br>=A0 =A0 DEBUG3 [2132/2132]: Creating LTTng run directo=
ry: /data/lttng (in create_lttng_rundir() at main.c:3853)<br>



=A0 =A0 DEBUG2 [2132/2132]: Kernel consumer err path: /data/lttng/kconsumer=
d/error (in main() at main.c:4140)<br>=A0 =A0 DEBUG2 [2132/2132]: Kernel co=
nsumer cmd path: /data/lttng/kconsumerd/command (in main() at main.c:4142)<=
br>


=A0 =A0 DEBUG1 [2132/2132]: Client socket path /data/lttng/client-lttng-ses=
siond (in main() at main.c:4195)<br>
=A0 =A0 DEBUG1 [2132/2132]: Application socket path /data/lttng/lttng-ust-s=
ock-4 (in main() at main.c:4196)<br>=A0 =A0 DEBUG1 [2132/2132]: Application=
 wait path /lttng-ust-wait-4 (in main() at main.c:4197)<br>=A0 =A0 DEBUG1 [=
2132/2132]: LTTng run directory path: /data/lttng (in main() at main.c:4198=
)<br>



=A0 =A0 DEBUG2 [2132/2132]: UST consumer 32 bits err path: /data/lttng/ustc=
onsumerd32/error (in main() at main.c:4207)<br>=A0 =A0 DEBUG2 [2132/2132]: =
UST consumer 32 bits cmd path: /data/lttng/ustconsumerd32/command (in main(=
) at main.c:4209)<br>



=A0 =A0 DEBUG2 [2132/2132]: UST consumer 64 bits err path: /data/lttng/ustc=
onsumerd64/error (in main() at main.c:4218)<br>=A0 =A0 DEBUG2 [2132/2132]: =
UST consumer 64 bits cmd path: /data/lttng/ustconsumerd64/command (in main(=
) at main.c:4220)<br>



=A0 =A0 DEBUG2 [2132/2132]: Creating consumer directory: /data/lttng/kconsu=
merd (in set_consumer_sockets() at main.c:3895)<br>=A0 =A0 sh: /sbin/modpro=
be: not found<br>=A0 =A0 Error: Unable to load module lttng-tracer<br>=A0 =
=A0 DEBUG2 [2132/2132]: Kernel tracer version validated (major version 2) (=
in kernel_validate_version() at kernel.c:688)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-ftrace (in modprobe_lttng_data() at modprobe.c:227)<b=
r>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modp=
robe successfully lttng-kprobes (in modprobe_lttng_data() at modprobe.c:227=
)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-kretprobes (in modprobe_lttng_data() at modprobe.c:22=
7)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to loa=
d module lttng-lib-ring-buffer<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to load modu=
le lttng-ring-buffer-client-discard<br>=A0 =A0 sh: /sbin/modprobe: not foun=
d<br>=A0 =A0 Error: Unable to load module lttng-ring-buffer-client-overwrit=
e<br>=A0 =A0 sh: /sbin/modprobe: not found<br>



=A0 =A0 Error: Unable to load module lttng-ring-buffer-metadata-client<br>=
=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to load modu=
le lttng-ring-buffer-client-mmap-discard<br>=A0 =A0 sh: /sbin/modprobe: not=
 found<br>=A0 =A0 Error: Unable to load module lttng-ring-buffer-client-mma=
p-overwrite<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 Error: Unable to load modu=
le lttng-ring-buffer-metadata-mmap-client<br>=A0 =A0 sh: /sbin/modprobe: no=
t found<br>=A0 =A0 Error: Unable to load module lttng-probe-lttng<br>=A0 =
=A0 sh: /sbin/modprobe: not found<br>



=A0 =A0 DEBUG1 [2132/2132]: Modprobe successfully lttng-types (in modprobe_=
lttng_data() at modprobe.c:227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br=
>=A0 =A0 DEBUG1 [2132/2132]: Modprobe successfully lttng-probe-asoc (in mod=
probe_lttng_data() at modprobe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-block (in modprobe_lttng_data() at modprobe.c:2=
27)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]:=
 Modprobe successfully lttng-probe-btrfs (in modprobe_lttng_data() at modpr=
obe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-compaction (in modprobe_lttng_data() at modprob=
e.c:227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2=
132]: Modprobe successfully lttng-probe-ext3 (in modprobe_lttng_data() at m=
odprobe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-ext4 (in modprobe_lttng_data() at modprobe.c:22=
7)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: =
Modprobe successfully lttng-probe-gpio (in modprobe_lttng_data() at modprob=
e.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-irq (in modprobe_lttng_data() at modprobe.c:227=
)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: M=
odprobe successfully lttng-probe-jbd (in modprobe_lttng_data() at modprobe.=
c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-jbd2 (in modprobe_lttng_data() at modprobe.c:22=
7)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: =
Modprobe successfully lttng-probe-kmem (in modprobe_lttng_data() at modprob=
e.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-kvm (in modprobe_lttng_data() at modprobe.c:227=
)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: M=
odprobe successfully lttng-probe-lock (in modprobe_lttng_data() at modprobe=
.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-module (in modprobe_lttng_data() at modprobe.c:=
227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]=
: Modprobe successfully lttng-probe-napi (in modprobe_lttng_data() at modpr=
obe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-net (in modprobe_lttng_data() at modprobe.c:227=
)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: M=
odprobe successfully lttng-probe-power (in modprobe_lttng_data() at modprob=
e.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-printk (in modprobe_lttng_data() at modprobe.c:=
227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]=
: Modprobe successfully lttng-probe-random (in modprobe_lttng_data() at mod=
probe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-rcu (in modprobe_lttng_data() at modprobe.c:227=
)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: M=
odprobe successfully lttng-probe-regmap (in modprobe_lttng_data() at modpro=
be.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-regulator (in modprobe_lttng_data() at modprobe=
.c:227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/21=
32]: Modprobe successfully lttng-probe-rpm (in modprobe_lttng_data() at mod=
probe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-sched (in modprobe_lttng_data() at modprobe.c:2=
27)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]:=
 Modprobe successfully lttng-probe-scsi (in modprobe_lttng_data() at modpro=
be.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-signal (in modprobe_lttng_data() at modprobe.c:=
227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]=
: Modprobe successfully lttng-probe-skb (in modprobe_lttng_data() at modpro=
be.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-sock (in modprobe_lttng_data() at modprobe.c:22=
7)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: =
Modprobe successfully lttng-probe-statedump (in modprobe_lttng_data() at mo=
dprobe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-sunrpc (in modprobe_lttng_data() at modprobe.c:=
227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]=
: Modprobe successfully lttng-probe-timer (in modprobe_lttng_data() at modp=
robe.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-udp (in modprobe_lttng_data() at modprobe.c:227=
)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: M=
odprobe successfully lttng-probe-vmscan (in modprobe_lttng_data() at modpro=
be.c:227)<br>



=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/2132]: Modpro=
be successfully lttng-probe-workqueue (in modprobe_lttng_data() at modprobe=
.c:227)<br>=A0 =A0 sh: /sbin/modprobe: not found<br>=A0 =A0 DEBUG1 [2132/21=
32]: Modprobe successfully lttng-probe-writeback (in modprobe_lttng_data() =
at modprobe.c:227)<br>



=A0 =A0 DEBUG1 [2132/2132]: Kernel tracer fd 6 (in init_kernel_tracer() at =
main.c:2139)<br>=A0 =A0 DEBUG2 [2132/2132]: Creating consumer directory: /d=
ata/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:3895)<br>=A0 =
=A0 DEBUG2 [2132/2132]: Creating consumer directory: /data/lttng/ustconsume=
rd32 (in set_consumer_sockets() at main.c:3895)<br>



=A0 =A0 DEBUG1 [2132/2132]: Signal handler set for SIGTERM, SIGPIPE and SIG=
INT (in set_signal_handler() at main.c:3987)<br>=A0 =A0 DEBUG3 [2132/2132]:=
 Session daemon client socket 10 and application socket 11 created (in init=
_daemon_socket() at main.c:3757)<br>



=A0 =A0 Warning: No tracing group detected<br>=A0 =A0 DEBUG3 [2132/2132]: C=
reated hashtable size 4 at 0x1250208 of type 2 (in lttng_ht_new() at hashta=
ble.c:112)<br>=A0 =A0 DEBUG3 [2132/2132]: Global buffer per UID registry in=
itialized (in buffer_reg_init_uid_registry() at buffer-registry.c:98)<br>



=A0 =A0 DEBUG3 [2132/2132]: Created hashtable size 4 at 0x1250360 of type 1=
 (in lttng_ht_new() at hashtable.c:112)<br>=A0 =A0 DEBUG3 [2132/2132]: Glob=
al buffer per PID registry initialized (in buffer_reg_init_pid_registry() a=
t buffer-registry.c:219)<br>



=A0 =A0 DEBUG1 [2132/2132]: epoll set max size is 153106 (in compat_epoll_s=
et_max_size() at compat-epoll.c:270)<br>=A0 =A0 DEBUG1 [2132/2132]: Command=
 subsystem initialized (in cmd_init() at cmd.c:2146)<br>=A0 =A0 DEBUG1 [213=
2/2132]: Pid 2132 written in file /data/lttng/lttng-sessiond.pid (in utils_=
create_pid_file() at utils.c:237)<br>



=A0 =A0 DEBUG1 [2132/2182]: [thread] Manage health check started (in thread=
_manage_health() at main.c:3106)<br>=A0 =A0 DEBUG1 [2132/2182]: Health chec=
k ready (in thread_manage_health() at main.c:3148)<br>=A0 =A0 DEBUG1 [2132/=
2185]: [thread] Manage application registration started (in thread_registra=
tion_apps() at main.c:1542)<br>



=A0 =A0 DEBUG1 [2132/2185]: Notifying applications of session daemon state:=
 1 (in notify_ust_apps() at main.c:507)<br>=A0 =A0 DEBUG1 [2132/2185]: Got =
the wait shm fd 21 (in get_wait_shm() at shm.c:122)<br>=A0 =A0 DEBUG1 [2132=
/2185]: Futex wait update active 1 (in futex_wait_update() at futex.c:63)<b=
r>



=A0 =A0 DEBUG1 [2132/2185]: Accepting application registration (in thread_r=
egistration_apps() at main.c:1579)<br>=A0 =A0 DEBUG1 [2132/2183]: [thread] =
Manage client started (in thread_manage_clients() at main.c:3303)<br>=A0 =
=A0 DEBUG1 [2132/2183]: Accepting client command ... (in thread_manage_clie=
nts() at main.c:3349)<br>



=A0 =A0 DEBUG1 [2132/2186]: [thread] Manage application started (in thread_=
manage_apps() at main.c:1152)<br>=A0 =A0 DEBUG1 [2132/2186]: Apps thread po=
lling on 2 fds (in thread_manage_apps() at main.c:1182)<br>=A0 =A0 DEBUG1 [=
2132/2188]: [thread] Thread manage kernel started (in thread_manage_kernel(=
) at main.c:702)<br>



=A0 =A0 DEBUG1 [2132/2188]: Updating kernel poll set (in update_kernel_poll=
() at main.c:568)<br>=A0 =A0 DEBUG1 [2132/2188]: Thread kernel polling on 2=
 fds (in thread_manage_kernel() at main.c:747)<br>=A0 =A0 DEBUG1 [2132/2184=
]: [thread] Dispatch UST command started (in thread_dispatch_ust_registrati=
on() at main.c:1352)<br>



=A0 =A0 DEBUG1 [2132/2184]: Futex n to 1 prepare done (in futex_nto1_prepar=
e() at futex.c:75)<br>=A0 =A0 DEBUG1 [2132/2184]: Woken up but nothing in t=
he UST command queue (in thread_dispatch_ust_registration() at main.c:1365)=
</blockquote>



</div>

--047d7bdca4cee1099e04e1f6be3a--


--===============2021080163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2021080163==--
