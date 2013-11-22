From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: make a trace_event in a modul (driver)
Date: Fri, 22 Nov 2013 11:12:50 -0500
Message-ID: <CA+jJMxtD7TZ6MEf+URHe=SkOhCVT3aD56BhuQdp48EmJvnsyJg__42818.5503268198$1385136854$gmane$org@mail.gmail.com>
References: <527DF369.4020704@gmx.de> <5283B8BD.9020703@gmx.de>
	<528DD70B.8040504@gmx.de>
	<CA+jJMxsybZ4mo1Mp369hhgNSCi-pfNh8VG1F5S2H5DpKL5nSsw@mail.gmail.com>
	<528E37D8.3060606@gmx.de>
	<CA+jJMxt89qdM98hu536heBwk90AQEPwONvpa7s-vqKGQ036euQ@mail.gmail.com>
	<528F37DE.7050204@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VjtLk-0008JW-C6
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 11:13:03 -0500
Received: by mail-qe0-f46.google.com with SMTP id a11so1074658qen.19
	for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2013 08:12:50 -0800 (PST)
In-Reply-To: <528F37DE.7050204@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Klaus Dannecker <klaus.dannecker@gmx.de>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Nov 22, 2013 at 5:54 AM, Klaus Dannecker <klaus.dannecker@gmx.de> w=
rote:
>
> Am 21.11.2013 18:41, schrieb J=E9r=E9mie Galarneau:
>
>> On Thu, Nov 21, 2013 at 11:42 AM, Klaus Dannecker
>> <klaus.dannecker@gmx.de> wrote:
>>>
>>> Am 21.11.2013 16:49, schrieb J=E9r=E9mie Galarneau:
>>>
>>>> On Thu, Nov 21, 2013 at 4:48 AM, Klaus Dannecker
>>>> <klaus.dannecker@gmx.de>
>>>> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Nobody can help me?
>>>>>
>>>>> now i have ubuntu 13.10 installed  in a vmware.
>>>>> but i have the same error!
>>>>>
>>>>> s$ sudo make modules_install
>>>>> make -C /lib/modules/3.11.0-12-generic/build
>>>>> M=3D/home/klaus/lttng_src/lttng-modules modules_install
>>>>> make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
>>>>>     INSTALL
>>>>> /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer.ko
>>>>>
>>>>> Can't read private key
>>>>
>>>> Ubuntu now ships with module signing enabled by default.
>>>> Does the installation fail, or is it just a warning?
>>>
>>> i don't know
>>>
>>>>> ....
>>>>> lsmod | grep lttng
>>>>> -> no module found
>>>>>
>>>> The modules will not be automatically loaded after being built and
>>>> installed. You have to launch lttng-sessiond (as root) for that. What
>>>> is the output of the following commands?
>>>>
>>>> make
>>>> sudo make modules_install
>>>> sudo depmod -a
>>>> sudo lttng-sessiond &
>>>> lsmod | grep lttng
>>>
>>> klaus@ubuntu:~/lttng_src/lttng-modules$ make
>>> make -C /lib/modules/3.11.0-12-generic/build
>>> M=3D/home/klaus/lttng_src/lttng-modules modules
>>>
>>> make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
>>> /home/klaus/lttng_src/lttng-modules/probes/Makefile:30: File
>>> /usr/src/linux-headers-3.11.0-12-generic/virt/kvm/iodev.h not found.
>>> Probe
>>> "kvm" x86-specific is disabled. Use full kernel source tree to enable i=
t.
>>> /home/klaus/lttng_src/lttng-modules/probes/Makefile:81: Files
>>> /usr/src/linux-headers-3.11.0-12-generic/fs/ext3/*.h not found. Probe
>>> "ext3"
>>> is disabled. Use full kernel source tree to enable it.
>>> /home/klaus/lttng_src/lttng-modules/probes/Makefile:142: Files
>>> /usr/src/linux-headers-3.11.0-12-generic/fs/btrfs/*.h not found. Probe
>>> "btrfs" is disabled. Use full kernel source tree to enable it.
>>> /home/klaus/lttng_src/lttng-modules/probes/Makefile:158: Files
>>> /usr/src/linux-headers-3.11.0-12-generic/fs/ext4/*.h not found. Probe
>>> "ext4"
>>> is disabled. Use full kernel source tree to enable it.
>>>    Building modules, stage 2.
>>>    MODPOST 44 modules
>>> make[1]: Leaving directory `/usr/src/linux-headers-3.11.0-12-generic'
>>>
>>> klaus@ubuntu:~/lttng_src/lttng-modules$ sudo make modules_install
>>>
>>> make -C /lib/modules/3.11.0-12-generic/build
>>> M=3D/home/klaus/lttng_src/lttng-modules modules_install
>>> make[1]: Entering directory `/usr/src/linux-headers-3.11.0-12-generic'
>>>    INSTALL
>>> /home/klaus/lttng_src/lttng-modules/lib/lttng-lib-ring-buffer.ko
>>> Can't read private key
>>>    INSTALL
>>> /home/klaus/lttng_src/lttng-modules/lttng-ring-buffer-client-discard.ko
>>>
>>> Can't read private key
>>> ...
>>>    DEPMOD  3.11.0-12-generic
>>> make[1]: Leaving directory `/usr/src/linux-headers-3.11.0-12-generic'
>>> klaus@ubuntu:~/lttng_src/lttng-modules$
>>>
>>> klaus@ubuntu:~/lttng_src/lttng-modules$ sudo depmod -a
>>> klaus@ubuntu:~/lttng_src/lttng-modules$
>>> klaus@ubuntu:~/lttng_src/lttng-modules$ sudo lttng-sessiond &
>>> [1] 23486
>>> klaus@ubuntu:~/lttng_src/lttng-modules$ lsmod | grep lttng
>>>
>>> [1]+  Stopped                 sudo lttng-sessiond
>>> klaus@ubuntu:~/lttng_src/lttng-modules$
>>>
>> Hard to say why lttng-sessiond received SIGSTOP...
>>
>> Could you try running the session daemon in verbose mode in another
>> terminal?
>> sudo lttng-sessiond -vvv
>
> klaus@ubuntu:~$ sudo lttng-sessiond -vvv
> [sudo] password for klaus:
> DEBUG3 [23710/23710]: Creating LTTng run directory: /var/run/lttng (in
> create_lttng_rundir() at main.c:4267)
> DEBUG2 [23710/23710]: Kernel consumer err path:
> /var/run/lttng/kconsumerd/error (in main() at main.c:4696)
> DEBUG2 [23710/23710]: Kernel consumer cmd path:
> /var/run/lttng/kconsumerd/command (in main() at main.c:4698)
> DEBUG1 [23710/23710]: Client socket path
> /var/run/lttng/client-lttng-sessiond (in main() at main.c:4751)
> DEBUG1 [23710/23710]: Application socket path
> /var/run/lttng/lttng-ust-sock-5 (in main() at main.c:4752)
> DEBUG1 [23710/23710]: Application wait path /lttng-ust-wait-5 (in main() =
at
> main.c:4753)
> DEBUG1 [23710/23710]: LTTng run directory path: /var/run/lttng (in main()=
 at
> main.c:4754)
> DEBUG2 [23710/23710]: UST consumer 32 bits err path:
> /var/run/lttng/ustconsumerd32/error (in main() at main.c:4763)
> DEBUG2 [23710/23710]: UST consumer 32 bits cmd path:
> /var/run/lttng/ustconsumerd32/command (in main() at main.c:4765)
> DEBUG2 [23710/23710]: UST consumer 64 bits err path:
> /var/run/lttng/ustconsumerd64/error (in main() at main.c:4774)
> DEBUG2 [23710/23710]: UST consumer 64 bits cmd path:
> /var/run/lttng/ustconsumerd64/command (in main() at main.c:4776)
> DEBUG3 [23710/23710]: Created hashtable size 4 at 0x982c080 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [23710/23710]: Created hashtable size 4 at 0x982c270 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [23710/23710]: Created hashtable size 4 at 0x982c498 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [23710/23710]: Created hashtable size 4 at 0x982c6c0 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG2 [23710/23710]: Creating consumer directory: /var/run/lttng/kconsum=
erd
> (in set_consumer_sockets() at main.c:4309)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-tracer (in
> modprobe_lttng_control() at modprobe.c:192)
> DEBUG2 [23710/23710]: Kernel tracer version validated (major version 2) (=
in
> kernel_validate_version() at kernel.c:700)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-ftrace (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-kprobes (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-kretprobes (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-lib-ring-buffer (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-ring-buffer-client-disc=
ard
> (in modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully
> lttng-ring-buffer-client-overwrite (in modprobe_lttng_data() at
> modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully
> lttng-ring-buffer-metadata-client (in modprobe_lttng_data() at
> modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully
> lttng-ring-buffer-client-mmap-discard (in modprobe_lttng_data() at
> modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully
> lttng-ring-buffer-client-mmap-overwrite (in modprobe_lttng_data() at
> modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully
> lttng-ring-buffer-metadata-mmap-client (in modprobe_lttng_data() at
> modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-types (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-asoc (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-block (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-btrfs (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-compaction (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-ext3 (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-ext4 (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-gpio (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-irq (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-jbd (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-jbd2 (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-kmem (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-kvm (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-kvm-x86 (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-kvm-x86-mmu (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-lock (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-module (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-napi (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-net (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-power (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-printk (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-random (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-rcu (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-regmap (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-regulator (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-rpm (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-sched (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-scsi (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-signal (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-skb (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-sock (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-statedump (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-sunrpc (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-timer (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-udp (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-vmscan (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-workqueue (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Modprobe successfully lttng-probe-writeback (in
> modprobe_lttng_data() at modprobe.c:228)
> DEBUG1 [23710/23710]: Kernel tracer fd 6 (in init_kernel_tracer() at
> main.c:2364)
> DEBUG2 [23710/23710]: Creating consumer directory:
> /var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:4309)
> DEBUG2 [23710/23710]: Creating consumer directory:
> /var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4309)
> DEBUG3 [23710/23710]: Session daemon client socket 9 and application sock=
et
> 10 created (in init_daemon_socket() at main.c:4175)
> DEBUG1 [23710/23710]: All permissions are set (in set_permissions() at
> main.c:4255)
> DEBUG3 [23710/23710]: Created hashtable size 4 at 0x982e160 of type 2 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [23710/23710]: Global buffer per UID registry initialized (in
> buffer_reg_init_uid_registry() at buffer-registry.c:99)
> DEBUG3 [23710/23710]: Created hashtable size 4 at 0x982e388 of type 2 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [23710/23710]: Global buffer per PID registry initialized (in
> buffer_reg_init_pid_registry() at buffer-registry.c:220)
> DEBUG1 [23710/23710]: epoll set max size is 327338 (in
> compat_epoll_set_max_size() at compat-epoll.c:280)
> DEBUG1 [23710/23710]: Command subsystem initialized (in cmd_init() at
> cmd.c:3056)
> DEBUG1 [23710/23710]: Pid 23710 written in file
> /var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at
> utils.c:437)
> DEBUG1 [23710/23710]: Pid 5345 written in file /var/run/lttng/jul.port (in
> utils_create_pid_file() at utils.c:437)
> DEBUG1 [23710/23710]: TCP inet operation timeout set to 216 sec (in
> lttcomm_inet_init() at inet.c:529)
> DEBUG1 [23710/23710]: Health check time delta in seconds set to 236 (in
> health_init() at health.c:73)
> DEBUG1 [23710/23820]: [thread] Manage health check started (in
> thread_manage_health() at main.c:3511)
> DEBUG1 [23710/23824]: [thread] Manage application started (in
> thread_manage_apps() at main.c:1256)
> DEBUG1 [23710/23823]: [thread] Manage application registration started (in
> thread_registration_apps() at main.c:1766)
> DEBUG1 [23710/23822]: [thread] Dispatch UST command started (in
> thread_dispatch_ust_registration() at main.c:1543)
> DEBUG1 [23710/23821]: [thread] Manage client started (in
> thread_manage_clients() at main.c:3695)
> DEBUG1 [23710/23821]: Accepting client command ... (in
> thread_manage_clients() at main.c:3747)
> DEBUG1 [23710/23819]: [ht-thread] startup. (in thread_ht_cleanup() at
> ht-cleanup.c:35)
> DEBUG3 [23710/23819]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup=
()
> at ht-cleanup.c:59)
> DEBUG1 [23710/23825]: [ust-thread] Manage application notify command (in
> ust_thread_manage_notify() at ust-thread.c:38)
> DEBUG1 [23710/23826]: [jul-thread] Manage JUL application registration. (=
in
> jul_thread_manage_registration() at jul-thread.c:250)
> DEBUG3 [23710/23826]: URI string: tcp://localhost (in uri_parse() at
> uri.c:291)
> DEBUG1 [23710/23824]: Apps thread polling on 2 fds (in thread_manage_apps=
()
> at main.c:1286)
> DEBUG1 [23710/23822]: Futex n to 1 prepare done (in futex_nto1_prepare() =
at
> futex.c:75)
> DEBUG1 [23710/23823]: Notifying applications of session daemon state: 1 (=
in
> notify_ust_apps() at main.c:593)
> DEBUG3 [23710/23825]: [ust-thread] Manage notify polling on 2 fds (in
> ust_thread_manage_notify() at ust-thread.c:63)
> DEBUG1 [23710/23820]: Health check ready (in thread_manage_health() at
> main.c:3574)
> DEBUG1 [23710/23827]: [thread] Thread manage kernel started (in
> thread_manage_kernel() at main.c:794)
> DEBUG1 [23710/23827]: Updating kernel poll set (in update_kernel_poll() at
> main.c:654)
> DEBUG1 [23710/23827]: Thread kernel polling on 2 fds (in
> thread_manage_kernel() at main.c:839)
> DEBUG1 [23710/23822]: Woken up but nothing in the UST command queue (in
> thread_dispatch_ust_registration() at main.c:1566)
> DEBUG2 [23710/23826]: IP address resolved to 127.0.0.1 (in set_ip_address=
()
> at uri.c:132)
> DEBUG3 [23710/23826]: URI dtype: 1, proto: 1, host: localhost, subdir: ,
> ctrl: 0, data: 0 (in uri_parse() at uri.c:505)
> PERROR [23710/23826]: bind inet: Address already in use (in
> lttcomm_bind_inet_sock() at inet.c:109)
> DEBUG1 [23710/23826]: [jul-thread] is cleaning up and stopping. (in
> jul_thread_manage_registration() at jul-thread.c:356)
> DEBUG3 [23710/23826]: [jul-thread] Cleaning JUL apps ht (in
> clean_jul_apps_ht() at jul-thread.c:100)
> DEBUG1 [23710/23823]: Got the wait shm fd 26 (in get_wait_shm() at
> shm.c:115)
> DEBUG1 [23710/23823]: Futex wait update active 1 (in futex_wait_update() =
at
> futex.c:63)
> DEBUG1 [23710/23823]: Accepting application registration (in
> thread_registration_apps() at main.c:1803)
>
> another terminal:
>
> klaus@ubuntu:~/lttng_src/lttng-modules$ lsmod | grep lttng
> lttng_probe_writeback    22927  0
> lttng_probe_workqueue    13726  0
> lttng_probe_vmscan     17138  0
> ....
>
> but:
> klaus@ubuntu:~/lttng_src/lttng-modules$ lttng list -k
> Error: Unable to list kernel events: Tracing the kernel requires a root
> lttng-sessiond daemon, as well as "tracing" group membership or root user=
 ID
> for the lttng client.
> Error: Command error
> klaus@ubuntu:~/lttng_src/lttng-modules$
>
> then stop the command sudo lttng-sessiond -vvv with "STRG+C"
> ^CDEBUG1 [23710/23710]: SIGINT caught (in sighandler() at main.c:4374)
> DEBUG1 [23710/23710]: Terminating all threads (in stop_threads() at
> main.c:370)
> DEBUG1 [23710/23710]: Futex n to 1 wake done (in futex_nto1_wake() at
> futex.c:104)
> DEBUG1 [23710/23821]: Clean command context structure (in
> clean_command_ctx() at main.c:573)
> ...
>
> klaus@ubuntu:~/lttng_src/lttng-modules$ lsmod | grep lttng
> klaus@ubuntu:~/lttng_src/lttng-modules$
>

Everything looks fine to me.

The modules are loaded and unloaded automatically by the session
daemon when it is launched and stopped, respectively.

If you want to trace the kernel or list the kernel events, you will
have to launch a root session daemon (sudo lttng-sessiond -d) and then
create a tracing session either as root or as a member of the
"tracing" group.

Regards,
J=E9r=E9mie

> Regards,
> Klaus
>
>
>
>
>> This should load the modules or at least log an error if it fails to do
>> so.
>>
>>> Thanks for your help!
>>>
>>> Regards,
>>> Klaus
>>>
>>>> Regards,
>>>> J=E9r=E9mie
>>>>
>>>>> Thanks!
>>>>>
>>>>> Am 13.11.2013 18:37, schrieb Klaus Dannecker:
>>>>>
>>>>>
>>>>> Am 09.11.2013 09:33, schrieb Klaus Dannecker:
>>>>>
>>>>> Hi,
>>>>> I want to write a driver with trace events.
>>>>> In the first step i compile the example  trace-events-sample.c with t=
he
>>>>> makefile:
>>>>>
>>>>> ifneq ($(KERNELRELEASE),)
>>>>>       obj-m  :=3D modul_trace-events-sample.o
>>>>>       modul_trace-events-sample-y :=3D trace-events-sample.o
>>>>>       ccflags-y :=3D -I$(src)
>>>>> else
>>>>>       KDIR ?=3D /lib/modules/`uname -r`/build
>>>>> default:
>>>>>       $(MAKE) -C $(KDIR) M=3D$$PWD
>>>>> endif
>>>>>
>>>>> now i get the modul_trace-events-sample.ko File.
>>>>> now:
>>>>> insmod modul_trace-events-sample.ko
>>>>> lttng create
>>>>> lttng enable-event -k -a
>>>>> lttng start
>>>>> ...wait...
>>>>> lttng stop
>>>>> lttng destroy
>>>>>
>>>>> now i look the result in the eclise viewer, but i found event
>>>>> "trace_foo_bar" not in the session!
>>>>> what am I doing wrong?
>>>>>
>>>>> I use ubuntu 13.04 in a vmware
>>>>>
>>>>> Thanks
>>>>>
>>>>> _______________________________________________
>>>>>
>>>>> Hi,
>>>>>
>>>>> now i found a answer:
>>>>> http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
>>>>> now i download the lttng-module and compiled it.
>>>>>
>>>>> $ git clone git://git.lttng.org/lttng-modules.git
>>>>> $ cd lttng-tools
>>>>> $ make
>>>>> $ sudo make modules_install
>>>>> here I get error
>>>>> INSTALL
>>>>> /mnt/hgfs/shared_Folder/lttng-modules/lib/lttng-lib-ring-buffer.ko
>>>>> Can't read private key
>>>>> ...
>>>>> what does that mean?
>>>>> what should I do?
>>>>>
>>>>> please help me!
>>>>>
>>>>> another question:
>>>>> when i create a trace events in module_a,
>>>>> can i use it in module_b?
>>>>> if yes, what should I do?
>>>>>
>>>>> thanks Klaus
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>>
>>
>>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
