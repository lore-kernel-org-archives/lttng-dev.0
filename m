From: Neil Bryan <Neil.Bryan@ttp.com>
Subject: lttng-tracer missing
Date: Tue, 17 Feb 2015 17:02:16 +0000
Message-ID: <8369DAE2C5B8814998E89CE414A915381F6B7AF4__5975.57289661399$1424192761$gmane$org@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0801689077=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.148])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Neil.Bryan@ttp.com>) id 1YNlXQ-0006Oi-9E
 for lttng-dev@lists.lttng.org; Tue, 17 Feb 2015 12:02:23 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0801689077==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8369DAE2C5B8814998E89CE414A915381F6B7AF4ITMailbox3TTPGr_"

--_000_8369DAE2C5B8814998E89CE414A915381F6B7AF4ITMailbox3TTPGr_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Forum,

I am having a few problems enabling LTTng kernel tracing. I am using Yocto =
on an Alter SOC FPGA platform.
I have added the following to local.conf to bring in the required packages:
<SNIP>
EXTRA_IMAGE_FEATURES =3D "debug-tweaks tools-debug tools-profile"
PACKAGE_DEBUG_SPLIT_STYLE =3D 'debug-file-directory'

INHIBIT_PACKAGE_STRIP =3D "1"

KERNEL_CONFIG_TRACEPOINTS=3D"y"
KERNEL_CONFIG_HAVE_ARCH_TRACEHOOK=3D"y"
KERNEL_CONFIG_TRACE_IRQFLAGS=3D"y"
KERNEL_CONFIG_STACKTRACE=3D"y"
KERNEL_CONFIG_FRAME_POINTER=3D"y"
KERNEL_CONFIG_NOP_TRACER=3D"y"
KERNEL_CONFIG_TRACER_MAX_TRACE=3D"y"
KERNEL_CONFIG_EVENT_TRACING=3D"y"
KERNEL_CONFIG_EVENT_POWER_TRACING_DEPRECATED=3D"y"
KERNEL_CONFIG_CONTEXT_SWITCH_TRACER=3D"y"
KERNEL_CONFIG_TRACING=3D"y"
KERNEL_CONFIG_GENERIC_TRACER=3D"y"
KERNEL_CONFIG_FTRACE=3D"y"
KERNEL_CONFIG_FUNCTION_TRACER=3D"y"
KERNEL_CONFIG_FUNCTION_GRAPH_TRACER=3D"y"
KERNEL_CONFIG_IRQSOFF_TRACER=3D"y"
KERNEL_CONFIG_PREEMPT_TRACER=3D"y"
KERNEL_CONFIG_SCHED_TRACER=3D"y"
KERNEL_CONFIG_FTRACE_SYSCALLS=3D"y"
KERNEL_CONFIG_BRANCH_PROFILE_NONE=3D"y"
KERNEL_CONFIG_STACK_TRACER=3D"y"
KERNEL_CONFIG_BLK_DEV_IO_TRACE=3D"y"
KERNEL_CONFIG_KPROBES=3D"y"
KERNEL_CONFIG_KPROBE_EVENT=3D"y"
KERNEL_CONFIG_DYNAMIC_FTRACE=3D"y"
KERNEL_CONFIG_FUNCTION_PROFILER=3D"y"
KERNEL_CONFIG_FTRACE_MCOUNT_RECORD=3D"y"
KERNEL_CONFIG_FTRACE_SELFTEST=3D"y"
KERNEL_CONFIG_FTRACE_STARTUP_TEST=3D"y"
KERNEL_CONFIG_EVENT_TRACE_TEST_SYSCALLS=3D"y"
KERNEL_CONFIG_RING_BUFFER_BENCHMARK=3D"y"
<SNIP>

Following the bitbake build I see these kernel modules in the build output =
directory:

./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/lib/lib=
-ring-buffer.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-rin=
g-buffer-client-overwrite.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/=
lttng-probe-irq.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/=
lttng-probe-lttng.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/=
lttng-probe-block.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/=
lttng-probe-sched.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/=
lttng-types.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-rin=
g-buffer-metadata-mmap-client.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-rel=
ay.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-rin=
g-buffer-metadata-client.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-rin=
g-buffer-client-mmap-discard.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-rin=
g-buffer-client-discard.ko
./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-rin=
g-buffer-client-mmap-overwrite.ko

When I try to create an lttng session on the target I see the following (no=
t surprisingly as the lttng-tracer module is not present above):

