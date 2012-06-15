From: David Goulet <dgoulet@efficios.com>
Subject: Re: Empty traces for UST
Date: Fri, 15 Jun 2012 10:57:31 -0400
Message-ID: <4FDB4D5B.6050701__882.065916857933$1339772284$gmane$org@efficios.com>
References: <47D610AD9C485E458630BA38C324D3B60113FB00FBB0@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SfXxw-0001OM-R4
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 10:57:37 -0400
In-Reply-To: <47D610AD9C485E458630BA38C324D3B60113FB00FBB0@EXGMBX01.sasken.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Pavan Anumula <pavan.anumula@sasken.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Pavan,

Glad for the kernel! :)

For UST, I'll recommend you start a session daemon like so "lttng-sessiond
- -vvv". After that, use the lttng-ust/tests/hello program and execute it. You
should see on the debug output of the session daemon that the application
"hello" has registered and is ready for tracing.

Your output below does NOT show those debug messages so it would be a good
start to see if there is a problem at that point. Also, make sure that the
liblttng-ust is installed upon compiling lttng-tools so that the user space
tracer support is enabled in the tools.

Thanks!
David

On 15/06/12 10:50 AM, Pavan Anumula wrote:
> Hi David,
> 
> Finally I was able to get kernel traces by referring to one of your other
> posts , Actually lttng-consumerd  binary was actually not present at the
> needed path, Thanks for your help.
> 
> And sorry for bugging  you with mails :) .
> 
> 
> But this time I am facing issues at UST tracing . Please kindly help me on
> this.
> 
> When I try to trace for User space it is creating an empty folder with no
> traces on ARM target, I tried with all the sample trace programs in
> LTTng-UST/tests folder.
> 
> I am using NFS to load binaries and for tracing will that causes problem.
> Please also find the debug logs attached,
> 
> Please also let me know if you want some more information.
> 
> 
> ************************************** fcntl64(12, F_SETFD, FD_CLOEXEC)
> = 0 fcntl64(13, F_SETFD, FD_CLOEXEC)        = 0 pipe([14, 15])
> = 0 fcntl64(14, F_SETFD, FD_CLOEXEC)        = 0 fcntl64(15, F_SETFD,
> FD_CLOEXEC)        = 0 getrlimit(RLIMIT_NOFILE, {rlim_cur=65535,
> rlim_max=65535}) = 0 write(2, "DEBUG1: poll set max size set to"...,
> 92DEBUG1: poll set max size set to 65535 [in compat_poll_set_max_size() at
> compat-poll.c:196] ) = 92 mmap2(NULL, 8388608, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4024b000 mprotect(0x4024b000, 4096,
> PROT_NONE)   = 0 clone(child_stack=0x40a49ef8,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0x40a4a3e8, tls=0x40a4a840, child_tidptr=0x40a4a3e8) = 921 
> mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x40a4b000 mprotect(0x40a4b000, 4096, PROT_NONE)   = 0 
> clone(child_stack=0x41249ef8,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0x4124a3e8, tls=0x4124a840, child_tidptr=0x4124a3e8) = 922 
> mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x4124b000 mprotect(0x4124b000, 4096, PROT_NONE)   = 0 
> clone(child_stack=0x41a49ef8,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0x41a4a3e8, tls=0x41a4a840, child_tidptr=0x41a4a3e8) = 923 
> mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x41a4b000 mprotect(0x41a4b000, 4096, PROT_NONE)   = 0 clone(DEBUG1:
> [thread] Dispatch UST command started [in
> thread_dispatch_ust_registration() at main.c:1324] DEBUG1: Futex n to 1
> prepare done [in futex_nto1_prepare() at futex.c:73] DEBUG1: Woken up but
> nothing in the UST command queue [in thread_dispatch_ust_registration() at
> main.c:1334] DEBUG1: [thread] Manage application registration started [in
> thread_registration_apps() at main.c:1392] DEBUG1: fd 3 of 1 added to
> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 11 of 2 added
> to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: Notifying
> applications of session daemon state: 1 [in notify_ust_apps() at
> main.c:687] DEBUG1: Got the wait shm fd 16 [in get_wait_shm() at
> shm.c:117] DEBUG1: Futex wait update active 1 [in futex_wait_update() at
> futex.c:62] DEBUG1: Accepting application registration [in
> thread_registration_apps() at main.c:1423] DEBUG1: [thread] Manage
> application started [in thread_manage_apps() at main.c:1179] DEBUG1: fd 3
> of 1 added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd
> 14 of 2 added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
> Apps thread polling on 2 fds [in thread_manage_apps() at main.c:1200] 
> DEBUG1: [thread] Manage client started [in thread_manage_clients() at
> main.c:3794] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add() at
> compat-poll.c:91] DEBUG1: fd 10 of 2 added to pollfd [in compat_poll_add()
> at compat-poll.c:91] DEBUG1: Accepting client command ... [in
> thread_manage_clients() at main.c:3826] child_stack=0x42249ef8,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0x4224a3e8, tls=0x4224a840, child_tidptr=0x4224a3e8) = 924 
> mmap2(NULL, 8388608, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0x4224b000 mprotect(0x4224b000, 4096, PROT_NONE)   = 0 
> clone(child_stack=0x42a49ef8,
> flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
> parent_tidptr=0x42a4a3e8, tls=0x42a4a840, child_tidptr=0x42a4a3e8) = 925 
> futex(0x42a4a3e8, FUTEX_WAIT, 925, NULLDEBUG1: Thread manage kernel started
> [in thread_manage_kernel() at main.c:876] DEBUG1: fd 3 of 1 added to pollfd
> [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 12 of 2 added to
> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: Updating kernel
> poll set [in update_kernel_poll() at main.c:748] DEBUG1: Thread kernel
> polling on 2 fds [in thread_manage_kernel() at main.c:905] DEBUG1: Wait for
> client response [in thread_manage_clients() at main.c:3863] DEBUG1:
> Receiving data from client ... [in thread_manage_clients() at main.c:3898] 
> DEBUG1: Nothing recv() from client... continuing [in
> thread_manage_clients() at main.c:3902] DEBUG1: Clean command context
> structure [in clean_command_ctx() at main.c:534] DEBUG1: Accepting client
> command ... [in thread_manage_clients() at main.c:3826] DEBUG1: Wait for
> client response [in thread_manage_clients() at main.c:3863] DEBUG1:
> Receiving data from client ... [in thread_manage_clients() at main.c:3898] 
> DEBUG1: Processing client command 8 [in process_client_msg() at
> main.c:3309] DEBUG2: Trying to find session by name sesCCC [in
> session_find_by_name() at session.c:126] DEBUG3: mkdir() recursive
> /home/root/lttng-traces/sesCCC-20110327-045731 with mode 504 for uid 0 and
> gid 0 [in run_as_mkdir_recursive() at runas.c:338] DEBUG1: Using
> run_as_clone [in run_as() at runas.c:322] DEBUG1: Tracing session sesCCC
> created in /home/root/lttng-traces/sesCCC-20110327-045731 with ID 1 by UID
> 0 GID 0 [in session_create() at session.c:234] DEBUG1: Sending response
> (size: 16, retcode: Success) [in thread_manage_clients() at main.c:3936] 
> DEBUG1: Clean command context structure [in clean_command_ctx() at
> main.c:534] DEBUG1: Accepting client command ... [in
> thread_manage_clients() at main.c:3826] DEBUG1: Wait for client response
> [in thread_manage_clients() at main.c:3863] DEBUG1: Receiving data from
> client ... [in thread_manage_clients() at main.c:3898] DEBUG1: Nothing
> recv() from client... continuing [in thread_manage_clients() at
> main.c:3902] DEBUG1: Clean command context structure [in
> clean_command_ctx() at main.c:534] DEBUG1: Accepting client command ... [in
> thread_manage_clients() at main.c:3826] DEBUG1: Wait for client response
> [in thread_manage_clients() at main.c:3863] DEBUG1: Receiving data from
> client ... [in thread_manage_clients() at main.c:3898] DEBUG1: Processing
> client command 6 [in process_client_msg() at main.c:3309] DEBUG1: Getting
> session sesCCC by name [in process_client_msg() at main.c:3364] DEBUG2:
> Trying to find session by name sesCCC [in session_find_by_name() at
> session.c:126] DEBUG1: Creating UST session [in create_ust_session() at
> main.c:1965] DEBUG3: Created hashtable size 4 at 0x4fa08 of type 1 [in
> lttng_ht_new() at hashtable.c:96] DEBUG3: Created hashtable size 4 at
> 0x4fb28 of type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG3: Created
> hashtable size 4 at 0x4fc48 of type 0 [in lttng_ht_new() at
> hashtable.c:96] DEBUG2: UST trace session create successful [in
> trace_ust_create_session() at trace-ust.c:119] DEBUG3: mkdir() recursive
> /home/root/lttng-traces/sesCCC-20110327-045731/ust with mode 504 for uid 0
> and gid 0 [in run_as_mkdir_recursive() at runas.c:338] DEBUG1: Using
> run_as_clone [in run_as() at runas.c:322] DEBUG1: Spawning consumerd [in
> spawn_consumerd() at main.c:1659] DEBUG1: Using 32-bit UST consumer at:
> /root/armfilesystem/lib/lttng/libexec/lttng-consumerd [in spawn_consumerd()
> at main.c:1777] DEBUG2: Consumer pid 934 [in start_consumerd() at
> main.c:1830] DEBUG2: Spawning consumer control thread [in start_consumerd()
> at main.c:1833] DEBUG1: [thread] Manage consumer started [in
> thread_manage_consumer() at main.c:982] DEBUG1: fd 3 of 1 added to pollfd
> [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 9 of 2 added to
> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG2: Receiving code
> from consumer err_sock [in thread_manage_consumer() at main.c:1043] DEBUG1:
> consumer command socket ready [in thread_manage_consumer() at main.c:1062] 
> DEBUG1: fd 17 of 2 added to pollfd [in compat_poll_add() at
> compat-poll.c:91] DEBUG2: Trace UST channel channel0 not found by name [in
> trace_ust_find_channel_by_name() at trace-ust.c:52] DEBUG3: Created
> hashtable size 4 at 0x51310 of type 0 [in lttng_ht_new() at
> hashtable.c:96] DEBUG3: Created hashtable size 4 at 0x51430 of type 1 [in
> lttng_ht_new() at hashtable.c:96] DEBUG2: Trace UST channel channel0
> created [in trace_ust_create_channel() at trace-ust.c:181] DEBUG2: Channel
> channel0 being created in UST global domain [in channel_ust_create() at
> channel.c:267] DEBUG2: UST app adding channel channel0 to global domain for
> session id 1 [in ust_app_create_channel_glb() at ust-app.c:1792] DEBUG2:
> Channel channel0 created successfully [in channel_ust_create() at
> channel.c:292] DEBUG2: Trace UST channel channel0 found by name [in
> trace_ust_find_channel_by_name() at trace-ust.c:47] DEBUG2: Trace UST event
> NOT found by name * [in trace_ust_find_event_by_name() at trace-ust.c:79] 
> DEBUG3: Created hashtable size 4 at 0x51550 of type 1 [in lttng_ht_new() at
> hashtable.c:96] DEBUG2: Trace UST event *, loglevel (0,-1) created [in
> trace_ust_create_event() at trace-ust.c:260] DEBUG1: UST app creating event
> * for all apps for session id 1 [in ust_app_create_event_glb() at
> ust-app.c:1916] DEBUG1: Event UST * created in channel channel0 [in
> event_ust_enable_tracepoint() at event.c:446] DEBUG1: Sending response
> (size: 16, retcode: Success) [in thread_manage_clients() at main.c:3936] 
> DEBUG1: Clean command context structure [in clean_command_ctx() at
> main.c:534] DEBUG1: Accepting client command ... [in
> thread_manage_clients() at main.c:3826] DEBUG1: Wait for client response
> [in thread_manage_clients() at main.c:3863] DEBUG1: Receiving data from
> client ... [in thread_manage_clients() at main.c:3898] DEBUG1: Nothing
> recv() from client... continuing [in thread_manage_clients() at
> main.c:3902] DEBUG1: Clean command context structure [in
> clean_command_ctx() at main.c:534] DEBUG1: Accepting client command ... [in
> thread_manage_clients() at main.c:3826] DEBUG1: Wait for client response
> [in thread_manage_clients() at main.c:3863] DEBUG1: Receiving data from
> client ... [in thread_manage_clients() at main.c:3898] DEBUG1: Processing
> client command 16 [in process_client_msg() at main.c:3309] DEBUG1: Getting
> session sesCCC by name [in process_client_msg() at main.c:3364] DEBUG2:
> Trying to find session by name sesCCC [in session_find_by_name() at
> session.c:126] DEBUG1: Starting all UST traces [in
> ust_app_start_trace_all() at ust-app.c:2207] DEBUG1: Sending response
> (size: 16, retcode: Success) [in thread_manage_clients() at main.c:3936] 
> DEBUG1: Clean command context structure [in clean_command_ctx() at
> main.c:534] DEBUG1: Accepting client command ... [in
> thread_manage_clients() at main.c:3826] 
> ************************************************
> 
> 
> 
> 
> 
> Thanks in Advance, Pavan
> 
> 
> -----Original Message----- From: David Goulet
> [mailto:dgoulet@efficios.com] Sent: Tuesday, June 12, 2012 9:05 PM To:
> Pavan Anumula Cc: lttng-dev@lists.lttng.org Subject: Re: [lttng-dev] Lttng
> start failed
> 
> Hi Pavan,
> 
> The output below is normal and should be working fine. However, the problem
> is that you have _NO_ debug message after the "lttng start". That command
> should at least produce 10+ lines of messages after this last line:
> 
> "DEBUG1: Accepting application registration [in thread_registration_apps()
> at main.c:1423]"
> 
> Can you enlight me and tell me if by doing "lttng create newsessiom" and
> "lttng enable-event -a -k", you have output messages coming out of the
> session daemon in -vvv mode ?
> 
> If NOT, you are talking to another daemon! A quick "ps faux | grep
> lttng-sessiond" could help clear that question.
> 
> If only one daemon is running and stuck at the above debug message, the
> next step is to tell me on what the daemon is waiting on using either
> "strace -p" or "gdb" also. There is 6 threads so having the strace -p
> output for all of them would help me greatly.
> 
> Thanks! David
> 
> On 12/06/12 10:05 AM, Mathieu Desnoyers wrote:
>> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>>> Hi Mathieu, Still I am unable to start tracing, And I am facing the 
>>> same start  errors. Please kindly help me on this. This time I loaded 
>>> the modules by modprobe( not with insmod as I did  before), Then I run
>>> the command  " arm-none-linux-gnueabi-lttng-sessiond  -vvv " (before
>>> arm-none-linux-gnueabi-lttng-sessiond  -d),
> 
>> When using "arm-none-linux-gnueabi-lttng-sessiond  -vvv", you should 
>> _not_ run "arm-none-linux-gnueabi-lttng-sessiond  -d".
> 
> 
>>> The below is the Output, And It got hanged overthere.
> 
>> This is normal: the sessiond is waiting for applications to connect. It
>> does not hang, it just waits.
> 
>> David, can you follow up on this issue ? It seems to be
>> sessiond-related.
> 
>> Thanks,
> 
>> Mathieu
> 
> 
>>> Later when I started lttng start I am acing the same erros below: 
>>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng start LTTng: 
>>> Failure to write metadata to buffers (timeout) Error: Starting kernel 
>>> trace failed
>>> 
>>> ********************************************************************* 
>>> ***************************
>>> 
>>> 
> DEBUG3: Creating LTTng run directory: /var/run/lttng [in
> create_lttng_rundir() at main.c:4315]
>>> DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [in 
>>> main() at main.c:4543] DEBUG2: Kernel consumer cmd path: 
>>> /var/run/lttng/kconsumerd/command [in main() at main.c:4545] DEBUG1: 
>>> Client socket path /var/run/lttng/client-lttng-sessiond [in main() at 
>>> main.c:4592] DEBUG1: Application socket path 
>>> /var/run/lttng/apps-lttng-sessiond [in main() at main.c:4593] DEBUG1: 
>>> LTTng run directory path: /var/run/lttng [in main() at main.c:4594] 
>>> DEBUG2: UST consumer 32 bits err path: 
>>> /var/run/lttng/ustconsumerd32/error [in main() at main.c:4603] DEBUG2: 
>>> UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command 
>>> [in main() at main.c:4605] DEBUG2: UST consumer 64 bits err path: 
>>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614] DEBUG2: 
>>> UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command 
>>> [in main() at main.c:4616] DEBUG3: Created hashtable size 4 at 0x4a080
>>> of type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG3: Created 
>>> hashtable size 4 at 0x4a168 of type 1 [in lttng_ht_new() at
>>> hashtable.c:96] DEBUG2: Creating consumer directory:
>>> /var/run/lttng/kconsumerd [in set_consumer_sockets() at main.c:4357]
>>> DEBUG1: Modprobe successfully lttng-tracer [in modprobe_lttng_control()
>>> at modprobe.c:163] DEBUG2: Kernel tracer version validated (major
>>> version 2) [in kernel_validate_version() at kernel.c:675] DEBUG1:
>>> Modprobe successfully lttng-ftrace [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-kprobes [in
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-kretprobes [in modprobe_lttng_data() at modprobe.c:199] DEBUG1:
>>> Modprobe successfully lttng-lib-ring-buffer [in modprobe_lttng_data()
>>> at modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-ring-buffer-client-discard [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-ring-buffer-client-overwrite [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-ring-buffer-metadata-client [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-ring-buffer-client-mmap-discard [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-ring-buffer-client-mmap-overwrite [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-ring-buffer-metadata-mmap-client [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-lttng [in 
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-types [in modprobe_lttng_data() at modprobe.c:199] DEBUG1:
>>> Modprobe successfully lttng-probe-block [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-irq [in 
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-probe-kvm [in modprobe_lttng_data() at modprobe.c:199] DEBUG1: 
>>> Modprobe successfully lttng-probe-sched [in modprobe_lttng_data() at 
>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-signal [in 
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-probe-statedump [in modprobe_lttng_data() at modprobe.c:199] 
>>> DEBUG1: Modprobe successfully lttng-probe-timer [in 
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Kernel tracer fd 6 [in
>>> init_kernel_tracer() at main.c:1887] DEBUG2: Creating consumer
>>> directory: /var/run/lttng/ustconsumerd64 [in set_consumer_sockets() at 
>>> main.c:4357] DEBUG2: Creating consumer directory:
>>> /var/run/lttng/ustconsumerd32 [in set_consumer_sockets() at
>>> main.c:4357] DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT
>>> [in set_signal_handler() at main.c:4449] DEBUG1: All permissions are
>>> set [in set_permissions() at main.c:4250] DEBUG1: poll set max size set
>>> to 65535 [in compat_poll_set_max_size() at compat-poll.c:196] DEBUG1:
>>> [thread] Manage application started [in thread_manage_apps() at
>>> main.c:1179] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add() at
>>> compat-poll.c:91] DEBUG1: fd 13 of 2 added to pollfd [in
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Apps thread polling on 2
>>> fds [in thread_manage_apps() at main.c:1200] DEBUG1: Thread manage
>>> kernel started [in thread_manage_kernel() at main.c:876] DEBUG1: fd 3
>>> of 1 added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>>> fd 11 of 2 added to pollfd [in compat_poll_add() at compat-poll.c:91]
>>> DEBUG1: Updating kernel poll set [in update_kernel_poll() at
>>> main.c:748] DEBUG1: Thread kernel polling on 2 fds [in
>>> thread_manage_kernel() at main.c:905] DEBUG1: [thread] Manage
>>> application registration started [in thread_registration_apps() at
>>> main.c:1392] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add() at
>>> compat-poll.c:91] DEBUG1: fd 10 of 2 added to pollfd [in 
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Notifying applications 
>>> of session daemon state: 1 [in notify_ust_apps() at main.c:687]
>>> DEBUG1: [thread] Dispatch UST command started [in 
>>> thread_dispatch_ust_registration() at main.c:1324] DEBUG1: Futex n to 1
>>> prepare done [in futex_nto1_prepare() at futex.c:73] DEBUG1: Woken up
>>> but nothing in the UST command queue [in 
>>> thread_dispatch_ust_registration() at main.c:1334] DEBUG1: [thread]
>>> Manage client started [in thread_manage_clients() at main.c:3794]
>>> DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add() at
>>> compat-poll.c:91] DEBUG1: fd 9 of 2 added to pollfd [in
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Accepting client command
>>> ... [in thread_manage_clients() at main.c:3826] DEBUG1: Got the wait
>>> shm fd 15 [in get_wait_shm() at shm.c:117] DEBUG1: Futex wait update
>>> active 1 [in futex_wait_update() at futex.c:62] DEBUG1: Accepting
>>> application registration [in thread_registration_apps() at 
>>> main.c:1423] 
>>> ********************************************************************* 
>>> ***********************************
>>> 
>>> 
> Am I missing anything??
>>> 
>>> Thanks in Advance, Pavan
>>> 
>>> 
>>> ________________________________________ From: Mathieu Desnoyers 
>>> [mathieu.desnoyers@efficios.com] Sent: Monday, June 11, 2012 7:24 PM
>>> To: Pavan Anumula Cc: lttng-dev@lists.lttng.org Subject: Re:
>>> [lttng-dev] Lttng start failed
>>> 
>>> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>>>> Hi Mathieu,
>>>> 
>>>> Please find the info below as per your comments
>>>> 
>>>> 
>>>> ########## Output of  command "arm-none-linux-gnueabi-lttng-sessiond 
>>>> -vvv " , After loading the modules #######
>>>> 
>>>> DEBUG3: Creating LTTng run directory: /var/run/lttng [in 
>>>> create_lttng_rundir() at main.c:4315] DEBUG2: Kernel consumer err
>>>> path: /var/run/lttng/kconsumerd/error [in main() at main.c:4543]
>>>> DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command
>>>> [in main() at main.c:4545] DEBUG1: Client socket path 
>>>> /var/run/lttng/client-lttng-sessiond [in main() at main.c:4592]
>>>> DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond
>>>> [in main() at main.c:4593] DEBUG1: LTTng run directory path: 
>>>> /var/run/lttng [in main() at main.c:4594] DEBUG2: UST consumer 32
>>>> bits err path: /var/run/lttng/ustconsumerd32/error [in main() at
>>>> main.c:4603] DEBUG2: UST consumer 32 bits cmd path:
>>>> /var/run/lttng/ustconsumerd32/command [in main() at main.c:4605]
>>>> DEBUG2: UST consumer 64 bits err path: 
>>>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614]
>>>> DEBUG2: UST consumer 64 bits cmd path:
>>>> /var/run/lttng/ustconsumerd64/command [in main() at main.c:4616]
>>>> DEBUG3: Created hashtable size 4 at 0x4a080 of type 1 [in
>>>> lttng_ht_new() at hashtable.c:96] DEBUG3: Created hashtable size 4 at
>>>> 0x4a168 of type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG2:
>>>> Creating consumer directory: /var/run/lttng/kconsumerd [in
>>>> set_consumer_sockets() at main.c:4357] FATAL: Module lttng_tracer not
>>>> found. Error: Unable to load module lttng-tracer
>>> 
>>> Hrm. You want to do kernel tracing, but modprobe cannot find the lttng
>>> kernel tracer modules. You might want to run depmod -a or something
>>> like that on your target, and ensure that modprobe works properly.
>>> 
>>> Thanks,
>>> 
>>> Mathieu
>>> 
>>>> DEBUG2: Kernel tracer version validated (major version 2) [in 
>>>> kernel_validate_version() at kernel.c:675] DEBUG1: Modprobe 
>>>> successfully lttng-ftrace [in modprobe_lttng_data() at 
>>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-kprobes [in 
>>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe 
>>>> successfully lttng-kretprobes [in modprobe_lttng_data() at
>>>> modprobe.c:199] FATAL: Module lttng_lib_ring_buffer not found. Error:
>>>> Unable to load module lttng-lib-ring-buffer FATAL: Module
>>>> lttng_ring_buffer_client_discard not found. Error: Unable to load
>>>> module lttng-ring-buffer-client-discard FATAL: Module 
>>>> lttng_ring_buffer_client_overwrite not found. Error: Unable to load 
>>>> module lttng-ring-buffer-client-overwrite FATAL: Module 
>>>> lttng_ring_buffer_metadata_client not found. Error: Unable to load 
>>>> module lttng-ring-buffer-metadata-client FATAL: Module 
>>>> lttng_ring_buffer_client_mmap_discard not found. Error: Unable to 
>>>> load module lttng-ring-buffer-client-mmap-discard FATAL: Module 
>>>> lttng_ring_buffer_client_mmap_overwrite not found. Error: Unable to 
>>>> load module lttng-ring-buffer-client-mmap-overwrite FATAL: Module 
>>>> lttng_ring_buffer_metadata_mmap_client not found. Error: Unable to 
>>>> load module lttng-ring-buffer-metadata-mmap-client FATAL: Module 
>>>> lttng_probe_lttng not found. Error: Unable to load module 
>>>> lttng-probe-lttng DEBUG1: Modprobe successfully lttng-types [in 
>>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe 
>>>> successfully lttng-probe-block [in modprobe_lttng_data() at
>>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-irq [in
>>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>>>> successfully lttng-probe-kvm [in modprobe_lttng_data() at
>>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-sched [in
>>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>>>> successfully lttng-probe-signal [in modprobe_lttng_data() at
>>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-statedump
>>>> [in modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe 
>>>> successfully lttng-probe-timer [in modprobe_lttng_data() at
>>>> modprobe.c:199] DEBUG1: Kernel tracer fd 6 [in init_kernel_tracer()
>>>> at main.c:1887] DEBUG2: Creating consumer directory:
>>>> /var/run/lttng/ustconsumerd64 [in set_consumer_sockets() at
>>>> main.c:4357] DEBUG2: Creating consumer directory:
>>>> /var/run/lttng/ustconsumerd32 [in set_consumer_sockets() at
>>>> main.c:4357] DEBUG1: Signal handler set for SIGTERM, SIGPIPE and 
>>>> SIGINT [in set_signal_handler() at main.c:4449] DEBUG1: All 
>>>> permissions are set [in set_permissions() at main.c:4250] DEBUG1: 
>>>> poll set max size set to 65535 [in compat_poll_set_max_size() at
>>>> compat-poll.c:196] DEBUG1: [thread] Manage client started [in
>>>> thread_manage_clients() at main.c:3794] DEBUG1: fd 3 of 1 added to
>>>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 9 of 2
>>>> added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>>>> Accepting client command ... [in thread_manage_clients() at
>>>> main.c:3826] DEBUG1: [thread] Dispatch UST command started [in 
>>>> thread_dispatch_ust_registration() at main.c:1324] DEBUG1: Futex n to
>>>> 1 prepare done [in futex_nto1_prepare() at futex.c:73] DEBUG1: Woken
>>>> up but nothing in the UST command queue [in 
>>>> thread_dispatch_ust_registration() at main.c:1334] DEBUG1: Thread
>>>> manage kernel started [in thread_manage_kernel() at main.c:876]
>>>> DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add() at
>>>> compat-poll.c:91] DEBUG1: fd 11 of 2 added to pollfd [in
>>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Updating kernel poll
>>>> set [in update_kernel_poll() at main.c:748] DEBUG1: Thread kernel
>>>> polling on 2 fds [in thread_manage_kernel() at main.c:905] DEBUG1:
>>>> [thread] Manage application started [in thread_manage_apps() at
>>>> main.c:1179] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add()
>>>> at compat-poll.c:91] DEBUG1: fd 13 of 2 added to pollfd [in
>>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Apps thread polling on
>>>> 2 fds [in thread_manage_apps() at main.c:1200] DEBUG1: [thread]
>>>> Manage application registration started [in
>>>> thread_registration_apps() at main.c:1392] DEBUG1: fd 3 of 1 added to
>>>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 10 of 2
>>>> added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>>>> Notifying applications of session daemon state: 1 [in
>>>> notify_ust_apps() at main.c:687] DEBUG1: Got the wait shm fd 15 [in
>>>> get_wait_shm() at shm.c:117] DEBUG1: Futex wait update active 1 [in
>>>> futex_wait_update() at futex.c:62] DEBUG1: Accepting application
>>>> registration [in thread_registration_apps() at main.c:1423]
>>>> 
>>>> 
>>>> 
>>>> #### Output of  command "arm-none-linux-gnueabi-lttng-sessiond -vvv
>>>> " before loading the modules #############
>>>> 
>>>> DEBUG3: Creating LTTng run directory: /var/run/lttng [in 
>>>> create_lttng_rundir() at main.c:4315] DEBUG2: Kernel consumer err
>>>> path: /var/run/lttng/kconsumerd/error [in main() at main.c:4543]
>>>> DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command
>>>> [in main() at main.c:4545] DEBUG1: Client socket path 
>>>> /var/run/lttng/client-lttng-sessiond [in main() at main.c:4592]
>>>> DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond
>>>> [in main() at main.c:4593] DEBUG1: LTTng run directory path: 
>>>> /var/run/lttng [in main() at main.c:4594] DEBUG2: UST consumer 32
>>>> bits err path: /var/run/lttng/ustconsumerd32/error [in main() at
>>>> main.c:4603] DEBUG2: UST consumer 32 bits cmd path:
>>>> /var/run/lttng/ustconsumerd32/command [in main() at main.c:4605]
>>>> DEBUG2: UST consumer 64 bits err path: 
>>>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614]
>>>> DEBUG2: UST consumer 64 bits cmd path:
>>>> /var/run/lttng/ustconsumerd64/command [in main() at main.c:4616]
>>>> DEBUG3: Created hashtable size 4 at 0x4a080 of type 1 [in
>>>> lttng_ht_new() at hashtable.c:96] DEBUG3: Created hashtable size 4 at
>>>> 0x4a168 of type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG2:
>>>> Creating consumer directory: /var/run/lttng/kconsumerd [in
>>>> set_consumer_sockets() at main.c:4357] FATAL: Module lttng_tracer not
>>>> found. Error: Unable to load module lttng-tracer DEBUG1: Failed to
>>>> open /proc/lttng [in init_kernel_tracer() at main.c:1871] Error:
>>>> Unable to remove module lttng-tracer Warning: No kernel tracer
>>>> available DEBUG2: Creating consumer directory:
>>>> /var/run/lttng/ustconsumerd64 [in set_consumer_sockets() at
>>>> main.c:4357] DEBUG2: Creating consumer directory:
>>>> /var/run/lttng/ustconsumerd32 [in set_consumer_sockets() at
>>>> main.c:4357] DEBUG1: Signal handler set for SIGTERM, SIGPIPE and 
>>>> SIGINT [in set_signal_handler() at main.c:4449] DEBUG1: All 
>>>> permissions are set [in set_permissions() at main.c:4250] DEBUG1: 
>>>> poll set max size set to 65535 [in compat_poll_set_max_size() at
>>>> compat-poll.c:196] DEBUG1: [thread] Manage application started [in
>>>> thread_manage_apps() at main.c:1179] DEBUG1: fd 3 of 1 added to
>>>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 12 of 2
>>>> added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>>>> Apps thread polling on 2 fds [in thread_manage_apps() at main.c:1200]
>>>> DEBUG1: Thread manage kernel started [in thread_manage_kernel() at
>>>> main.c:876] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add()
>>>> at compat-poll.c:91] DEBUG1: fd 10 of 2 added to pollfd [in
>>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Updating kernel poll
>>>> set [in update_kernel_poll() at main.c:748] DEBUG1: Thread kernel
>>>> polling on 2 fds [in thread_manage_kernel() at main.c:905] DEBUG1:
>>>> [thread] Manage application registration started [in
>>>> thread_registration_apps() at main.c:1392] DEBUG1: fd 3 of 1 added to
>>>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 9 of 2
>>>> added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>>>> Notifying applications of session daemon state: 1 [in
>>>> notify_ust_apps() at main.c:687] DEBUG1: [thread] Dispatch UST
>>>> command started [in thread_dispatch_ust_registration() at
>>>> main.c:1324] DEBUG1: Futex n to 1 prepare done [in
>>>> futex_nto1_prepare() at futex.c:73] DEBUG1: Woken up but nothing in
>>>> the UST command queue [in thread_dispatch_ust_registration() at
>>>> main.c:1334] DEBUG1: [thread] Manage client started [in
>>>> thread_manage_clients() at main.c:3794] DEBUG1: fd 3 of 1 added to
>>>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 8 of 2
>>>> added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>>>> Accepting client command ... [in thread_manage_clients() at
>>>> main.c:3826] DEBUG1: Got the wait shm fd 14 [in get_wait_shm() at
>>>> shm.c:117] DEBUG1: Futex wait update active 1 [in futex_wait_update()
>>>> at futex.c:62] DEBUG1: Accepting application registration [in
>>>> thread_registration_apps() at main.c:1423]
>>>> 
>>>> 
>>>> Regards, Pavan
>>>> 
>>>> -----Original Message----- From: Mathieu Desnoyers 
>>>> [mailto:mathieu.desnoyers@efficios.com] Sent: Saturday, June 09, 
>>>> 2012 6:03 PM To: Pavan Anumula Cc: lttng-dev@lists.lttng.org Subject:
>>>> Re: [lttng-dev] Lttng start failed
>>>> 
>>>> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>>>>> Hi Mathue,
>>>>> 
>>>>> Thanks for the quick reply,
>>>>> 
>>>>> After inserting lttng modules , I had given the command 
>>>>> "arm-none-linux-gnueabi-lttng-sessiond -vvv"  as you said, Below
>>>>> is the output where there are error messages. Please help me in 
>>>>> resolving the issue, SO that I can catch kernel and user traces.
>>>>> 
>>>>> 
>>>>> root@arago:/usr/lttng/modules# 
>>>>> arm-none-linux-gnueabi-lttng-sessiond -d
>>>>> root@arago:/usr/lttng/modules# 
>>>>> arm-none-linux-gnueabi-lttng-sessiond -vvv DEBUG3: Creating LTTng 
>>>>> run directory: /var/run/lttng [in create_lttng_rundir() at
>>>>> main.c:4315] DEBUG2: Kernel consumer err path:
>>>>> /var/run/lttng/kconsumerd/error [in main() at main.c:4543] DEBUG2:
>>>>> Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in
>>>>> main() at main.c:4545] DEBUG1: Client socket path
>>>>> /var/run/lttng/client-lttng-sessiond [in main() at main.c:4592]
>>>>> DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond
>>>>> [in main() at main.c:4593] DEBUG1: LTTng run directory path:
>>>>> /var/run/lttng [in main() at main.c:4594] DEBUG2: UST consumer 32
>>>>> bits err path: /var/run/lttng/ustconsumerd32/error [in main() at
>>>>> main.c:4603] DEBUG2: UST consumer 32 bits cmd path: 
>>>>> /var/run/lttng/ustconsumerd32/command [in main() at main.c:4605] 
>>>>> DEBUG2: UST consumer 64 bits err path: 
>>>>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614] 
>>>>> DEBUG2: UST consumer 64 bits cmd path: 
>>>>> /var/run/lttng/ustconsumerd64/command [in main() at main.c:4616] 
>>>>> Error: Already running daemon.
>>>> 
>>>> Please kill the lttng-sessiond that is already started (the one with 
>>>> -d). Instead of that one, run the sessiond with:
>>>> 
>>>> lttng-sessiond -vvv
>>>> 
>>>> (don't run lttng-sessiond -d before)
>>>> 
>>>> Thanks,
>>>> 
>>>> Mathieu
>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>> Thanks in advance, Pavan
>>>>> 
>>>>> -----Original Message----- From: Mathieu Desnoyers 
>>>>> [mailto:mathieu.desnoyers@efficios.com] Sent: Friday, June 08,
>>>>> 2012 11:12 PM To: Pavan Anumula Cc: lttng-dev@lists.lttng.org
>>>>> Subject: Re: [lttng-dev] Lttng start failed
>>>>> 
>>>>> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>>>>>> Hi ,
>>>>>> 
>>>>>> I am new to LTTng usage, I am trying to use LTTng 2.0.1 and 
>>>>>> LTTng-modules-2.0.2  for ARM(omapL138), with Linux kernel 2.6.33 
>>>>>> wit RT-29 patch on it.
>>>>>> 
>>>>>> After enabling all the kernel events I am facing the below
>>>>>> errors. I loaded all the modules manually by insmod.
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng create 
>>>>>> newsessiom Session newsessiom created. Traces will be written in 
>>>>>> /home/root/lttng-traces/newsessiom-20110325-154922
>>>>>> 
>>>>>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng 
>>>>>> enable-event -a --kernel All kernel events are enabled in
>>>>>> channel channel0
>>>>>> 
>>>>>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng start 
>>>>>> LTTng: Failure to write metadata to buffers (timeout) Error: 
>>>>>> Starting kernel trace failed
>>>>>> 
>>>>>> Please kindly help me on this.
>>>>> 
>>>>> I think you should look into the lttng-sessiond --help :
>>>>> 
>>>>> --consumerd32-path PATH     Specify path for the 32-bit UST
>>>>> consumer daemon binary --consumerd32-libdir PATH   Specify path for
>>>>> the 32-bit UST consumer daemon libraries --consumerd64-path PATH
>>>>> Specify path for the 64-bit UST consumer daemon binary
>>>>> --consumerd64-libdir PATH   Specify path for the 64-bit UST
>>>>> consumer daemon libraries
>>>>> 
>>>>> options. My guess is that lttng-sessiond is not able to find the 
>>>>> consumerd binary files, maybe due to a rename or because they have 
>>>>> been moved after install.
>>>>> 
>>>>> One more thing that might help is to launch the lttng-sessiond
>>>>> with "-vvv" : it will provide verbose output and let us know where 
>>>>> things fall apart.
>>>>> 
>>>>> Thanks,
>>>>> 
>>>>> Mathieu
>>>>> 
>>>>> 
>>>>>> 
>>>>>> 
>>>>>> Thanks in advance, Pavan
>>>>>> 
>>>>>> ________________________________ SASKEN BUSINESS DISCLAIMER:
>>>>>> This message may contain confidential, proprietary or legally 
>>>>>> privileged information. In case you are not the original
>>>>>> intended Recipient of the message, you must not, directly or
>>>>>> indirectly, use, disclose, distribute, print, or copy any part of
>>>>>> this message and you are requested to delete it and inform the
>>>>>> sender. Any views expressed in this message are those of the
>>>>>> individual sender unless otherwise stated. Nothing contained in
>>>>>> this message shall be construed as an offer or acceptance of any
>>>>>> offer by Sasken Communication Technologies Limited ("Sasken")
>>>>>> unless sent with that express intent and with due authority of
>>>>>> Sasken. Sasken has taken enough precautions to prevent the spread
>>>>>> of viruses. However the company accepts no liability for any
>>>>>> damage caused by any virus transmitted by this email. Read
>>>>>> Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
>>>>> 
>>>>>> _______________________________________________ lttng-dev
>>>>>> mailing list lttng-dev@lists.lttng.org 
>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>> 
>>>>> 
>>>>> -- Mathieu Desnoyers Operating System Efficiency R&D Consultant 
>>>>> EfficiOS Inc. http://www.efficios.com
>>>> 
>>>> -- Mathieu Desnoyers Operating System Efficiency R&D Consultant 
>>>> EfficiOS Inc. http://www.efficios.com
>>> 
>>> -- Mathieu Desnoyers Operating System Efficiency R&D Consultant 
>>> EfficiOS Inc. http://www.efficios.com
> 
> 
> _______________________________________________ lttng-dev mailing list 
> lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJP201YAAoJEELoaioR9I02a7AH/3sTHsbxRJ3z+//6+wPQu7GC
6KIZxfBhhq4WSSZRJGHvD9O6QCHPgUmrYjR4leONB9//FfoWdzzRZb0IDErpJ3+L
B8I49nd7X2UHp1jf7CpbJUzrs1AQZa3K32D/nRlF3LceOGnvIpkKstur5msXvN5B
msGap8UQ8NsxkyCRW8cmPNt/Qm7lMsrg9zeP5VGEncj7dywIqaPfjz7MGFwNp4Vz
uxxBusAjnI50Kmx+ETYZmTiqEIPCV9rnpVK4T2LtZgX/+rh06gDkkvW6xy0wO7pf
ymZ0MytfvuKaHXmQnXyGvWhrodmn+D9E32DwyrcuhZa6K0ZPE5eDRbxUT5WGbuQ=
=VYvD
-----END PGP SIGNATURE-----
