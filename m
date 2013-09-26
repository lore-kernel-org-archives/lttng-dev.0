From: Manikandan <email@manikandan.co.in>
Subject: Lttng start failure
Date: Thu, 26 Sep 2013 12:47:38 +0000 (UTC)
Message-ID: <loom.20130926T144725-840__10000.8999616422$1380200166$gmane$org@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from plane.gmane.org ([80.91.229.3])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <glktld-ltt-dev@m.gmane.org>) id 1VPB61-0001cX-DS
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 08:55:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glktld-ltt-dev@m.gmane.org>) id 1VPB5z-0008Po-BU
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 14:55:03 +0200
Received: from illchn-static-202.54.152.130.vsnl.net.in
	([illchn-static-202.54.152.130.vsnl.net.in])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Thu, 26 Sep 2013 14:55:03 +0200
Received: from email by illchn-static-202.54.152.130.vsnl.net.in with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Thu, 26 Sep 2013 14:55:03 +0200
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

Hi,

I'm using arm cortex 9 processor and I build the lttng modules, userspace 
rcu and tools using arm-linux-gnueabi toolchain.

After I compile and deployed on the target 
1.
./lttng-sessiond -vvv --consumer32-path /tmp/lt
tng-build-root/lib/lttng/libexec -d
./lttng-sessiond: unrecognized option '--consumer32-path'
root@/tmp/lttng-build-root/bin # ./lttng-sessiond -vvv --consumerd32-path 
/tmp/l
ttng-build-root/lib/lttng/libexec
DEBUG3: Creating LTTng run directory: /tmp/lttng [in create_lttng_rundir() 
at ma
in.c:3692]
DEBUG2: Kernel consumer err path: /tmp/lttng/kconsumerd/error [in main() at 
main
.c:3940]
DEBUG2: Kernel consumer cmd path: /tmp/lttng/kconsumerd/command [in main() 
at ma
in.c:3942]
DEBUG1: Client socket path /tmp/lttng/client-lttng-slttng_tracer: Unknown 
symbol
 lttng_statedump_start (err 0)
