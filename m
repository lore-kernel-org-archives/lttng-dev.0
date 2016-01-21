From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Problem using pthread and libc wrapper
Date: Thu, 21 Jan 2016 14:58:50 -0500
Message-ID: <56A1387A.7090700__28119.9821424254$1453406447$gmane$org@efficios.com>
References: <CABatt_zWkMPgLx72c4VEi2nU=o-CtuFLDfN6qajUBJsFkr1eQw@mail.gmail.com>
 <613581409.17.1453226029572.JavaMail.zimbra@efficios.com>
 <CABatt_wZ9ah_coTUupZNP_fif4h5=Hb08kxKFEcf_qGQeWq6Xg@mail.gmail.com>
 <CABatt_wVjnLVZzoknaQi1cWOZkrXVUCkg2QD_0vFSWFth1Okog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1aMLNl-0002nq-EV
 for lttng-dev@lists.lttng.org; Thu, 21 Jan 2016 14:59:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1D4553403DD
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jan 2016 19:58:55 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id D6RnP6Wbsujp for <lttng-dev@lists.lttng.org>;
 Thu, 21 Jan 2016 19:58:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EAD023404DD
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jan 2016 19:58:51 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 4vxMAaVy-EFy for <lttng-dev@lists.lttng.org>;
 Thu, 21 Jan 2016 19:58:51 +0000 (UTC)
Received: from [172.16.0.150] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 3F0813403DD
 for <lttng-dev@lists.lttng.org>; Thu, 21 Jan 2016 19:58:51 +0000 (UTC)
In-Reply-To: <CABatt_wVjnLVZzoknaQi1cWOZkrXVUCkg2QD_0vFSWFth1Okog@mail.gmail.com>
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

Hi Martin,

We have been able to reproduce the problem with yocto-fido with updated 
lttng 2.7.1 on a wanboard-quad(armv7rev10).

This is some weird behavior and so far we don't have a direct 
explanation. We have other arm boards with Ubuntu on it and we will 
check if we have any problems there to eliminate some hypothesis.
It's not only affecting the libc and pthread wrapped but also to the 
internal statedump provider etc.

We are working on it.

Thanks for reporting this and working with us on the issue.

Cheers

