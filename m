From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup:
 Assertion `pollfd == ht_cleanup_pipe[0]' failed.
Date: Tue, 08 Apr 2014 15:19:08 +0200
Message-ID: <5343F74C.2040800__38550.526466179$1396963233$gmane$org@keymile.com>
References: <532AE51F.6030406@keymile.com> <20140403143216.GA9339@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070905030500040407020100"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0175200b5f=gerlando.falauto@keymile.com>)
 id 1WXVvr-0008VA-NJ
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 09:19:25 -0400
In-Reply-To: <20140403143216.GA9339@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------070905030500040407020100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 04/03/2014 04:32 PM, David Goulet wrote:
> On 20 Mar (13:54:55), Gerlando Falauto wrote:
>> Hi,
>>
>> I'm trying to bring lttng-tools up to date, but I get the following message:
>>
>> lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion `pollfd ==
>> ht_cleanup_pipe[0]' failed.
>>
>> I noticed this was already filed as a bug:
>> http://redmine.dorsal.polymtl.ca/issues/747
>>
>> I tried implementing the solution proposed on the comment:
>>
>>> We should add a check to see if the revent is 0 at the beginning of
>>> the loop, and continue to the next loop iteration if it is the case.
>>
>> But this doesn't seem to help.
>>
>> Any suggestion?
>
> Sorry for the delay!
>
> An approach here to debug this would be to first compile with -O0 to
> remove any optimization from the compiler (simply add this to CFLAGS in
> configure.ac).

I don't understand... why is that so important? Shouldn't the end result 
be exactly the same?

>
> Then, have some printf() that prints the revents + pollfd at each
> iteration and see why revents == 0 is not enough.

Actually, it sort of does something, but I then run into another issue.

It looks like clean_command_ctx() causes a double free when trying to:

		free(*cmd_ctx);

