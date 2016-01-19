From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Problem using pthread and libc wrapper
Date: Tue, 19 Jan 2016 17:53:49 +0000 (UTC)
Message-ID: <613581409.17.1453226029572.JavaMail.zimbra__39201.003246899$1453226162$gmane$org@efficios.com>
References: <CABatt_zWkMPgLx72c4VEi2nU=o-CtuFLDfN6qajUBJsFkr1eQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0781778080=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aLaTh-0001Yr-It
 for lttng-dev@lists.lttng.org; Tue, 19 Jan 2016 12:54:14 -0500
In-Reply-To: <CABatt_zWkMPgLx72c4VEi2nU=o-CtuFLDfN6qajUBJsFkr1eQw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0781778080==
Content-Type: multipart/alternative;
	boundary="----=_Part_16_1420688020.1453226029541"

------=_Part_16_1420688020.1453226029541
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Martin, 

Can you reproduce with the latest stable branch (2.7.x) or with master 
of lttng-ust and lttng-tools ? 

New in lttng 2.7 is the renaming of some providers to add proper name spacing: 

ust_pthread -> lttng_ust_pthread 
ust_libc -> lttng_ust_libc 

Thanks, 

Mathieu 

----- On Jan 19, 2016, at 12:08 PM, Martin Townsend <mtownsend1973@gmail.com> wrote: 

> Hi,

> I'm trying to enable pthread mutex and libc events and then use LD_PRELOAD to
> load the associated wrappers but I'm not getting anything in my trace files.

> Here are the commands I run
> ttng create
> lttng enable-event -u --tracepoint 'org_po_threadtest:*'
> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_req
> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_acq
> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_unlock
> lttng enable-event -u --tracepoint 'ust_libc:*'
> lttng add-context -u -t pthread_id
> lttng start
> LTTNG_UST_REGISTER_TIMEOUT=-1 LTTNG_UST_DEBUG=1
> LD_PRELOAD="/usr/lib/liblttng-ust-pthread-wrapper.so.0
> /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threadtest
> lttng stop
> lttng destroy

> The kernel and rootfs was built using Yocto (Fido)
> uname -a
> Linux am43-devboard-aquila-3dc40a 3.14.26 #1 Mon Jan 11 16:52:19 GMT 2016 armv7l
> GNU/Linux

> lttng --version
> lttng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.0