root@socfpga_cyclone5:/lib/modules/3.7.0# lttng-sessiond -vvv
DEBUG3: Creating LTTng run directory: /var/run/lttng [in create_lttng_rundi=
r() at main.c:4315]
DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [in main(=
) at main.c:4543]
DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in mai=
n() at main.c:4545]
DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in main() =
at main.c:4592]
DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in main=
() at main.c:4593]
DEBUG1: LTTng run directory path: /var/run/lttng [in main() at main.c:4594]
DEBUG2: UST consumer 32 bits err path: /var/run/lttng/ustconsumerd32/error =
[in main() at main.c:4603]
DEBUG2: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/comman=
d [in main() at main.c:4605]
DEBUG2: UST consumer 64 bits err path: /var/run/lttng/ustconsumerd64/error =
[in main() at main.c:4614]
DEBUG2: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/comman=
d [in main() at main.c:4616]
DEBUG3: Created hashtable size 4 at 0x37080 of type 1 [in lttng_ht_new() at=
 hashtable.c:96]
DEBUG3: Created hashtable size 4 at 0x37168 of type 1 [in lttng_ht_new() at=
 hashtable.c:96]
DEBUG2: Creating consumer directory: /var/run/lttng/kconsumerd [in set_cons=
umer_sockets() at main.c:4357]
FATAL: Module lttng-tracer not found.
Error: Unable to load module lttng-tracer
DEBUG1: Failed to open /proc/lttng [in init_kernel_tracer() at main.c:1871]
Error: Unable to remove module lttng-tracer
Warning: No kernel tracer available
DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd64 [in set_=
consumer_sockets() at main.c:4357]
DEBUG2: Creating consumer directory: /var/run/lttng/ustconsumerd32 [in set_=
consumer_sockets() at main.c:4357]
DEBUG1: Signal handler set for SIGTERM, SIGPIPE and SIGINT [in set_signal_h=
andler() at main.c:4449]
DEBUG1: All permissions are set [in set_permissions() at main.c:4250]
DEBUG1: epoll set max size is 89794 [in compat_epoll_set_max_size() at comp=
at-epoll.c:224]
DEBUG1: [thread] Manage client started [in thread_manage_clients() at main.=
c:3794]
DEBUG1: [thread] Dispatch UST command started [in thread_dispatch_ust_regis=
tration() at main.c:1324]
DEBUG1: Futex n to 1 prepare done [in futex_nto1_prepare() at futex.c:73]
DEBUG1: Accepting client command ... [in thread_manage_clients() at main.c:=
3826]
DEBUG1: Woken up but nothing in the UST command queue [in thread_dispatch_u=
st_registration() at main.c:1334]
DEBUG1: Thread manage kernel started [in thread_manage_kernel() at main.c:8=
76]
DEBUG1: [thread] Manage application started [in thread_manage_apps() at mai=
n.c:1179]
DEBUG1: [thread] Manage application registration started [in thread_registr=
ation_apps() at main.c:1392]
DEBUG1: Notifying applications of session daemon state: 1 [in notify_ust_ap=
ps() at main.c:687]
DEBUG1: Updating kernel poll set [in update_kernel_poll() at main.c:748]
DEBUG1: Apps thread polling on 2 fds [in thread_manage_apps() at main.c:120=
0]
DEBUG1: Thread kernel polling on 2 fds [in thread_manage_kernel() at main.c=
:905]
DEBUG1: Got the wait shm fd 18 [in get_wait_shm() at shm.c:117]
DEBUG1: Futex wait update active 1 [in futex_wait_update() at futex.c:62]
DEBUG1: Accepting application registration [in thread_registration_apps() a=
t main.c:1423]