*** Error in `lttng-sessiond': double free or corruption (out): 
0x4c2004c8 ***
======= Backtrace: =========
/usr/local/lib/libc.so.6(+0xfea2f70)[0x48098f70]
/usr/local/lib/libc.so.6(+0xfea3ecc)[0x48099ecc]
lttng-sessiond[0x10023850]
lttng-sessiond[0x1002eb24]
/usr/local/lib/libpthread.so.0[0xfdf7a68]
/usr/local/lib/libc.so.6(clone+0x84)[0x480ffa4c]
======= Memory map: ========
00100000-00103000 r-xp 00000000 00:00 0          [vdso]
0f22f000-0f23b000 r-xp 00000000 00:0c 7910950 
/usr/local/lib/libnss_files.so.2
0f23b000-0f24a000 ---p 0000c000 00:0c 7910950 
/usr/local/lib/libnss_files.so.2
0f24a000-0f24b000 r--p 0000b000 00:0c 7910950 
/usr/local/lib/libnss_files.so.2
0f24b000-0f24c000 rwxp 0000c000 00:0c 7910950 
/usr/local/lib/libnss_files.so.2
0f25c000-0f266000 r-xp 00000000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f266000-0f275000 ---p 0000a000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f275000-0f276000 r--p 00009000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f276000-0f277000 rwxp 0000a000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f287000-0f28e000 r-xp 00000000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f28e000-0f29e000 ---p 00007000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f29e000-0f29f000 r--p 00007000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f29f000-0f2a0000 rwxp 00008000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f2b0000-0f2b4000 r-xp 00000000 00:0c 7910976    /usr/local/lib/libuuid.so.1
0f2b4000-0f2c3000 ---p 00004000 00:0c 7910976    /usr/local/lib/libuuid.so.1

I tried adding the same check (i.e. check to see if the revent is 0, and 
if so continue) to the last loop within thread_manage_clients(), but to 
no avail.
I also tried tracing evey "free()" invocation within 
lttng-sessiond/main.c, but I couldn't make any sense of it (see attached 
file didnt_work2.txt). It looks like that area is never freed before.
Notice how the same area is first allocated, then freed right after, 
then allocated again -- to the same address, and then freed (and this is 
where the runtime complains about this double free.

So either this pointer is freed at some other place (though I can't 
really understand how), or perhaps something is corrupting some memory 
area around that address.

Only once was I able to get the execution going without any error (see 
worked_by_chance.txt), but I've not been to determine under what weird 
circumstances this would happen.

BTW, I noticed that within main.c, the same pattern of code (where we 
should add the check for revents == 0) occurs *EIGHT* times:

	revents = LTTNG_POLL_GETEV(&events, i);
	pollfd = LTTNG_POLL_GETFD(&events, i);

	health_code_update();

	/* Thread quit pipe has been closed. Killing thread. */
	ret = sessiond_check_thread_quit_pipe(pollfd, revents);
	if (ret) {
		err = 0;
		goto exit;
	}

Is this really wanted? Should they *all* be fixed with the check 
mentioned by Mathieu?

Any feedback would be highly appreciated.

Thank you,
Gerlando

> As stated in the bug report, poll() will make the loop iterate over all
> fd thus this assert() is a bit hardcore considering that we didn't check
> if an event was triggered before.
>
> Please if you work on that, update the ticket so we can track the
> progress! :)
>
> Thanks!
> David
>
>>
>> Thank you,
>> Gerlando
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------070905030500040407020100
Content-Type: text/plain; charset=UTF-8;
 name="didnt_work2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="didnt_work2.txt"

root@kmeter1:~# lttng -vvv create trace
DEBUG1 [365/365]: Session daemon at: /usr/local/bin/lttng-sessiond (in check_sessiond() at lttng.c:370)
Spawning a session daemon
DEBUG3 [366/366]: Creating LTTng run directory: /var/run/lttng (in create_lttng_rundir() at main.c:4322)
DEBUG2 [366/366]: Kernel consumer err path: /var/run/lttng/kconsumerd/error (in main() at main.c:4663)
DEBUG2 [366/366]: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command (in main() at main.c:4665)
DEBUG1 [366/366]: Client socket path /var/run/lttng/client-lttng-sessiond (in main() at main.c:4718)
DEBUG1 [366/366]: Application socket path /var/run/lttng/lttng-ust-sock-5 (in main() at main.c:4719)
DEBUG1 [366/366]: Application wait path /lttng-ust-wait-5 (in main() at main.c:4720)
DEBUG1 [366/366]: LTTng run directory path: /var/run/lttng (in main() at main.c:4721)
DEBUG2 [366/366]: UST consumer 32 bits err path: /var/run/lttng/ustconsumerd32/error (in main() at main.c:4730)
DEBUG2 [366/366]: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command (in main() at main.c:4732)
DEBUG2 [366/366]: UST consumer 64 bits err path: /var/run/lttng/ustconsumerd64/error (in main() at main.c:4741)
DEBUG2 [366/366]: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command (in main() at main.c:4743)
DEBUG3 [366/366]: Created hashtable size 4 at 0x10073080 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG2 [366/366]: Creating consumer directory: /var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:4364)
Warning: No tracing group detected

DEBUG1 [366/366]: Modprobe successfully lttng-tracer (in modprobe_lttng_control() at modprobe.c:193)
DEBUG2 [366/366]: Kernel tracer version validated (major version 2) (in kernel_validate_version() at kernel.c:704)
DEBUG1 [366/366]: Modprobe successfully lttng-ftrace (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-kprobes (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-kretprobes (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-lib-ring-buffer (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-ring-buffer-client-discard (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-ring-buffer-client-overwrite (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-ring-buffer-metadata-client (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-ring-buffer-client-mmap-discard (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-ring-buffer-client-mmap-overwrite (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-ring-buffer-metadata-mmap-client (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-types (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-asoc (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-block (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-btrfs (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-compaction (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-ext3 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-ext4 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-gpio (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-irq (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-jbd (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-jbd2 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-kmem (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-kvm (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-kvm-x86 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-kvm-x86-mmu (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-lock (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-module (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-napi (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-net (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-power (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-printk (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-random (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-rcu (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-regmap (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-regulator (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-rpm (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-sched (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-scsi (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-signal (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-skb (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-sock (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-statedump (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-sunrpc (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-timer (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-udp (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-vmscan (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-workqueue (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Modprobe successfully lttng-probe-writeback (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [366/366]: Kernel tracer fd 6 (in init_kernel_tracer() at main.c:2413)
DEBUG2 [366/366]: Creating consumer directory: /var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:4364)
DEBUG2 [366/366]: Creating consumer directory: /var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4364)
DEBUG3 [366/366]: Session daemon client socket 9 and application socket 10 created (in init_daemon_socket() at main.c:4230)
DEBUG1 [366/366]: All permissions are set (in set_permissions() at main.c:4310)
DEBUG3 [366/366]: Created hashtable size 4 at 0x10074ac0 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [366/366]: Global buffer per UID registry initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:99)
DEBUG3 [366/366]: Created hashtable size 4 at 0x10074ce8 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [366/366]: Global buffer per PID registry initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:220)
DEBUG1 [366/366]: poll set max size set to 65535 (in compat_poll_set_max_size() at compat-poll.c:318)
DEBUG1 [366/366]: Command subsystem initialized (in cmd_init() at cmd.c:3110)
DEBUG1 [366/366]: Pid 366 written in file /var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at utils.c:465)
DEBUG1 [366/366]: Pid 5345 written in file /var/run/lttng/jul.port (in utils_create_pid_file() at utils.c:465)
DEBUG1 [366/366]: TCP inet operation timeout set to 216 sec (in lttcomm_inet_init() at inet.c:529)
DEBUG1 [366/366]: Health check time delta in seconds set to 236 (in health_init() at health.c:73)
DEBUG1 [366/502]: [thread] Dispatch UST command started (in thread_dispatch_ust_registration() at main.c:1590)
DEBUG1 [366/502]: Futex n to 1 prepare done (in futex_nto1_prepare() at futex.c:75)
DEBUG1 [366/502]: Woken up but nothing in the UST command queue (in thread_dispatch_ust_registration() at main.c:1614)
DEBUG1 [366/501]: [thread] Manage client started (in thread_manage_clients() at main.c:3746)
DEBUG1 [366/501]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/501]: fd 9 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/501]: Accepting client command ... (in thread_manage_clients() at main.c:3789)
DEBUG1 [366/503]: [thread] Manage application registration started (in thread_registration_apps() at main.c:1815)
DEBUG1 [366/503]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/503]: fd 10 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/503]: Notifying applications of session daemon state: 1 (in notify_ust_apps() at main.c:638)
DEBUG1 [366/503]: Got the wait shm fd 19 (in get_wait_shm() at shm.c:115)
DEBUG1 [366/503]: Futex wait update active 1 (in futex_wait_update() at futex.c:63)
DEBUG1 [366/503]: Accepting application registration (in thread_registration_apps() at main.c:1853)
DEBUG1 [366/504]: [thread] Manage application started (in thread_manage_apps() at main.c:1303)
DEBUG1 [366/504]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/504]: fd 15 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/504]: Apps thread polling on 0 fds (in thread_manage_apps() at main.c:1334)
DEBUG1 [366/500]: [thread] Manage health check started (in thread_manage_health() at main.c:3560)
DEBUG1 [366/507]: [thread] Thread manage kernel started (in thread_manage_kernel() at main.c:839)
DEBUG1 [366/507]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/507]: fd 11 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/507]: Updating kernel poll set (in update_kernel_poll() at main.c:699)
DEBUG1 [366/507]: Thread kernel polling on 0 fds (in thread_manage_kernel() at main.c:885)
DEBUG1 [366/499]: [ht-thread] startup. (in thread_ht_cleanup() at ht-cleanup.c:36)
DEBUG1 [366/499]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/499]: fd 13 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG3 [366/499]: [ht-thread] Polling on 0 fds. (in thread_ht_cleanup() at ht-cleanup.c:64)
DEBUG1 [366/500]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/500]: fd 19 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [365/365]: SIGUSR1 caught (in sighandler() at lttng.c:192)
DEBUG3 [365/365]: URI string: file:///root/lttng-traces/trace-19700101-000931 (in uri_parse() at uri.c:291)
DEBUG3 [365/365]: URI file destination: /root/lttng-traces/trace-19700101-000931 (in uri_parse() at uri.c:328)
DEBUG3 [365/365]: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:505)
DEBUG3 [366/501]: [main] revents = 0, pollfd = 3 (in thread_manage_clients() at main.c:3813)
DEBUG3 [366/501]: [main] revents = 0, skipping to next item (in thread_manage_clients() at main.c:3815)
DEBUG3 [366/501]: [main] revents = 1, pollfd = 9 (in thread_manage_clients() at main.c:3813)
DEBUG3 [366/501]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [366/501]: Wait for client response (in thread_manage_clients() at main.c:3837)
DEBUG1 [366/501]: cmd_ctx is now 0x4ca004c8 (in thread_manage_clients() at main.c:3865)
DEBUG1 [366/501]: Receiving data from client ... (in thread_manage_clients() at main.c:3885)
DEBUG1 [366/500]: Health check ready (in thread_manage_health() at main.c:3625)
DEBUG1 [365/365]: LSM cmd type : 8 (in send_session_msg() at lttng-ctl.c:131)
DEBUG1 [366/501]: Processing client command 8 (in process_client_msg() at main.c:2652)
DEBUG1 [366/501]: Waiting for 1 URIs from client ... (in process_client_msg() at main.c:3216)
DEBUG2 [366/501]: Trying to find session by name trace (in session_find_by_name() at session.c:169)
DEBUG3 [366/501]: Created hashtable size 4 at 0x4ca05a58 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [366/501]: Tracing session trace created with ID 0 by UID 0 GID 0 (in session_create() at session.c:276)
DEBUG2 [366/501]: Trying to find session by name trace (in session_find_by_name() at session.c:169)
DEBUG3 [366/501]: Created hashtable size 4 at 0x4ca0acd0 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG2 [366/501]: Setting trace directory path from URI to /root/lttng-traces/trace-19700101-000931 (in add_uri_to_consumer() at cmd.c:481)
DEBUG1 [366/501]: FREEING 0x4ca03870 (in process_client_msg() at main.c:3237)
DEBUG1 [366/501]: Sending response (size: 16, retcode: Success) (in thread_manage_clients() at main.c:3934)
DEBUG1 [366/501]: Clean command context structure, cmd_ctx = 0x4ca004c8 (in clean_command_ctx() at main.c:612)
DEBUG1 [366/501]: Freeing cmd_ctx->llm = 0x4ca03858 (in clean_command_ctx() at main.c:615)
DEBUG1 [366/501]: FREEING 0x4ca03858 (in clean_command_ctx() at main.c:616)
DEBUG1 [366/501]: Freeing cmd_ctx->llm, DONE (in clean_command_ctx() at main.c:617)
DEBUG1 [366/501]: Freeing cmd_ctx->lsm = 0x4ca004f0 (in clean_command_ctx() at main.c:620)
DEBUG1 [366/501]: FREEING 0x4ca004f0 (in clean_command_ctx() at main.c:621)
DEBUG1 [366/501]: Freeing cmd_ctx->lsm, DONE (in clean_command_ctx() at main.c:622)
DEBUG1 [366/501]: Freeing cmd_ctx = 0x4ca004c8 (in clean_command_ctx() at main.c:624)
DEBUG1 [366/501]: FREEING 0x4ca004c8 (in clean_command_ctx() at main.c:625)
DEBUG1 [366/501]: Freeing cmd_ctx, DONE (in clean_command_ctx() at main.c:626)
DEBUG1 [366/501]: Accepting client command ... (in thread_manage_clients() at main.c:3789)
Session trace created.
Traces will be written in /root/lttng-traces/trace-19700101-000931
DEBUG1 [365/365]: Init config session in /root (in config_init() at conf.c:295)
root@kmeter1:~# 
root@kmeter1:~# lttng -vvv enable-channel mychannel -k --overwrite --subbuf-size
=4096 --num-subbuf=4
DEBUG3 [366/501]: [main] revents = 0, pollfd = 3 (in thread_manage_clients() at main.c:3813)
DEBUG3 [366/501]: [main] revents = 0, skipping to next item (in thread_manage_clients() at main.c:3815)
DEBUG3 [366/501]: [main] revents = 1, pollfd = 9 (in thread_manage_clients() at main.c:3813)
DEBUG3 [366/501]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [366/501]: Wait for client response (in thread_manage_clients() at main.c:3837)
DEBUG1 [366/501]: cmd_ctx is now 0x4ca004c8 (in thread_manage_clients() at main.c:3865)
DEBUG1 [366/501]: Receiving data from client ... (in thread_manage_clients() at main.c:3885)
DEBUG1 [366/501]: Nothing recv() from client... continuing (in thread_manage_clients() at main.c:3889)
DEBUG1 [366/501]: Clean command context structure, cmd_ctx = 0x4ca004c8 (in clean_command_ctx() at main.c:612)
DEBUG1 [366/501]: Freeing cmd_ctx->lsm = 0x4ca004f0 (in clean_command_ctx() at main.c:620)
DEBUG1 [366/501]: FREEING 0x4ca004f0 (in clean_command_ctx() at main.c:621)
DEBUG1 [366/501]: Freeing cmd_ctx->lsm, DONE (in clean_command_ctx() at main.c:622)
DEBUG1 [366/501]: Freeing cmd_ctx = 0x4ca004c8 (in clean_command_ctx() at main.c:624)
DEBUG1 [366/501]: FREEING 0x4ca004c8 (in clean_command_ctx() at main.c:625)
DEBUG1 [366/501]: Freeing cmd_ctx, DONE (in clean_command_ctx() at main.c:626)
DEBUG1 [366/501]: Accepting client command ... (in thread_manage_clients() at main.c:3789)
DEBUG1 [508/508]: Channel set to overwrite (in cmd_enable_channels() at commands/enable_channels.c:341)
DEBUG1 [508/508]: Channel subbuf size set to 4096 (in cmd_enable_channels() at commands/enable_channels.c:375)
DEBUG1 [508/508]: Channel subbuf num set to 4 (in cmd_enable_channels() at commands/enable_channels.c:411)
DEBUG2 [508/508]: Config file path found: /root (in get_session_name() at utils.c:62)
DEBUG1 [508/508]: Session name found: trace (in get_session_name() at utils.c:63)
DEBUG1 [508/508]: Enabling channel mychannel (in enable_channel() at commands/enable_channels.c:265)
DEBUG3 [366/501]: [main] revents = 0, pollfd = 3 (in thread_manage_clients() at main.c:3813)
DEBUG3 [366/501]: [main] revents = 0, skipping to next item (in thread_manage_clients() at main.c:3815)
DEBUG3 [366/501]: [main] revents = 1, pollfd = 9 (in thread_manage_clients() at main.c:3813)
DEBUG3 [366/501]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [366/501]: Wait for client response (in thread_manage_clients() at main.c:3837)
DEBUG1 [366/501]: cmd_ctx is now 0x4ca004c8 (in thread_manage_clients() at main.c:3865)
DEBUG1 [366/501]: Receiving data from client ... (in thread_manage_clients() at main.c:3885)
DEBUG1 [508/508]: LSM cmd type : 5 (in send_session_msg() at lttng-ctl.c:131)
DEBUG1 [366/501]: Processing client command 5 (in process_client_msg() at main.c:2652)
DEBUG1 [366/501]: Getting session trace by name (in process_client_msg() at main.c:2731)
DEBUG2 [366/501]: Trying to find session by name trace (in session_find_by_name() at session.c:169)
DEBUG1 [366/501]: Creating kernel session (in create_kernel_session() at main.c:2568)
DEBUG3 [366/501]: Created hashtable size 4 at 0x4ca038d0 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [366/501]: Kernel session created (fd: 21) (in kernel_create_session() at kernel.c:109)
DEBUG3 [366/501]: Copying tracing session consumer output in kernel session (in copy_session_consumer() at main.c:2463)
DEBUG3 [366/499]: [ht-thread] nb_fd = 2 (in thread_ht_cleanup() at ht-cleanup.c:83)
DEBUG3 [366/499]: [ht-thread] revents = 0, pollfd = 3 (in thread_ht_cleanup() at ht-cleanup.c:93)
DEBUG3 [366/499]: [ht-thread] revents = 0, skipping to next item (in thread_ht_cleanup() at ht-cleanup.c:95)
DEBUG3 [366/499]: [ht-thread] revents = 1, pollfd = 13 (in thread_ht_cleanup() at ht-cleanup.c:93)
DEBUG3 [366/499]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [366/499]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:64)
DEBUG3 [366/501]: Created hashtable size 4 at 0x4ca038d0 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [366/501]: Copy session consumer subdir /kernel (in copy_session_consumer() at main.c:2499)
DEBUG3 [366/501]: mkdir() recursive /root/lttng-traces/trace-19700101-000931 with mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive() at runas.c:308)
DEBUG1 [366/501]: Using run_as_clone (in run_as() at runas.c:291)
DEBUG1 [366/501]: Spawning consumerd (in spawn_consumerd() at main.c:2173)
DEBUG2 [366/501]: Consumer pid 510 (in start_consumerd() at main.c:2355)
DEBUG2 [366/501]: Spawning consumer control thread (in start_consumerd() at main.c:2358)
DEBUG1 [366/511]: [thread] Manage consumer started (in thread_manage_consumer() at main.c:1005)
DEBUG1 [366/511]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/511]: fd 5 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG3 [510/510]: Looking for a kernel consumer at these locations: (in spawn_consumerd() at main.c:2192)
DEBUG3 [510/510]: 	1)  (in spawn_consumerd() at main.c:2193)
DEBUG3 [510/510]: 	2) /usr/local/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2194)
DEBUG3 [510/510]: 	3) /usr/local/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2195)
DEBUG3 [510/510]: Found location #2 (in spawn_consumerd() at main.c:2200)
DEBUG1 [510/510]: Using kernel consumer at: /usr/local/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2210)
DEBUG1 [510/510]: poll set max size set to 65535 (in compat_poll_set_max_size() at compat-poll.c:318)
DEBUG3 [510/510]: Created hashtable size 4 at 0x1004c018 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [510/510]: Created hashtable size 4 at 0x1004c240 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [510/510]: Created hashtable size 4 at 0x1004c468 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [510/510]: Created hashtable size 4 at 0x1004c690 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [510/510]: Created hashtable size 4 at 0x1004c8b8 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [510/510]: Created hashtable size 4 at 0x1004cae0 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [510/510]: TCP inet operation timeout set to 216 sec (in lttcomm_inet_init() at inet.c:529)
DEBUG1 [510/510]: Health check time delta in seconds set to 236 (in health_init() at health.c:73)
DEBUG1 [510/510]: Connecting to error socket /var/run/lttng/kconsumerd/error (in main() at lttng-consumerd.c:395)
DEBUG3 [366/511]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [366/511]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG2 [366/511]: Receiving code from consumer err_sock (in thread_manage_consumer() at main.c:1091)
DEBUG1 [510/512]: [thread] Manage health check started (in thread_manage_health() at health-consumerd.c:168)
Warning: No tracing group detected
DEBUG1 [510/512]: fd 17 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [510/512]: fd 19 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [510/512]: Health check ready (in thread_manage_health() at health-consumerd.c:241)
DEBUG1 [510/516]: Creating command socket /var/run/lttng/kconsumerd/command (in consumer_thread_sessiond_poll() at consumer.c:2991)
DEBUG1 [510/516]: Sending ready command to lttng-sessiond (in consumer_thread_sessiond_poll() at consumer.c:3004)
DEBUG1 [366/511]: Consumer command socket ready (fd: 23 (in thread_manage_consumer() at main.c:1125)
DEBUG1 [366/511]: Consumer metadata socket ready (fd: 24) (in thread_manage_consumer() at main.c:1127)
DEBUG1 [366/511]: fd 22 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/511]: fd 24 of 3 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG3 [366/501]: Consumer socket created (fd: 23) and added to output (in consumer_create_socket() at consumer.c:301)
DEBUG1 [366/501]: Setting relayd for session trace (in cmd_setup_relayd() at cmd.c:722)
DEBUG1 [366/501]: Enabling channel mychannel for session trace (in cmd_enable_channel() at cmd.c:910)
DEBUG1 [366/501]: Trying to find channel mychannel (in trace_kernel_get_channel_by_name() at trace-kernel.c:48)
DEBUG3 [366/501]: Kernel create channel mychannel with attr: 1, 4096, 4, 0, 200000, -1, 0 (in kernel_create_channel() at kernel.c:143)
DEBUG1 [366/501]: Kernel channel mychannel created (fd: 25) (in kernel_create_channel() at kernel.c:165)
DEBUG3 [366/507]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [366/507]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [366/507]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/507]: fd 11 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/507]: Updating kernel poll set (in update_kernel_poll() at main.c:699)
DEBUG1 [510/515]: Updating poll fd array (in update_poll_array() at consumer.c:1060)
DEBUG1 [510/515]: polling on 1 fd (in consumer_thread_data_poll() at consumer.c:2443)
DEBUG1 [510/516]: Connection on client_socket (in consumer_thread_sessiond_poll() at consumer.c:3026)
DEBUG1 [510/516]: Metadata connection on client_socket (in set_metadata_socket() at consumer.c:2950)
DEBUG1 [510/514]: Thread metadata poll started (in consumer_thread_metadata_poll() at consumer.c:2175)
DEBUG1 [510/514]: fd 12 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [510/514]: Metadata main loop started (in consumer_thread_metadata_poll() at consumer.c:2191)
DEBUG1 [510/514]: Metadata poll wait with 0 fd(s) (in consumer_thread_metadata_poll() at consumer.c:2203)
DEBUG1 [366/501]: Kernel quiescent wait on 6 (in kernel_wait_quiescent() at kernel.c:429)
DEBUG1 [366/507]: fd 25 of 3 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/507]: Channel fd 25 added to kernel set (in update_kernel_poll() at main.c:717)
DEBUG1 [366/507]: Thread kernel polling on 0 fds (in thread_manage_kernel() at main.c:885)
DEBUG3 [366/507]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [366/507]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [366/507]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [366/507]: Updating kernel streams for channel fd 25 (in update_kernel_stream() at main.c:743)
DEBUG1 [366/507]: Channel found, updating kernel streams (in update_kernel_stream() at main.c:756)
DEBUG1 [366/507]: Kernel stream mychannel_0 created (fd: 26, state: 0) (in kernel_open_channel_stream() at kernel.c:562)
DEBUG1 [366/507]: Thread kernel polling on 3 fds (in thread_manage_kernel() at main.c:885)
DEBUG1 [366/501]: Sending response (size: 16, retcode: Success) (in thread_manage_clients() at main.c:3934)
Kernel channel mychannel enabled for session trace
root@kmeter1:~# DEBUG1 [366/501]: Clean command context structure, cmd_ctx = 0x4ca004c8 (in clean_command_ctx() at main.c:612)
DEBUG1 [366/501]: Freeing cmd_ctx->llm = 0x4ca03858 (in clean_command_ctx() at main.c:615)
DEBUG1 [366/501]: FREEING 0x4ca03858 (in clean_command_ctx() at main.c:616)
DEBUG1 [366/501]: Freeing cmd_ctx->llm, DONE (in clean_command_ctx() at main.c:617)
DEBUG1 [366/501]: Freeing cmd_ctx->lsm = 0x4ca004f0 (in clean_command_ctx() at main.c:620)
DEBUG1 [366/501]: FREEING 0x4ca004f0 (in clean_command_ctx() at main.c:621)
DEBUG1 [366/501]: Freeing cmd_ctx->lsm, DONE (in clean_command_ctx() at main.c:622)
DEBUG1 [366/501]: Freeing cmd_ctx = 0x4ca004c8 (in clean_command_ctx() at main.c:624)
DEBUG1 [366/501]: FREEING 0x4ca004c8 (in clean_command_ctx() at main.c:625)
*** Error in `lttng-sessiond': double free or corruption (out): 0x4ca004c8 ***
======= Backtrace: =========
/usr/local/lib/libc.so.6(+0xfea2f70)[0x48098f70]
/usr/local/lib/libc.so.6(+0xfea3ecc)[0x48099ecc]
lttng-sessiond[0x10023850]
lttng-sessiond[0x1002eb24]
/usr/local/lib/libpthread.so.0[0xfdf7a68]
/usr/local/lib/libc.so.6(clone+0x84)[0x480ffa4c]
======= Memory map: ========
00100000-00103000 r-xp 00000000 00:00 0          [vdso]
0f22f000-0f23b000 r-xp 00000000 00:0c 7910950    /usr/local/lib/libnss_files.so.2
0f23b000-0f24a000 ---p 0000c000 00:0c 7910950    /usr/local/lib/libnss_files.so.2
0f24a000-0f24b000 r--p 0000b000 00:0c 7910950    /usr/local/lib/libnss_files.so.2
0f24b000-0f24c000 rwxp 0000c000 00:0c 7910950    /usr/local/lib/libnss_files.so.2
0f25c000-0f266000 r-xp 00000000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f266000-0f275000 ---p 0000a000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f275000-0f276000 r--p 00009000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f276000-0f277000 rwxp 0000a000 00:0c 7937693    /lib/libnss_nis-2.17.so
0f287000-0f28e000 r-xp 00000000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f28e000-0f29e000 ---p 00007000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f29e000-0f29f000 r--p 00007000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f29f000-0f2a0000 rwxp 00008000 00:0c 7937677    /lib/libnss_compat-2.17.so
0f2b0000-0f2b4000 r-xp 00000000 00:0c 7910976    /usr/local/lib/libuuid.so.1
0f2b4000-0f2c3000 ---p 00004000 00:0c 7910976    /usr/local/lib/libuuid.so.1
0f2c3000-0f2c4000 rwxp 00003000 00:0c 7910976    /usr/local/lib/libuuid.so.1
0fa20000-0fa2b000 r-xp 00000000 00:0c 7911133    /usr/local/lib/libpopt.so.0
0fa2b000-0fa3a000 ---p 0000b000 00:0c 7911133    /usr/local/lib/libpopt.so.0
0fa3a000-0fa3b000 rwxp 0000a000 00:0c 7911133    /usr/local/lib/libpopt.so.0
0fdd0000-0fdd7000 r-xp 00000000 00:0c 7910955    /usr/local/lib/librt.so.1
0fdd7000-0fde6000 ---p 00007000 00:0c 7910955    /usr/local/lib/librt.so.1
0fde6000-0fde7000 r--p 00006000 00:0c 7910955    /usr/local/lib/librt.so.1
0fde7000-0fde8000 rwxp 00007000 00:0c 7910955    /usr/local/lib/librt.so.1
0fdf0000-0fe06000 r-xp 00000000 00:0c 7911132    /usr/local/lib/libpthread.so.0
0fe06000-0fe15000 ---p 00016000 00:0c 7911132    /usr/local/lib/libpthread.so.0
0fe15000-0fe16000 r--p 00015000 00:0c 7911132    /usr/local/lib/libpthread.so.0
0fe16000-0fe17000 rwxp 00016000 00:0c 7911132    /usr/local/lib/libpthread.so.0
0fe17000-0fe19000 rwxp 00000000 00:00 0 
0ff34000-0ff37000 r-xp 00000000 00:0c 7910971    /usr/local/lib/liburcu-common.so.2.0.0
0ff37000-0ff46000 ---p 00003000 00:0c 7910971    /usr/local/lib/liburcu-common.so.2.0.0
0ff46000-0ff47000 rwxp 00002000 00:0c 7910971    /usr/local/lib/liburcu-common.so.2.0.0
0ff57000-0ff5c000 r-xp 00000000 00:0c 7910982    /usr/local/lib/liburcu.so.2.0.0
0ff5c000-0ff6c000 ---p 00005000 00:0c 7910982    /usr/local/lib/liburcu.so.2.0.0
0ff6c000-0ff6d000 rwxp 00005000 00:0c 7910982    /usr/local/lib/liburcu.so.2.0.0
0ff7d000-0ffad000 r-xp 00000000 00:0c 7910958    /usr/local/lib/liblttng-ctl.so.0.0.0
0ffad000-0ffaf000 rwxp 00030000 00:0c 7910958    /usr/local/lib/liblttngDEBUG3 [510/513]: Created hashtable size 4 at 0x4b300498 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [510/513]: Thread channel poll started (in consumer_thread_channel_poll() at consumer.c:2730)
DEBUG1 [510/513]: fd 10 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [510/513]: Channel main loop started (in consumer_thread_channel_poll() at consumer.c:2745)
DEBUG1 [510/513]: Channel poll wait with 0 fd(s) (in consumer_thread_channel_poll() at consumer.c:2757)
DEBUG1 [510/516]: Incoming command on sock (in consumer_thread_sessiond_poll() at consumer.c:3072)
DEBUG1 [510/516]: Communication interrupted on command socket (in consumer_thread_sessiond_poll() at consumer.c:3079)
DEBUG1 [510/516]: Consumer thread sessiond poll exiting (in consumer_thread_sessiond_poll() at consumer.c:3094)
DEBUG1 [510/515]: poll num_rdy : 1 (in consumer_thread_data_poll() at consumer.c:2447)
DEBUG1 [510/515]: consumer_data_pipe wake up (in consumer_thread_data_poll() at consumer.c:2471)
DEBUG1 [510/515]: Consumer delete flagged data stream (in validate_endpoint_status_data_stream() at consumer.c:2105)
DEBUG1 [510/515]: polling thread exiting (in consumer_thread_data_poll() at consumer.c:2598)
DEBUG1 [510/512]: Health check thread dying (in thread_manage_health() at health-consumerd.c:337)
DEBUG1 [510/514]: Metadata event catched in thread (in consumer_thread_metadata_poll() at consumer.c:2207)
DEBUG1 [510/514]: Metadata thread pipe hung up (in consumer_thread_metadata_poll() at consumer.c:2227)
DEBUG1 [510/514]: Metadata poll wait with 1 fd(s) (in consumer_thread_metadata_poll() at consumer.c:2203)
DEBUG1 [510/514]: Metadata event catched in thread (in consumer_thread_metadata_poll() at consumer.c:2207)
DEBUG1 [510/514]: Metadata poll thread exiting (in consumer_thread_metadata_poll() at consumer.c:2343)
Error: Health error occurred in consumer_thread_metadata_poll
DEBUG1 [510/513]: Channel event catched in thread (in consumer_thread_channel_poll() at consumer.c:2761)
DEBUG1 [510/513]: Channel poll wait with 1 fd(s) (in consumer_thread_channel_poll() at consumer.c:2757)
DEBUG1 [510/513]: Channel event catched in thread (in consumer_thread_channel_poll() at consumer.c:2761)
DEBUG1 [510/513]: Channel poll thread exiting (in consumer_thread_channel_poll() at consumer.c:2928)
Error: Health error occurred in consumer_thread_channel_poll
PERROR [510/510]: sendmsg: Broken pipe (in lttcomm_send_unix_sock() at unix.c:218)
DEBUG1 [510/510]: Consumer destroying it. Closing everything. (in lttng_consumer_destroy() at consumer.c:1395)


