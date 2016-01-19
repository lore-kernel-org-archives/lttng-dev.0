From: Martin Townsend <mtownsend1973@gmail.com>
Subject: Problem using pthread and libc wrapper
Date: Tue, 19 Jan 2016 17:08:05 +0000
Message-ID: <CABatt_zWkMPgLx72c4VEi2nU=o-CtuFLDfN6qajUBJsFkr1eQw__31364.6522620276$1453223478$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789050844=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mtownsend1973@gmail.com>) id 1aLZlL-0001Fl-IB
 for lttng-dev@lists.lttng.org; Tue, 19 Jan 2016 12:08:24 -0500
Received: by mail-lf0-f54.google.com with SMTP id 17so140672315lfz.1
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jan 2016 09:08:11 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1789050844==
Content-Type: multipart/alternative; boundary=001a113f3894b876610529b2e9b0

--001a113f3894b876610529b2e9b0
Content-Type: text/plain; charset=UTF-8

Hi,

I'm trying to enable pthread mutex and libc events and then use LD_PRELOAD
to load the associated wrappers but I'm not getting anything in my trace
files.

Here are the commands I run
ttng create
lttng enable-event -u --tracepoint 'org_po_threadtest:*'
lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_req
lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_acq
lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_unlock
lttng enable-event -u --tracepoint 'ust_libc:*'
lttng add-context -u  -t pthread_id
lttng start
LTTNG_UST_REGISTER_TIMEOUT=-1 LTTNG_UST_DEBUG=1
LD_PRELOAD="/usr/lib/liblttng-ust-pthread-wrapper.so.0
/usr/lib/liblttng-ust-libc-wrapper.so.0" ./threadtest
lttng stop
lttng destroy

The kernel and rootfs was built using Yocto (Fido)
 uname -a
Linux am43-devboard-aquila-3dc40a 3.14.26 #1 Mon Jan 11 16:52:19 GMT 2016
armv7l GNU/Linux

lttng --version
lttng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.0



