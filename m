From: Pavan Anumula <pavan.anumula@sasken.com>
Subject: Re: Lttng start failed
Date: Wed, 13 Jun 2012 17:15:44 +0530
Message-ID: <47D610AD9C485E458630BA38C324D3B60113FB00FAF3__49510.8782699846$1339587974$gmane$org@EXGMBX01.sasken.com>
References: <47D610AD9C485E458630BA38C324D3B60113FB00F9EA@EXGMBX01.sasken.com>
	<20120608174226.GA23339@Krystal>
	<47D610AD9C485E458630BA38C324D3B60113FB00FA00@EXGMBX01.sasken.com>
	<20120609123251.GA14280@Krystal>
	<47D610AD9C485E458630BA38C324D3B60113FB0E22D1@EXGMBX01.sasken.com>
	<20120612140548.GA13917@Krystal> <4FD7618F.8090407@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <pavan.anumula@sasken.com>) id 1Sem17-0003GJ-Qc
	for lttng-dev@lists.lttng.org; Wed, 13 Jun 2012 07:45:43 -0400
In-Reply-To: <4FD7618F.8090407@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Hi David,

I am still unable to  see any traces when running the /tests/demo application in UST.
Please find as much detail as I can give you below:

We are using UST version 2.0.1
We are using userspace-rcu version 0.6.7
We are using modules version 2.0.2
We are using tools version 2.0.1

The Kernel version of 2.6.33.7 and we have applied the patches for 2.6.32 as supplied by Yannick Brosseau.

The kernel is built with the following LTTNG configuration options:
CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_TRACEPOINTS=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS  is not set
CONFIG_PERF_EVENTS is not set

I have booted and issued the following commands:

root@arago:~# arm-none-linux-gnueabi-lttng-sessiond -d /* To start a deamon */
root@arago:~# arm-none-linux-gnueabi-lttng create xyz
Session xyz created.
Traces will be written in /home/root/lttng-traces/xyz-20110326-104303.
root@arago:~# arm-none-linux-gnueabi-lttng enable-event -k -a
All kernel events are enabled in channel channel0
root@arago:~# arm-none-linux-gnueabi-lttng start
LTTng: Failure to write metadata to buffers (timeout)
Error: Starting kernel trace failed

********* The output of lsmod   After loading  lttng modules before executing  the lttng commands to trace***********
root@arago:~# lsmod

lttng_ring_buffer_metadata_client     4146  0
lttng_ring_buffer_client_overwrite     9226  0
lttng_ring_buffer_client_mmap_overwrite     9234  0
lttng_ring_buffer_client_mmap_discard     7826  0
lttng_ring_buffer_client_discard     7822  0
lttng_probe_timer       6699  0
lttng_probe_signal      3332  0
lttng_probe_sched       6649  0
lttng_probe_lttng       1086  0
lttng_tracer           24543  9 lttng_ring_buffer_metadata_client,lttng_ring_buffer_client_overwrite,lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_client_discard,lttng_probe_timer,lttng_probe_signal,lttng_probe_sched,lttng_probe_lttng
lttng_statedump         3587  1 lttng_tracer
lttng_lib_ring_buffer    31358  6 lttng_ring_buffer_metadata_client,lttng_ring_buffer_client_overwrite,lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_client_discard,lttng_tracer



******************The new output of lsmod after executing trace commands**********************

Module                  Size  Used by
lttng_probe_statedump     5848  7
lttng_probe_irq         2100  3
lttng_types              932  0
lttng_ring_buffer_metadata_mmap_client     4150  0
lttng_ring_buffer_metadata_client     4146  1
lttng_ring_buffer_client_overwrite     9226  0
lttng_ring_buffer_client_mmap_overwrite     9234  0
lttng_ring_buffer_client_mmap_discard     7826  0
lttng_ring_buffer_client_discard     7822  1
lttng_probe_timer       6699  12
lttng_probe_signal      3332  4
lttng_probe_sched       6649  12
lttng_probe_lttng       1086  1
lttng_tracer           24543  53 lttng_probe_statedump,lttng_probe_irq,lttng_ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lttng_ring_buffer_client_overwrite,lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_client_discard,lttng_probe_timer,lttng_probe_signal,lttng_probe_sched,lttng_probe_lttng
lttng_statedump         3587  1 lttng_tracer
lttng_lib_ring_buffer    31358  9 lttng_ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lttng_ring_buffer_client_overwrite,lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_client_discard,lttng_tracer