essiond [in main() at main.c:3995]
DEBUG1: Application socket plttng_tracer: Unknown symbol 
lib_ring_buffer_file_op
erations (err 0)
ath /tmp/lttng/apps-lttng-sessiond [in main() at main.c:3996]
DEBUG1: LTTng run directory path: /tmp/lttng [in main() at main.c:3997]
DEBUG2: UST consumer 32 bits err path: /tmp/lttng/ustconsumerd32/error [in 
main(
) at main.c:4006]
DEBUG2: UST consumer 32 bits cmd path: /tmp/lttng/ustconsumerd32/command [in 
mai
n() at main.c:4008]
DEBUG2: UST consumer 64 bits err path: /tmp/lttng/ustconsumerd64/error [in 
main(
) at main.c:4017]
DEBUG2: UST consumer 64 bits cmd path: /tmp/lttng/ustconsumerd64/command [in 
mai
n() at main.c:4019]
DEBUG2: Creating consumer directory: /tmp/lttng/kconsumerd [in 
set_consumer_sock
ets() at main.c:3734]
DEBUG1: Modprobe successfully lttng-tracer [in modprobe_lttng_control() at 
modpr
obe.c:180]
DEBUG2: Kernel tracer version validated (major version 2) [in 
kernel_validate_ve
rsion() at kernel.c:649]
modprobe: module 'lttng_ftrace' not found
DEBUG1: Modprobe successfully lttng-ftrace [in modprobe_lttng_data() at 
modprobe
.c:216]
modprobe: module 'lttng_kprobes' not found
DEBUG1: Modprobe successfully lttng-kprobes [in modprobe_lttng_data() at 
modprob
e.c:216]
modprobe: module 'lttng_kretprobes' not found
DEBUG1: Modprobe successfully lttng-kretprobes [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-lib-ring-buffer [in 
modprobe_lttng_data() at
 modprobe.c:216]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-discard [in 
modprobe_lttn
g_data() at modprobe.c:216]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-overwrite [in 
modprobe_lt
tng_data() at modprobe.c:216]
DEBUG1: Modprobe successfully lttng-ring-buffer-metadata-client [in 
modprobe_ltt
ng_data() at modprobe.c:216]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-mmap-discard [in 
modprobe
_lttng_data() at modprobe.c:216]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-mmap-overwrite [in 
modpro
be_lttng_data() at modprobe.c:216]
DEBUG1: Modprobe successfully lttng-ring-buffer-metadata-mmap-client [in 
modprob
e_lttng_data() at modprobe.c:216]
modprobe: module 'lttng_probe_lttng' not found
DEBUG1: Modprobe successfully lttng-probe-lttng [in modprobe_lttng_data() at 
mod
probe.c:216]
DEBUG1: Modprobe successfully lttng-types [in modprobe_lttng_data() at 
modprobe.
c:216]
modprobe: module 'lttng_probe_asoc' not found
DEBUG1: Modprobe successfully lttng-probe-asoc [in modprobe_lttng_data() at 
modp
robe.c:216]
modprobe: module 'lttng_probe_block' not found
DEBUG1: Modprobe successfully lttng-probe-block [in modprobe_lttng_data() at 
mod
probe.c:216]
DEBUG1: Modprobe successfully lttng-probe-ext3 [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-probe-gpio [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-probe-irq [in modprobe_lttng_data() at 
modpr
obe.c:216]
DEBUG1: Modprobe successfully lttng-probe-jbd [in modprobe_lttng_data() at 
modpr
obe.c:216]
DEBUG1: Modprobe successfully lttng-probe-jbd2 [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-probe-kmem [in modprobe_lttng_data() at 
modp
robe.c:216]
modprobe: module 'lttng_probe_kvm' not found
DEBUG1: Modprobe successfully lttng-probe-kvm [in modprobe_lttng_data() at 
modpr
obe.c:216]
modprobe: module 'lttng_probe_lock' not found
DEBUG1: Modprobe successfully lttng-probe-lock [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-probe-module [in modprobe_lttng_data() 
at mo
dprobe.c:216]
DEBUG1: Modprobe successfully lttng-probe-napi [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-probe-net [in modprobe_lttng_data() at 
modpr
obe.c:216]
DEBUG1: Modprobe successfully lttng-probe-power [in modprobe_lttng_data() at 
mod
probe.c:216]
modprobe: module 'lttng_probe_regulator' not found
DEBUG1: Modprobe successfully lttng-probe-regulator [in 
modprobe_lttng_data() at
 modprobe.c:216]
DEBUG1: Modprobe successfully lttng-probe-sched [in modprobe_lttng_data() at 
mod
probe.c:216]
DEBUG1: Modprobe successfully lttng-probe-scsi [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-probe-signal [in modprobe_lttng_data() 
at mo
dprobe.c:216]
DEBUG1: Modprobe successfully lttng-probe-skb [in modprobe_lttng_data() at 
modpr
obe.c:216]
DEBUG1: Modprobe successfully lttng-probe-sock [in modprobe_lttng_data() at 
modp
robe.c:216]
DEBUG1: Modprobe successfully lttng-probe-statedump [in 
modprobe_lttng_data() at
 modprobe.c:216]
DEBUG1: Modprobe successfully lttng-probe-timer [in modprobe_lttng_data() at 
mod
probe.c:216]
DEBUG1: Modprobe successfully lttng-probe-udp [in modprobe_lttng_data() at 
modpr
obe.c:216]
DEBUG1: Modprobe successfully lttng-probe-vmscan [in modprobe_lttng_data() 
at mo
dprobe.c:216]
DEBUG1: Kernel tracer fd 6 [in init_kernel_tracer() at main.c:1978]
DEBUG2: Creating consumer directory: /tmp/lttng/ustconsumerd64 [in 
set_consumer_
sockets() at main.c:3734]
DEBUG2: Creating consumer directory: /tmp/lttng/ustconsumerd32 [in 
set_consumer_
sockets() at main.c:3734]
DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in 
set_signal_handle
r() at main.c:3826]
DEBUG3: Session daemon client socket 9 and application socket 10 created [in 
ini
t_daemon_socket() at main.c:3596]
Warning: No tracing group detected
DEBUG1: epoll set max size is 268040 [in compat_epoll_set_max_size() at 
compat-e
poll.c:270]
DEBUG1: Command subsystem initialized [in cmd_init() at cmd.c:2423]
DEBUG1: [thread] Manage health check started [in thread_manage_health() at 
main.
c:2953]
DEBUG1: [thread] Dispatch UST command started [in 
thread_dispatch_ust_registrati
on() at main.c:1300]
DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:75]
DEBUG1: Woken up but nothing in the UST command queue [in 
thread_dispatch_ust_re
gistration() at main.c:1310]
DEBUG1: [thread] Manage application registration started [in 
thread_registration
_apps() at main.c:1378]
DEBUG1: [thread] Thread manage kernel started [in thread_manage_kernel() at 
main
.c:692]
DEBUG1: Health check ready [in thread_manage_health() at main.c:2992]
DEBUG1: [thread] Manage client started [in thread_manage_clients() at 
main.c:314
7]
DEBUG1: Notifying applications of session daemon state: 1 [in 
notify_ust_apps()
at main.c:496]
DEBUG1: Accepting client command ... [in thread_manage_clients() at 
main.c:3191]
DEBUG1: [thread] Manage application started [in thread_manage_apps() at 
main.c:1
107]
DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at 
main.c:1135]
DEBUG1: Got the wait shm fd 20 [in get_wait_shm() at shm.c:117]
DEBUG1: Futex wait update active 1 [in futex_wait_update() at futex.c:63]
DEBUG1: Accepting application registration [in thread_registration_apps() at 
mai
n.c:1413]
DEBUG1: Updating kernel poll set [in update_kernel_poll() at main.c:557]
DEBUG1: Thread kernel polling on 2 fds [in thread_manage_kernel() at 
main.c:735]


2. I run "./lttng create test"
3. ./lttng enable-event -a -k
All kernel events are enabled in channel channel0

4. ./lttng start
LTTng: Failure to write metadata to buffers (timeout)
Error: Starting kernel trace failed


And I'm using linux 3.9.0 kernel for my testing.

Please tell me why this error is coming.
/Manikandan G