--------------070905030500040407020100
Content-Type: text/plain; charset=UTF-8;
 name="worked_by_chance.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="worked_by_chance.txt"

root@kmeter1:~# lttng -vvv create trace
DEBUG1 [366/366]: Session daemon at: /usr/local/bin/lttng-sessiond (in check_sessiond() at lttng.c:370)
Spawning a session daemon
DEBUG3 [367/367]: Creating LTTng run directory: /var/run/lttng (in create_lttng_rundir() at main.c:4322)
DEBUG2 [367/367]: Kernel consumer err path: /var/run/lttng/kconsumerd/error (in main() at main.c:4663)
DEBUG2 [367/367]: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command (in main() at main.c:4665)
DEBUG1 [367/367]: Client socket path /var/run/lttng/client-lttng-sessiond (in main() at main.c:4718)
DEBUG1 [367/367]: Application socket path /var/run/lttng/lttng-ust-sock-5 (in main() at main.c:4719)
DEBUG1 [367/367]: Application wait path /lttng-ust-wait-5 (in main() at main.c:4720)
DEBUG1 [367/367]: LTTng run directory path: /var/run/lttng (in main() at main.c:4721)
DEBUG2 [367/367]: UST consumer 32 bits err path: /var/run/lttng/ustconsumerd32/error (in main() at main.c:4730)
DEBUG2 [367/367]: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command (in main() at main.c:4732)
DEBUG2 [367/367]: UST consumer 64 bits err path: /var/run/lttng/ustconsumerd64/error (in main() at main.c:4741)
DEBUG2 [367/367]: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command (in main() at main.c:4743)
DEBUG3 [367/367]: Created hashtable size 4 at 0x10073080 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG2 [367/367]: Creating consumer directory: /var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:4364)
Warning: No tracing group detected
DEBUG1 [367/367]: Modprobe successfully lttng-tracer (in modprobe_lttng_control() at modprobe.c:193)
DEBUG2 [367/367]: Kernel tracer version validated (major version 2) (in kernel_validate_version() at kernel.c:704)
DEBUG1 [367/367]: Modprobe successfully lttng-ftrace (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-kprobes (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-kretprobes (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-lib-ring-buffer (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-ring-buffer-client-discard (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-ring-buffer-client-overwrite (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-ring-buffer-metadata-client (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-ring-buffer-client-mmap-discard (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-ring-buffer-client-mmap-overwrite (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-ring-buffer-metadata-mmap-client (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-types (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-asoc (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-block (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-btrfs (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-compaction (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-ext3 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-ext4 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-gpio (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-irq (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-jbd (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-jbd2 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-kmem (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-kvm (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-kvm-x86 (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-kvm-x86-mmu (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-lock (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-module (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-napi (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-net (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-power (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-printk (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-random (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-rcu (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-regmap (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-regulator (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-rpm (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-sched (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-scsi (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-signal (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-skb (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-sock (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-statedump (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-sunrpc (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-timer (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-udp (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-vmscan (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-workqueue (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Modprobe successfully lttng-probe-writeback (in modprobe_lttng_data() at modprobe.c:229)
DEBUG1 [367/367]: Kernel tracer fd 6 (in init_kernel_tracer() at main.c:2413)
DEBUG2 [367/367]: Creating consumer directory: /var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:4364)
DEBUG2 [367/367]: Creating consumer directory: /var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:4364)
DEBUG3 [367/367]: Session daemon client socket 9 and application socket 10 created (in init_daemon_socket() at main.c:4230)
DEBUG1 [367/367]: All permissions are set (in set_permissions() at main.c:4310)
DEBUG3 [367/367]: Created hashtable size 4 at 0x10074ac0 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [367/367]: Global buffer per UID registry initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:99)
DEBUG3 [367/367]: Created hashtable size 4 at 0x10074ce8 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [367/367]: Global buffer per PID registry initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:220)
DEBUG1 [367/367]: poll set max size set to 65535 (in compat_poll_set_max_size() at compat-poll.c:318)
DEBUG1 [367/367]: Command subsystem initialized (in cmd_init() at cmd.c:3110)
DEBUG1 [367/367]: Pid 367 written in file /var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at utils.c:465)
DEBUG1 [367/367]: Pid 5345 written in file /var/run/lttng/jul.port (in utils_create_pid_file() at utils.c:465)
DEBUG1 [367/367]: TCP inet operation timeout set to 216 sec (in lttcomm_inet_init() at inet.c:529)
DEBUG1 [367/367]: Health check time delta in seconds set to 236 (in health_init() at health.c:73)
DEBUG1 [367/503]: [thread] Dispatch UST command started (in thread_dispatch_ust_registration() at main.c:1590)
DEBUG1 [367/503]: Futex n to 1 prepare done (in futex_nto1_prepare() at futex.c:75)
DEBUG1 [367/503]: Woken up but nothing in the UST command queue (in thread_dispatch_ust_registration() at main.c:1614)
DEBUG1 [367/502]: [thread] Manage client started (in thread_manage_clients() at main.c:3746)
DEBUG1 [367/502]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/502]: fd 9 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/502]: Accepting client command ... (in thread_manage_clients() at main.c:3789)
DEBUG1 [367/504]: [thread] Manage application registration started (in thread_registration_apps() at main.c:1815)
DEBUG1 [367/504]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/504]: fd 10 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/504]: Notifying applications of session daemon state: 1 (in notify_ust_apps() at main.c:638)
DEBUG1 [367/504]: Got the wait shm fd 19 (in get_wait_shm() at shm.c:115)
DEBUG1 [367/501]: [thread] Manage health check started (in thread_manage_health() at main.c:3560)
DEBUG1 [367/505]: [thread] Manage application started (in thread_manage_apps() at main.c:1303)
DEBUG1 [367/505]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/505]: fd 15 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/505]: Apps thread polling on 0 fds (in thread_manage_apps() at main.c:1334)
DEBUG1 [367/500]: [ht-thread] startup. (in thread_ht_cleanup() at ht-cleanup.c:36)
DEBUG1 [367/500]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/500]: fd 13 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG3 [367/500]: [ht-thread] Polling on 0 fds. (in thread_ht_cleanup() at ht-cleanup.c:64)
DEBUG1 [367/501]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/501]: fd 19 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [366/366]: SIGUSR1 caught (in sighandler() at lttng.c:192)
DEBUG1 [367/501]: Health check ready (in thread_manage_health() at main.c:3625)
DEBUG3 [366/366]: URI string: file:///root/lttng-traces/trace-19700101-000148 (in uri_parse() at uri.c:291)
DEBUG3 [366/366]: URI file destination: /root/lttng-traces/trace-19700101-000148 (in uri_parse() at uri.c:328)
DEBUG3 [366/366]: URI dtype: 3, proto: 0, host: , subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:505)
DEBUG1 [367/504]: Futex wait update active 1 (in futex_wait_update() at futex.c:63)
DEBUG3 [367/502]: [main] revents = 0, pollfd = 3 (in thread_manage_clients() at main.c:3813)
DEBUG3 [367/502]: [main] revents = 0, skipping to next item (in thread_manage_clients() at main.c:3815)
DEBUG3 [367/502]: [main] revents = 1, pollfd = 9 (in thread_manage_clients() at main.c:3813)
DEBUG3 [367/502]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [367/502]: Wait for client response (in thread_manage_clients() at main.c:3837)
DEBUG1 [367/502]: cmd_ctx is now 0x4c2004c8 (in thread_manage_clients() at main.c:3865)
DEBUG1 [367/502]: Receiving data from client ... (in thread_manage_clients() at main.c:3885)
DEBUG1 [367/504]: Accepting application registration (in thread_registration_apps() at main.c:1853)
DEBUG1 [367/508]: [thread] Thread manage kernel started (in thread_manage_kernel() at main.c:839)
DEBUG1 [367/508]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/508]: fd 11 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/508]: Updating kernel poll set (in update_kernel_poll() at main.c:699)
DEBUG1 [367/508]: Thread kernel polling on 0 fds (in thread_manage_kernel() at main.c:885)
DEBUG1 [366/366]: LSM cmd type : 8 (in send_session_msg() at lttng-ctl.c:131)
DEBUG1 [367/502]: Processing client command 8 (in process_client_msg() at main.c:2652)
DEBUG1 [367/502]: Waiting for 1 URIs from client ... (in process_client_msg() at main.c:3216)
DEBUG2 [367/502]: Trying to find session by name trace (in session_find_by_name() at session.c:169)
DEBUG3 [367/502]: Created hashtable size 4 at 0x4c205a58 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [367/502]: Tracing session trace created with ID 0 by UID 0 GID 0 (in session_create() at session.c:276)
DEBUG2 [367/502]: Trying to find session by name trace (in session_find_by_name() at session.c:169)
DEBUG3 [367/502]: Created hashtable size 4 at 0x4c20acd0 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG2 [367/502]: Setting trace directory path from URI to /root/lttng-traces/trace-19700101-000148 (in add_uri_to_consumer() at cmd.c:481)
DEBUG1 [367/502]: FREEING 0x4c203870 (in process_client_msg() at main.c:3237)
DEBUG1 [367/502]: Sending response (size: 16, retcode: Success) (in thread_manage_clients() at main.c:3934)
DEBUG1 [367/502]: Clean command context structure, cmd_ctx = 0x4c2004c8 (in clean_command_ctx() at main.c:612)
DEBUG1 [367/502]: Freeing cmd_ctx->llm = 0x4c203858 (in clean_command_ctx() at main.c:615)
DEBUG1 [367/502]: FREEING 0x4c203858 (in clean_command_ctx() at main.c:616)
DEBUG1 [367/502]: Freeing cmd_ctx->llm, DONE (in clean_command_ctx() at main.c:617)
DEBUG1 [367/502]: Freeing cmd_ctx->lsm = 0x4c2004f0 (in clean_command_ctx() at main.c:620)
DEBUG1 [367/502]: FREEING 0x4c2004f0 (in clean_command_ctx() at main.c:621)
DEBUG1 [367/502]: Freeing cmd_ctx->lsm, DONE (in clean_command_ctx() at main.c:622)
DEBUG1 [367/502]: Freeing cmd_ctx = 0x4c2004c8 (in clean_command_ctx() at main.c:624)
DEBUG1 [367/502]: FREEING 0x4c2004c8 (in clean_command_ctx() at main.c:625)
DEBUG1 [367/502]: Freeing cmd_ctx, DONE (in clean_command_ctx() at main.c:626)
DEBUG1 [367/502]: Accepting client command ... (in thread_manage_clients() at main.c:3789)
Session trace created.
Traces will be written in /root/lttng-traces/trace-19700101-000148
DEBUG1 [366/366]: Init config session in /root (in config_init() at conf.c:295)
root@kmeter1:~# lttng -vvv enable-channel mychannel -k --overwrite --subbuf-size
=4096 --num-subbuf=4
DEBUG3 [367/502]: [main] revents = 0, pollfd = 3 (in thread_manage_clients() at main.c:3813)
DEBUG3 [367/502]: [main] revents = 0, skipping to next item (in thread_manage_clients() at main.c:3815)
DEBUG3 [367/502]: [main] revents = 1, pollfd = 9 (in thread_manage_clients() at main.c:3813)
DEBUG3 [367/502]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [367/502]: Wait for client response (in thread_manage_clients() at main.c:3837)
DEBUG1 [367/502]: cmd_ctx is now 0x4c2004c8 (in thread_manage_clients() at main.c:3865)
DEBUG1 [367/502]: Receiving data from client ... (in thread_manage_clients() at main.c:3885)
DEBUG1 [367/502]: Nothing recv() from client... continuing (in thread_manage_clients() at main.c:3889)
DEBUG1 [367/502]: Clean command context structure, cmd_ctx = 0x4c2004c8 (in clean_command_ctx() at main.c:612)
DEBUG1 [367/502]: Freeing cmd_ctx->lsm = 0x4c2004f0 (in clean_command_ctx() at main.c:620)
DEBUG1 [367/502]: FREEING 0x4c2004f0 (in clean_command_ctx() at main.c:621)
DEBUG1 [367/502]: Freeing cmd_ctx->lsm, DONE (in clean_command_ctx() at main.c:622)
DEBUG1 [367/502]: Freeing cmd_ctx = 0x4c2004c8 (in clean_command_ctx() at main.c:624)
DEBUG1 [367/502]: FREEING 0x4c2004c8 (in clean_command_ctx() at main.c:625)
DEBUG1 [367/502]: Freeing cmd_ctx, DONE (in clean_command_ctx() at main.c:626)
DEBUG1 [367/502]: Accepting client command ... (in thread_manage_clients() at main.c:3789)
DEBUG1 [509/509]: Channel set to overwrite (in cmd_enable_channels() at commands/enable_channels.c:341)
DEBUG1 [509/509]: Channel subbuf size set to 4096 (in cmd_enable_channels() at commands/enable_channels.c:375)
DEBUG1 [509/509]: Channel subbuf num set to 4 (in cmd_enable_channels() at commands/enable_channels.c:411)
DEBUG2 [509/509]: Config file path found: /root (in get_session_name() at utils.c:62)
DEBUG1 [509/509]: Session name found: trace (in get_session_name() at utils.c:63)
DEBUG1 [509/509]: Enabling channel mychannel (in enable_channel() at commands/enable_channels.c:265)
DEBUG3 [367/502]: [main] revents = 0, pollfd = 3 (in thread_manage_clients() at main.c:3813)
DEBUG3 [367/502]: [main] revents = 0, skipping to next item (in thread_manage_clients() at main.c:3815)
DEBUG3 [367/502]: [main] revents = 1, pollfd = 9 (in thread_manage_clients() at main.c:3813)
DEBUG3 [367/502]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [367/502]: Wait for client response (in thread_manage_clients() at main.c:3837)
DEBUG1 [367/502]: cmd_ctx is now 0x4c2004c8 (in thread_manage_clients() at main.c:3865)
DEBUG1 [367/502]: Receiving data from client ... (in thread_manage_clients() at main.c:3885)
DEBUG1 [509/509]: LSM cmd type : 5 (in send_session_msg() at lttng-ctl.c:131)
DEBUG1 [367/502]: Processing client command 5 (in process_client_msg() at main.c:2652)
DEBUG1 [367/502]: Getting session trace by name (in process_client_msg() at main.c:2731)
DEBUG2 [367/502]: Trying to find session by name trace (in session_find_by_name() at session.c:169)
DEBUG1 [367/502]: Creating kernel session (in create_kernel_session() at main.c:2568)
DEBUG3 [367/502]: Created hashtable size 4 at 0x4c2038d0 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [367/502]: Kernel session created (fd: 21) (in kernel_create_session() at kernel.c:109)
DEBUG3 [367/502]: Copying tracing session consumer output in kernel session (in copy_session_consumer() at main.c:2463)
DEBUG3 [367/500]: [ht-thread] nb_fd = 2 (in thread_ht_cleanup() at ht-cleanup.c:83)
DEBUG3 [367/500]: [ht-thread] revents = 0, pollfd = 3 (in thread_ht_cleanup() at ht-cleanup.c:93)
DEBUG3 [367/500]: [ht-thread] revents = 0, skipping to next item (in thread_ht_cleanup() at ht-cleanup.c:95)
DEBUG3 [367/500]: [ht-thread] revents = 1, pollfd = 13 (in thread_ht_cleanup() at ht-cleanup.c:93)
DEBUG3 [367/500]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [367/500]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:64)
DEBUG3 [367/502]: Created hashtable size 4 at 0x4c2038d0 of type 1 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [367/502]: Copy session consumer subdir /kernel (in copy_session_consumer() at main.c:2499)
DEBUG3 [367/502]: mkdir() recursive /root/lttng-traces/trace-19700101-000148 with mode 504 for uid 0 and gid 0 (in run_as_mkdir_recursive() at runas.c:308)
DEBUG1 [367/502]: Using run_as_clone (in run_as() at runas.c:291)
DEBUG1 [367/502]: Spawning consumerd (in spawn_consumerd() at main.c:2173)
DEBUG2 [367/502]: Consumer pid 511 (in start_consumerd() at main.c:2355)
DEBUG2 [367/502]: Spawning consumer control thread (in start_consumerd() at main.c:2358)
DEBUG1 [367/512]: [thread] Manage consumer started (in thread_manage_consumer() at main.c:1005)
DEBUG1 [367/512]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/512]: fd 5 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG3 [511/511]: Looking for a kernel consumer at these locations: (in spawn_consumerd() at main.c:2192)
DEBUG3 [511/511]: 	1)  (in spawn_consumerd() at main.c:2193)
DEBUG3 [511/511]: 	2) /usr/local/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2194)
DEBUG3 [511/511]: 	3) /usr/local/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2195)
DEBUG3 [511/511]: Found location #2 (in spawn_consumerd() at main.c:2200)
DEBUG1 [511/511]: Using kernel consumer at: /usr/local/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2210)
DEBUG1 [511/511]: poll set max size set to 65535 (in compat_poll_set_max_size() at compat-poll.c:318)
DEBUG3 [511/511]: Created hashtable size 4 at 0x1004c018 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [511/511]: Created hashtable size 4 at 0x1004c240 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [511/511]: Created hashtable size 4 at 0x1004c468 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [511/511]: Created hashtable size 4 at 0x1004c690 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [511/511]: Created hashtable size 4 at 0x1004c8b8 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG3 [511/511]: Created hashtable size 4 at 0x1004cae0 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [511/511]: TCP inet operation timeout set to 216 sec (in lttcomm_inet_init() at inet.c:529)
DEBUG1 [511/511]: Health check time delta in seconds set to 236 (in health_init() at health.c:73)
DEBUG1 [511/511]: Connecting to error socket /var/run/lttng/kconsumerd/error (in main() at lttng-consumerd.c:395)
DEBUG3 [367/512]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [367/512]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG2 [367/512]: Receiving code from consumer err_sock (in thread_manage_consumer() at main.c:1091)
DEBUG1 [511/513]: [thread] Manage health check started (in thread_manage_health() at health-consumerd.c:168)
Warning: No tracing group detected
DEBUG1 [511/513]: fd 17 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [511/513]: fd 19 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [511/513]: Health check ready (in thread_manage_health() at health-consumerd.c:241)
DEBUG1 [511/517]: Creating command socket /var/run/lttng/kconsumerd/command (in consumer_thread_sessiond_poll() at consumer.c:2991)
DEBUG1 [511/517]: Sending ready command to lttng-sessiond (in consumer_thread_sessiond_poll() at consumer.c:3004)
DEBUG1 [367/512]: Consumer command socket ready (fd: 23 (in thread_manage_consumer() at main.c:1125)
DEBUG1 [367/512]: Consumer metadata socket ready (fd: 24) (in thread_manage_consumer() at main.c:1127)
DEBUG1 [367/512]: fd 22 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/512]: fd 24 of 3 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG3 [367/502]: Consumer socket created (fd: 23) and added to output (in consumer_create_socket() at consumer.c:301)
DEBUG1 [367/502]: Setting relayd for session trace (in cmd_setup_relayd() at cmd.c:722)
DEBUG1 [367/502]: Enabling channel mychannel for session trace (in cmd_enable_channel() at cmd.c:910)
DEBUG1 [367/502]: Trying to find channel mychannel (in trace_kernel_get_channel_by_name() at trace-kernel.c:48)
DEBUG3 [367/502]: Kernel create channel mychannel with attr: 1, 4096, 4, 0, 200000, -1, 0 (in kernel_create_channel() at kernel.c:143)
DEBUG1 [367/502]: Kernel channel mychannel created (fd: 25) (in kernel_create_channel() at kernel.c:165)
DEBUG3 [367/508]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [367/508]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [367/508]: fd 3 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/508]: fd 11 of 2 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/508]: Updating kernel poll set (in update_kernel_poll() at main.c:699)
DEBUG1 [511/517]: Connection on client_socket (in consumer_thread_sessiond_poll() at consumer.c:3026)
DEBUG1 [511/517]: Metadata connection on client_socket (in set_metadata_socket() at consumer.c:2950)
DEBUG1 [511/516]: Updating poll fd array (in update_poll_array() at consumer.c:1060)
DEBUG1 [511/516]: polling on 1 fd (in consumer_thread_data_poll() at consumer.c:2443)
DEBUG1 [511/515]: Thread metadata poll started (in consumer_thread_metadata_poll() at consumer.c:2175)
DEBUG1 [511/515]: fd 12 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [511/515]: Metadata main loop started (in consumer_thread_metadata_poll() at consumer.c:2191)
DEBUG1 [511/515]: Metadata poll wait with 0 fd(s) (in consumer_thread_metadata_poll() at consumer.c:2203)
DEBUG3 [511/514]: Created hashtable size 4 at 0x1004d240 of type 2 (in lttng_ht_new() at hashtable.c:127)
DEBUG1 [511/514]: Thread channel poll started (in consumer_thread_channel_poll() at consumer.c:2730)
DEBUG1 [511/514]: fd 10 of 1 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [511/514]: Channel main loop started (in consumer_thread_channel_poll() at consumer.c:2745)
DEBUG1 [511/514]: Channel poll wait with 0 fd(s) (in consumer_thread_channel_poll() at consumer.c:2757)
DEBUG1 [367/502]: Kernel quiescent wait on 6 (in kernel_wait_quiescent() at kernel.c:429)
DEBUG1 [367/508]: fd 25 of 3 added to pollfd (in compat_poll_add() at compat-poll.c:193)
DEBUG1 [367/508]: Channel fd 25 added to kernel set (in update_kernel_poll() at main.c:717)
DEBUG1 [367/508]: Thread kernel polling on 0 fds (in thread_manage_kernel() at main.c:885)
DEBUG3 [367/508]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [367/508]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG3 [367/508]: [...] thread_quit_pipe = 3 (in sessiond_check_thread_quit_pipe() at main.c:366)
DEBUG1 [367/508]: Updating kernel streams for channel fd 25 (in update_kernel_stream() at main.c:743)
DEBUG1 [367/508]: Channel found, updating kernel streams (in update_kernel_stream() at main.c:756)
DEBUG1 [367/508]: Kernel stream mychannel_0 created (fd: 26, state: 0) (in kernel_open_channel_stream() at kernel.c:562)
DEBUG1 [367/508]: Thread kernel polling on 3 fds (in thread_manage_kernel() at main.c:885)
DEBUG1 [367/502]: Sending response (size: 16, retcode: Success) (in thread_manage_clients() at main.c:3934)
Kernel channel mychannel enabled for session trace
root@kmeter1:~# DEBUG1 [367/502]: Clean command context structure, cmd_ctx = 0x4c2004c8 (in clean_command_ctx() at main.c:612)
DEBUG1 [367/502]: Freeing cmd_ctx->llm = 0x4c203858 (in clean_command_ctx() at main.c:615)
DEBUG1 [367/502]: FREEING 0x4c203858 (in clean_command_ctx() at main.c:616)
DEBUG1 [367/502]: Freeing cmd_ctx->llm, DONE (in clean_command_ctx() at main.c:617)
DEBUG1 [367/502]: Freeing cmd_ctx->lsm = 0x4c2004f0 (in clean_command_ctx() at main.c:620)
DEBUG1 [367/502]: FREEING 0x4c2004f0 (in clean_command_ctx() at main.c:621)
DEBUG1 [367/502]: Freeing cmd_ctx->lsm, DONE (in clean_command_ctx() at main.c:622)
DEBUG1 [367/502]: Freeing cmd_ctx = 0x4c2004c8 (in clean_command_ctx() at main.c:624)
DEBUG1 [367/502]: FREEING 0x4c2004c8 (in clean_command_ctx() at main.c:625)
DEBUG1 [367/502]: Freeing cmd_ctx, DONE (in clean_command_ctx() at main.c:626)
DEBUG1 [367/502]: Accepting client command ... (in thread_manage_clients() at main.c:3789)



--------------070905030500040407020100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------070905030500040407020100--