******************************************************************

The /lttng-traces/xyz-20110326-104303 is empty with no traces(only folder named kernel got created).

In /dev, there is no lttng entry.

In /proc, there is a file called lttng but when trying to print is says:
root@arago:~/lttng-traces/xyz-20110326-104303/kernel# cat /proc/lttng
cat: read error: Input/output error

Thanks in Advance,
Pavan


-----Original Message-----
From: David Goulet [mailto:dgoulet@efficios.com]
Sent: Tuesday, June 12, 2012 9:05 PM
To: Pavan Anumula
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Lttng start failed

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Pavan,

The output below is normal and should be working fine. However, the problem is that you have _NO_ debug message after the "lttng start". That command should at least produce 10+ lines of messages after this last line:

"DEBUG1: Accepting application registration [in thread_registration_apps() at main.c:1423]"

Can you enlight me and tell me if by doing "lttng create newsessiom" and "lttng enable-event -a -k", you have output messages coming out of the session daemon in -vvv mode ?

If NOT, you are talking to another daemon! A quick "ps faux | grep lttng-sessiond" could help clear that question.

If only one daemon is running and stuck at the above debug message, the next step is to tell me on what the daemon is waiting on using either "strace -p"
or "gdb" also. There is 6 threads so having the strace -p output for all of them would help me greatly.

Thanks!
David

