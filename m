From: "Arulraj, Dhiliphen IN BLR STS" <Dhiliphen.Arulraj@siemens.com>
Subject: LTTng run issues
Date: Thu, 30 Aug 2012 20:20:41 +0530
Message-ID: <18BECF85FEE8A1469B4AD1584AE2FF200AE61D8EC7__31197.4214077511$1346347732$gmane$org@INBLRK77M2MSX.in002.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from krishna.sisl.co.in ([194.138.248.75])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Dhiliphen.Arulraj@siemens.com>) id 1T765U-0002C8-V4
	for lttng-dev@lists.lttng.org; Thu, 30 Aug 2012 10:51:17 -0400
Received: from kaveri.sisl.co.in (kaveri.sisl.co.in [132.186.192.4])
	by krishna.sisl.co.in (Postfix) with ESMTP id 5DA0913DCD1
	for <lttng-dev@lists.lttng.org>; Thu, 30 Aug 2012 20:54:00 +0530 (IST)
Received: from INBLRK77N3MSX.in002.siemens.net
	(inblrk77n3msx.in002.siemens.net [132.186.221.164])
	by kaveri.sisl.co.in (Postfix) with ESMTP id 767013E63E3
	for <lttng-dev@lists.lttng.org>; Thu, 30 Aug 2012 20:01:06 +0530 (IST)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello ,

I am new to LTTng usage. When trying to run lttng 2.0.4 for tracing my kernel I get the following issue - 

root@am335x-evm:/media/mmcblk0p1/lttng_bin/bin# ./arm-arago-linux-gnueabi-lttng start
[ 1775.934997] LTTng: Failure to write metadata to buffers (timeout)
Error: Starting kernel trace failed

I checked the session daemon for startup issues and got the following - 

./arm-arago-linux-gnueabi-lttng-
sessiond -vvv --consumerd32-path /media/mmcblk0p1/lttng_bin/lib/lttng/libexec

root@am335x-evm:/media/mmcblk0p1/lttng_bin/bin# ./arm-arago-linux-gnueabi-lttng-
sessiond -vvv --consumerd32-path /media/mmcblk0p1/lttng_bin/lib/lttng/libexec
DEBUG3: Creating LTTng run directory: /var/run/lttng [in create_lttng_rundir() a
t main.c:4317]
DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [in main() at
main.c:4560]
DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in main() a
t main.c:4562]
DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in main() at ma
in.c:4609]
DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in main() at
main.c:4610]
DEBUG1: LTTng run directory path: /var/run/lttng [in main() at main.c:4611]
DEBUG2: UST consumer 32 bits err path: /var/run/lttng/ustconsumerd32/error [in m
ain() at main.c:4620]
DEBUG2: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command [in
main() at main.c:4622]
DEBUG2: UST consumer 64 bits err path: /var/run/lttng/ustconsumerd64/error [in m
ain() at main.c:4631]
DEBUG2: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command [in
main() at main.c:4633]
DEBUG2: Creating consumer directory: /var/run/lttng/kconsumerd [in set_consumer_
sockets() at main.c:4359]
DEBUG1: Modprobe successfully lttng-tracer [in modprobe_lttng_control() at modpr
obe.c:163]
DEBUG2: Kernel tracer version validated (major version 2) [in kernel_validate_ve
rsion() at kernel.c:675]
DEBUG1: Modprobe successfully lttng-ftrace [in modprobe_lttng_data() at modprobe
.c:199]
DEBUG1: Modprobe successfully lttng-kprobes [in modprobe_lttng_data() at modprob
e.c:199]
DEBUG1: Modprobe successfully lttng-kretprobes [in modprobe_lttng_data() at modp
robe.c:199]
DEBUG1: Modprobe successfully lttng-lib-ring-buffer [in modprobe_lttng_data() at
modprobe.c:199]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-discard [in modprobe_lttn
g_data() at modprobe.c:199]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-overwrite [in modprobe_lt
tng_data() at modprobe.c:199]
DEBUG1: Modprobe successfully lttng-ring-buffer-metadata-client [in modprobe_ltt
ng_data() at modprobe.c:199]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-mmap-discard [in modprobe
_lttng_data() at modprobe.c:199]
DEBUG1: Modprobe successfully lttng-ring-buffer-client-mmap-overwrite [in modpro
be_lttng_data() at modprobe.c:199]
DEBUG1: Modprobe successfully lttng-ring-buffer-metadata-mmap-client [in modprob
e_lttng_data() at modprobe.c:199]
DEBUG1: Modprobe successfully lttng-probe-lttng [in modprobe_lttng_data() at mod
probe.c:199]
DEBUG1: Modprobe successfully lttng-types [in modprobe_lttng_data() at modprobe.
c:199]
DEBUG1: Modprobe successfully lttng-probe-block [in modprobe_lttng_data() at mod
probe.c:199]
DEBUG1: Modprobe successfully lttng-probe-irq [in modprobe_lttng_data() at modpr
obe.c:199]
DEBUG1: Modprobe successfully lttng-probe-kvm [in modprobe_lttng_data() at modpr
obe.c:199]
DEBUG1: Modprobe successfully lttng-probe-sched [in modprobe_lttng_data() at mod
probe.c:199]
DEBUG1: Modprobe successfully lttng-probe-signal [in modprobe_lttng_data() at mo
dprobe.c:199]
DEBUG1: Modprobe successfully lttng-probe-statedump [in modprobe_lttng_data() at
modprobe.c:199]
DEBUG1: Modprobe successfully lttng-probe-timer [in modprobe_lttng_data() at mod
probe.c:199]
DEBUG1: Kernel tracer fd 6 [in init_kernel_tracer() at main.c:1887]
DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd64 [in set_consu
mer_sockets() at main.c:4359]
DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd32 [in set_consu
mer_sockets() at main.c:4359]
DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in set_signal_handle
r() at main.c:4451]
Warning: No tracing group detected
DEBUG1: epoll set max size is 95800 [in compat_epoll_set_max_size() at compat-ep
oll.c:224]
DEBUG1: Thread manage kernel started [in thread_manage_kernel() at main.c:876]
DEBUG1: Updating kernel poll set [in update_kernel_poll() at main.c:748]
DEBUG1: Thread kernel polling on 2 fds [in thread_manage_kernel() at main.c:905]
DEBUG1: [thread] Manage application started [in thread_manage_apps() at main.c:1
179]
DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at main.c:1200]
DEBUG1: [thread] Manage application registration started [in thread_registration
_apps() at main.c:1392]
DEBUG1: Notifying applications of session daemon state: 1 [in notify_ust_apps()
at main.c:687]
DEBUG1: Got the wait shm fd 18 [in get_wait_shm() at shm.c:117]
DEBUG1: Futex wait update active 1 [in futex_wait_update() at futex.c:62]
DEBUG1: Accepting application registration [in thread_registration_apps() at mai
n.c:1423]
DEBUG1: [thread] Dispatch UST command started [in thread_dispatch_ust_registrati
on() at main.c:1324]
DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:73]
DEBUG1: Woken up but nothing in the UST command queue [in thread_dispatch_ust_re
gistration() at main.c:1334]
DEBUG1: [thread] Manage client started [in thread_manage_clients() at main.c:379
4]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:3826]

From the above it seems I don't have any problems. Yes I get that failure when running lttng.

I'm running this on a TI AM335x EVM with the lttng modules compiled against the arago 05.04 linux kernel(Version 3.2) and everything compiled using the arago toolchain.

Thanks in advance 
Dhiliphen
