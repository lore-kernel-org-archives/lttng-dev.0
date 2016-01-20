From: Martin Townsend <mtownsend1973@gmail.com>
Subject: Re: Problem using pthread and libc wrapper
Date: Wed, 20 Jan 2016 10:29:00 +0000
Message-ID: <CABatt_wZ9ah_coTUupZNP_fif4h5=Hb08kxKFEcf_qGQeWq6Xg__17482.45788408$1453285872$gmane$org@mail.gmail.com>
References: <CABatt_zWkMPgLx72c4VEi2nU=o-CtuFLDfN6qajUBJsFkr1eQw@mail.gmail.com>
 <613581409.17.1453226029572.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0558726786=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mtownsend1973@gmail.com>) id 1aLq0h-0007Pr-4U
 for lttng-dev@lists.lttng.org; Wed, 20 Jan 2016 05:29:23 -0500
Received: by mail-lb0-f179.google.com with SMTP id oh2so2502393lbb.3
 for <lttng-dev@lists.lttng.org>; Wed, 20 Jan 2016 02:29:07 -0800 (PST)
In-Reply-To: <613581409.17.1453226029572.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0558726786==
Content-Type: multipart/alternative; boundary=001a11c36f5c5901580529c17426

--001a11c36f5c5901580529c17426
Content-Type: text/plain; charset=UTF-8

Hi Mathieu,

I've take the latest LTTng recipes for yocto from poky/meta which uses the
git repostiory with branch=stable-2.7 and reports that it builds 2.7.0,
here are the commit ids
UST = "826c6c686f16b9aeb3100f3f880d630911691cf1"
Tools = "d71e55a5f1f423eeaa47c08e5797e47ce8e825fb"
Modules = "f4b27072a77b43af2fea72d6700bd64eb59a39f1"

I still see the same problem, Is there another branch or tag I should try?

Cheers,
Martin.