Here's the output of lttng ust debug and the trace file
tracing started for session auto-20160113-190852
stg-ust-pthread-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0"
./threadte
liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:consume (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:produce (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
libust[2225/2225]: Provider "ust_baddr_statedump" accepted, version 1.0 is
compatible with LTTng UST provider version 1.0. (in
check_provider_version() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
libust[2225/2225]: adding probe ust_baddr_statedump containing 1 events to
lazy registration list (in lttng_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
libust[2225/2225]: LTT : ltt ring buffer client "relay-metadata-mmap" init
 (in lttng_ring_buffer_metadata_client_init() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:330)
libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
 (in lttng_ring_buffer_client_overwrite_init() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
init
 (in lttng_ring_buffer_client_overwrite_rt_init() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-mmap" init
 (in lttng_ring_buffer_client_discard_init() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
 (in lttng_ring_buffer_client_discard_rt_init() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
libust[2225/2227]: Info: sessiond not accepting connections to local apps
socket (in ust_listener_thread() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1221)
libust[2225/2227]: Waiting for local apps sessiond (in wait_for_sessiond()
at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1132)
libust[2225/2226]: Message Received "Get Tracer Version" (65), Handle
"root" (0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
(0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 1 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Channel" (81), Handle "session"
(1) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: channel data received (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
libust[2225/2226]: Return value: 2 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
(2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Context" (112), Handle
"channel" (2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 3 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (3)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 4 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (4)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 5 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (5)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 6 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (6)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 7 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (7)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(2) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 8 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (8)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "session" (1)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Sent register channel notification: chan_id 0,
header_type 1
 (in ustcomm_register_channel() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
libust[2225/2226]: just registered probe ust_baddr_statedump containing 1
events (in lttng_lazy_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Wait for Quiescent State" (67), Handle
"root" (0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
(0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 9 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Channel" (81), Handle "session"
(9) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: channel data received (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
libust[2225/2226]: Return value: 10 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
(10) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Context" (112), Handle
"channel" (10) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(10) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 11 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (11)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(10) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 12 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (12)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(10) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 13 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (13)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(10) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 14 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (14)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "session" (9)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Sent register channel notification: chan_id 0,
header_type 1
 (in ustcomm_register_channel() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Wait for Quiescent State" (67), Handle
"root" (0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
(0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 15 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Channel" (81), Handle "session"
(15) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: channel data received (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
libust[2225/2226]: Return value: 16 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
(16) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Context" (112), Handle
"channel" (16) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(16) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 17 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (17)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(16) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 18 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (18)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(16) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 19 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (19)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(16) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 20 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (20)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2225]: Error: Timed out waiting for lttng-sessiond (in
lttng_ust_init() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1529)
libust[2225/2225]: Provider "lttng_ust_tracef" accepted, version 1.0 is
compatible with LTTng UST provider version 1.0. (in
check_provider_version() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
libust[2225/2225]: adding probe lttng_ust_tracef containing 1 events to
lazy registration list (in lttng_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
libust[2225/2225]: just registered probe lttng_ust_tracef containing 1
events (in lttng_lazy_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:consume (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:produce (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
libust[2225/2225]: Provider "ust_libc" accepted, version 1.0 is compatible
with LTTng UST provider version 1.0. (in check_provider_version() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
libust[2225/2225]: adding probe ust_libc containing 6 events to lazy
registration list (in lttng_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
libust[2225/2225]: just registered probe ust_libc containing 6 events (in
lttng_lazy_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
(0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2225]: Sent register event notification for name
"ust_libc:malloc": ret_code 0, event_id 4
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:free": ret_code 0, event_id 5
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:calloc": ret_code 0, event_id 6
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:realloc": ret_code 0, event_id 7
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:memalign": ret_code 0, event_id 8
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:posix_memalign": ret_code 0, event_id 9
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:posix_memalign (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:memalign (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:realloc (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:calloc (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:free (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:malloc (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
libust[2225/2225]: Sent register event notification for name
"ust_libc:malloc": ret_code 0, event_id 0
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:free": ret_code 0, event_id 1
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:calloc": ret_code 0, event_id 2
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:realloc": ret_code 0, event_id 3
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:memalign": ret_code 0, event_id 4
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_libc:posix_memalign": ret_code 0, event_id 5
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:posix_memalign (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:memalign (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:realloc (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:calloc (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:free (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_libc:malloc (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
libust[2225/2226]: Return value: 21 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Channel" (81), Handle "session"
(21) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: channel data received (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
libust[2225/2226]: Return value: 22 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
(22) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:consume (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:produce (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
libust[2225/2225]: Provider "ust_pthread" accepted, version 1.0 is
compatible with LTTng UST provider version 1.0. (in
check_provider_version() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
libust[2225/2225]: adding probe ust_pthread containing 4 events to lazy
registration list (in lttng_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
libust[2225/2225]: just registered probe ust_pthread containing 4 events
(in lttng_lazy_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
libust[2225/2226]: Message Received "Create Context" (112), Handle
"channel" (22) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2225]: Sent register event notification for name
"ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 0
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 1
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_pthread:pthread_mutex_trylock": ret_code 0, event_id 2
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 3
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_pthread:pthread_mutex_unlock (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_pthread:pthread_mutex_trylock (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
libust[2225/2225]: Sent register event notification for name
"ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 6
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 7
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 8
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
ust_pthread:pthread_mutex_unlock (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(22) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 23 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (23)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:consume (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
org_po_threadtest:produce (in tracepoint_register_lib() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
libust[2225/2225]: Provider "org_po_threadtest" accepted, version 1.0 is
compatible with LTTng UST provider version 1.0. (in
check_provider_version() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
libust[2225/2225]: adding probe org_po_threadtest containing 2 events to
lazy registration list (in lttng_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
libust[2225/2225]: just registered probe org_po_threadtest containing 2
events (in lttng_lazy_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(22) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2225]: Sent register event notification for name
"org_po_threadtest:produce": ret_code 0, event_id 10
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"org_po_threadtest:consume": ret_code 0, event_id 11
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
org_po_threadtest:consume (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
org_po_threadtest:produce (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
libust[2225/2225]: Sent register event notification for name
"org_po_threadtest:produce": ret_code 0, event_id 9
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
libust[2225/2225]: Sent register event notification for name
"org_po_threadtest:consume": ret_code 0, event_id 10
 (in ustcomm_register_event() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
org_po_threadtest:consume (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
org_po_threadtest:produce (in __tracepoint_probe_register() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
libust[2225/2226]: Return value: 24 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (24)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
(0) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 25 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Channel" (81), Handle "session"
(25) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: channel data received (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
libust[2225/2226]: Return value: 26 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
(26) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
(26) (in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 27 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (27)
(in print_cmd() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
libust[2225/2226]: Return value: 0 (in handle_message() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
libust[2225/2226]: message successfully sent (in send_reply() at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
threadtest: threadtest.c:70: consumer: Assertion `buffer->len >= 0' failed.
Aborted
root@am43-devboard-aquila-3dc40a:~# lttng stop
Waiting for data availability
Tracing stopped for session auto-20160113-190852
root@am43-devboard-aquila-3dc40a:~# lttng destroy
root@am43-devboard-aquila-3dc40a:~# babeltrace
lttng-traces/auto-20160113-190852
[19:08:59.023256390] (+?.?????????) am43-devboard-aquila-3dc40a
org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
value_field = 846930886, buf_pos_field = 0 }
[19:08:59.116224140] (+0.092967750) am43-devboard-aquila-3dc40a
org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
value_field = 1714636915, buf_pos_field = 1 }
[19:08:59.164360932] (+0.048136792) am43-devboard-aquila-3dc40a
org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
value_field = 424238335, buf_pos_field = 2 }
[19:08:59.249898432] (+0.085537500) am43-devboard-aquila-3dc40a
org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
value_field = 1649760492, buf_pos_field = 3 }
[19:08:59.266681973] (+0.016783541) am43-devboard-aquila-3dc40a
org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
value_field = 1189641421, buf_pos_field = 4 }
[19:08:59.269474015] (+0.002792042) am43-devboard-aquila-3dc40a
org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
value_field = 1189641421, buf_pos_field = 4 }
[19:08:59.269517598] (+0.000043583) am43-devboard-aquila-3dc40a
org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
value_field = 1649760492, buf_pos_field = 3 }
[19:08:59.269537140] (+0.000019542) am43-devboard-aquila-3dc40a
org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
value_field = 424238335, buf_pos_field = 2 }
[19:08:59.269555432] (+0.000018292) am43-devboard-aquila-3dc40a
org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
value_field = 1714636915, buf_pos_field = 1 }
[19:08:59.269573140] (+0.000017708) am43-devboard-aquila-3dc40a
org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
value_field = 846930886, buf_pos_field = 0 }
[19:08:59.269628015] (+0.000054875) am43-devboard-aquila-3dc40a
org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3029824528 }, {
value_field = -1265142768, buf_pos_field = 4294967295 }

I've doubled checked with other viewers but no ust_xxx events.

Am I doing something wrong with the lttng commands I'm running?

Many Thanks,
Martin

--001a113f3894b876610529b2e9b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi,<br><br></div>I&#39;m try=
ing to enable pthread mutex and libc events and then use LD_PRELOAD to load=
 the associated wrappers but I&#39;m not getting anything in my trace files=
. <br><br></div>Here are the commands I run<br>ttng create<br>lttng enable-=
event -u --tracepoint &#39;org_po_threadtest:*&#39;<br>lttng enable-event -=
u --tracepoint ust_pthread:pthread_mutex_lock_req<br>lttng enable-event -u =
--tracepoint ust_pthread:pthread_mutex_lock_acq<br>lttng enable-event -u --=
tracepoint ust_pthread:pthread_mutex_unlock<br>lttng enable-event -u --trac=
epoint &#39;ust_libc:*&#39;<br>lttng add-context -u=C2=A0 -t pthread_id<br>=
lttng start<br>LTTNG_UST_REGISTER_TIMEOUT=3D-1 LTTNG_UST_DEBUG=3D1 LD_PRELO=
AD=3D&quot;/usr/lib/liblttng-ust-pthread-wrapper.so.0 /usr/lib/liblttng-ust=
-libc-wrapper.so.0&quot; ./threadtest<br>lttng stop<br>lttng destroy<br><br=
><span></span><span>The kernel and rootfs was built using Yocto (Fido)<br>=
=C2=A0uname -a<br>Linux am43-devboard-aquila-3dc40a 3.14.26 #1 Mon Jan 11 1=
6:52:19 GMT 2016 armv7l GNU/Linux<br><br>lttng --version<br>lttng (LTTng Tr=
ace Control) 2.6.0 - Gaia - v2.6.0<br><br><br></span><span><br></span>Here&=
#39;s the output of lttng ust debug and the trace file<br>tracing started f=
or session auto-20160113-190852<br>stg-ust-pthread-wrapper.so.0 /usr/lib/li=
blttng-ust-libc-wrapper.so.0&quot; ./threadte<br>liblttng_ust_tracepoint[22=
25/2225]: just registered a tracepoints section from 0xb700108c and having =
2 tracepoints (in tracepoint_register_lib() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)<br>liblttng_ust_tracepoint[=
2225/2225]: registered tracepoint: org_po_threadtest:consume (in tracepoint=
_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/tracepoint.c:772)<br>liblttng_ust_tracepoint[2225/2225]: registered trace=
point: org_po_threadtest:produce (in tracepoint_register_lib() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>libus=
t[2225/2225]: Provider &quot;ust_baddr_statedump&quot; accepted, version 1.=
0 is compatible with LTTng UST provider version 1.0. (in check_provider_ver=
sion() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-p=
robes.c:174)<br>libust[2225/2225]: adding probe ust_baddr_statedump contain=
ing 1 events to lazy registration list (in lttng_probe_register() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br>=
libust[2225/2225]: LTT : ltt ring buffer client &quot;relay-metadata-mmap&q=
uot; init<br>=C2=A0(in lttng_ring_buffer_metadata_client_init() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-metadat=
a-client.h:330)<br>libust[2225/2225]: LTT : ltt ring buffer client &quot;re=
lay-overwrite-mmap&quot; init<br>=C2=A0(in lttng_ring_buffer_client_overwri=
te_init() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ring-buffer-client.h:681)<br>libust[2225/2225]: LTT : ltt ring buffer cli=
ent &quot;relay-overwrite-rt-mmap&quot; init<br>=C2=A0(in lttng_ring_buffer=
_client_overwrite_rt_init() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ring-buffer-client.h:681)<br>libust[2225/2225]: LTT : l=
tt ring buffer client &quot;relay-discard-mmap&quot; init<br>=C2=A0(in lttn=
g_ring_buffer_client_discard_init() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)<br>libust[2225/2225]:=
 LTT : ltt ring buffer client &quot;relay-discard-rt-mmap&quot; init<br>=C2=
=A0(in lttng_ring_buffer_client_discard_rt_init() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)<br>libu=
st[2225/2227]: Info: sessiond not accepting connections to local apps socke=
t (in ust_listener_thread() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:1221)<br>libust[2225/2227]: Waiting for loca=
l apps sessiond (in wait_for_sessiond() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1132)<br>libust[2225/2226]: Mess=
age Received &quot;Get Tracer Version&quot; (65), Handle &quot;root&quot; (=
0) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle=
_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send=
_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Sessio=
n&quot; (64), Handle &quot;root&quot; (0) (in print_cmd() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust=
[2225/2226]: Return value: 1 (in handle_message() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/22=
26]: message successfully sent (in send_reply() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226=
]: Message Received &quot;Create Channel&quot; (81), Handle &quot;session&q=
uot; (1) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: channel data receive=
d (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Return value: 2 (in ha=
ndle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in =
send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create St=
ream&quot; (96), Handle &quot;channel&quot; (2) (in print_cmd() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>=
libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2=
225/2226]: message successfully sent (in send_reply() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[222=
5/2226]: Message Received &quot;Create Context&quot; (112), Handle &quot;ch=
annel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Create Event&quot; (97), Handle &quot;channel&quot; (2) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: Return value: 3 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;en=
abler&quot; (3) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Create Event&quot; (97), Handle &quot;channel&quot; (2) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: Return value: 4 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;en=
abler&quot; (4) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Create Event&quot; (97), Handle &quot;channel&quot; (2) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: Return value: 5 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;en=
abler&quot; (5) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Create Event&quot; (97), Handle &quot;channel&quot; (2) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: Return value: 6 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;en=
abler&quot; (6) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Create Event&quot; (97), Handle &quot;channel&quot; (2) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: Return value: 7 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;en=
abler&quot; (7) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Create Event&quot; (97), Handle &quot;channel&quot; (2) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: Return value: 8 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;en=
abler&quot; (8) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;session&quot; (1) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Sent register channel notification: chan_id 0, header=
_type 1<br>=C2=A0(in ustcomm_register_channel() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)<br>libust[222=
5/2226]: just registered probe ust_baddr_statedump containing 1 events (in =
lttng_lazy_probe_register() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-probes.c:115)<br>libust[2225/2226]: Return value: 0 (in=
 handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (=
in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Wait f=
or Quiescent State&quot; (67), Handle &quot;root&quot; (0) (in print_cmd() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<=
br>libust[2225/2226]: message successfully sent (in send_reply() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br=
>libust[2225/2226]: Message Received &quot;Create Session&quot; (64), Handl=
e &quot;root&quot; (0) (in print_cmd() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return=
 value: 9 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succes=
sfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received=
 &quot;Create Channel&quot; (81), Handle &quot;session&quot; (9) (in print_=
cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:366)<br>libust[2225/2226]: channel data received (in handle_messag=
e() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:720)<br>libust[2225/2226]: Return value: 10 (in handle_message() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
824)<br>libust[2225/2226]: message successfully sent (in send_reply() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:48=
1)<br>libust[2225/2226]: Message Received &quot;Create Stream&quot; (96), H=
andle &quot;channel&quot; (10) (in print_cmd() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]=
: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: messag=
e successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message =
Received &quot;Create Context&quot; (112), Handle &quot;channel&quot; (10) =
(in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_me=
ssage() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-=
ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_re=
ply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Event&quo=
t; (97), Handle &quot;channel&quot; (10) (in print_cmd() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[=
2225/2226]: Return value: 11 (in handle_message() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/22=
26]: message successfully sent (in send_reply() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226=
]: Message Received &quot;Enable&quot; (128), Handle &quot;enabler&quot; (1=
1) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle=
_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send=
_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Event&=
quot; (97), Handle &quot;channel&quot; (10) (in print_cmd() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libu=
st[2225/2226]: Return value: 12 (in handle_message() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225=
/2226]: message successfully sent (in send_reply() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2=
226]: Message Received &quot;Enable&quot; (128), Handle &quot;enabler&quot;=
 (12) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in han=
dle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in s=
end_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lt=
tng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Eve=
nt&quot; (97), Handle &quot;channel&quot; (10) (in print_cmd() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>l=
ibust[2225/2226]: Return value: 13 (in handle_message() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2=
225/2226]: message successfully sent (in send_reply() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[222=
5/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;enabler&qu=
ot; (13) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in =
handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (i=
n send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create =
Event&quot; (97), Handle &quot;channel&quot; (10) (in print_cmd() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<b=
r>libust[2225/2226]: Return value: 14 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;enabler=
&quot; (14) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (=
in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent=
 (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enab=
le&quot; (128), Handle &quot;session&quot; (9) (in print_cmd() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>l=
ibust[2225/2226]: Sent register channel notification: chan_id 0, header_typ=
e 1<br>=C2=A0(in ustcomm_register_channel() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)<br>libust[2225/22=
26]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: mes=
sage successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Messa=
ge Received &quot;Wait for Quiescent State&quot; (67), Handle &quot;root&qu=
ot; (0) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in h=
andle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in=
 send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create S=
ession&quot; (64), Handle &quot;root&quot; (0) (in print_cmd() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>l=
ibust[2225/2226]: Return value: 15 (in handle_message() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2=
225/2226]: message successfully sent (in send_reply() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[222=
5/2226]: Message Received &quot;Create Channel&quot; (81), Handle &quot;ses=
sion&quot; (15) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: channel data =
received (in handle_message() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Return value: 1=
6 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully s=
ent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;C=
reate Stream&quot; (96), Handle &quot;channel&quot; (16) (in print_cmd() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c=
:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br=
>libust[2225/2226]: message successfully sent (in send_reply() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>l=
ibust[2225/2226]: Message Received &quot;Create Context&quot; (112), Handle=
 &quot;channel&quot; (16) (in print_cmd() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Ret=
urn value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message suc=
cessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Recei=
ved &quot;Create Event&quot; (97), Handle &quot;channel&quot; (16) (in prin=
t_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-=
ust-comm.c:366)<br>libust[2225/2226]: Return value: 17 (in handle_message()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), Han=
dle &quot;enabler&quot; (17) (in print_cmd() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: =
Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message =
successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Re=
ceived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (16) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 18 (in handle_messag=
e() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), =
Handle &quot;enabler&quot; (18) (in print_cmd() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226=
]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: messa=
ge successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message=
 Received &quot;Create Event&quot; (97), Handle &quot;channel&quot; (16) (i=
n print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 19 (in handle_mes=
sage() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_rep=
ly() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust=
-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128=
), Handle &quot;enabler&quot; (19) (in print_cmd() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2=
226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: me=
ssage successfully sent (in send_reply() at /home/poweroasis/bia/build/am43=
-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2=
_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Mess=
age Received &quot;Create Event&quot; (97), Handle &quot;channel&quot; (16)=
 (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 20 (in handle_=
message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_=
reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-=
ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (=
128), Handle &quot;enabler&quot; (20) (in print_cmd() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[222=
5/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]:=
 message successfully sent (in send_reply() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2225]: E=
rror: Timed out waiting for lttng-sessiond (in lttng_ust_init() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1529)<br=
>libust[2225/2225]: Provider &quot;lttng_ust_tracef&quot; accepted, version=
 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_=
version() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-probes.c:174)<br>libust[2225/2225]: adding probe lttng_ust_tracef contain=
ing 1 events to lazy registration list (in lttng_probe_register() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br>=
libust[2225/2225]: just registered probe lttng_ust_tracef containing 1 even=
ts (in lttng_lazy_probe_register() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-probes.c:115)<br>liblttng_ust_tracepoint[2225/22=
25]: just registered a tracepoints section from 0xb700108c and having 2 tra=
cepoints (in tracepoint_register_lib() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/tracepoint.c:767)<br>liblttng_ust_tracepoint[2225/=
2225]: registered tracepoint: org_po_threadtest:consume (in tracepoint_regi=
ster_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tra=
cepoint.c:772)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint=
: org_po_threadtest:produce (in tracepoint_register_lib() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>libust[222=
5/2225]: Provider &quot;ust_libc&quot; accepted, version 1.0 is compatible =
with LTTng UST provider version 1.0. (in check_provider_version() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>=
libust[2225/2225]: adding probe ust_libc containing 6 events to lazy regist=
ration list (in lttng_probe_register() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: just reg=
istered probe ust_libc containing 6 events (in lttng_lazy_probe_register() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c=
:115)<br>libust[2225/2226]: Message Received &quot;Create Session&quot; (64=
), Handle &quot;root&quot; (0) (in print_cmd() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2225]=
: Sent register event notification for name &quot;ust_libc:malloc&quot;: re=
t_code 0, event_id 4<br>=C2=A0(in ustcomm_register_event() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br=
>libust[2225/2225]: Sent register event notification for name &quot;ust_lib=
c:free&quot;: ret_code 0, event_id 5<br>=C2=A0(in ustcomm_register_event() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust=
-comm.c:1001)<br>libust[2225/2225]: Sent register event notification for na=
me &quot;ust_libc:calloc&quot;: ret_code 0, event_id 6<br>=C2=A0(in ustcomm=
_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event n=
otification for name &quot;ust_libc:realloc&quot;: ret_code 0, event_id 7<b=
r>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Se=
nt register event notification for name &quot;ust_libc:memalign&quot;: ret_=
code 0, event_id 8<br>=C2=A0(in ustcomm_register_event() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>l=
ibust[2225/2225]: Sent register event notification for name &quot;ust_libc:=
posix_memalign&quot;: ret_code 0, event_id 9<br>=C2=A0(in ustcomm_register_=
event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/l=
ttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: Registering pr=
obe to tracepoint ust_libc:posix_memalign (in __tracepoint_probe_register()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:=
563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint=
 ust_libc:memalign (in __tracepoint_probe_register() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tr=
acepoint[2225/2225]: Registering probe to tracepoint ust_libc:realloc (in _=
_tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Reg=
istering probe to tracepoint ust_libc:calloc (in __tracepoint_probe_registe=
r() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint=
.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepo=
int ust_libc:free (in __tracepoint_probe_register() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tra=
cepoint[2225/2225]: Registering probe to tracepoint ust_libc:malloc (in __t=
racepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/tracepoint.c:563)<br>libust[2225/2225]: Sent register event no=
tification for name &quot;ust_libc:malloc&quot;: ret_code 0, event_id 0<br>=
=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent=
 register event notification for name &quot;ust_libc:free&quot;: ret_code 0=
, event_id 1<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[=
2225/2225]: Sent register event notification for name &quot;ust_libc:calloc=
&quot;: ret_code 0, event_id 2<br>=C2=A0(in ustcomm_register_event() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.=
c:1001)<br>libust[2225/2225]: Sent register event notification for name &qu=
ot;ust_libc:realloc&quot;: ret_code 0, event_id 3<br>=C2=A0(in ustcomm_regi=
ster_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-c=
omm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event notifi=
cation for name &quot;ust_libc:memalign&quot;: ret_code 0, event_id 4<br>=
=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent=
 register event notification for name &quot;ust_libc:posix_memalign&quot;: =
ret_code 0, event_id 5<br>=C2=A0(in ustcomm_register_event() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<=
br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_=
libc:posix_memalign (in __tracepoint_probe_register() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_t=
racepoint[2225/2225]: Registering probe to tracepoint ust_libc:memalign (in=
 __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: R=
egistering probe to tracepoint ust_libc:realloc (in __tracepoint_probe_regi=
ster() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepo=
int.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to trac=
epoint ust_libc:calloc (in __tracepoint_probe_register() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_us=
t_tracepoint[2225/2225]: Registering probe to tracepoint ust_libc:free (in =
__tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Re=
gistering probe to tracepoint ust_libc:malloc (in __tracepoint_probe_regist=
er() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoin=
t.c:563)<br>libust[2225/2226]: Return value: 21 (in handle_message() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824=
)<br>libust[2225/2226]: message successfully sent (in send_reply() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<=
br>libust[2225/2226]: Message Received &quot;Create Channel&quot; (81), Han=
dle &quot;session&quot; (21) (in print_cmd() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: =
channel data received (in handle_message() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Re=
turn value: 22 (in handle_message() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message s=
uccessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Rec=
eived &quot;Create Stream&quot; (96), Handle &quot;channel&quot; (22) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>liblttng_ust_tracepoint[2225/2225]: just registered a tracepoin=
ts section from 0xb700108c and having 2 tracepoints (in tracepoint_register=
_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepo=
int.c:767)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint: or=
g_po_threadtest:consume (in tracepoint_register_lib() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblttng_ust_t=
racepoint[2225/2225]: registered tracepoint: org_po_threadtest:produce (in =
tracepoint_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider &quot;ust_pthr=
ead&quot; accepted, version 1.0 is compatible with LTTng UST provider versi=
on 1.0. (in check_provider_version() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: adding pro=
be ust_pthread containing 4 events to lazy registration list (in lttng_prob=
e_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-probes.c:216)<br>libust[2225/2225]: just registered probe ust_pthread =
containing 4 events (in lttng_lazy_probe_register() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)<br>libust[2225/22=
26]: Message Received &quot;Create Context&quot; (112), Handle &quot;channe=
l&quot; (22) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2225]: Sent register ev=
ent notification for name &quot;ust_pthread:pthread_mutex_lock_req&quot;: r=
et_code 0, event_id 0<br>=C2=A0(in ustcomm_register_event() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<b=
r>libust[2225/2225]: Sent register event notification for name &quot;ust_pt=
hread:pthread_mutex_lock_acq&quot;: ret_code 0, event_id 1<br>=C2=A0(in ust=
comm_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register eve=
nt notification for name &quot;ust_pthread:pthread_mutex_trylock&quot;: ret=
_code 0, event_id 2<br>=C2=A0(in ustcomm_register_event() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>=
libust[2225/2225]: Sent register event notification for name &quot;ust_pthr=
ead:pthread_mutex_unlock&quot;: ret_code 0, event_id 3<br>=C2=A0(in ustcomm=
_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: Regi=
stering probe to tracepoint ust_pthread:pthread_mutex_unlock (in __tracepoi=
nt_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering =
probe to tracepoint ust_pthread:pthread_mutex_trylock (in __tracepoint_prob=
e_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/t=
racepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe t=
o tracepoint ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_regi=
ster() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepo=
int.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to trac=
epoint ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:=
563)<br>libust[2225/2225]: Sent register event notification for name &quot;=
ust_pthread:pthread_mutex_unlock&quot;: ret_code 0, event_id 6<br>=C2=A0(in=
 ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register=
 event notification for name &quot;ust_pthread:pthread_mutex_lock_req&quot;=
: ret_code 0, event_id 7<br>=C2=A0(in ustcomm_register_event() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001=
)<br>libust[2225/2225]: Sent register event notification for name &quot;ust=
_pthread:pthread_mutex_lock_acq&quot;: ret_code 0, event_id 8<br>=C2=A0(in =
ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225=
]: Registering probe to tracepoint ust_pthread:pthread_mutex_lock_acq (in _=
_tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Reg=
istering probe to tracepoint ust_pthread:pthread_mutex_lock_req (in __trace=
point_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registeri=
ng probe to tracepoint ust_pthread:pthread_mutex_unlock (in __tracepoint_pr=
obe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/tracepoint.c:563)<br>libust[2225/2226]: Return value: 0 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Create Event&quot; (9=
7), Handle &quot;channel&quot; (22) (in print_cmd() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/=
2226]: Return value: 23 (in handle_message() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: =
message successfully sent (in send_reply() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Me=
ssage Received &quot;Enable&quot; (128), Handle &quot;enabler&quot; (23) (i=
n print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_mess=
age() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_repl=
y() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:481)<br>liblttng_ust_tracepoint[2225/2225]: just registered a tracep=
oints section from 0xb700108c and having 2 tracepoints (in tracepoint_regis=
ter_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/trac=
epoint.c:767)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint:=
 org_po_threadtest:consume (in tracepoint_register_lib() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblttng_us=
t_tracepoint[2225/2225]: registered tracepoint: org_po_threadtest:produce (=
in tracepoint_register_lib() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider &quot;org_p=
o_threadtest&quot; accepted, version 1.0 is compatible with LTTng UST provi=
der version 1.0. (in check_provider_version() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: a=
dding probe org_po_threadtest containing 2 events to lazy registration list=
 (in lttng_probe_register() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: just registered pro=
be org_po_threadtest containing 2 events (in lttng_lazy_probe_register() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:1=
15)<br>libust[2225/2226]: Message Received &quot;Create Event&quot; (97), H=
andle &quot;channel&quot; (22) (in print_cmd() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2225]=
: Sent register event notification for name &quot;org_po_threadtest:produce=
&quot;: ret_code 0, event_id 10<br>=C2=A0(in ustcomm_register_event() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm=
.c:1001)<br>libust[2225/2225]: Sent register event notification for name &q=
uot;org_po_threadtest:consume&quot;: ret_code 0, event_id 11<br>=C2=A0(in u=
stcomm_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]=
: Registering probe to tracepoint org_po_threadtest:consume (in __tracepoin=
t_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering p=
robe to tracepoint org_po_threadtest:produce (in __tracepoint_probe_registe=
r() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint=
.c:563)<br>libust[2225/2225]: Sent register event notification for name &qu=
ot;org_po_threadtest:produce&quot;: ret_code 0, event_id 9<br>=C2=A0(in ust=
comm_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register eve=
nt notification for name &quot;org_po_threadtest:consume&quot;: ret_code 0,=
 event_id 10<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttn=
g_ust_tracepoint[2225/2225]: Registering probe to tracepoint org_po_threadt=
est:consume (in __tracepoint_probe_register() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoin=
t[2225/2225]: Registering probe to tracepoint org_po_threadtest:produce (in=
 __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2226]: Return value: 24 (=
in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent=
 (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enab=
le&quot; (128), Handle &quot;enabler&quot; (24) (in print_cmd() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>=
libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2=
225/2226]: message successfully sent (in send_reply() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[222=
5/2226]: Message Received &quot;Create Session&quot; (64), Handle &quot;roo=
t&quot; (0) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 25 =
(in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sen=
t (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Cre=
ate Channel&quot; (81), Handle &quot;session&quot; (25) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: channel data received (in handle_message() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:72=
0)<br>libust[2225/2226]: Return value: 26 (in handle_message() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>l=
ibust[2225/2226]: message successfully sent (in send_reply() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>lib=
ust[2225/2226]: Message Received &quot;Create Stream&quot; (96), Handle &qu=
ot;channel&quot; (26) (in print_cmd() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return =
value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message success=
fully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received =
&quot;Create Event&quot; (97), Handle &quot;channel&quot; (26) (in print_cm=
d() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:366)<br>libust[2225/2226]: Return value: 27 (in handle_message() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
824)<br>libust[2225/2226]: message successfully sent (in send_reply() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:48=
1)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle =
&quot;enabler&quot; (27) (in print_cmd() at /home/poweroasis/bia/build/am43=
-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2=
_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Retu=
rn value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboar=
d-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r=
0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succ=
essfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-ust-comm.c:481)<br>threadtest: threadtest.c:70: cons=
umer: Assertion `buffer-&gt;len &gt;=3D 0&#39; failed.<br>Aborted<br>root@a=
m43-devboard-aquila-3dc40a:~# lttng stop<br>Waiting for data availability<b=
r>Tracing stopped for session auto-20160113-190852<br>root@am43-devboard-aq=
uila-3dc40a:~# lttng destroy<br>root@am43-devboard-aquila-3dc40a:~# babeltr=
ace lttng-traces/auto-20160113-190852<br>[19:08:59.023256390] (+?.?????????=
) am43-devboard-aquila-3dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, =
{ pthread_id =3D 3046601744 }, { value_field =3D 846930886, buf_pos_field =
=3D 0 }<br>[19:08:59.116224140] (+0.092967750) am43-devboard-aquila-3dc40a =
org_po_threadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D 3046601744 },=
 { value_field =3D 1714636915, buf_pos_field =3D 1 }<br>[19:08:59.164360932=
] (+0.048136792) am43-devboard-aquila-3dc40a org_po_threadtest:produce: { c=
pu_id =3D 0 }, { pthread_id =3D 3046601744 }, { value_field =3D 424238335, =
buf_pos_field =3D 2 }<br>[19:08:59.249898432] (+0.085537500) am43-devboard-=
aquila-3dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D=
 3046601744 }, { value_field =3D 1649760492, buf_pos_field =3D 3 }<br>[19:0=
8:59.266681973] (+0.016783541) am43-devboard-aquila-3dc40a org_po_threadtes=
t:produce: { cpu_id =3D 0 }, { pthread_id =3D 3046601744 }, { value_field =
=3D 1189641421, buf_pos_field =3D 4 }<br>[19:08:59.269474015] (+0.002792042=
) am43-devboard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, =
{ pthread_id =3D 3038213136 }, { value_field =3D 1189641421, buf_pos_field =
=3D 4 }<br>[19:08:59.269517598] (+0.000043583) am43-devboard-aquila-3dc40a =
org_po_threadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D 3038213136 },=
 { value_field =3D 1649760492, buf_pos_field =3D 3 }<br>[19:08:59.269537140=
] (+0.000019542) am43-devboard-aquila-3dc40a org_po_threadtest:consume: { c=
pu_id =3D 0 }, { pthread_id =3D 3038213136 }, { value_field =3D 424238335, =
buf_pos_field =3D 2 }<br>[19:08:59.269555432] (+0.000018292) am43-devboard-=
aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D=
 3038213136 }, { value_field =3D 1714636915, buf_pos_field =3D 1 }<br>[19:0=
8:59.269573140] (+0.000017708) am43-devboard-aquila-3dc40a org_po_threadtes=
t:consume: { cpu_id =3D 0 }, { pthread_id =3D 3038213136 }, { value_field =
=3D 846930886, buf_pos_field =3D 0 }<br>[19:08:59.269628015] (+0.000054875)=
 am43-devboard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, {=
 pthread_id =3D 3029824528 }, { value_field =3D -1265142768, buf_pos_field =
=3D 4294967295 }<br><br></div>I&#39;ve doubled checked with other viewers b=
ut no ust_xxx events.<br><br></div>Am I doing something wrong with the lttn=
g commands I&#39;m running?<br><br></div>Many Thanks,<br></div>Martin<br><d=
iv><div><div><div><div><div><div><br><br></div></div></div></div></div></di=
v></div></div>

--001a113f3894b876610529b2e9b0--


--===============1789050844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1789050844==--