DEBUG1: SIGINT caught [in sighandler() at main.c:4404]
DEBUG1: Terminating all threads [in stop_threads() at main.c:412]
DEBUG1: Futex n to 1 wake done [in futex_nto1_wake() at futex.c:100]
DEBUG1: Kernel thread dying [in thread_manage_kernel() at main.c:967]
DEBUG1: Application communication apps thread cleanup complete [in thread_m=
anage_apps() at main.c:1308]
DEBUG1: Futex n to 1 wait done [in futex_nto1_wait() at futex.c:87]
DEBUG1: Notifying applications of session daemon state: 0 [in notify_ust_ap=
ps() at main.c:687]
DEBUG1: Dispatch thread dying [in thread_dispatch_ust_registration() at mai=
n.c:1374]
DEBUG1: Got the wait shm fd 15 [in get_wait_shm() at shm.c:117]
DEBUG1: Client thread dying [in thread_manage_clients() at main.c:3953]
DEBUG1: Futex wait update active 0 [in futex_wait_update() at futex.c:62]
DEBUG1: Clean command context structure [in clean_command_ctx() at main.c:5=
34]
DEBUG1: UST Registration thread cleanup complete [in thread_registration_ap=
ps() at main.c:1551]
DEBUG1: Cleaning up [in cleanup() at main.c:432]
DEBUG1: Removing /var/run/lttng directory [in cleanup() at main.c:434]
DEBUG1: Cleaning up all sessions [in cleanup() at main.c:447]
DEBUG1: Closing all UST sockets [in cleanup() at main.c:462]
DEBUG2: UST app cleaning registered apps hash table [in ust_app_clean_list(=
) at ust-app.c:1509]
DEBUG2: Closing kernel fd [in cleanup() at main.c:468]
DEBUG1: Unloading kernel modules [in cleanup() at main.c:475]
DEBUG1: Modprobe removal successful lttng-probe-timer [in modprobe_remove_l=
ttng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-probe-statedump [in modprobe_remo=
ve_lttng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-probe-signal [in modprobe_remove_=
lttng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-probe-sched [in modprobe_remove_l=
ttng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-probe-kvm [in modprobe_remove_ltt=
ng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-probe-irq [in modprobe_remove_ltt=
ng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-probe-block [in modprobe_remove_l=
ttng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-types [in modprobe_remove_lttng_d=
ata() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-probe-lttng [in modprobe_remove_l=
ttng_data() at modprobe.c:118]
Error: Unable to remove module lttng-ring-buffer-metadata-mmap-client
Error: Unable to remove module lttng-ring-buffer-client-mmap-overwrite
Error: Unable to remove module lttng-ring-buffer-client-mmap-discard
Error: Unable to remove module lttng-ring-buffer-metadata-client
Error: Unable to remove module lttng-ring-buffer-client-overwrite
Error: Unable to remove module lttng-ring-buffer-client-discard
Error: Unable to remove module lttng-lib-ring-buffer
DEBUG1: Modprobe removal successful lttng-kretprobes [in modprobe_remove_lt=
tng_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-kprobes [in modprobe_remove_lttng=
_data() at modprobe.c:118]
DEBUG1: Modprobe removal successful lttng-ftrace [in modprobe_remove_lttng_=
data() at modprobe.c:118]
Error: Unable to remove module lttng-tracer
DEBUG1: *** assert failed :-) *** =3D=3D> Matthew, BEET driven development =
works! [in cleanup()

I am running an early(ish) version of the kernel (3.7) but this is because =
the Altera Yocto source package is quite an old vintage.

Any clues as to what am I doing wrong?

Thanks for any help anyone can offer.

Best regards,

Neil.




--_000_8369DAE2C5B8814998E89CE414A915381F6B7AF4ITMailbox3TTPGr_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:2.0cm 42.5pt 2.0cm 3.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Forum,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am having a few problems enabling LTTng kernel tra=
cing. I am using Yocto on an Alter SOC FPGA platform.<o:p></o:p></p>
<p class=3D"MsoNormal">I have added the following to local.conf to bring in=
 the required packages:<o:p></o:p></p>
<p class=3D"MsoNormal">&lt;SNIP&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">EXTRA_IMAGE_FEATURES =3D &quot;debug-tweaks tools-de=
bug tools-profile&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">PACKAGE_DEBUG_SPLIT_STYLE =3D 'debug-file-directory'=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">INHIBIT_PACKAGE_STRIP =3D &quot;1&quot;<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_TRACEPOINTS=3D&quot;y&quot;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">KERNEL_CONFIG_HAVE_ARCH_TRACEHOOK=3D&quot;y&quot;<o:=
p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_TRACE_IRQFLAGS=3D&quot;y&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_STACKTRACE=3D&quot;y&quot;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FRAME_POINTER=3D&quot;y&quot;<o:p></o:=
p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_NOP_TRACER=3D&quot;y&quot;<o:p></o:p><=
/p>
<p class=3D"MsoNormal">KERNEL_CONFIG_TRACER_MAX_TRACE=3D&quot;y&quot;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_EVENT_TRACING=3D&quot;y&quot;<o:p></o:=
p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_EVENT_POWER_TRACING_DEPRECATED=3D&quot=
;y&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_CONTEXT_SWITCH_TRACER=3D&quot;y&quot;<=
o:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_TRACING=3D&quot;y&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_GENERIC_TRACER=3D&quot;y&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FTRACE=3D&quot;y&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FUNCTION_TRACER=3D&quot;y&quot;<o:p></=
o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FUNCTION_GRAPH_TRACER=3D&quot;y&quot;<=
o:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_IRQSOFF_TRACER=3D&quot;y&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_PREEMPT_TRACER=3D&quot;y&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_SCHED_TRACER=3D&quot;y&quot;<o:p></o:p=
></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FTRACE_SYSCALLS=3D&quot;y&quot;<o:p></=
o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_BRANCH_PROFILE_NONE=3D&quot;y&quot;<o:=
p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_STACK_TRACER=3D&quot;y&quot;<o:p></o:p=
></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_BLK_DEV_IO_TRACE=3D&quot;y&quot;<o:p><=
/o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_KPROBES=3D&quot;y&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_KPROBE_EVENT=3D&quot;y&quot;<o:p></o:p=
></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_DYNAMIC_FTRACE=3D&quot;y&quot;<o:p></o=
:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FUNCTION_PROFILER=3D&quot;y&quot;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FTRACE_MCOUNT_RECORD=3D&quot;y&quot;<o=
:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FTRACE_SELFTEST=3D&quot;y&quot;<o:p></=
o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_FTRACE_STARTUP_TEST=3D&quot;y&quot;<o:=
p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_EVENT_TRACE_TEST_SYSCALLS=3D&quot;y&qu=
ot;<o:p></o:p></p>
<p class=3D"MsoNormal">KERNEL_CONFIG_RING_BUFFER_BENCHMARK=3D&quot;y&quot;<=
o:p></o:p></p>
<p class=3D"MsoNormal">&lt;SNIP&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Following the bitbake build I see these kernel modul=
es in the build output directory:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/lib/lib-ring-buffer.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/ltt-ring-buffer-client-overwrite.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/probes/lttng-probe-irq.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/probes/lttng-probe-lttng.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/probes/lttng-probe-block.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/probes/lttng-probe-sched.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/probes/lttng-types.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/ltt-ring-buffer-metadata-mmap-client.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/ltt-relay.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/ltt-ring-buffer-metadata-client.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/ltt-ring-buffer-client-mmap-discard.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/ltt-ring-buffer-client-discard.ko<o:p></o:p></p>
<p class=3D"MsoNormal">./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kerne=
l/lttng-modules/ltt-ring-buffer-client-mmap-overwrite.ko<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When I try to create an lttng session on the target =
I see the following (not surprisingly as the lttng-tracer module is not pre=
sent above):<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">root@socfpga_cyclone5:/lib/modules/3.7.0# lttng-sess=
iond -vvv<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG3: Creating LTTng run directory: /var/run/lttng=
 [in create_lttng_rundir() at main.c:4315]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: Kernel consumer err path: /var/run/lttng/kco=
nsumerd/error [in main() at main.c:4543]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: Kernel consumer cmd path: /var/run/lttng/kco=
nsumerd/command [in main() at main.c:4545]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Client socket path /var/run/lttng/client-ltt=
ng-sessiond [in main() at main.c:4592]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Application socket path /var/run/lttng/apps-=
lttng-sessiond [in main() at main.c:4593]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: LTTng run directory path: /var/run/lttng [in=
 main() at main.c:4594]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: UST consumer 32 bits err path: /var/run/lttn=
g/ustconsumerd32/error [in main() at main.c:4603]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: UST consumer 32 bits cmd path: /var/run/lttn=
g/ustconsumerd32/command [in main() at main.c:4605]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: UST consumer 64 bits err path: /var/run/lttn=
g/ustconsumerd64/error [in main() at main.c:4614]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: UST consumer 64 bits cmd path: /var/run/lttn=
g/ustconsumerd64/command [in main() at main.c:4616]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG3: Created hashtable size 4 at 0x37080 of type =
1 [in lttng_ht_new() at hashtable.c:96]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG3: Created hashtable size 4 at 0x37168 of type =
1 [in lttng_ht_new() at hashtable.c:96]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: Creating consumer directory: /var/run/lttng/=
kconsumerd [in set_consumer_sockets() at main.c:4357]<o:p></o:p></p>
<p class=3D"MsoNormal">FATAL: Module lttng-tracer not found.<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to load module lttng-tracer<o:p></o:p>=
</p>
<p class=3D"MsoNormal">DEBUG1: Failed to open /proc/lttng [in init_kernel_t=
racer() at main.c:1871]<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-tracer<o:p></o:=
p></p>
<p class=3D"MsoNormal">Warning: No kernel tracer available<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: Creating consumer directory: /var/run/lttng/=
ustconsumerd64 [in set_consumer_sockets() at main.c:4357]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: Creating consumer directory: /var/run/lttng/=
ustconsumerd32 [in set_consumer_sockets() at main.c:4357]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Signal handler set for SIGTERM, SIGPIPE and =
SIGINT [in set_signal_handler() at main.c:4449]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: All permissions are set [in set_permissions(=
) at main.c:4250]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: epoll set max size is 89794 [in compat_epoll=
_set_max_size() at compat-epoll.c:224]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: [thread] Manage client started [in thread_ma=
nage_clients() at main.c:3794]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: [thread] Dispatch UST command started [in th=
read_dispatch_ust_registration() at main.c:1324]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Futex n to 1 prepare done [in futex_nto1_pre=
pare() at futex.c:73]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Accepting client command ... [in thread_mana=
ge_clients() at main.c:3826]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Woken up but nothing in the UST command queu=
e [in thread_dispatch_ust_registration() at main.c:1334]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Thread manage kernel started [in thread_mana=
ge_kernel() at main.c:876]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: [thread] Manage application started [in thre=
ad_manage_apps() at main.c:1179]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: [thread] Manage application registration sta=
rted [in thread_registration_apps() at main.c:1392]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Notifying applications of session daemon sta=
te: 1 [in notify_ust_apps() at main.c:687]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Updating kernel poll set [in update_kernel_p=
oll() at main.c:748]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Apps thread polling on 2 fds [in thread_mana=
ge_apps() at main.c:1200]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Thread kernel polling on 2 fds [in thread_ma=
nage_kernel() at main.c:905]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Got the wait shm fd 18 [in get_wait_shm() at=
 shm.c:117]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Futex wait update active 1 [in futex_wait_up=
date() at futex.c:62]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Accepting application registration [in threa=
d_registration_apps() at main.c:1423]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">DEBUG1: SIGINT caught [in sighandler() at main.c:440=
4]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Terminating all threads [in stop_threads() a=
t main.c:412]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Futex n to 1 wake done [in futex_nto1_wake()=
 at futex.c:100]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Kernel thread dying [in thread_manage_kernel=
() at main.c:967]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Application communication apps thread cleanu=
p complete [in thread_manage_apps() at main.c:1308]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Futex n to 1 wait done [in futex_nto1_wait()=
 at futex.c:87]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Notifying applications of session daemon sta=
te: 0 [in notify_ust_apps() at main.c:687]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Dispatch thread dying [in thread_dispatch_us=
t_registration() at main.c:1374]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Got the wait shm fd 15 [in get_wait_shm() at=
 shm.c:117]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Client thread dying [in thread_manage_client=
s() at main.c:3953]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Futex wait update active 0 [in futex_wait_up=
date() at futex.c:62]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Clean command context structure [in clean_co=
mmand_ctx() at main.c:534]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: UST Registration thread cleanup complete [in=
 thread_registration_apps() at main.c:1551]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Cleaning up [in cleanup() at main.c:432]<o:p=
></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Removing /var/run/lttng directory [in cleanu=
p() at main.c:434]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Cleaning up all sessions [in cleanup() at ma=
in.c:447]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Closing all UST sockets [in cleanup() at mai=
n.c:462]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: UST app cleaning registered apps hash table =
[in ust_app_clean_list() at ust-app.c:1509]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG2: Closing kernel fd [in cleanup() at main.c:46=
8]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Unloading kernel modules [in cleanup() at ma=
in.c:475]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-time=
r [in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-stat=
edump [in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-sign=
al [in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-sche=
d [in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-kvm =
[in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-irq =
[in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-bloc=
k [in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-types [in =
modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-probe-lttn=
g [in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-ring-buffer-met=
adata-mmap-client<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-ring-buffer-cli=
ent-mmap-overwrite<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-ring-buffer-cli=
ent-mmap-discard<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-ring-buffer-met=
adata-client<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-ring-buffer-cli=
ent-overwrite<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-ring-buffer-cli=
ent-discard<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-lib-ring-buffer=
<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-kretprobes=
 [in modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-kprobes [i=
n modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">DEBUG1: Modprobe removal successful lttng-ftrace [in=
 modprobe_remove_lttng_data() at modprobe.c:118]<o:p></o:p></p>
<p class=3D"MsoNormal">Error: Unable to remove module lttng-tracer<o:p></o:=
p></p>
<p class=3D"MsoNormal">DEBUG1: *** assert failed :-) *** =3D=3D&gt; Matthew=
, BEET driven development works! [in cleanup()<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am running an early(ish) version of the kernel (3.=
7) but this is because the Altera Yocto source package is quite an old vint=
age.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any clues as to what am I doing wrong?<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for any help anyone can offer.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Neil.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_8369DAE2C5B8814998E89CE414A915381F6B7AF4ITMailbox3TTPGr_--


--===============0801689077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0801689077==--