> Here's the output of lttng ust debug and the trace file
> tracing started for session auto-20160113-190852
> stg-ust-pthread-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threadte
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section from
> 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "ust_baddr_statedump" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe ust_baddr_statedump containing 1 events to lazy
> registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-metadata-mmap" init
> (in lttng_ring_buffer_metadata_client_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:330)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
> (in lttng_ring_buffer_client_overwrite_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap" init
> (in lttng_ring_buffer_client_overwrite_rt_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-mmap" init
> (in lttng_ring_buffer_client_discard_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
> (in lttng_ring_buffer_client_discard_rt_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2227]: Info: sessiond not accepting connections to local apps socket
> (in ust_listener_thread() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1221)
> libust[2225/2227]: Waiting for local apps sessiond (in wait_for_sessiond() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1132)
> libust[2225/2226]: Message Received "Get Tracer Version" (65), Handle "root" (0)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root" (0) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 1 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle "session" (1)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 2 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Context" (112), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 3 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (3) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 4 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (4) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 5 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (5) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 6 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (6) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 7 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (7) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (2)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 8 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (8) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "session" (1) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Sent register channel notification: chan_id 0, header_type 1
> (in ustcomm_register_channel() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
> libust[2225/2226]: just registered probe ust_baddr_statedump containing 1 events
> (in lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Wait for Quiescent State" (67), Handle
> "root" (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root" (0) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 9 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle "session" (9)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 10 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel" (10)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Context" (112), Handle "channel"
> (10) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (10)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 11 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (11) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (10)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 12 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (12) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (10)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 13 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (13) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (10)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 14 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (14) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "session" (9) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Sent register channel notification: chan_id 0, header_type 1
> (in ustcomm_register_channel() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Wait for Quiescent State" (67), Handle
> "root" (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root" (0) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 15 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle "session" (15)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 16 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel" (16)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Context" (112), Handle "channel"
> (16) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (16)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 17 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (17) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (16)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 18 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (18) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (16)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 19 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (19) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (16)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 20 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (20) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2225]: Error: Timed out waiting for lttng-sessiond (in
> lttng_ust_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1529)
> libust[2225/2225]: Provider "lttng_ust_tracef" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe lttng_ust_tracef containing 1 events to lazy
> registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe lttng_ust_tracef containing 1 events
> (in lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section from
> 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "ust_libc" accepted, version 1.0 is compatible with
> LTTng UST provider version 1.0. (in check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe ust_libc containing 6 events to lazy
> registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe ust_libc containing 6 events (in
> lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root" (0) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2225]: Sent register event notification for name "ust_libc:malloc":
> ret_code 0, event_id 4
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name "ust_libc:free":
> ret_code 0, event_id 5
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name "ust_libc:calloc":
> ret_code 0, event_id 6
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name "ust_libc:realloc":
> ret_code 0, event_id 7
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:memalign": ret_code 0, event_id 8
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:posix_memalign": ret_code 0, event_id 9
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:posix_memalign (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:memalign (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:realloc (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:calloc (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:free (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:malloc (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> libust[2225/2225]: Sent register event notification for name "ust_libc:malloc":
> ret_code 0, event_id 0
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name "ust_libc:free":
> ret_code 0, event_id 1
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name "ust_libc:calloc":
> ret_code 0, event_id 2
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name "ust_libc:realloc":
> ret_code 0, event_id 3
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:memalign": ret_code 0, event_id 4
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:posix_memalign": ret_code 0, event_id 5
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:posix_memalign (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:memalign (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:realloc (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:calloc (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:free (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_libc:malloc (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> libust[2225/2226]: Return value: 21 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle "session" (21)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 22 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel" (22)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section from
> 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "ust_pthread" accepted, version 1.0 is compatible
> with LTTng UST provider version 1.0. (in check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe ust_pthread containing 4 events to lazy
> registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe ust_pthread containing 4 events (in
> lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Message Received "Create Context" (112), Handle "channel"
> (22) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 0
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 1
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_trylock": ret_code 0, event_id 2
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 3
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_pthread:pthread_mutex_unlock (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_pthread:pthread_mutex_trylock (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 6
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 7
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 8
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> ust_pthread:pthread_mutex_unlock (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (22)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 23 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (23) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section from
> 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "org_po_threadtest" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe org_po_threadtest containing 2 events to lazy
> registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe org_po_threadtest containing 2 events
> (in lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (22)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:produce": ret_code 0, event_id 10
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:consume": ret_code 0, event_id 11
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> org_po_threadtest:consume (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> org_po_threadtest:produce (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:produce": ret_code 0, event_id 9
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:consume": ret_code 0, event_id 10
> (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> org_po_threadtest:consume (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> org_po_threadtest:produce (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> libust[2225/2226]: Return value: 24 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (24) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root" (0) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 25 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle "session" (25)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 26 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel" (26)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel" (26)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 27 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (27) (in
> print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> threadtest: threadtest.c:70: consumer: Assertion `buffer->len >= 0' failed.
> Aborted
> root@am43-devboard-aquila-3dc40a:~# lttng stop
> Waiting for data availability
> Tracing stopped for session auto-20160113-190852
> root@am43-devboard-aquila-3dc40a:~# lttng destroy
> root@am43-devboard-aquila-3dc40a:~# babeltrace lttng-traces/auto-20160113-190852
> [19:08:59.023256390] (+?.?????????) am43-devboard-aquila-3dc40a
> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
> value_field = 846930886, buf_pos_field = 0 }
> [19:08:59.116224140] (+0.092967750) am43-devboard-aquila-3dc40a
> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
> value_field = 1714636915, buf_pos_field = 1 }
> [19:08:59.164360932] (+0.048136792) am43-devboard-aquila-3dc40a
> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
> value_field = 424238335, buf_pos_field = 2 }
> [19:08:59.249898432] (+0.085537500) am43-devboard-aquila-3dc40a
> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
> value_field = 1649760492, buf_pos_field = 3 }
> [19:08:59.266681973] (+0.016783541) am43-devboard-aquila-3dc40a
> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
> value_field = 1189641421, buf_pos_field = 4 }
> [19:08:59.269474015] (+0.002792042) am43-devboard-aquila-3dc40a
> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
> value_field = 1189641421, buf_pos_field = 4 }
> [19:08:59.269517598] (+0.000043583) am43-devboard-aquila-3dc40a
> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
> value_field = 1649760492, buf_pos_field = 3 }
> [19:08:59.269537140] (+0.000019542) am43-devboard-aquila-3dc40a
> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
> value_field = 424238335, buf_pos_field = 2 }
> [19:08:59.269555432] (+0.000018292) am43-devboard-aquila-3dc40a
> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
> value_field = 1714636915, buf_pos_field = 1 }
> [19:08:59.269573140] (+0.000017708) am43-devboard-aquila-3dc40a
> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
> value_field = 846930886, buf_pos_field = 0 }
> [19:08:59.269628015] (+0.000054875) am43-devboard-aquila-3dc40a
> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3029824528 }, {
> value_field = -1265142768, buf_pos_field = 4294967295 }

> I've doubled checked with other viewers but no ust_xxx events.

> Am I doing something wrong with the lttng commands I'm running?

> Many Thanks,
> Martin

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_16_1420688020.1453226029541
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span data-marker=3D"__DIVIDER__">Hi Martin=
,<br data-mce-bogus=3D"1"></span></div><div><span data-marker=3D"__DIVIDER_=
_"><br data-mce-bogus=3D"1"></span></div><div><span data-marker=3D"__DIVIDE=
R__">Can you reproduce with the latest stable branch (2.7.x) or with master=
</span></div><div><span data-marker=3D"__DIVIDER__">of lttng-ust and lttng-=
tools ?<br data-mce-bogus=3D"1"></span></div><div><span data-marker=3D"__DI=
VIDER__"><br data-mce-bogus=3D"1"></span></div><div><span data-marker=3D"__=
DIVIDER__">New in lttng 2.7 is the renaming of some providers to add proper=
 name spacing:<br data-mce-bogus=3D"1"></span></div><div><span data-marker=
=3D"__DIVIDER__"><br data-mce-bogus=3D"1"></span></div><div><span data-mark=
er=3D"__DIVIDER__">ust_pthread -&gt; lttng_ust_pthread<br data-mce-bogus=3D=
"1"></span></div><div><span data-marker=3D"__DIVIDER__">ust_libc -&gt; lttn=
g_ust_libc<br data-mce-bogus=3D"1"></span></div><div><span data-marker=3D"_=
_DIVIDER__"><br data-mce-bogus=3D"1"></span></div><div><span data-marker=3D=
"__DIVIDER__">Thanks,<br data-mce-bogus=3D"1"></span></div><div><span data-=
marker=3D"__DIVIDER__"><br data-mce-bogus=3D"1"></span></div><div><span dat=
a-marker=3D"__DIVIDER__">Mathieu</span></div><div><span data-marker=3D"__DI=
VIDER__"><br data-mce-bogus=3D"1"></span></div><div><span id=3D"zwchr" data=
-marker=3D"__DIVIDER__">----- On Jan 19, 2016, at 12:08 PM, Martin Townsend=
 &lt;mtownsend1973@gmail.com&gt; wrote:<br></span></div><div data-marker=3D=
"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><div><div><div><div><div><div>Hi,<br><br></div>I'm tryin=
g to enable pthread mutex and libc events and then use LD_PRELOAD to load t=
he associated wrappers but I'm not getting anything in my trace files. <br>=
<br></div>Here are the commands I run<br>ttng create<br>lttng enable-event =
-u --tracepoint 'org_po_threadtest:*'<br>lttng enable-event -u --tracepoint=
 ust_pthread:pthread_mutex_lock_req<br>lttng enable-event -u --tracepoint u=
st_pthread:pthread_mutex_lock_acq<br>lttng enable-event -u --tracepoint ust=
_pthread:pthread_mutex_unlock<br>lttng enable-event -u --tracepoint 'ust_li=
bc:*'<br>lttng add-context -u&nbsp; -t pthread_id<br>lttng start<br>LTTNG_U=
ST_REGISTER_TIMEOUT=3D-1 LTTNG_UST_DEBUG=3D1 LD_PRELOAD=3D"/usr/lib/liblttn=
g-ust-pthread-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threa=
dtest<br>lttng stop<br>lttng destroy<br><br><span></span><span>The kernel a=
nd rootfs was built using Yocto (Fido)<br>&nbsp;uname -a<br>Linux am43-devb=
oard-aquila-3dc40a 3.14.26 #1 Mon Jan 11 16:52:19 GMT 2016 armv7l GNU/Linux=
<br><br>lttng --version<br>lttng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.=
0<br><br><br></span><span><br></span>Here's the output of lttng ust debug a=
nd the trace file<br>tracing started for session auto-20160113-190852<br>st=
g-ust-pthread-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threa=
dte<br>liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints se=
ction from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c=
:767)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint: org_po_=
threadtest:consume (in tracepoint_register_lib() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblttng_ust_tracep=
oint[2225/2225]: registered tracepoint: org_po_threadtest:produce (in trace=
point_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider "ust_baddr_statedum=
p" accepted, version 1.0 is compatible with LTTng UST provider version 1.0.=
 (in check_provider_version() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: adding probe ust_=
baddr_statedump containing 1 events to lazy registration list (in lttng_pro=
be_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-probes.c:216)<br>libust[2225/2225]: LTT : ltt ring buffer client "rel=
ay-metadata-mmap" init<br>&nbsp;(in lttng_ring_buffer_metadata_client_init(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-b=
uffer-metadata-client.h:330)<br>libust[2225/2225]: LTT : ltt ring buffer cl=
ient "relay-overwrite-mmap" init<br>&nbsp;(in lttng_ring_buffer_client_over=
write_init() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-ring-buffer-client.h:681)<br>libust[2225/2225]: LTT : ltt ring buffer =
client "relay-overwrite-rt-mmap" init<br>&nbsp;(in lttng_ring_buffer_client=
_overwrite_rt_init() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/lttng-ring-buffer-client.h:681)<br>libust[2225/2225]: LTT : ltt ring=
 buffer client "relay-discard-mmap" init<br>&nbsp;(in lttng_ring_buffer_cli=
ent_discard_init() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ring-buffer-client.h:681)<br>libust[2225/2225]: LTT : ltt ring b=
uffer client "relay-discard-rt-mmap" init<br>&nbsp;(in lttng_ring_buffer_cl=
ient_discard_rt_init() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ring-buffer-client.h:681)<br>libust[2225/2227]: Info: sessio=
nd not accepting connections to local apps socket (in ust_listener_thread()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:1221)<br>libust[2225/2227]: Waiting for local apps sessiond (in wait_fo=
r_sessiond() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-ust-comm.c:1132)<br>libust[2225/2226]: Message Received "Get Tracer Ve=
rsion" (65), Handle "root" (0) (in print_cmd() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]=
: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: messag=
e successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message =
Received "Create Session" (64), Handle "root" (0) (in print_cmd() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<b=
r>libust[2225/2226]: Return value: 1 (in handle_message() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust=
[2225/2226]: message successfully sent (in send_reply() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2=
225/2226]: Message Received "Create Channel" (81), Handle "session" (1) (in=
 print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-ust-comm.c:366)<br>libust[2225/2226]: channel data received (in handle=
_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:720)<br>libust[2225/2226]: Return value: 2 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received "Create Stream" (96), Handl=
e "channel" (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Creat=
e Context" (112), Handle "channel" (2) (in print_cmd() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[22=
25/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]=
: message successfully sent (in send_reply() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: =
Message Received "Create Event" (97), Handle "channel" (2) (in print_cmd() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:366)<br>libust[2225/2226]: Return value: 3 (in handle_message() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<=
br>libust[2225/2226]: message successfully sent (in send_reply() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br=
>libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (3) (=
in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_mes=
sage() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_rep=
ly() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust=
-comm.c:481)<br>libust[2225/2226]: Message Received "Create Event" (97), Ha=
ndle "channel" (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return val=
ue: 4 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successful=
ly sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "En=
able" (128), Handle "enabler" (4) (in print_cmd() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/22=
26]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: mes=
sage successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Messa=
ge Received "Create Event" (97), Handle "channel" (2) (in print_cmd() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:36=
6)<br>libust[2225/2226]: Return value: 5 (in handle_message() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>li=
bust[2225/2226]: message successfully sent (in send_reply() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libu=
st[2225/2226]: Message Received "Enable" (128), Handle "enabler" (5) (in pr=
int_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:481)<br>libust[2225/2226]: Message Received "Create Event" (97), Handle =
"channel" (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 6=
 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully se=
nt (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Enable"=
 (128), Handle "enabler" (6) (in print_cmd() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: =
Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message =
successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Re=
ceived "Create Event" (97), Handle "channel" (2) (in print_cmd() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br=
>libust[2225/2226]: Return value: 7 (in handle_message() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[=
2225/2226]: message successfully sent (in send_reply() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[22=
25/2226]: Message Received "Enable" (128), Handle "enabler" (7) (in print_c=
md() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust=
-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
824)<br>libust[2225/2226]: message successfully sent (in send_reply() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:48=
1)<br>libust[2225/2226]: Message Received "Create Event" (97), Handle "chan=
nel" (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 8 (in =
handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (i=
n send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Enable" (128=
), Handle "enabler" (8) (in print_cmd() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Retur=
n value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succe=
ssfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Receive=
d "Enable" (128), Handle "session" (1) (in print_cmd() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[22=
25/2226]: Sent register channel notification: chan_id 0, header_type 1<br>&=
nbsp;(in ustcomm_register_channel() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)<br>libust[2225/2226]: jus=
t registered probe ust_baddr_statedump containing 1 events (in lttng_lazy_p=
robe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-probes.c:115)<br>libust[2225/2226]: Return value: 0 (in handle_mess=
age() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_repl=
y() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:481)<br>libust[2225/2226]: Message Received "Wait for Quiescent Stat=
e" (67), Handle "root" (0) (in print_cmd() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Re=
turn value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message su=
ccessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboar=
d-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r=
0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Rece=
ived "Create Session" (64), Handle "root" (0) (in print_cmd() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>li=
bust[2225/2226]: Return value: 9 (in handle_message() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[222=
5/2226]: message successfully sent (in send_reply() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/=
2226]: Message Received "Create Channel" (81), Handle "session" (9) (in pri=
nt_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:366)<br>libust[2225/2226]: channel data received (in handle_mes=
sage() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:720)<br>libust[2225/2226]: Return value: 10 (in handle_message() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c=
:481)<br>libust[2225/2226]: Message Received "Create Stream" (96), Handle "=
channel" (10) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0=
 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully se=
nt (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Create =
Context" (112), Handle "channel" (10) (in print_cmd() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[222=
5/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]:=
 message successfully sent (in send_reply() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: M=
essage Received "Create Event" (97), Handle "channel" (10) (in print_cmd() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:366)<br>libust[2225/2226]: Return value: 11 (in handle_message() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)=
<br>libust[2225/2226]: message successfully sent (in send_reply() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<b=
r>libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (11)=
 (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_m=
essage() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_r=
eply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:481)<br>libust[2225/2226]: Message Received "Create Event" (97), =
Handle "channel" (10) (in print_cmd() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return =
value: 12 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succes=
sfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received=
 "Enable" (128), Handle "enabler" (12) (in print_cmd() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[22=
25/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]=
: message successfully sent (in send_reply() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: =
Message Received "Create Event" (97), Handle "channel" (10) (in print_cmd()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:366)<br>libust[2225/2226]: Return value: 13 (in handle_message() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824=
)<br>libust[2225/2226]: message successfully sent (in send_reply() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<=
br>libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (13=
) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_=
message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_=
reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-=
ust-comm.c:481)<br>libust[2225/2226]: Message Received "Create Event" (97),=
 Handle "channel" (10) (in print_cmd() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return=
 value: 14 (in handle_message() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succe=
ssfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Receive=
d "Enable" (128), Handle "enabler" (14) (in print_cmd() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2=
225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226=
]: message successfully sent (in send_reply() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]:=
 Message Received "Enable" (128), Handle "session" (9) (in print_cmd() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:3=
66)<br>libust[2225/2226]: Sent register channel notification: chan_id 0, he=
ader_type 1<br>&nbsp;(in ustcomm_register_channel() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)<br>libust=
[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/22=
26]: message successfully sent (in send_reply() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226=
]: Message Received "Wait for Quiescent State" (67), Handle "root" (0) (in =
print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lt=
tng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_messag=
e() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:481)<br>libust[2225/2226]: Message Received "Create Session" (64), Han=
dle "root" (0) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: =
15 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Creat=
e Channel" (81), Handle "session" (15) (in print_cmd() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[22=
25/2226]: channel data received (in handle_message() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libust[2225=
/2226]: Return value: 16 (in handle_message() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]:=
 message successfully sent (in send_reply() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: M=
essage Received "Create Stream" (96), Handle "channel" (16) (in print_cmd()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)=
<br>libust[2225/2226]: message successfully sent (in send_reply() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<b=
r>libust[2225/2226]: Message Received "Create Context" (112), Handle "chann=
el" (16) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in =
handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (i=
n send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Create Event=
" (97), Handle "channel" (16) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 17 (in handle_message() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: messag=
e successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message =
Received "Enable" (128), Handle "enabler" (17) (in print_cmd() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>l=
ibust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[22=
25/2226]: message successfully sent (in send_reply() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225=
/2226]: Message Received "Create Event" (97), Handle "channel" (16) (in pri=
nt_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:366)<br>libust[2225/2226]: Return value: 18 (in handle_message(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:481)<br>libust[2225/2226]: Message Received "Enable" (128), Handle "enab=
ler" (18) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in=
 handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (=
in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Create Even=
t" (97), Handle "channel" (16) (in print_cmd() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]=
: Return value: 19 (in handle_message() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: messa=
ge successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message=
 Received "Enable" (128), Handle "enabler" (19) (in print_cmd() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>=
libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2=
225/2226]: message successfully sent (in send_reply() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[222=
5/2226]: Message Received "Create Event" (97), Handle "channel" (16) (in pr=
int_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:366)<br>libust[2225/2226]: Return value: 20 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received "Enable" (128), Handle "ena=
bler" (20) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (i=
n handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent =
(in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:481)<br>libust[2225/2225]: Error: Timed out waiting for=
 lttng-sessiond (in lttng_ust_init() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:1529)<br>libust[2225/2225]: Provide=
r "lttng_ust_tracef" accepted, version 1.0 is compatible with LTTng UST pro=
vider version 1.0. (in check_provider_version() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]:=
 adding probe lttng_ust_tracef containing 1 events to lazy registration lis=
t (in lttng_probe_register() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: just registered pr=
obe lttng_ust_tracef containing 1 events (in lttng_lazy_probe_register() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:1=
15)<br>liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints se=
ction from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c=
:767)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint: org_po_=
threadtest:consume (in tracepoint_register_lib() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblttng_ust_tracep=
oint[2225/2225]: registered tracepoint: org_po_threadtest:produce (in trace=
point_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider "ust_libc" accepted=
, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_=
provider_version() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-probes.c:174)<br>libust[2225/2225]: adding probe ust_libc contai=
ning 6 events to lazy registration list (in lttng_probe_register() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br=
>libust[2225/2225]: just registered probe ust_libc containing 6 events (in =
lttng_lazy_probe_register() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-probes.c:115)<br>libust[2225/2226]: Message Received "C=
reate Session" (64), Handle "root" (0) (in print_cmd() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[22=
25/2225]: Sent register event notification for name "ust_libc:malloc": ret_=
code 0, event_id 4<br>&nbsp;(in ustcomm_register_event() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>l=
ibust[2225/2225]: Sent register event notification for name "ust_libc:free"=
: ret_code 0, event_id 5<br>&nbsp;(in ustcomm_register_event() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001=
)<br>libust[2225/2225]: Sent register event notification for name "ust_libc=
:calloc": ret_code 0, event_id 6<br>&nbsp;(in ustcomm_register_event() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-com=
m.c:1001)<br>libust[2225/2225]: Sent register event notification for name "=
ust_libc:realloc": ret_code 0, event_id 7<br>&nbsp;(in ustcomm_register_eve=
nt() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttn=
g-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event notification f=
or name "ust_libc:memalign": ret_code 0, event_id 8<br>&nbsp;(in ustcomm_re=
gister_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event noti=
fication for name "ust_libc:posix_memalign": ret_code 0, event_id 9<br>&nbs=
p;(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[222=
5/2225]: Registering probe to tracepoint ust_libc:posix_memalign (in __trac=
epoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Register=
ing probe to tracepoint ust_libc:memalign (in __tracepoint_probe_register()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:=
563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint=
 ust_libc:realloc (in __tracepoint_probe_register() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tra=
cepoint[2225/2225]: Registering probe to tracepoint ust_libc:calloc (in __t=
racepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Regis=
tering probe to tracepoint ust_libc:free (in __tracepoint_probe_register() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:5=
63)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint =
ust_libc:malloc (in __tracepoint_probe_register() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2225]:=
 Sent register event notification for name "ust_libc:malloc": ret_code 0, e=
vent_id 0<br>&nbsp;(in ustcomm_register_event() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[222=
5/2225]: Sent register event notification for name "ust_libc:free": ret_cod=
e 0, event_id 1<br>&nbsp;(in ustcomm_register_event() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libu=
st[2225/2225]: Sent register event notification for name "ust_libc:calloc":=
 ret_code 0, event_id 2<br>&nbsp;(in ustcomm_register_event() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)=
<br>libust[2225/2225]: Sent register event notification for name "ust_libc:=
realloc": ret_code 0, event_id 3<br>&nbsp;(in ustcomm_register_event() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-com=
m.c:1001)<br>libust[2225/2225]: Sent register event notification for name "=
ust_libc:memalign": ret_code 0, event_id 4<br>&nbsp;(in ustcomm_register_ev=
ent() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/ltt=
ng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event notification =
for name "ust_libc:posix_memalign": ret_code 0, event_id 5<br>&nbsp;(in ust=
comm_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: =
Registering probe to tracepoint ust_libc:posix_memalign (in __tracepoint_pr=
obe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe=
 to tracepoint ust_libc:memalign (in __tracepoint_probe_register() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>l=
iblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_libc=
:realloc (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2=
225/2225]: Registering probe to tracepoint ust_libc:calloc (in __tracepoint=
_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering pr=
obe to tracepoint ust_libc:free (in __tracepoint_probe_register() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>li=
blttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_libc:=
malloc (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43=
-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2=
_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2226]: Return v=
alue: 21 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message success=
fully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received =
"Create Channel" (81), Handle "session" (21) (in print_cmd() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>lib=
ust[2225/2226]: channel data received (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libus=
t[2225/2226]: Return value: 22 (in handle_message() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/=
2226]: message successfully sent (in send_reply() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/22=
26]: Message Received "Create Stream" (96), Handle "channel" (22) (in print=
_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
481)<br>liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints s=
ection from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.=
c:767)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint: org_po=
_threadtest:consume (in tracepoint_register_lib() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblttng_ust_trace=
point[2225/2225]: registered tracepoint: org_po_threadtest:produce (in trac=
epoint_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider "ust_pthread" acce=
pted, version 1.0 is compatible with LTTng UST provider version 1.0. (in ch=
eck_provider_version() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: adding probe ust_pthread=
 containing 4 events to lazy registration list (in lttng_probe_register() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:=
216)<br>libust[2225/2225]: just registered probe ust_pthread containing 4 e=
vents (in lttng_lazy_probe_register() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-probes.c:115)<br>libust[2225/2226]: Message R=
eceived "Create Context" (112), Handle "channel" (22) (in print_cmd() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:36=
6)<br>libust[2225/2225]: Sent register event notification for name "ust_pth=
read:pthread_mutex_lock_req": ret_code 0, event_id 0<br>&nbsp;(in ustcomm_r=
egister_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event not=
ification for name "ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_=
id 1<br>&nbsp;(in ustcomm_register_event() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/222=
5]: Sent register event notification for name "ust_pthread:pthread_mutex_tr=
ylock": ret_code 0, event_id 2<br>&nbsp;(in ustcomm_register_event() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.=
c:1001)<br>libust[2225/2225]: Sent register event notification for name "us=
t_pthread:pthread_mutex_unlock": ret_code 0, event_id 3<br>&nbsp;(in ustcom=
m_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: Reg=
istering probe to tracepoint ust_pthread:pthread_mutex_unlock (in __tracepo=
int_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering=
 probe to tracepoint ust_pthread:pthread_mutex_trylock (in __tracepoint_pro=
be_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe =
to tracepoint ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_reg=
ister() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracep=
oint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tra=
cepoint ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c=
:563)<br>libust[2225/2225]: Sent register event notification for name "ust_=
pthread:pthread_mutex_unlock": ret_code 0, event_id 6<br>&nbsp;(in ustcomm_=
register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event no=
tification for name "ust_pthread:pthread_mutex_lock_req": ret_code 0, event=
_id 7<br>&nbsp;(in ustcomm_register_event() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/22=
25]: Sent register event notification for name "ust_pthread:pthread_mutex_l=
ock_acq": ret_code 0, event_id 8<br>&nbsp;(in ustcomm_register_event() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-com=
m.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to trace=
point ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:5=
63)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint =
ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br=
>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_pt=
hread:pthread_mutex_unlock (in __tracepoint_probe_register() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[=
2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/222=
6]: message successfully sent (in send_reply() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]=
: Message Received "Create Event" (97), Handle "channel" (22) (in print_cmd=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:366)<br>libust[2225/2226]: Return value: 23 (in handle_message() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:8=
24)<br>libust[2225/2226]: message successfully sent (in send_reply() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481=
)<br>libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (=
23) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handl=
e_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lt=
tng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in sen=
d_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:481)<br>liblttng_ust_tracepoint[2225/2225]: just registered a =
tracepoints section from 0xb700108c and having 2 tracepoints (in tracepoint=
_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/tracepoint.c:767)<br>liblttng_ust_tracepoint[2225/2225]: registered trace=
point: org_po_threadtest:consume (in tracepoint_register_lib() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblt=
tng_ust_tracepoint[2225/2225]: registered tracepoint: org_po_threadtest:pro=
duce (in tracepoint_register_lib() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider "org_=
po_threadtest" accepted, version 1.0 is compatible with LTTng UST provider =
version 1.0. (in check_provider_version() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: addin=
g probe org_po_threadtest containing 2 events to lazy registration list (in=
 lttng_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: just registered probe o=
rg_po_threadtest containing 2 events (in lttng_lazy_probe_register() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)<=
br>libust[2225/2226]: Message Received "Create Event" (97), Handle "channel=
" (22) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2225]: Sent register event no=
tification for name "org_po_threadtest:produce": ret_code 0, event_id 10<br=
>&nbsp;(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sen=
t register event notification for name "org_po_threadtest:consume": ret_cod=
e 0, event_id 11<br>&nbsp;(in ustcomm_register_event() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>lib=
lttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint org_po_thr=
eadtest:consume (in __tracepoint_probe_register() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_trace=
point[2225/2225]: Registering probe to tracepoint org_po_threadtest:produce=
 (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2225]: Sent register =
event notification for name "org_po_threadtest:produce": ret_code 0, event_=
id 9<br>&nbsp;(in ustcomm_register_event() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/222=
5]: Sent register event notification for name "org_po_threadtest:consume": =
ret_code 0, event_id 10<br>&nbsp;(in ustcomm_register_event() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)=
<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint org=
_po_threadtest:consume (in __tracepoint_probe_register() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_us=
t_tracepoint[2225/2225]: Registering probe to tracepoint org_po_threadtest:=
produce (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2226]: Return =
value: 24 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succes=
sfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received=
 "Enable" (128), Handle "enabler" (24) (in print_cmd() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[22=
25/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]=
: message successfully sent (in send_reply() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: =
Message Received "Create Session" (64), Handle "root" (0) (in print_cmd() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:366)<br>libust[2225/2226]: Return value: 25 (in handle_message() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<=
br>libust[2225/2226]: message successfully sent (in send_reply() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br=
>libust[2225/2226]: Message Received "Create Channel" (81), Handle "session=
" (25) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: channel data received =
(in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Return value: 26 (in han=
dle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in s=
end_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lt=
tng-ust-comm.c:481)<br>libust[2225/2226]: Message Received "Create Stream" =
(96), Handle "channel" (26) (in print_cmd() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: R=
eturn value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message s=
uccessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Rec=
eived "Create Event" (97), Handle "channel" (26) (in print_cmd() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br=
>libust[2225/2226]: Return value: 27 (in handle_message() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust=
[2225/2226]: message successfully sent (in send_reply() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2=
225/2226]: Message Received "Enable" (128), Handle "enabler" (27) (in print=
_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
481)<br>threadtest: threadtest.c:70: consumer: Assertion `buffer-&gt;len &g=
t;=3D 0' failed.<br>Aborted<br>root@am43-devboard-aquila-3dc40a:~# lttng st=
op<br>Waiting for data availability<br>Tracing stopped for session auto-201=
60113-190852<br>root@am43-devboard-aquila-3dc40a:~# lttng destroy<br>root@a=
m43-devboard-aquila-3dc40a:~# babeltrace lttng-traces/auto-20160113-190852<=
br>[19:08:59.023256390] (+?.?????????) am43-devboard-aquila-3dc40a org_po_t=
hreadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D 3046601744 }, { value=
_field =3D 846930886, buf_pos_field =3D 0 }<br>[19:08:59.116224140] (+0.092=
967750) am43-devboard-aquila-3dc40a org_po_threadtest:produce: { cpu_id =3D=
 0 }, { pthread_id =3D 3046601744 }, { value_field =3D 1714636915, buf_pos_=
field =3D 1 }<br>[19:08:59.164360932] (+0.048136792) am43-devboard-aquila-3=
dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D 3046601=
744 }, { value_field =3D 424238335, buf_pos_field =3D 2 }<br>[19:08:59.2498=
98432] (+0.085537500) am43-devboard-aquila-3dc40a org_po_threadtest:produce=
: { cpu_id =3D 0 }, { pthread_id =3D 3046601744 }, { value_field =3D 164976=
0492, buf_pos_field =3D 3 }<br>[19:08:59.266681973] (+0.016783541) am43-dev=
board-aquila-3dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, { pthread_=
id =3D 3046601744 }, { value_field =3D 1189641421, buf_pos_field =3D 4 }<br=
>[19:08:59.269474015] (+0.002792042) am43-devboard-aquila-3dc40a org_po_thr=
eadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D 3038213136 }, { value_f=
ield =3D 1189641421, buf_pos_field =3D 4 }<br>[19:08:59.269517598] (+0.0000=
43583) am43-devboard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D =
0 }, { pthread_id =3D 3038213136 }, { value_field =3D 1649760492, buf_pos_f=
ield =3D 3 }<br>[19:08:59.269537140] (+0.000019542) am43-devboard-aquila-3d=
c40a org_po_threadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D 30382131=
36 }, { value_field =3D 424238335, buf_pos_field =3D 2 }<br>[19:08:59.26955=
5432] (+0.000018292) am43-devboard-aquila-3dc40a org_po_threadtest:consume:=
 { cpu_id =3D 0 }, { pthread_id =3D 3038213136 }, { value_field =3D 1714636=
915, buf_pos_field =3D 1 }<br>[19:08:59.269573140] (+0.000017708) am43-devb=
oard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, { pthread_i=
d =3D 3038213136 }, { value_field =3D 846930886, buf_pos_field =3D 0 }<br>[=
19:08:59.269628015] (+0.000054875) am43-devboard-aquila-3dc40a org_po_threa=
dtest:consume: { cpu_id =3D 0 }, { pthread_id =3D 3029824528 }, { value_fie=
ld =3D -1265142768, buf_pos_field =3D 4294967295 }<br><br></div>I've double=
d checked with other viewers but no ust_xxx events.<br><br></div>Am I doing=
 something wrong with the lttng commands I'm running?<br><br></div>Many Tha=
nks,<br></div>Martin<br><div><div><div><div><div><div><div><br><br></div></=
div></div></div></div></div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"=
__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http:=
//www.efficios.com</div></div></body></html>
------=_Part_16_1420688020.1453226029541--




--===============0781778080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0781778080==--