On 2016-01-20 10:28 AM, Martin Townsend wrote:
> Hi Mathieu,
>
> I tried the HEAD of stable-2.7 but still the same problem.  With gdb I 
> stepped through the code and although it stepped into the pthread 
> wrapper it didn't step into the tracepoint call but then again it 
> didn't for the applications tracepoint calls so probably can't read 
> too much into that.
>
> Although I see a message saying that the pthread tracepoints are being 
> registered.
>
> liblttng_ust_tracepoint[4855/4855]: Registering probe to tracepoint 
> lttng_ust_pthread:pthread_mutex_lock_req (in 
> __tracepoint_probe_register() at 
> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.7.1+gitAUTOINC+7e249a01c9-r0/git/liblttng-ust/tracepoint.c:564)
> ...
>
> I never see the message saying they are registered but I do with my 
> application specific tracepoints.
>
> I'll try dynamically loading my application tracepoints, maybe this is 
> the problem.
>
> Cheers,
> Martin.
>
>
>
> On Wed, Jan 20, 2016 at 10:29 AM, Martin Townsend 
> <mtownsend1973@gmail.com <mailto:mtownsend1973@gmail.com>> wrote:
>
>     Hi Mathieu,
>
>     I've take the latest LTTng recipes for yocto from poky/meta which
>     uses the git repostiory with branch=stable-2.7 and reports that it
>     builds 2.7.0, here are the commit ids
>     UST = "826c6c686f16b9aeb3100f3f880d630911691cf1"
>     Tools = "d71e55a5f1f423eeaa47c08e5797e47ce8e825fb"
>     Modules = "f4b27072a77b43af2fea72d6700bd64eb59a39f1"
>
>     I still see the same problem, Is there another branch or tag I
>     should try?
>
>     Cheers,
>     Martin.
>
>     On Tue, Jan 19, 2016 at 5:53 PM, Mathieu Desnoyers
>     <mathieu.desnoyers@efficios.com
>     <mailto:mathieu.desnoyers@efficios.com>> wrote:
>
>         Hi Martin,
>
>         Can you reproduce with the latest stable branch (2.7.x) or
>         with master
>         of lttng-ust and lttng-tools ?
>
>         New in lttng 2.7 is the renaming of some providers to add
>         proper name spacing:
>
>         ust_pthread -> lttng_ust_pthread
>         ust_libc -> lttng_ust_libc
>
>         Thanks,
>
>         Mathieu
>
>         ----- On Jan 19, 2016, at 12:08 PM, Martin Townsend
>         <mtownsend1973@gmail.com <mailto:mtownsend1973@gmail.com>> wrote:
>
>             Hi,
>
>             I'm trying to enable pthread mutex and libc events and
>             then use LD_PRELOAD to load the associated wrappers but
>             I'm not getting anything in my trace files.
>
>             Here are the commands I run
>             ttng create
>             lttng enable-event -u --tracepoint 'org_po_threadtest:*'
>             lttng enable-event -u --tracepoint
>             ust_pthread:pthread_mutex_lock_req
>             lttng enable-event -u --tracepoint
>             ust_pthread:pthread_mutex_lock_acq
>             lttng enable-event -u --tracepoint
>             ust_pthread:pthread_mutex_unlock
>             lttng enable-event -u --tracepoint 'ust_libc:*'
>             lttng add-context -u  -t pthread_id
>             lttng start
>             LTTNG_UST_REGISTER_TIMEOUT=-1 LTTNG_UST_DEBUG=1
>             LD_PRELOAD="/usr/lib/liblttng-ust-pthread-wrapper.so.0
>             /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threadtest
>             lttng stop
>             lttng destroy
>
>             The kernel and rootfs was built using Yocto (Fido)
>              uname -a
>             Linux am43-devboard-aquila-3dc40a 3.14.26 #1 Mon Jan 11
>             16:52:19 GMT 2016 armv7l GNU/Linux
>
>             lttng --version
>             lttng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.0
>
>
>
>             Here's the output of lttng ust debug and the trace file
>             tracing started for session auto-20160113-190852
>             stg-ust-pthread-wrapper.so.0
>             /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threadte
>             liblttng_ust_tracepoint[2225/2225]: just registered a
>             tracepoints section from 0xb700108c and having 2
>             tracepoints (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:consume (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:produce (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             libust[2225/2225]: Provider "ust_baddr_statedump"
>             accepted, version 1.0 is compatible with LTTng UST
>             provider version 1.0. (in check_provider_version() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>             libust[2225/2225]: adding probe ust_baddr_statedump
>             containing 1 events to lazy registration list (in
>             lttng_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>             libust[2225/2225]: LTT : ltt ring buffer client
>             "relay-metadata-mmap" init
>              (in lttng_ring_buffer_metadata_client_init() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:330)
>             libust[2225/2225]: LTT : ltt ring buffer client
>             "relay-overwrite-mmap" init
>              (in lttng_ring_buffer_client_overwrite_init() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>             libust[2225/2225]: LTT : ltt ring buffer client
>             "relay-overwrite-rt-mmap" init
>              (in lttng_ring_buffer_client_overwrite_rt_init() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>             libust[2225/2225]: LTT : ltt ring buffer client
>             "relay-discard-mmap" init
>              (in lttng_ring_buffer_client_discard_init() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>             libust[2225/2225]: LTT : ltt ring buffer client
>             "relay-discard-rt-mmap" init
>              (in lttng_ring_buffer_client_discard_rt_init() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>             libust[2225/2227]: Info: sessiond not accepting
>             connections to local apps socket (in ust_listener_thread()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1221)
>             libust[2225/2227]: Waiting for local apps sessiond (in
>             wait_for_sessiond() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1132)
>             libust[2225/2226]: Message Received "Get Tracer Version"
>             (65), Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Session" (64),
>             Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 1 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Channel" (81),
>             Handle "session" (1) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: channel data received (in
>             handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>             libust[2225/2226]: Return value: 2 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Stream" (96),
>             Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Context"
>             (112), Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 3 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (3) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 4 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (4) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 5 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (5) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 6 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (6) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 7 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (7) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (2) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 8 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (8) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "session" (1) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Sent register channel notification:
>             chan_id 0, header_type 1
>              (in ustcomm_register_channel() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
>             libust[2225/2226]: just registered probe
>             ust_baddr_statedump containing 1 events (in
>             lttng_lazy_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Wait for Quiescent
>             State" (67), Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Session" (64),
>             Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 9 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Channel" (81),
>             Handle "session" (9) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: channel data received (in
>             handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>             libust[2225/2226]: Return value: 10 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Stream" (96),
>             Handle "channel" (10) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Context"
>             (112), Handle "channel" (10) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (10) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 11 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (11) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (10) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 12 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (12) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (10) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 13 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (13) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (10) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 14 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (14) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "session" (9) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Sent register channel notification:
>             chan_id 0, header_type 1
>              (in ustcomm_register_channel() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Wait for Quiescent
>             State" (67), Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Session" (64),
>             Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 15 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Channel" (81),
>             Handle "session" (15) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: channel data received (in
>             handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>             libust[2225/2226]: Return value: 16 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Stream" (96),
>             Handle "channel" (16) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Context"
>             (112), Handle "channel" (16) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (16) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 17 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (17) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (16) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 18 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (18) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (16) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 19 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (19) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (16) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 20 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (20) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2225]: Error: Timed out waiting for
>             lttng-sessiond (in lttng_ust_init() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1529)
>             libust[2225/2225]: Provider "lttng_ust_tracef" accepted,
>             version 1.0 is compatible with LTTng UST provider version
>             1.0. (in check_provider_version() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>             libust[2225/2225]: adding probe lttng_ust_tracef
>             containing 1 events to lazy registration list (in
>             lttng_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>             libust[2225/2225]: just registered probe lttng_ust_tracef
>             containing 1 events (in lttng_lazy_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>             liblttng_ust_tracepoint[2225/2225]: just registered a
>             tracepoints section from 0xb700108c and having 2
>             tracepoints (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:consume (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:produce (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             libust[2225/2225]: Provider "ust_libc" accepted, version
>             1.0 is compatible with LTTng UST provider version 1.0. (in
>             check_provider_version() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>             libust[2225/2225]: adding probe ust_libc containing 6
>             events to lazy registration list (in
>             lttng_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>             libust[2225/2225]: just registered probe ust_libc
>             containing 6 events (in lttng_lazy_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>             libust[2225/2226]: Message Received "Create Session" (64),
>             Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:malloc": ret_code 0, event_id 4
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:free": ret_code 0, event_id 5
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:calloc": ret_code 0, event_id 6
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:realloc": ret_code 0, event_id 7
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:memalign": ret_code 0, event_id 8
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:posix_memalign": ret_code 0, event_id 9
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:posix_memalign (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:memalign (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:realloc (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:calloc (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:free (in __tracepoint_probe_register()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:malloc (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:malloc": ret_code 0, event_id 0
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:free": ret_code 0, event_id 1
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:calloc": ret_code 0, event_id 2
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:realloc": ret_code 0, event_id 3
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:memalign": ret_code 0, event_id 4
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_libc:posix_memalign": ret_code 0, event_id 5
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:posix_memalign (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:memalign (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:realloc (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:calloc (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:free (in __tracepoint_probe_register()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_libc:malloc (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             libust[2225/2226]: Return value: 21 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Channel" (81),
>             Handle "session" (21) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: channel data received (in
>             handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>             libust[2225/2226]: Return value: 22 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Stream" (96),
>             Handle "channel" (22) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             liblttng_ust_tracepoint[2225/2225]: just registered a
>             tracepoints section from 0xb700108c and having 2
>             tracepoints (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:consume (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:produce (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             libust[2225/2225]: Provider "ust_pthread" accepted,
>             version 1.0 is compatible with LTTng UST provider version
>             1.0. (in check_provider_version() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>             libust[2225/2225]: adding probe ust_pthread containing 4
>             events to lazy registration list (in
>             lttng_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>             libust[2225/2225]: just registered probe ust_pthread
>             containing 4 events (in lttng_lazy_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>             libust[2225/2226]: Message Received "Create Context"
>             (112), Handle "channel" (22) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_pthread:pthread_mutex_lock_req": ret_code 0,
>             event_id 0
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_pthread:pthread_mutex_lock_acq": ret_code 0,
>             event_id 1
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_pthread:pthread_mutex_trylock": ret_code 0,
>             event_id 2
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_pthread:pthread_mutex_unlock": ret_code 0,
>             event_id 3
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_pthread:pthread_mutex_unlock (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_pthread:pthread_mutex_trylock (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_pthread:pthread_mutex_lock_acq (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_pthread:pthread_mutex_lock_req (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_pthread:pthread_mutex_unlock": ret_code 0,
>             event_id 6
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_pthread:pthread_mutex_lock_req": ret_code 0,
>             event_id 7
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "ust_pthread:pthread_mutex_lock_acq": ret_code 0,
>             event_id 8
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_pthread:pthread_mutex_lock_acq (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_pthread:pthread_mutex_lock_req (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint ust_pthread:pthread_mutex_unlock (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (22) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 23 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (23) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             liblttng_ust_tracepoint[2225/2225]: just registered a
>             tracepoints section from 0xb700108c and having 2
>             tracepoints (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:consume (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>             org_po_threadtest:produce (in tracepoint_register_lib() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>             libust[2225/2225]: Provider "org_po_threadtest" accepted,
>             version 1.0 is compatible with LTTng UST provider version
>             1.0. (in check_provider_version() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>             libust[2225/2225]: adding probe org_po_threadtest
>             containing 2 events to lazy registration list (in
>             lttng_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>             libust[2225/2225]: just registered probe org_po_threadtest
>             containing 2 events (in lttng_lazy_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (22) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2225]: Sent register event notification for
>             name "org_po_threadtest:produce": ret_code 0, event_id 10
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "org_po_threadtest:consume": ret_code 0, event_id 11
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint org_po_threadtest:consume (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint org_po_threadtest:produce (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             libust[2225/2225]: Sent register event notification for
>             name "org_po_threadtest:produce": ret_code 0, event_id 9
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             libust[2225/2225]: Sent register event notification for
>             name "org_po_threadtest:consume": ret_code 0, event_id 10
>              (in ustcomm_register_event() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint org_po_threadtest:consume (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             liblttng_ust_tracepoint[2225/2225]: Registering probe to
>             tracepoint org_po_threadtest:produce (in
>             __tracepoint_probe_register() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>             libust[2225/2226]: Return value: 24 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (24) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Session" (64),
>             Handle "root" (0) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 25 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Channel" (81),
>             Handle "session" (25) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: channel data received (in
>             handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>             libust[2225/2226]: Return value: 26 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Stream" (96),
>             Handle "channel" (26) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Create Event" (97),
>             Handle "channel" (26) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 27 (in handle_message()
>             at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             libust[2225/2226]: Message Received "Enable" (128), Handle
>             "enabler" (27) (in print_cmd() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>             libust[2225/2226]: Return value: 0 (in handle_message() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>             libust[2225/2226]: message successfully sent (in
>             send_reply() at
>             /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>             threadtest: threadtest.c:70: consumer: Assertion
>             `buffer->len >= 0' failed.
>             Aborted
>             root@am43-devboard-aquila-3dc40a:~# lttng stop
>             Waiting for data availability
>             Tracing stopped for session auto-20160113-190852
>             root@am43-devboard-aquila-3dc40a:~# lttng destroy
>             root@am43-devboard-aquila-3dc40a:~# babeltrace
>             lttng-traces/auto-20160113-190852
>             [19:08:59.023256390] (+?.?????????)
>             am43-devboard-aquila-3dc40a org_po_threadtest:produce: {
>             cpu_id = 0 }, { pthread_id = 3046601744 <tel:3046601744>
>             }, { value_field = 846930886, buf_pos_field = 0 }
>             [19:08:59.116224140] (+0.092967750)
>             am43-devboard-aquila-3dc40a org_po_threadtest:produce: {
>             cpu_id = 0 }, { pthread_id = 3046601744 }, { value_field =
>             1714636915, buf_pos_field = 1 }
>             [19:08:59.164360932] (+0.048136792)
>             am43-devboard-aquila-3dc40a org_po_threadtest:produce: {
>             cpu_id = 0 }, { pthread_id = 3046601744 }, { value_field =
>             424238335, buf_pos_field = 2 }
>             [19:08:59.249898432] (+0.085537500)
>             am43-devboard-aquila-3dc40a org_po_threadtest:produce: {
>             cpu_id = 0 }, { pthread_id = 3046601744 }, { value_field =
>             1649760492, buf_pos_field = 3 }
>             [19:08:59.266681973] (+0.016783541)
>             am43-devboard-aquila-3dc40a org_po_threadtest:produce: {
>             cpu_id = 0 }, { pthread_id = 3046601744 }, { value_field =
>             1189641421, buf_pos_field = 4 }
>             [19:08:59.269474015] (+0.002792042)
>             am43-devboard-aquila-3dc40a org_po_threadtest:consume: {
>             cpu_id = 0 }, { pthread_id = 3038213136 }, { value_field =
>             1189641421, buf_pos_field = 4 }
>             [19:08:59.269517598] (+0.000043583)
>             am43-devboard-aquila-3dc40a org_po_threadtest:consume: {
>             cpu_id = 0 }, { pthread_id = 3038213136 }, { value_field =
>             1649760492, buf_pos_field = 3 }
>             [19:08:59.269537140] (+0.000019542)
>             am43-devboard-aquila-3dc40a org_po_threadtest:consume: {
>             cpu_id = 0 }, { pthread_id = 3038213136 }, { value_field =
>             424238335, buf_pos_field = 2 }
>             [19:08:59.269555432] (+0.000018292)
>             am43-devboard-aquila-3dc40a org_po_threadtest:consume: {
>             cpu_id = 0 }, { pthread_id = 3038213136 }, { value_field =
>             1714636915, buf_pos_field = 1 }
>             [19:08:59.269573140] (+0.000017708)
>             am43-devboard-aquila-3dc40a org_po_threadtest:consume: {
>             cpu_id = 0 }, { pthread_id = 3038213136 }, { value_field =
>             846930886, buf_pos_field = 0 }
>             [19:08:59.269628015] (+0.000054875)
>             am43-devboard-aquila-3dc40a org_po_threadtest:consume: {
>             cpu_id = 0 }, { pthread_id = 3029824528 }, { value_field =
>             -1265142768, buf_pos_field = 4294967295 }
>
>             I've doubled checked with other viewers but no ust_xxx events.
>
>             Am I doing something wrong with the lttng commands I'm
>             running?
>
>             Many Thanks,
>             Martin
>
>
>
>             _______________________________________________
>             lttng-dev mailing list
>             lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>             http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>         -- 
>         Mathieu Desnoyers
>         EfficiOS Inc.
>         http://www.efficios.com
>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