On Tue, Jan 19, 2016 at 5:53 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi Martin,
>
> Can you reproduce with the latest stable branch (2.7.x) or with master
> of lttng-ust and lttng-tools ?
>
> New in lttng 2.7 is the renaming of some providers to add proper name
> spacing:
>
> ust_pthread -> lttng_ust_pthread
> ust_libc -> lttng_ust_libc
>
> Thanks,
>
> Mathieu
>
> ----- On Jan 19, 2016, at 12:08 PM, Martin Townsend <
> mtownsend1973@gmail.com> wrote:
>
> Hi,
>
> I'm trying to enable pthread mutex and libc events and then use LD_PRELOAD
> to load the associated wrappers but I'm not getting anything in my trace
> files.
>
> Here are the commands I run
> ttng create
> lttng enable-event -u --tracepoint 'org_po_threadtest:*'
> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_req
> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_acq
> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_unlock
> lttng enable-event -u --tracepoint 'ust_libc:*'
> lttng add-context -u  -t pthread_id
> lttng start
> LTTNG_UST_REGISTER_TIMEOUT=-1 LTTNG_UST_DEBUG=1
> LD_PRELOAD="/usr/lib/liblttng-ust-pthread-wrapper.so.0
> /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threadtest
> lttng stop
> lttng destroy
>
> The kernel and rootfs was built using Yocto (Fido)
>  uname -a
> Linux am43-devboard-aquila-3dc40a 3.14.26 #1 Mon Jan 11 16:52:19 GMT 2016
> armv7l GNU/Linux
>
> lttng --version
> lttng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.0
>
>
>
> Here's the output of lttng ust debug and the trace file
> tracing started for session auto-20160113-190852
> stg-ust-pthread-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0"
> ./threadte
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "ust_baddr_statedump" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in
> check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe ust_baddr_statedump containing 1 events to
> lazy registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>  (in lttng_ring_buffer_metadata_client_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:330)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
>  (in lttng_ring_buffer_client_overwrite_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
> init
>  (in lttng_ring_buffer_client_overwrite_rt_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-mmap" init
>  (in lttng_ring_buffer_client_discard_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-rt-mmap"
> init
>  (in lttng_ring_buffer_client_discard_rt_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
> libust[2225/2227]: Info: sessiond not accepting connections to local apps
> socket (in ust_listener_thread() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1221)
> libust[2225/2227]: Waiting for local apps sessiond (in wait_for_sessiond()
> at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1132)
> libust[2225/2226]: Message Received "Get Tracer Version" (65), Handle
> "root" (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
> (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 1 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle
> "session" (1) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 2 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
> (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Context" (112), Handle
> "channel" (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 3 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (3)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 4 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (4)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 5 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (5)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 6 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (6)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 7 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (7)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (2) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 8 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (8)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "session" (1)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Sent register channel notification: chan_id 0,
> header_type 1
>  (in ustcomm_register_channel() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
> libust[2225/2226]: just registered probe ust_baddr_statedump containing 1
> events (in lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Wait for Quiescent State" (67),
> Handle "root" (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
> (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 9 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle
> "session" (9) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 10 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
> (10) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Context" (112), Handle
> "channel" (10) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (10) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 11 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (11)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (10) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 12 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (12)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (10) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 13 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (13)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (10) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 14 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (14)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "session" (9)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Sent register channel notification: chan_id 0,
> header_type 1
>  (in ustcomm_register_channel() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Wait for Quiescent State" (67),
> Handle "root" (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
> (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 15 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle
> "session" (15) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 16 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
> (16) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Context" (112), Handle
> "channel" (16) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (16) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 17 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (17)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (16) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 18 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (18)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (16) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 19 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (19)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (16) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 20 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (20)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2225]: Error: Timed out waiting for lttng-sessiond (in
> lttng_ust_init() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1529)
> libust[2225/2225]: Provider "lttng_ust_tracef" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in
> check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe lttng_ust_tracef containing 1 events to
> lazy registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe lttng_ust_tracef containing 1
> events (in lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "ust_libc" accepted, version 1.0 is compatible
> with LTTng UST provider version 1.0. (in check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe ust_libc containing 6 events to lazy
> registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe ust_libc containing 6 events (in
> lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
> (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:malloc": ret_code 0, event_id 4
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:free": ret_code 0, event_id 5
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:calloc": ret_code 0, event_id 6
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:realloc": ret_code 0, event_id 7
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:memalign": ret_code 0, event_id 8
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:posix_memalign": ret_code 0, event_id 9
>  (in ustcomm_register_event() at
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
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:malloc": ret_code 0, event_id 0
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:free": ret_code 0, event_id 1
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:calloc": ret_code 0, event_id 2
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:realloc": ret_code 0, event_id 3
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:memalign": ret_code 0, event_id 4
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_libc:posix_memalign": ret_code 0, event_id 5
>  (in ustcomm_register_event() at
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
> libust[2225/2226]: Message Received "Create Channel" (81), Handle
> "session" (21) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 22 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
> (22) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "ust_pthread" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in
> check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe ust_pthread containing 4 events to lazy
> registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe ust_pthread containing 4 events
> (in lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Message Received "Create Context" (112), Handle
> "channel" (22) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 0
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 1
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_trylock": ret_code 0, event_id 2
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 3
>  (in ustcomm_register_event() at
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
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 7
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 8
>  (in ustcomm_register_event() at
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
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (22) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 23 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (23)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:consume (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
> org_po_threadtest:produce (in tracepoint_register_lib() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
> libust[2225/2225]: Provider "org_po_threadtest" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in
> check_provider_version() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
> libust[2225/2225]: adding probe org_po_threadtest containing 2 events to
> lazy registration list (in lttng_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
> libust[2225/2225]: just registered probe org_po_threadtest containing 2
> events (in lttng_lazy_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (22) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:produce": ret_code 0, event_id 10
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:consume": ret_code 0, event_id 11
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> org_po_threadtest:consume (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
> org_po_threadtest:produce (in __tracepoint_probe_register() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:produce": ret_code 0, event_id 9
>  (in ustcomm_register_event() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
> libust[2225/2225]: Sent register event notification for name
> "org_po_threadtest:consume": ret_code 0, event_id 10
>  (in ustcomm_register_event() at
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
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (24)
> (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
> (0) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 25 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Channel" (81), Handle
> "session" (25) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: channel data received (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
> libust[2225/2226]: Return value: 26 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Stream" (96), Handle "channel"
> (26) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 0 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
> (26) (in print_cmd() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
> libust[2225/2226]: Return value: 27 (in handle_message() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
> libust[2225/2226]: message successfully sent (in send_reply() at
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (27)
> (in print_cmd() at
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
> root@am43-devboard-aquila-3dc40a:~# babeltrace
> lttng-traces/auto-20160113-190852
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
>
> I've doubled checked with other viewers but no ust_xxx events.
>
> Am I doing something wrong with the lttng commands I'm running?
>
> Many Thanks,
> Martin
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--001a11c36f5c5901580529c17426
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi Mathieu,<br><br></div>I&#39;ve=
 take the latest LTTng recipes for yocto from poky/meta which uses the git =
repostiory with branch=3Dstable-2.7 and reports that it builds 2.7.0, here =
are the commit ids<br>UST =3D &quot;826c6c686f16b9aeb3100f3f880d630911691cf=
1&quot;<br>Tools =3D &quot;d71e55a5f1f423eeaa47c08e5797e47ce8e825fb&quot;<b=
r></div>Modules =3D &quot;f4b27072a77b43af2fea72d6700bd64eb59a39f1&quot;<br=
><br></div>I still see the same problem, Is there another branch or tag I s=
hould try?<br><br></div>Cheers,<br></div>Martin.<br></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">On Tue, Jan 19, 2016 at 5:53 PM, M=
athieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@=
efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family:=
arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div><span>Hi Mart=
in,<br></span></div><div><span><br></span></div><div><span>Can you reproduc=
e with the latest stable branch (2.7.x) or with master</span></div><div><sp=
an>of lttng-ust and lttng-tools ?<br></span></div><div><span><br></span></d=
iv><div><span>New in lttng 2.7 is the renaming of some providers to add pro=
per name spacing:<br></span></div><div><span><br></span></div><div><span>us=
t_pthread -&gt; lttng_ust_pthread<br></span></div><div><span>ust_libc -&gt;=
 lttng_ust_libc<br></span></div><div><span><br></span></div><div><span>Than=
ks,<br></span></div><div><span><br></span></div><div><span>Mathieu</span></=
div><div><div class=3D"h5"><div><span><br></span></div><div><span>----- On =
Jan 19, 2016, at 12:08 PM, Martin Townsend &lt;<a href=3D"mailto:mtownsend1=
973@gmail.com" target=3D"_blank">mtownsend1973@gmail.com</a>&gt; wrote:<br>=
</span></div></div></div><div><blockquote style=3D"border-left:2px solid #1=
010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt"><div><div class=3D"h5"><div dir=3D"ltr"><div><div><div><div><d=
iv><div>Hi,<br><br></div>I&#39;m trying to enable pthread mutex and libc ev=
ents and then use LD_PRELOAD to load the associated wrappers but I&#39;m no=
t getting anything in my trace files. <br><br></div>Here are the commands I=
 run<br>ttng create<br>lttng enable-event -u --tracepoint &#39;org_po_threa=
dtest:*&#39;<br>lttng enable-event -u --tracepoint ust_pthread:pthread_mute=
x_lock_req<br>lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_=
lock_acq<br>lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_un=
lock<br>lttng enable-event -u --tracepoint &#39;ust_libc:*&#39;<br>lttng ad=
d-context -u=C2=A0 -t pthread_id<br>lttng start<br>LTTNG_UST_REGISTER_TIMEO=
UT=3D-1 LTTNG_UST_DEBUG=3D1 LD_PRELOAD=3D&quot;/usr/lib/liblttng-ust-pthrea=
d-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0&quot; ./threadtest<b=
r>lttng stop<br>lttng destroy<br><br><span></span><span>The kernel and root=
fs was built using Yocto (Fido)<br>=C2=A0uname -a<br>Linux am43-devboard-aq=
uila-3dc40a 3.14.26 #1 Mon Jan 11 16:52:19 GMT 2016 armv7l GNU/Linux<br><br=
>lttng --version<br>lttng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.0<br><b=
r><br></span><span><br></span>Here&#39;s the output of lttng ust debug and =
the trace file<br>tracing started for session auto-20160113-190852<br>stg-u=
st-pthread-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0&quot; ./thr=
eadte<br>liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints =
section from 0xb700108c and having 2 tracepoints (in tracepoint_register_li=
b() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint=
.c:767)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint: org_p=
o_threadtest:consume (in tracepoint_register_lib() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblttng_ust_trac=
epoint[2225/2225]: registered tracepoint: org_po_threadtest:produce (in tra=
cepoint_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider &quot;ust_baddr_s=
tatedump&quot; accepted, version 1.0 is compatible with LTTng UST provider =
version 1.0. (in check_provider_version() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: addin=
g probe ust_baddr_statedump containing 1 events to lazy registration list (=
in lttng_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: LTT : ltt ring buffer=
 client &quot;relay-metadata-mmap&quot; init<br>=C2=A0(in lttng_ring_buffer=
_metadata_client_init() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ring-buffer-metadata-client.h:330)<br>libust[2225/2225]: LT=
T : ltt ring buffer client &quot;relay-overwrite-mmap&quot; init<br>=C2=A0(=
in lttng_ring_buffer_client_overwrite_init() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)<br>libust[22=
25/2225]: LTT : ltt ring buffer client &quot;relay-overwrite-rt-mmap&quot; =
init<br>=C2=A0(in lttng_ring_buffer_client_overwrite_rt_init() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h=
:681)<br>libust[2225/2225]: LTT : ltt ring buffer client &quot;relay-discar=
d-mmap&quot; init<br>=C2=A0(in lttng_ring_buffer_client_discard_init() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-=
client.h:681)<br>libust[2225/2225]: LTT : ltt ring buffer client &quot;rela=
y-discard-rt-mmap&quot; init<br>=C2=A0(in lttng_ring_buffer_client_discard_=
rt_init() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ring-buffer-client.h:681)<br>libust[2225/2227]: Info: sessiond not accept=
ing connections to local apps socket (in ust_listener_thread() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1221)<br>=
libust[2225/2227]: Waiting for local apps sessiond (in wait_for_sessiond() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:1132)<br>libust[2225/2226]: Message Received &quot;Get Tracer Version&qu=
ot; (65), Handle &quot;root&quot; (0) (in print_cmd() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[222=
5/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]:=
 message successfully sent (in send_reply() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: M=
essage Received &quot;Create Session&quot; (64), Handle &quot;root&quot; (0=
) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 1 (in handle_=
message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_=
reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-=
ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Channel=
&quot; (81), Handle &quot;session&quot; (1) (in print_cmd() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libu=
st[2225/2226]: channel data received (in handle_message() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libust=
[2225/2226]: Return value: 2 (in handle_message() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/22=
26]: message successfully sent (in send_reply() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226=
]: Message Received &quot;Create Stream&quot; (96), Handle &quot;channel&qu=
ot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in h=
andle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in=
 send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create C=
ontext&quot; (112), Handle &quot;channel&quot; (2) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;ch=
annel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 3 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;enabler&quot; (3) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;ch=
annel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 4 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;enabler&quot; (4) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;ch=
annel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 5 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;enabler&quot; (5) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;ch=
annel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 6 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;enabler&quot; (6) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;ch=
annel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 7 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;enabler&quot; (7) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;ch=
annel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value:=
 8 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;enabler&quot; (8) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;session=
&quot; (1) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Sent register chan=
nel notification: chan_id 0, header_type 1<br>=C2=A0(in ustcomm_register_ch=
annel() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/l=
ttng-ust-comm.c:1108)<br>libust[2225/2226]: just registered probe ust_baddr=
_statedump containing 1 events (in lttng_lazy_probe_register() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)<br>lib=
ust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225=
/2226]: message successfully sent (in send_reply() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2=
226]: Message Received &quot;Wait for Quiescent State&quot; (67), Handle &q=
uot;root&quot; (0) (in print_cmd() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return val=
ue: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successful=
ly sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &qu=
ot;Create Session&quot; (64), Handle &quot;root&quot; (0) (in print_cmd() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:366)<br>libust[2225/2226]: Return value: 9 (in handle_message() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<b=
r>libust[2225/2226]: message successfully sent (in send_reply() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>=
libust[2225/2226]: Message Received &quot;Create Channel&quot; (81), Handle=
 &quot;session&quot; (9) (in print_cmd() at /home/poweroasis/bia/build/am43=
-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2=
_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: chan=
nel data received (in handle_message() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Return=
 value: 10 (in handle_message() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succe=
ssfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Receive=
d &quot;Create Stream&quot; (96), Handle &quot;channel&quot; (10) (in print=
_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
481)<br>libust[2225/2226]: Message Received &quot;Create Context&quot; (112=
), Handle &quot;channel&quot; (10) (in print_cmd() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2=
226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: me=
ssage successfully sent (in send_reply() at /home/poweroasis/bia/build/am43=
-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2=
_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Mess=
age Received &quot;Create Event&quot; (97), Handle &quot;channel&quot; (10)=
 (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 11 (in handle_=
message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_=
reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-=
ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (=
128), Handle &quot;enabler&quot; (11) (in print_cmd() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[222=
5/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]:=
 message successfully sent (in send_reply() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: M=
essage Received &quot;Create Event&quot; (97), Handle &quot;channel&quot; (=
10) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 12 (in hand=
le_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in se=
nd_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot=
; (128), Handle &quot;enabler&quot; (12) (in print_cmd() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[=
2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/222=
6]: message successfully sent (in send_reply() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]=
: Message Received &quot;Create Event&quot; (97), Handle &quot;channel&quot=
; (10) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 13 (in h=
andle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in=
 send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&q=
uot; (128), Handle &quot;enabler&quot; (13) (in print_cmd() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libu=
st[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/=
2226]: message successfully sent (in send_reply() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/22=
26]: Message Received &quot;Create Event&quot; (97), Handle &quot;channel&q=
uot; (10) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 14 (i=
n handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent =
(in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enabl=
e&quot; (128), Handle &quot;enabler&quot; (14) (in print_cmd() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>l=
ibust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[22=
25/2226]: message successfully sent (in send_reply() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225=
/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;session&quo=
t; (9) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Sent register channel =
notification: chan_id 0, header_type 1<br>=C2=A0(in ustcomm_register_channe=
l() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng=
-ust-comm.c:1108)<br>libust[2225/2226]: Return value: 0 (in handle_message(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:481)<br>libust[2225/2226]: Message Received &quot;Wait for Quiescent Sta=
te&quot; (67), Handle &quot;root&quot; (0) (in print_cmd() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libus=
t[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2=
226]: message successfully sent (in send_reply() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/222=
6]: Message Received &quot;Create Session&quot; (64), Handle &quot;root&quo=
t; (0) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 15 (in h=
andle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in=
 send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create C=
hannel&quot; (81), Handle &quot;session&quot; (15) (in print_cmd() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<=
br>libust[2225/2226]: channel data received (in handle_message() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br=
>libust[2225/2226]: Return value: 16 (in handle_message() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust=
[2225/2226]: message successfully sent (in send_reply() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2=
225/2226]: Message Received &quot;Create Stream&quot; (96), Handle &quot;ch=
annel&quot; (16) (in print_cmd() at /home/poweroasis/bia/build/am43-devboar=
d-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r=
0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value=
: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully=
 sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot=
;Create Context&quot; (112), Handle &quot;channel&quot; (16) (in print_cmd(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824=
)<br>libust[2225/2226]: message successfully sent (in send_reply() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<=
br>libust[2225/2226]: Message Received &quot;Create Event&quot; (97), Handl=
e &quot;channel&quot; (16) (in print_cmd() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Re=
turn value: 17 (in handle_message() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message s=
uccessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Rec=
eived &quot;Enable&quot; (128), Handle &quot;enabler&quot; (17) (in print_c=
md() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust=
-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
824)<br>libust[2225/2226]: message successfully sent (in send_reply() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:48=
1)<br>libust[2225/2226]: Message Received &quot;Create Event&quot; (97), Ha=
ndle &quot;channel&quot; (16) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 18 (in handle_message() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: messag=
e successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message =
Received &quot;Enable&quot; (128), Handle &quot;enabler&quot; (18) (in prin=
t_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-=
ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c=
:481)<br>libust[2225/2226]: Message Received &quot;Create Event&quot; (97),=
 Handle &quot;channel&quot; (16) (in print_cmd() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/222=
6]: Return value: 19 (in handle_message() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: mes=
sage successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Messa=
ge Received &quot;Enable&quot; (128), Handle &quot;enabler&quot; (19) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Create Event&quot; (9=
7), Handle &quot;channel&quot; (16) (in print_cmd() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/=
2226]: Return value: 20 (in handle_message() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: =
message successfully sent (in send_reply() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Me=
ssage Received &quot;Enable&quot; (128), Handle &quot;enabler&quot; (20) (i=
n print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_mess=
age() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_repl=
y() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:481)<br>libust[2225/2225]: Error: Timed out waiting for lttng-sessio=
nd (in lttng_ust_init() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:1529)<br>libust[2225/2225]: Provider &quot;lttng=
_ust_tracef&quot; accepted, version 1.0 is compatible with LTTng UST provid=
er version 1.0. (in check_provider_version() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: ad=
ding probe lttng_ust_tracef containing 1 events to lazy registration list (=
in lttng_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: just registered probe=
 lttng_ust_tracef containing 1 events (in lttng_lazy_probe_register() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)=
<br>liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints secti=
on from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:76=
7)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint: org_po_thr=
eadtest:consume (in tracepoint_register_lib() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>liblttng_ust_tracepoin=
t[2225/2225]: registered tracepoint: org_po_threadtest:produce (in tracepoi=
nt_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/tracepoint.c:772)<br>libust[2225/2225]: Provider &quot;ust_libc&quot; a=
ccepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in=
 check_provider_version() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: adding probe ust_libc=
 containing 6 events to lazy registration list (in lttng_probe_register() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:=
216)<br>libust[2225/2225]: just registered probe ust_libc containing 6 even=
ts (in lttng_lazy_probe_register() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-probes.c:115)<br>libust[2225/2226]: Message Rece=
ived &quot;Create Session&quot; (64), Handle &quot;root&quot; (0) (in print=
_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9=
hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-u=
st-comm.c:366)<br>libust[2225/2225]: Sent register event notification for n=
ame &quot;ust_libc:malloc&quot;: ret_code 0, event_id 4<br>=C2=A0(in ustcom=
m_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event =
notification for name &quot;ust_libc:free&quot;: ret_code 0, event_id 5<br>=
=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent=
 register event notification for name &quot;ust_libc:calloc&quot;: ret_code=
 0, event_id 6<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libus=
t[2225/2225]: Sent register event notification for name &quot;ust_libc:real=
loc&quot;: ret_code 0, event_id 7<br>=C2=A0(in ustcomm_register_event() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-co=
mm.c:1001)<br>libust[2225/2225]: Sent register event notification for name =
&quot;ust_libc:memalign&quot;: ret_code 0, event_id 8<br>=C2=A0(in ustcomm_=
register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event no=
tification for name &quot;ust_libc:posix_memalign&quot;: ret_code 0, event_=
id 9<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tr=
acepoint[2225/2225]: Registering probe to tracepoint ust_libc:posix_memalig=
n (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/222=
5]: Registering probe to tracepoint ust_libc:memalign (in __tracepoint_prob=
e_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/t=
racepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe t=
o tracepoint ust_libc:realloc (in __tracepoint_probe_register() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libl=
ttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_libc:ca=
lloc (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/=
2225]: Registering probe to tracepoint ust_libc:free (in __tracepoint_probe=
_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tr=
acepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to=
 tracepoint ust_libc:malloc (in __tracepoint_probe_register() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust=
[2225/2225]: Sent register event notification for name &quot;ust_libc:mallo=
c&quot;: ret_code 0, event_id 0<br>=C2=A0(in ustcomm_register_event() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm=
.c:1001)<br>libust[2225/2225]: Sent register event notification for name &q=
uot;ust_libc:free&quot;: ret_code 0, event_id 1<br>=C2=A0(in ustcomm_regist=
er_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-com=
m/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event notifica=
tion for name &quot;ust_libc:calloc&quot;: ret_code 0, event_id 2<br>=C2=A0=
(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent regis=
ter event notification for name &quot;ust_libc:realloc&quot;: ret_code 0, e=
vent_id 3<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[222=
5/2225]: Sent register event notification for name &quot;ust_libc:memalign&=
quot;: ret_code 0, event_id 4<br>=C2=A0(in ustcomm_register_event() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c=
:1001)<br>libust[2225/2225]: Sent register event notification for name &quo=
t;ust_libc:posix_memalign&quot;: ret_code 0, event_id 5<br>=C2=A0(in ustcom=
m_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: Reg=
istering probe to tracepoint ust_libc:posix_memalign (in __tracepoint_probe=
_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tr=
acepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to=
 tracepoint ust_libc:memalign (in __tracepoint_probe_register() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libl=
ttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_libc:re=
alloc (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225=
/2225]: Registering probe to tracepoint ust_libc:calloc (in __tracepoint_pr=
obe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe=
 to tracepoint ust_libc:free (in __tracepoint_probe_register() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblt=
tng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_libc:mal=
loc (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2226]: Return valu=
e: 21 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successful=
ly sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &qu=
ot;Create Channel&quot; (81), Handle &quot;session&quot; (21) (in print_cmd=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:366)<br>libust[2225/2226]: channel data received (in handle_message()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:720)<br>libust[2225/2226]: Return value: 22 (in handle_message() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824=
)<br>libust[2225/2226]: message successfully sent (in send_reply() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<=
br>libust[2225/2226]: Message Received &quot;Create Stream&quot; (96), Hand=
le &quot;channel&quot; (22) (in print_cmd() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: R=
eturn value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message s=
uccessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>liblttng_ust_tracepoint[2225/2=
225]: just registered a tracepoints section from 0xb700108c and having 2 tr=
acepoints (in tracepoint_register_lib() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/tracepoint.c:767)<br>liblttng_ust_tracepoint[2225=
/2225]: registered tracepoint: org_po_threadtest:consume (in tracepoint_reg=
ister_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tr=
acepoint.c:772)<br>liblttng_ust_tracepoint[2225/2225]: registered tracepoin=
t: org_po_threadtest:produce (in tracepoint_register_lib() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>libust[22=
25/2225]: Provider &quot;ust_pthread&quot; accepted, version 1.0 is compati=
ble with LTTng UST provider version 1.0. (in check_provider_version() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)=
<br>libust[2225/2225]: adding probe ust_pthread containing 4 events to lazy=
 registration list (in lttng_probe_register() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: j=
ust registered probe ust_pthread containing 4 events (in lttng_lazy_probe_r=
egister() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-probes.c:115)<br>libust[2225/2226]: Message Received &quot;Create Context=
&quot; (112), Handle &quot;channel&quot; (22) (in print_cmd() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>li=
bust[2225/2225]: Sent register event notification for name &quot;ust_pthrea=
d:pthread_mutex_lock_req&quot;: ret_code 0, event_id 0<br>=C2=A0(in ustcomm=
_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event n=
otification for name &quot;ust_pthread:pthread_mutex_lock_acq&quot;: ret_co=
de 0, event_id 1<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>lib=
ust[2225/2225]: Sent register event notification for name &quot;ust_pthread=
:pthread_mutex_trylock&quot;: ret_code 0, event_id 2<br>=C2=A0(in ustcomm_r=
egister_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event not=
ification for name &quot;ust_pthread:pthread_mutex_unlock&quot;: ret_code 0=
, event_id 3<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttn=
g_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_pthread:pt=
hread_mutex_unlock (in __tracepoint_probe_register() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tr=
acepoint[2225/2225]: Registering probe to tracepoint ust_pthread:pthread_mu=
tex_trylock (in __tracepoint_probe_register() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoin=
t[2225/2225]: Registering probe to tracepoint ust_pthread:pthread_mutex_loc=
k_acq (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225=
/2225]: Registering probe to tracepoint ust_pthread:pthread_mutex_lock_req =
(in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2225]: Sent register e=
vent notification for name &quot;ust_pthread:pthread_mutex_unlock&quot;: re=
t_code 0, event_id 6<br>=C2=A0(in ustcomm_register_event() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br=
>libust[2225/2225]: Sent register event notification for name &quot;ust_pth=
read:pthread_mutex_lock_req&quot;: ret_code 0, event_id 7<br>=C2=A0(in ustc=
omm_register_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register even=
t notification for name &quot;ust_pthread:pthread_mutex_lock_acq&quot;: ret=
_code 0, event_id 8<br>=C2=A0(in ustcomm_register_event() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>=
liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_pth=
read:pthread_mutex_lock_acq (in __tracepoint_probe_register() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libltt=
ng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_pthread:p=
thread_mutex_lock_req (in __tracepoint_probe_register() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust=
_tracepoint[2225/2225]: Registering probe to tracepoint ust_pthread:pthread=
_mutex_unlock (in __tracepoint_probe_register() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2226]: R=
eturn value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message s=
uccessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Rec=
eived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (22) (in pr=
int_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/corte=
xa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttn=
g-ust-comm.c:366)<br>libust[2225/2226]: Return value: 23 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), H=
andle &quot;enabler&quot; (23) (in print_cmd() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]=
: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: messag=
e successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>liblttng_ust_tracepoint[222=
5/2225]: just registered a tracepoints section from 0xb700108c and having 2=
 tracepoints (in tracepoint_register_lib() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)<br>liblttng_ust_tracepoint[2=
225/2225]: registered tracepoint: org_po_threadtest:consume (in tracepoint_=
register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/tracepoint.c:772)<br>liblttng_ust_tracepoint[2225/2225]: registered tracep=
oint: org_po_threadtest:produce (in tracepoint_register_lib() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>libust=
[2225/2225]: Provider &quot;org_po_threadtest&quot; accepted, version 1.0 i=
s compatible with LTTng UST provider version 1.0. (in check_provider_versio=
n() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-prob=
es.c:174)<br>libust[2225/2225]: adding probe org_po_threadtest containing 2=
 events to lazy registration list (in lttng_probe_register() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br>libus=
t[2225/2225]: just registered probe org_po_threadtest containing 2 events (=
in lttng_lazy_probe_register() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-probes.c:115)<br>libust[2225/2226]: Message Received=
 &quot;Create Event&quot; (97), Handle &quot;channel&quot; (22) (in print_c=
md() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust=
-comm.c:366)<br>libust[2225/2225]: Sent register event notification for nam=
e &quot;org_po_threadtest:produce&quot;: ret_code 0, event_id 10<br>=C2=A0(=
in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent regist=
er event notification for name &quot;org_po_threadtest:consume&quot;: ret_c=
ode 0, event_id 11<br>=C2=A0(in ustcomm_register_event() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>l=
iblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint org_po_t=
hreadtest:consume (in __tracepoint_probe_register() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tra=
cepoint[2225/2225]: Registering probe to tracepoint org_po_threadtest:produ=
ce (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2225]: Sent registe=
r event notification for name &quot;org_po_threadtest:produce&quot;: ret_co=
de 0, event_id 9<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>lib=
ust[2225/2225]: Sent register event notification for name &quot;org_po_thre=
adtest:consume&quot;: ret_code 0, event_id 10<br>=C2=A0(in ustcomm_register=
_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/=
lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: Registering p=
robe to tracepoint org_po_threadtest:consume (in __tracepoint_probe_registe=
r() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint=
.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepo=
int org_po_threadtest:produce (in __tracepoint_probe_register() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libu=
st[2225/2226]: Return value: 24 (in handle_message() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225=
/2226]: message successfully sent (in send_reply() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2=
226]: Message Received &quot;Enable&quot; (128), Handle &quot;enabler&quot;=
 (24) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in han=
dle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in s=
end_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lt=
tng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Ses=
sion&quot; (64), Handle &quot;root&quot; (0) (in print_cmd() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>lib=
ust[2225/2226]: Return value: 25 (in handle_message() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[222=
5/2226]: message successfully sent (in send_reply() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/=
2226]: Message Received &quot;Create Channel&quot; (81), Handle &quot;sessi=
on&quot; (25) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: channel data re=
ceived (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Return value: 26 =
(in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sen=
t (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Cre=
ate Stream&quot; (96), Handle &quot;channel&quot; (26) (in print_cmd() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:3=
66)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/pow=
eroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-lin=
ux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>l=
ibust[2225/2226]: message successfully sent (in send_reply() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>lib=
ust[2225/2226]: Message Received &quot;Create Event&quot; (97), Handle &quo=
t;channel&quot; (26) (in print_cmd() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return v=
alue: 27 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message success=
fully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received =
&quot;Enable&quot; (128), Handle &quot;enabler&quot; (27) (in print_cmd() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<b=
r>libust[2225/2226]: message successfully sent (in send_reply() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>=
threadtest: threadtest.c:70: consumer: Assertion `buffer-&gt;len &gt;=3D 0&=
#39; failed.<br>Aborted<br>root@am43-devboard-aquila-3dc40a:~# lttng stop<b=
r>Waiting for data availability<br>Tracing stopped for session auto-2016011=
3-190852<br>root@am43-devboard-aquila-3dc40a:~# lttng destroy<br>root@am43-=
devboard-aquila-3dc40a:~# babeltrace lttng-traces/auto-20160113-190852<br>[=
19:08:59.023256390] (+?.?????????) am43-devboard-aquila-3dc40a org_po_threa=
dtest:produce: { cpu_id =3D 0 }, { pthread_id =3D <a href=3D"tel:3046601744=
" value=3D"+13046601744" target=3D"_blank">3046601744</a> }, { value_field =
=3D 846930886, buf_pos_field =3D 0 }<br>[19:08:59.116224140] (+0.092967750)=
 am43-devboard-aquila-3dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, {=
 pthread_id =3D 3046601744 }, { value_field =3D 1714636915, buf_pos_field =
=3D 1 }<br>[19:08:59.164360932] (+0.048136792) am43-devboard-aquila-3dc40a =
org_po_threadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D 3046601744 },=
 { value_field =3D 424238335, buf_pos_field =3D 2 }<br>[19:08:59.249898432]=
 (+0.085537500) am43-devboard-aquila-3dc40a org_po_threadtest:produce: { cp=
u_id =3D 0 }, { pthread_id =3D 3046601744 }, { value_field =3D 1649760492, =
buf_pos_field =3D 3 }<br>[19:08:59.266681973] (+0.016783541) am43-devboard-=
aquila-3dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D=
 3046601744 }, { value_field =3D 1189641421, buf_pos_field =3D 4 }<br>[19:0=
8:59.269474015] (+0.002792042) am43-devboard-aquila-3dc40a org_po_threadtes=
t:consume: { cpu_id =3D 0 }, { pthread_id =3D 3038213136 }, { value_field =
=3D 1189641421, buf_pos_field =3D 4 }<br>[19:08:59.269517598] (+0.000043583=
) am43-devboard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, =
{ pthread_id =3D 3038213136 }, { value_field =3D 1649760492, buf_pos_field =
=3D 3 }<br>[19:08:59.269537140] (+0.000019542) am43-devboard-aquila-3dc40a =
org_po_threadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D 3038213136 },=
 { value_field =3D 424238335, buf_pos_field =3D 2 }<br>[19:08:59.269555432]=
 (+0.000018292) am43-devboard-aquila-3dc40a org_po_threadtest:consume: { cp=
u_id =3D 0 }, { pthread_id =3D 3038213136 }, { value_field =3D 1714636915, =
buf_pos_field =3D 1 }<br>[19:08:59.269573140] (+0.000017708) am43-devboard-=
aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D=
 3038213136 }, { value_field =3D 846930886, buf_pos_field =3D 0 }<br>[19:08=
:59.269628015] (+0.000054875) am43-devboard-aquila-3dc40a org_po_threadtest=
:consume: { cpu_id =3D 0 }, { pthread_id =3D 3029824528 }, { value_field =
=3D -1265142768, buf_pos_field =3D 4294967295 }<br><br></div>I&#39;ve doubl=
ed checked with other viewers but no ust_xxx events.<br><br></div>Am I doin=
g something wrong with the lttng commands I&#39;m running?<br><br></div>Man=
y Thanks,<br></div>Martin<br><div><div><div><div><div><div><div><br><br></d=
iv></div></div></div></div></div></div></div>
<br></div></div>_______________________________________________<br>lttng-de=
v mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=3D=
"#888888"><br></font></span></blockquote></div><span class=3D"HOEnZb"><font=
 color=3D"#888888"><div><br></div><div>-- <br></div><div>Mathieu Desnoyers<=
br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">h=
ttp://www.efficios.com</a></div></font></span></div></div></blockquote></di=
v><br></div>

--001a11c36f5c5901580529c17426--


--===============0558726786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0558726786==--