On 12/06/12 10:05 AM, Mathieu Desnoyers wrote:
> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>> Hi Mathieu, Still I am unable to start tracing, And I am facing the
>> same start  errors. Please kindly help me on this. This time I loaded
>> the modules by modprobe( not with insmod as I did  before), Then I
>> run the command  " arm-none-linux-gnueabi-lttng-sessiond  -vvv "
>> (before arm-none-linux-gnueabi-lttng-sessiond  -d),
>
> When using "arm-none-linux-gnueabi-lttng-sessiond  -vvv", you should
> _not_ run "arm-none-linux-gnueabi-lttng-sessiond  -d".
>
>
>> The below is the Output, And It got hanged overthere.
>
> This is normal: the sessiond is waiting for applications to connect.
> It does not hang, it just waits.
>
> David, can you follow up on this issue ? It seems to be sessiond-related.
>
> Thanks,
>
> Mathieu
>
>
>> Later when I started lttng start I am acing the same erros below:
>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng start LTTng:
>> Failure to write metadata to buffers (timeout) Error: Starting kernel
>> trace failed
>>
>> *********************************************************************
>> ***************************
>>
>>
DEBUG3: Creating LTTng run directory: /var/run/lttng [in create_lttng_rundir() at main.c:4315]
>> DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [in
>> main() at main.c:4543] DEBUG2: Kernel consumer cmd path:
>> /var/run/lttng/kconsumerd/command [in main() at main.c:4545] DEBUG1:
>> Client socket path /var/run/lttng/client-lttng-sessiond [in main() at
>> main.c:4592] DEBUG1: Application socket path
>> /var/run/lttng/apps-lttng-sessiond [in main() at main.c:4593] DEBUG1:
>> LTTng run directory path: /var/run/lttng [in main() at main.c:4594]
>> DEBUG2: UST consumer 32 bits err path:
>> /var/run/lttng/ustconsumerd32/error [in main() at main.c:4603] DEBUG2:
>> UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command
>> [in
>> main() at main.c:4605] DEBUG2: UST consumer 64 bits err path:
>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614] DEBUG2:
>> UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command
>> [in
>> main() at main.c:4616] DEBUG3: Created hashtable size 4 at 0x4a080 of
>> type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG3: Created
>> hashtable size 4 at 0x4a168 of type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG2:
>> Creating consumer directory: /var/run/lttng/kconsumerd [in
>> set_consumer_sockets() at main.c:4357] DEBUG1: Modprobe successfully
>> lttng-tracer [in modprobe_lttng_control() at modprobe.c:163] DEBUG2:
>> Kernel tracer version validated (major version 2) [in
>> kernel_validate_version() at kernel.c:675] DEBUG1: Modprobe
>> successfully lttng-ftrace [in modprobe_lttng_data() at modprobe.c:199] DEBUG1:
>> Modprobe successfully lttng-kprobes [in modprobe_lttng_data() at
>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-kretprobes [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-lib-ring-buffer [in modprobe_lttng_data() at
>> modprobe.c:199]
>> DEBUG1: Modprobe successfully lttng-ring-buffer-client-discard [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-ring-buffer-client-overwrite [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-ring-buffer-metadata-client [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-ring-buffer-client-mmap-discard [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-ring-buffer-client-mmap-overwrite [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-ring-buffer-metadata-mmap-client [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-probe-lttng [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-types [in modprobe_lttng_data() at modprobe.c:199]
>> DEBUG1: Modprobe successfully lttng-probe-block [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-probe-irq [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-probe-kvm [in modprobe_lttng_data() at modprobe.c:199] DEBUG1:
>> Modprobe successfully lttng-probe-sched [in modprobe_lttng_data() at
>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-signal [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>> successfully lttng-probe-statedump [in modprobe_lttng_data() at
>> modprobe.c:199]
>> DEBUG1: Modprobe successfully lttng-probe-timer [in
>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Kernel tracer fd 6
>> [in init_kernel_tracer() at main.c:1887] DEBUG2: Creating consumer directory:
>> /var/run/lttng/ustconsumerd64 [in set_consumer_sockets() at
>> main.c:4357]
>> DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd32
>> [in
>> set_consumer_sockets() at main.c:4357] DEBUG1: Signal handler set for
>> SIGTERM, SIGPIPE and SIGINT [in set_signal_handler() at main.c:4449]
>> DEBUG1: All permissions are set [in set_permissions() at main.c:4250]
>> DEBUG1: poll set max size set to 65535 [in compat_poll_set_max_size()
>> at compat-poll.c:196] DEBUG1: [thread] Manage application started [in
>> thread_manage_apps() at main.c:1179] DEBUG1: fd 3 of 1 added to
>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 13 of 2
>> added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>> Apps thread polling on 2 fds [in thread_manage_apps() at main.c:1200]
>> DEBUG1: Thread manage kernel started [in thread_manage_kernel() at main.c:876] DEBUG1:
>> fd 3 of 1 added to pollfd [in compat_poll_add() at compat-poll.c:91]
>> DEBUG1: fd 11 of 2 added to pollfd [in compat_poll_add() at
>> compat-poll.c:91] DEBUG1: Updating kernel poll set [in
>> update_kernel_poll() at main.c:748] DEBUG1: Thread kernel polling on
>> 2 fds [in thread_manage_kernel() at main.c:905] DEBUG1: [thread]
>> Manage application registration started [in
>> thread_registration_apps() at main.c:1392] DEBUG1: fd 3 of 1 added to
>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 10 of 2
>> added to pollfd [in
>> compat_poll_add() at compat-poll.c:91] DEBUG1: Notifying applications
>> of session daemon state: 1 [in notify_ust_apps() at main.c:687] DEBUG1:
>> [thread] Dispatch UST command started [in
>> thread_dispatch_ust_registration() at main.c:1324] DEBUG1: Futex n to
>> 1 prepare done [in futex_nto1_prepare() at futex.c:73] DEBUG1: Woken
>> up but nothing in the UST command queue [in
>> thread_dispatch_ust_registration()
>> at main.c:1334] DEBUG1: [thread] Manage client started [in
>> thread_manage_clients() at main.c:3794] DEBUG1: fd 3 of 1 added to
>> pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1: fd 9 of 2
>> added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>> Accepting client command ... [in thread_manage_clients() at main.c:3826] DEBUG1:
>> Got the wait shm fd 15 [in get_wait_shm() at shm.c:117] DEBUG1: Futex
>> wait update active 1 [in futex_wait_update() at futex.c:62] DEBUG1:
>> Accepting application registration [in thread_registration_apps() at
>> main.c:1423]
>> *********************************************************************
>> ***********************************
>>
>>
Am I missing anything??
>>
>> Thanks in Advance, Pavan
>>
>>
>> ________________________________________ From: Mathieu Desnoyers
>> [mathieu.desnoyers@efficios.com] Sent: Monday, June 11, 2012 7:24 PM To:
>> Pavan Anumula Cc: lttng-dev@lists.lttng.org Subject: Re: [lttng-dev]
>> Lttng start failed
>>
>> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>>> Hi Mathieu,
>>>
>>> Please find the info below as per your comments
>>>
>>>
>>> ########## Output of  command "arm-none-linux-gnueabi-lttng-sessiond
>>> -vvv " , After loading the modules #######
>>>
>>> DEBUG3: Creating LTTng run directory: /var/run/lttng [in
>>> create_lttng_rundir() at main.c:4315] DEBUG2: Kernel consumer err path:
>>> /var/run/lttng/kconsumerd/error [in main() at main.c:4543] DEBUG2:
>>> Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in
>>> main() at main.c:4545] DEBUG1: Client socket path
>>> /var/run/lttng/client-lttng-sessiond [in main() at main.c:4592] DEBUG1:
>>> Application socket path /var/run/lttng/apps-lttng-sessiond [in
>>> main() at main.c:4593] DEBUG1: LTTng run directory path:
>>> /var/run/lttng [in
>>> main() at main.c:4594] DEBUG2: UST consumer 32 bits err path:
>>> /var/run/lttng/ustconsumerd32/error [in main() at main.c:4603] DEBUG2:
>>> UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command
>>> [in main() at main.c:4605] DEBUG2: UST consumer 64 bits err path:
>>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614] DEBUG2:
>>> UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command
>>> [in main() at main.c:4616] DEBUG3: Created hashtable size 4 at
>>> 0x4a080 of type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG3:
>>> Created hashtable size 4 at 0x4a168 of type 1 [in lttng_ht_new() at
>>> hashtable.c:96] DEBUG2: Creating consumer directory:
>>> /var/run/lttng/kconsumerd [in set_consumer_sockets() at main.c:4357]
>>> FATAL: Module lttng_tracer not found. Error: Unable to load module
>>> lttng-tracer
>>
>> Hrm. You want to do kernel tracing, but modprobe cannot find the
>> lttng kernel tracer modules. You might want to run depmod -a or
>> something like that on your target, and ensure that modprobe works properly.
>>
>> Thanks,
>>
>> Mathieu
>>
>>> DEBUG2: Kernel tracer version validated (major version 2) [in
>>> kernel_validate_version() at kernel.c:675] DEBUG1: Modprobe
>>> successfully lttng-ftrace [in modprobe_lttng_data() at
>>> modprobe.c:199]
>>> DEBUG1: Modprobe successfully lttng-kprobes [in
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>>> successfully lttng-kretprobes [in
>>> modprobe_lttng_data() at modprobe.c:199] FATAL: Module
>>> lttng_lib_ring_buffer not found. Error: Unable to load module
>>> lttng-lib-ring-buffer FATAL: Module lttng_ring_buffer_client_discard
>>> not found. Error: Unable to load module
>>> lttng-ring-buffer-client-discard FATAL: Module
>>> lttng_ring_buffer_client_overwrite not found. Error: Unable to load
>>> module lttng-ring-buffer-client-overwrite FATAL: Module
>>> lttng_ring_buffer_metadata_client not found. Error: Unable to load
>>> module lttng-ring-buffer-metadata-client FATAL: Module
>>> lttng_ring_buffer_client_mmap_discard not found. Error: Unable to
>>> load module lttng-ring-buffer-client-mmap-discard FATAL: Module
>>> lttng_ring_buffer_client_mmap_overwrite not found. Error: Unable to
>>> load module lttng-ring-buffer-client-mmap-overwrite FATAL: Module
>>> lttng_ring_buffer_metadata_mmap_client not found. Error: Unable to
>>> load module lttng-ring-buffer-metadata-mmap-client FATAL: Module
>>> lttng_probe_lttng not found. Error: Unable to load module
>>> lttng-probe-lttng DEBUG1: Modprobe successfully lttng-types [in
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>>> successfully lttng-probe-block [in modprobe_lttng_data() at modprobe.c:199] DEBUG1:
>>> Modprobe successfully lttng-probe-irq [in modprobe_lttng_data() at
>>> modprobe.c:199] DEBUG1: Modprobe successfully lttng-probe-kvm [in
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>>> successfully lttng-probe-sched [in modprobe_lttng_data() at modprobe.c:199] DEBUG1:
>>> Modprobe successfully lttng-probe-signal [in modprobe_lttng_data()
>>> at modprobe.c:199] DEBUG1: Modprobe successfully
>>> lttng-probe-statedump [in
>>> modprobe_lttng_data() at modprobe.c:199] DEBUG1: Modprobe
>>> successfully lttng-probe-timer [in modprobe_lttng_data() at modprobe.c:199] DEBUG1:
>>> Kernel tracer fd 6 [in init_kernel_tracer() at main.c:1887] DEBUG2:
>>> Creating consumer directory: /var/run/lttng/ustconsumerd64 [in
>>> set_consumer_sockets() at main.c:4357] DEBUG2: Creating consumer
>>> directory: /var/run/lttng/ustconsumerd32 [in set_consumer_sockets()
>>> at main.c:4357] DEBUG1: Signal handler set for SIGTERM, SIGPIPE and
>>> SIGINT [in set_signal_handler() at main.c:4449] DEBUG1: All
>>> permissions are set [in set_permissions() at main.c:4250] DEBUG1:
>>> poll set max size set to 65535 [in compat_poll_set_max_size() at compat-poll.c:196] DEBUG1:
>>> [thread] Manage client started [in thread_manage_clients() at
>>> main.c:3794] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add()
>>> at compat-poll.c:91] DEBUG1: fd 9 of 2 added to pollfd [in
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Accepting client
>>> command ... [in thread_manage_clients() at main.c:3826] DEBUG1:
>>> [thread] Dispatch UST command started [in
>>> thread_dispatch_ust_registration() at main.c:1324] DEBUG1: Futex n
>>> to 1 prepare done [in futex_nto1_prepare() at futex.c:73] DEBUG1:
>>> Woken up but nothing in the UST command queue [in
>>> thread_dispatch_ust_registration() at main.c:1334] DEBUG1: Thread manage kernel started [in thread_manage_kernel() at main.c:876] DEBUG1:
>>> fd 3 of 1 added to pollfd [in compat_poll_add() at compat-poll.c:91]
>>> DEBUG1: fd 11 of 2 added to pollfd [in compat_poll_add() at
>>> compat-poll.c:91] DEBUG1: Updating kernel poll set [in
>>> update_kernel_poll() at main.c:748] DEBUG1: Thread kernel polling on
>>> 2 fds [in thread_manage_kernel() at main.c:905] DEBUG1: [thread]
>>> Manage application started [in thread_manage_apps() at main.c:1179]
>>> DEBUG1: fd
>>> 3 of 1 added to pollfd [in compat_poll_add() at compat-poll.c:91]
>>> DEBUG1: fd 13 of 2 added to pollfd [in compat_poll_add() at
>>> compat-poll.c:91] DEBUG1: Apps thread polling on 2 fds [in
>>> thread_manage_apps() at main.c:1200] DEBUG1: [thread] Manage
>>> application registration started [in thread_registration_apps() at
>>> main.c:1392] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add()
>>> at compat-poll.c:91] DEBUG1: fd 10 of 2 added to pollfd [in
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Notifying
>>> applications of session daemon state: 1 [in notify_ust_apps() at main.c:687] DEBUG1:
>>> Got the wait shm fd 15 [in get_wait_shm() at shm.c:117] DEBUG1:
>>> Futex wait update active 1 [in futex_wait_update() at futex.c:62] DEBUG1:
>>> Accepting application registration [in thread_registration_apps() at
>>> main.c:1423]
>>>
>>>
>>>
>>> #### Output of  command "arm-none-linux-gnueabi-lttng-sessiond -vvv "
>>> before loading the modules #############
>>>
>>> DEBUG3: Creating LTTng run directory: /var/run/lttng [in
>>> create_lttng_rundir() at main.c:4315] DEBUG2: Kernel consumer err path:
>>> /var/run/lttng/kconsumerd/error [in main() at main.c:4543] DEBUG2:
>>> Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in
>>> main() at main.c:4545] DEBUG1: Client socket path
>>> /var/run/lttng/client-lttng-sessiond [in main() at main.c:4592] DEBUG1:
>>> Application socket path /var/run/lttng/apps-lttng-sessiond [in
>>> main() at main.c:4593] DEBUG1: LTTng run directory path:
>>> /var/run/lttng [in
>>> main() at main.c:4594] DEBUG2: UST consumer 32 bits err path:
>>> /var/run/lttng/ustconsumerd32/error [in main() at main.c:4603] DEBUG2:
>>> UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command
>>> [in main() at main.c:4605] DEBUG2: UST consumer 64 bits err path:
>>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614] DEBUG2:
>>> UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command
>>> [in main() at main.c:4616] DEBUG3: Created hashtable size 4 at
>>> 0x4a080 of type 1 [in lttng_ht_new() at hashtable.c:96] DEBUG3:
>>> Created hashtable size 4 at 0x4a168 of type 1 [in lttng_ht_new() at
>>> hashtable.c:96] DEBUG2: Creating consumer directory:
>>> /var/run/lttng/kconsumerd [in set_consumer_sockets() at main.c:4357]
>>> FATAL: Module lttng_tracer not found. Error: Unable to load module
>>> lttng-tracer DEBUG1: Failed to open /proc/lttng [in
>>> init_kernel_tracer() at main.c:1871] Error: Unable to remove module
>>> lttng-tracer Warning: No kernel tracer available DEBUG2: Creating
>>> consumer directory: /var/run/lttng/ustconsumerd64 [in
>>> set_consumer_sockets() at main.c:4357] DEBUG2: Creating consumer
>>> directory: /var/run/lttng/ustconsumerd32 [in set_consumer_sockets()
>>> at main.c:4357] DEBUG1: Signal handler set for SIGTERM, SIGPIPE and
>>> SIGINT [in set_signal_handler() at main.c:4449] DEBUG1: All
>>> permissions are set [in set_permissions() at main.c:4250] DEBUG1:
>>> poll set max size set to 65535 [in compat_poll_set_max_size() at compat-poll.c:196] DEBUG1:
>>> [thread] Manage application started [in thread_manage_apps() at
>>> main.c:1179] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add()
>>> at compat-poll.c:91] DEBUG1: fd 12 of 2 added to pollfd [in
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Apps thread polling
>>> on 2 fds [in thread_manage_apps() at main.c:1200] DEBUG1: Thread
>>> manage kernel started [in thread_manage_kernel() at main.c:876]
>>> DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add() at compat-poll.c:91] DEBUG1:
>>> fd 10 of 2 added to pollfd [in compat_poll_add() at
>>> compat-poll.c:91]
>>> DEBUG1: Updating kernel poll set [in update_kernel_poll() at
>>> main.c:748] DEBUG1: Thread kernel polling on 2 fds [in
>>> thread_manage_kernel() at main.c:905] DEBUG1: [thread] Manage
>>> application registration started [in thread_registration_apps() at
>>> main.c:1392] DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add()
>>> at compat-poll.c:91] DEBUG1: fd 9 of 2 added to pollfd [in
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Notifying
>>> applications of session daemon state: 1 [in notify_ust_apps() at main.c:687] DEBUG1:
>>> [thread] Dispatch UST command started [in
>>> thread_dispatch_ust_registration() at main.c:1324] DEBUG1: Futex n
>>> to 1 prepare done [in futex_nto1_prepare() at futex.c:73] DEBUG1:
>>> Woken up but nothing in the UST command queue [in
>>> thread_dispatch_ust_registration() at main.c:1334] DEBUG1: [thread]
>>> Manage client started [in thread_manage_clients() at main.c:3794]
>>> DEBUG1: fd 3 of 1 added to pollfd [in compat_poll_add() at
>>> compat-poll.c:91] DEBUG1: fd 8 of 2 added to pollfd [in
>>> compat_poll_add() at compat-poll.c:91] DEBUG1: Accepting client
>>> command ... [in thread_manage_clients() at main.c:3826] DEBUG1: Got
>>> the wait shm fd 14 [in get_wait_shm() at shm.c:117] DEBUG1: Futex
>>> wait update active 1 [in futex_wait_update() at futex.c:62] DEBUG1:
>>> Accepting application registration [in thread_registration_apps() at
>>> main.c:1423]
>>>
>>>
>>> Regards, Pavan
>>>
>>> -----Original Message----- From: Mathieu Desnoyers
>>> [mailto:mathieu.desnoyers@efficios.com] Sent: Saturday, June 09,
>>> 2012
>>> 6:03 PM To: Pavan Anumula Cc: lttng-dev@lists.lttng.org Subject: Re:
>>> [lttng-dev] Lttng start failed
>>>
>>> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>>>> Hi Mathue,
>>>>
>>>> Thanks for the quick reply,
>>>>
>>>> After inserting lttng modules , I had given the command
>>>> "arm-none-linux-gnueabi-lttng-sessiond -vvv"  as you said, Below is
>>>> the output where there are error messages. Please help me in
>>>> resolving the issue, SO that I can catch kernel and user traces.
>>>>
>>>>
>>>> root@arago:/usr/lttng/modules#
>>>> arm-none-linux-gnueabi-lttng-sessiond
>>>> -d root@arago:/usr/lttng/modules#
>>>> arm-none-linux-gnueabi-lttng-sessiond -vvv DEBUG3: Creating LTTng
>>>> run
>>>> directory: /var/run/lttng [in create_lttng_rundir() at main.c:4315]
>>>> DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error
>>>> [in main() at main.c:4543] DEBUG2: Kernel consumer cmd path:
>>>> /var/run/lttng/kconsumerd/command [in main() at main.c:4545] DEBUG1:
>>>> Client socket path /var/run/lttng/client-lttng-sessiond [in main()
>>>> at main.c:4592] DEBUG1: Application socket path
>>>> /var/run/lttng/apps-lttng-sessiond [in main() at main.c:4593] DEBUG1:
>>>> LTTng run directory path: /var/run/lttng [in main() at main.c:4594]
>>>> DEBUG2: UST consumer 32 bits err path:
>>>> /var/run/lttng/ustconsumerd32/error [in main() at main.c:4603]
>>>> DEBUG2: UST consumer 32 bits cmd path:
>>>> /var/run/lttng/ustconsumerd32/command [in main() at main.c:4605]
>>>> DEBUG2: UST consumer 64 bits err path:
>>>> /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614]
>>>> DEBUG2: UST consumer 64 bits cmd path:
>>>> /var/run/lttng/ustconsumerd64/command [in main() at main.c:4616]
>>>> Error: Already running daemon.
>>>
>>> Please kill the lttng-sessiond that is already started (the one with
>>> -d). Instead of that one, run the sessiond with:
>>>
>>> lttng-sessiond -vvv
>>>
>>> (don't run lttng-sessiond -d before)
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>>
>>>>
>>>>
>>>>
>>>> Thanks in advance, Pavan
>>>>
>>>> -----Original Message----- From: Mathieu Desnoyers
>>>> [mailto:mathieu.desnoyers@efficios.com] Sent: Friday, June 08, 2012
>>>> 11:12 PM To: Pavan Anumula Cc: lttng-dev@lists.lttng.org Subject: Re:
>>>> [lttng-dev] Lttng start failed
>>>>
>>>> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
>>>>> Hi ,
>>>>>
>>>>> I am new to LTTng usage, I am trying to use LTTng 2.0.1 and
>>>>> LTTng-modules-2.0.2  for ARM(omapL138), with Linux kernel 2.6.33
>>>>> wit RT-29 patch on it.
>>>>>
>>>>> After enabling all the kernel events I am facing the below errors.
>>>>> I loaded all the modules manually by insmod.
>>>>>
>>>>>
>>>>>
>>>>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng create
>>>>> newsessiom Session newsessiom created. Traces will be written in
>>>>> /home/root/lttng-traces/newsessiom-20110325-154922
>>>>>
>>>>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng
>>>>> enable-event -a --kernel All kernel events are enabled in channel
>>>>> channel0
>>>>>
>>>>> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng start
>>>>> LTTng: Failure to write metadata to buffers (timeout) Error:
>>>>> Starting kernel trace failed
>>>>>
>>>>> Please kindly help me on this.
>>>>
>>>> I think you should look into the lttng-sessiond --help :
>>>>
>>>> --consumerd32-path PATH     Specify path for the 32-bit UST consumer
>>>> daemon binary --consumerd32-libdir PATH   Specify path for the 32-bit
>>>> UST consumer daemon libraries --consumerd64-path PATH     Specify
>>>> path for the 64-bit UST consumer daemon binary --consumerd64-libdir
>>>> PATH   Specify path for the 64-bit UST consumer daemon libraries
>>>>
>>>> options. My guess is that lttng-sessiond is not able to find the
>>>> consumerd binary files, maybe due to a rename or because they have
>>>> been moved after install.
>>>>
>>>> One more thing that might help is to launch the lttng-sessiond with
>>>> "-vvv" : it will provide verbose output and let us know where
>>>> things fall apart.
>>>>
>>>> Thanks,
>>>>
>>>> Mathieu
>>>>
>>>>
>>>>>
>>>>>
>>>>> Thanks in advance, Pavan
>>>>>
>>>>> ________________________________ SASKEN BUSINESS DISCLAIMER: This
>>>>> message may contain confidential, proprietary or legally
>>>>> privileged information. In case you are not the original intended
>>>>> Recipient of the message, you must not, directly or indirectly,
>>>>> use, disclose, distribute, print, or copy any part of this message
>>>>> and you are requested to delete it and inform the sender. Any
>>>>> views expressed in this message are those of the individual sender
>>>>> unless otherwise stated. Nothing contained in this message shall
>>>>> be construed as an offer or acceptance of any offer by Sasken
>>>>> Communication Technologies Limited ("Sasken") unless sent with
>>>>> that express intent and with due authority of Sasken. Sasken has
>>>>> taken enough precautions to prevent the spread of viruses. However
>>>>> the company accepts no liability for any damage caused by any
>>>>> virus transmitted by this email. Read Disclaimer at
>>>>> http://www.sasken.com/extras/mail_disclaimer.html
>>>>
>>>>> _______________________________________________ lttng-dev mailing
>>>>> list lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>
>>>>
>>>> -- Mathieu Desnoyers Operating System Efficiency R&D Consultant
>>>> EfficiOS Inc. http://www.efficios.com
>>>
>>> -- Mathieu Desnoyers Operating System Efficiency R&D Consultant
>>> EfficiOS Inc. http://www.efficios.com
>>
>> -- Mathieu Desnoyers Operating System Efficiency R&D Consultant
>> EfficiOS Inc. http://www.efficios.com
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJP12GMAAoJEELoaioR9I02+q8IAKw/ot4BmP6xibXM/VnNaRdP
60S1KEynFPxDmO9JS3u3x+r4UiDaGWrP4+rEfgAeUeMQcOj3ItHZLyNhp+F8A8+j
Dj0q9YFNBLsANzHzAk9VsVlL/myYaeW7ysNGl1yxhL9Vc/Px3cmxaof79smxMGcQ
dnMKf6Gk+eNL4IPrXQIxF0cvVK85PI2xaDA1SiiKQaULUiqUBebn2gtGr1l8oFTw
FT1xryh4wRw4FUmqngw54SYPiYpZm1y/VUzTWB3Zs9hYPcvEum22wrhAaWNkoUkk
ixBjE+HHIVRBzZatDymE35tI4+Ci6z9J3uRmJVC97x2qQz2F4nl5Yw3qRmm1PVM=
=3VyT
-----END PGP SIGNATURE-----
