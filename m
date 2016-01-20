From: Martin Townsend <mtownsend1973@gmail.com>
Subject: Re: Problem using pthread and libc wrapper
Date: Wed, 20 Jan 2016 15:28:12 +0000
Message-ID: <CABatt_wVjnLVZzoknaQi1cWOZkrXVUCkg2QD_0vFSWFth1Okog__6438.67680705643$1453303818$gmane$org@mail.gmail.com>
References: <CABatt_zWkMPgLx72c4VEi2nU=o-CtuFLDfN6qajUBJsFkr1eQw@mail.gmail.com>
 <613581409.17.1453226029572.JavaMail.zimbra@efficios.com>
 <CABatt_wZ9ah_coTUupZNP_fif4h5=Hb08kxKFEcf_qGQeWq6Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1517407562=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mtownsend1973@gmail.com>) id 1aLugE-00015G-Ul
 for lttng-dev@lists.lttng.org; Wed, 20 Jan 2016 10:28:32 -0500
Received: by mail-lf0-f51.google.com with SMTP id 17so8147943lfz.1
 for <lttng-dev@lists.lttng.org>; Wed, 20 Jan 2016 07:28:18 -0800 (PST)
In-Reply-To: <CABatt_wZ9ah_coTUupZNP_fif4h5=Hb08kxKFEcf_qGQeWq6Xg@mail.gmail.com>
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

--===============1517407562==
Content-Type: multipart/alternative; boundary=001a11417b305dafac0529c5a24b

--001a11417b305dafac0529c5a24b
Content-Type: text/plain; charset=UTF-8

Hi Mathieu,

I tried the HEAD of stable-2.7 but still the same problem.  With gdb I
stepped through the code and although it stepped into the pthread wrapper
it didn't step into the tracepoint call but then again it didn't for the
applications tracepoint calls so probably can't read too much into that.

Although I see a message saying that the pthread tracepoints are being
registered.

liblttng_ust_tracepoint[4855/4855]: Registering probe to tracepoint
lttng_ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register()
at
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.7.1+gitAUTOINC+7e249a01c9-r0/git/liblttng-ust/tracepoint.c:564)
...

I never see the message saying they are registered but I do with my
application specific tracepoints.

I'll try dynamically loading my application tracepoints, maybe this is the
problem.

Cheers,
Martin.



On Wed, Jan 20, 2016 at 10:29 AM, Martin Townsend <mtownsend1973@gmail.com>
wrote:

> Hi Mathieu,
>
> I've take the latest LTTng recipes for yocto from poky/meta which uses the
> git repostiory with branch=stable-2.7 and reports that it builds 2.7.0,
> here are the commit ids
> UST = "826c6c686f16b9aeb3100f3f880d630911691cf1"
> Tools = "d71e55a5f1f423eeaa47c08e5797e47ce8e825fb"
> Modules = "f4b27072a77b43af2fea72d6700bd64eb59a39f1"
>
> I still see the same problem, Is there another branch or tag I should try?
>
> Cheers,
> Martin.
>
> On Tue, Jan 19, 2016 at 5:53 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> Hi Martin,
>>
>> Can you reproduce with the latest stable branch (2.7.x) or with master
>> of lttng-ust and lttng-tools ?
>>
>> New in lttng 2.7 is the renaming of some providers to add proper name
>> spacing:
>>
>> ust_pthread -> lttng_ust_pthread
>> ust_libc -> lttng_ust_libc
>>
>> Thanks,
>>
>> Mathieu
>>
>> ----- On Jan 19, 2016, at 12:08 PM, Martin Townsend <
>> mtownsend1973@gmail.com> wrote:
>>
>> Hi,
>>
>> I'm trying to enable pthread mutex and libc events and then use
>> LD_PRELOAD to load the associated wrappers but I'm not getting anything in
>> my trace files.
>>
>> Here are the commands I run
>> ttng create
>> lttng enable-event -u --tracepoint 'org_po_threadtest:*'
>> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_req
>> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_lock_acq
>> lttng enable-event -u --tracepoint ust_pthread:pthread_mutex_unlock
>> lttng enable-event -u --tracepoint 'ust_libc:*'
>> lttng add-context -u  -t pthread_id
>> lttng start
>> LTTNG_UST_REGISTER_TIMEOUT=-1 LTTNG_UST_DEBUG=1
>> LD_PRELOAD="/usr/lib/liblttng-ust-pthread-wrapper.so.0
>> /usr/lib/liblttng-ust-libc-wrapper.so.0" ./threadtest
>> lttng stop
>> lttng destroy
>>
>> The kernel and rootfs was built using Yocto (Fido)
>>  uname -a
>> Linux am43-devboard-aquila-3dc40a 3.14.26 #1 Mon Jan 11 16:52:19 GMT 2016
>> armv7l GNU/Linux
>>
>> lttng --version
>> lttng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.0
>>
>>
>>
>> Here's the output of lttng ust debug and the trace file
>> tracing started for session auto-20160113-190852
>> stg-ust-pthread-wrapper.so.0 /usr/lib/liblttng-ust-libc-wrapper.so.0"
>> ./threadte
>> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
>> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:consume (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:produce (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> libust[2225/2225]: Provider "ust_baddr_statedump" accepted, version 1.0
>> is compatible with LTTng UST provider version 1.0. (in
>> check_provider_version() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>> libust[2225/2225]: adding probe ust_baddr_statedump containing 1 events
>> to lazy registration list (in lttng_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>> libust[2225/2225]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>>  (in lttng_ring_buffer_metadata_client_init() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-metadata-client.h:330)
>> libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-mmap"
>> init
>>  (in lttng_ring_buffer_client_overwrite_init() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>> libust[2225/2225]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
>> init
>>  (in lttng_ring_buffer_client_overwrite_rt_init() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>> libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-mmap" init
>>  (in lttng_ring_buffer_client_discard_init() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>> libust[2225/2225]: LTT : ltt ring buffer client "relay-discard-rt-mmap"
>> init
>>  (in lttng_ring_buffer_client_discard_rt_init() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)
>> libust[2225/2227]: Info: sessiond not accepting connections to local apps
>> socket (in ust_listener_thread() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1221)
>> libust[2225/2227]: Waiting for local apps sessiond (in
>> wait_for_sessiond() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1132)
>> libust[2225/2226]: Message Received "Get Tracer Version" (65), Handle
>> "root" (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
>> (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 1 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Channel" (81), Handle
>> "session" (1) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: channel data received (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>> libust[2225/2226]: Return value: 2 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Stream" (96), Handle
>> "channel" (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Context" (112), Handle
>> "channel" (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 3 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (3)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 4 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (4)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 5 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (5)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 6 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (6)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 7 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (7)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (2) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 8 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (8)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "session" (1)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Sent register channel notification: chan_id 0,
>> header_type 1
>>  (in ustcomm_register_channel() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
>> libust[2225/2226]: just registered probe ust_baddr_statedump containing 1
>> events (in lttng_lazy_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Wait for Quiescent State" (67),
>> Handle "root" (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
>> (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 9 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Channel" (81), Handle
>> "session" (9) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: channel data received (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>> libust[2225/2226]: Return value: 10 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Stream" (96), Handle
>> "channel" (10) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Context" (112), Handle
>> "channel" (10) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (10) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 11 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (11)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (10) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 12 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (12)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (10) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 13 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (13)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (10) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 14 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (14)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "session" (9)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Sent register channel notification: chan_id 0,
>> header_type 1
>>  (in ustcomm_register_channel() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Wait for Quiescent State" (67),
>> Handle "root" (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
>> (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 15 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Channel" (81), Handle
>> "session" (15) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: channel data received (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>> libust[2225/2226]: Return value: 16 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Stream" (96), Handle
>> "channel" (16) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Context" (112), Handle
>> "channel" (16) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (16) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 17 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (17)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (16) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 18 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (18)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (16) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 19 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (19)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (16) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 20 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (20)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2225]: Error: Timed out waiting for lttng-sessiond (in
>> lttng_ust_init() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1529)
>> libust[2225/2225]: Provider "lttng_ust_tracef" accepted, version 1.0 is
>> compatible with LTTng UST provider version 1.0. (in
>> check_provider_version() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>> libust[2225/2225]: adding probe lttng_ust_tracef containing 1 events to
>> lazy registration list (in lttng_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>> libust[2225/2225]: just registered probe lttng_ust_tracef containing 1
>> events (in lttng_lazy_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
>> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:consume (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:produce (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> libust[2225/2225]: Provider "ust_libc" accepted, version 1.0 is
>> compatible with LTTng UST provider version 1.0. (in
>> check_provider_version() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>> libust[2225/2225]: adding probe ust_libc containing 6 events to lazy
>> registration list (in lttng_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>> libust[2225/2225]: just registered probe ust_libc containing 6 events (in
>> lttng_lazy_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
>> (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:malloc": ret_code 0, event_id 4
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:free": ret_code 0, event_id 5
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:calloc": ret_code 0, event_id 6
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:realloc": ret_code 0, event_id 7
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:memalign": ret_code 0, event_id 8
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:posix_memalign": ret_code 0, event_id 9
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:posix_memalign (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:memalign (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:realloc (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:calloc (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:free (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:malloc (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:malloc": ret_code 0, event_id 0
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:free": ret_code 0, event_id 1
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:calloc": ret_code 0, event_id 2
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:realloc": ret_code 0, event_id 3
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:memalign": ret_code 0, event_id 4
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_libc:posix_memalign": ret_code 0, event_id 5
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:posix_memalign (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:memalign (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:realloc (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:calloc (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:free (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_libc:malloc (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> libust[2225/2226]: Return value: 21 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Channel" (81), Handle
>> "session" (21) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: channel data received (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>> libust[2225/2226]: Return value: 22 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Stream" (96), Handle
>> "channel" (22) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
>> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:consume (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:produce (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> libust[2225/2225]: Provider "ust_pthread" accepted, version 1.0 is
>> compatible with LTTng UST provider version 1.0. (in
>> check_provider_version() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>> libust[2225/2225]: adding probe ust_pthread containing 4 events to lazy
>> registration list (in lttng_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>> libust[2225/2225]: just registered probe ust_pthread containing 4 events
>> (in lttng_lazy_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>> libust[2225/2226]: Message Received "Create Context" (112), Handle
>> "channel" (22) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 0
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 1
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_pthread:pthread_mutex_trylock": ret_code 0, event_id 2
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 3
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_pthread:pthread_mutex_unlock (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_pthread:pthread_mutex_trylock (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_pthread:pthread_mutex_unlock": ret_code 0, event_id 6
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_pthread:pthread_mutex_lock_req": ret_code 0, event_id 7
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "ust_pthread:pthread_mutex_lock_acq": ret_code 0, event_id 8
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_pthread:pthread_mutex_lock_acq (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_pthread:pthread_mutex_lock_req (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> ust_pthread:pthread_mutex_unlock (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (22) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 23 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (23)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> liblttng_ust_tracepoint[2225/2225]: just registered a tracepoints section
>> from 0xb700108c and having 2 tracepoints (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:consume (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> liblttng_ust_tracepoint[2225/2225]: registered tracepoint:
>> org_po_threadtest:produce (in tracepoint_register_lib() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)
>> libust[2225/2225]: Provider "org_po_threadtest" accepted, version 1.0 is
>> compatible with LTTng UST provider version 1.0. (in
>> check_provider_version() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)
>> libust[2225/2225]: adding probe org_po_threadtest containing 2 events to
>> lazy registration list (in lttng_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)
>> libust[2225/2225]: just registered probe org_po_threadtest containing 2
>> events (in lttng_lazy_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (22) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2225]: Sent register event notification for name
>> "org_po_threadtest:produce": ret_code 0, event_id 10
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "org_po_threadtest:consume": ret_code 0, event_id 11
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> org_po_threadtest:consume (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> org_po_threadtest:produce (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> libust[2225/2225]: Sent register event notification for name
>> "org_po_threadtest:produce": ret_code 0, event_id 9
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> libust[2225/2225]: Sent register event notification for name
>> "org_po_threadtest:consume": ret_code 0, event_id 10
>>  (in ustcomm_register_event() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> org_po_threadtest:consume (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint
>> org_po_threadtest:produce (in __tracepoint_probe_register() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)
>> libust[2225/2226]: Return value: 24 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (24)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Session" (64), Handle "root"
>> (0) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 25 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Channel" (81), Handle
>> "session" (25) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: channel data received (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)
>> libust[2225/2226]: Return value: 26 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Stream" (96), Handle
>> "channel" (26) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Create Event" (97), Handle "channel"
>> (26) (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 27 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> libust[2225/2226]: Message Received "Enable" (128), Handle "enabler" (27)
>> (in print_cmd() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)
>> libust[2225/2226]: Return value: 0 (in handle_message() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)
>> libust[2225/2226]: message successfully sent (in send_reply() at
>> /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)
>> threadtest: threadtest.c:70: consumer: Assertion `buffer->len >= 0'
>> failed.
>> Aborted
>> root@am43-devboard-aquila-3dc40a:~# lttng stop
>> Waiting for data availability
>> Tracing stopped for session auto-20160113-190852
>> root@am43-devboard-aquila-3dc40a:~# lttng destroy
>> root@am43-devboard-aquila-3dc40a:~# babeltrace
>> lttng-traces/auto-20160113-190852
>> [19:08:59.023256390] (+?.?????????) am43-devboard-aquila-3dc40a
>> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 },
>> { value_field = 846930886, buf_pos_field = 0 }
>> [19:08:59.116224140] (+0.092967750) am43-devboard-aquila-3dc40a
>> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
>> value_field = 1714636915, buf_pos_field = 1 }
>> [19:08:59.164360932] (+0.048136792) am43-devboard-aquila-3dc40a
>> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
>> value_field = 424238335, buf_pos_field = 2 }
>> [19:08:59.249898432] (+0.085537500) am43-devboard-aquila-3dc40a
>> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
>> value_field = 1649760492, buf_pos_field = 3 }
>> [19:08:59.266681973] (+0.016783541) am43-devboard-aquila-3dc40a
>> org_po_threadtest:produce: { cpu_id = 0 }, { pthread_id = 3046601744 }, {
>> value_field = 1189641421, buf_pos_field = 4 }
>> [19:08:59.269474015] (+0.002792042) am43-devboard-aquila-3dc40a
>> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
>> value_field = 1189641421, buf_pos_field = 4 }
>> [19:08:59.269517598] (+0.000043583) am43-devboard-aquila-3dc40a
>> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
>> value_field = 1649760492, buf_pos_field = 3 }
>> [19:08:59.269537140] (+0.000019542) am43-devboard-aquila-3dc40a
>> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
>> value_field = 424238335, buf_pos_field = 2 }
>> [19:08:59.269555432] (+0.000018292) am43-devboard-aquila-3dc40a
>> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
>> value_field = 1714636915, buf_pos_field = 1 }
>> [19:08:59.269573140] (+0.000017708) am43-devboard-aquila-3dc40a
>> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3038213136 }, {
>> value_field = 846930886, buf_pos_field = 0 }
>> [19:08:59.269628015] (+0.000054875) am43-devboard-aquila-3dc40a
>> org_po_threadtest:consume: { cpu_id = 0 }, { pthread_id = 3029824528 }, {
>> value_field = -1265142768, buf_pos_field = 4294967295 }
>>
>> I've doubled checked with other viewers but no ust_xxx events.
>>
>> Am I doing something wrong with the lttng commands I'm running?
>>
>> Many Thanks,
>> Martin
>>
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>

--001a11417b305dafac0529c5a24b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi Mathieu,<br><br></div>I t=
ried the HEAD of stable-2.7 but still the same problem.=C2=A0 With gdb I st=
epped through the code and although it stepped into the pthread wrapper it =
didn&#39;t step into the tracepoint call but then again it didn&#39;t for t=
he applications tracepoint calls so probably can&#39;t read too much into t=
hat.<br><br></div>Although I see a message saying that the pthread tracepoi=
nts are being registered.<br><br>liblttng_ust_tracepoint[4855/4855]: Regist=
ering probe to tracepoint lttng_ust_pthread:pthread_mutex_lock_req (in __tr=
acepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.7.1+gitAUTOI=
NC+7e249a01c9-r0/git/liblttng-ust/tracepoint.c:564)<br>...<br><br></div>I n=
ever see the message saying they are registered but I do with my applicatio=
n specific tracepoints.<br><br></div>I&#39;ll try dynamically loading my ap=
plication tracepoints, maybe this is the problem.<br><br></div>Cheers,<br><=
/div>Martin.<br><div><div><div><br><br></div></div></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jan 20, 2016 at 10:=
29 AM, Martin Townsend <span dir=3D"ltr">&lt;<a href=3D"mailto:mtownsend197=
3@gmail.com" target=3D"_blank">mtownsend1973@gmail.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div><d=
iv>Hi Mathieu,<br><br></div>I&#39;ve take the latest LTTng recipes for yoct=
o from poky/meta which uses the git repostiory with branch=3Dstable-2.7 and=
 reports that it builds 2.7.0, here are the commit ids<br>UST =3D &quot;826=
c6c686f16b9aeb3100f3f880d630911691cf1&quot;<br>Tools =3D &quot;d71e55a5f1f4=
23eeaa47c08e5797e47ce8e825fb&quot;<br></div>Modules =3D &quot;f4b27072a77b4=
3af2fea72d6700bd64eb59a39f1&quot;<br><br></div>I still see the same problem=
, Is there another branch or tag I should try?<br><br></div>Cheers,<br></di=
v>Martin.<br></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gm=
ail_extra"><br><div class=3D"gmail_quote">On Tue, Jan 19, 2016 at 5:53 PM, =
Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers=
@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-family=
:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div><span>Hi Mar=
tin,<br></span></div><div><span><br></span></div><div><span>Can you reprodu=
ce with the latest stable branch (2.7.x) or with master</span></div><div><s=
pan>of lttng-ust and lttng-tools ?<br></span></div><div><span><br></span></=
div><div><span>New in lttng 2.7 is the renaming of some providers to add pr=
oper name spacing:<br></span></div><div><span><br></span></div><div><span>u=
st_pthread -&gt; lttng_ust_pthread<br></span></div><div><span>ust_libc -&gt=
; lttng_ust_libc<br></span></div><div><span><br></span></div><div><span>Tha=
nks,<br></span></div><div><span><br></span></div><div><span>Mathieu</span><=
/div><div><div><div><span><br></span></div><div><span>----- On Jan 19, 2016=
, at 12:08 PM, Martin Townsend &lt;<a href=3D"mailto:mtownsend1973@gmail.co=
m" target=3D"_blank">mtownsend1973@gmail.com</a>&gt; wrote:<br></span></div=
></div></div><div><blockquote style=3D"border-left:2px solid #1010ff;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"=
><div><div><div dir=3D"ltr"><div><div><div><div><div><div>Hi,<br><br></div>=
I&#39;m trying to enable pthread mutex and libc events and then use LD_PREL=
OAD to load the associated wrappers but I&#39;m not getting anything in my =
trace files. <br><br></div>Here are the commands I run<br>ttng create<br>lt=
tng enable-event -u --tracepoint &#39;org_po_threadtest:*&#39;<br>lttng ena=
ble-event -u --tracepoint ust_pthread:pthread_mutex_lock_req<br>lttng enabl=
e-event -u --tracepoint ust_pthread:pthread_mutex_lock_acq<br>lttng enable-=
event -u --tracepoint ust_pthread:pthread_mutex_unlock<br>lttng enable-even=
t -u --tracepoint &#39;ust_libc:*&#39;<br>lttng add-context -u=C2=A0 -t pth=
read_id<br>lttng start<br>LTTNG_UST_REGISTER_TIMEOUT=3D-1 LTTNG_UST_DEBUG=
=3D1 LD_PRELOAD=3D&quot;/usr/lib/liblttng-ust-pthread-wrapper.so.0 /usr/lib=
/liblttng-ust-libc-wrapper.so.0&quot; ./threadtest<br>lttng stop<br>lttng d=
estroy<br><br><span></span><span>The kernel and rootfs was built using Yoct=
o (Fido)<br>=C2=A0uname -a<br>Linux am43-devboard-aquila-3dc40a 3.14.26 #1 =
Mon Jan 11 16:52:19 GMT 2016 armv7l GNU/Linux<br><br>lttng --version<br>ltt=
ng (LTTng Trace Control) 2.6.0 - Gaia - v2.6.0<br><br><br></span><span><br>=
</span>Here&#39;s the output of lttng ust debug and the trace file<br>traci=
ng started for session auto-20160113-190852<br>stg-ust-pthread-wrapper.so.0=
 /usr/lib/liblttng-ust-libc-wrapper.so.0&quot; ./threadte<br>liblttng_ust_t=
racepoint[2225/2225]: just registered a tracepoints section from 0xb700108c=
 and having 2 tracepoints (in tracepoint_register_lib() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)<br>liblttng_ust=
_tracepoint[2225/2225]: registered tracepoint: org_po_threadtest:consume (i=
n tracepoint_register_lib() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/tracepoint.c:772)<br>liblttng_ust_tracepoint[2225/2225]: regi=
stered tracepoint: org_po_threadtest:produce (in tracepoint_register_lib() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:7=
72)<br>libust[2225/2225]: Provider &quot;ust_baddr_statedump&quot; accepted=
, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_=
provider_version() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-probes.c:174)<br>libust[2225/2225]: adding probe ust_baddr_state=
dump containing 1 events to lazy registration list (in lttng_probe_register=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probe=
s.c:216)<br>libust[2225/2225]: LTT : ltt ring buffer client &quot;relay-met=
adata-mmap&quot; init<br>=C2=A0(in lttng_ring_buffer_metadata_client_init()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-bu=
ffer-metadata-client.h:330)<br>libust[2225/2225]: LTT : ltt ring buffer cli=
ent &quot;relay-overwrite-mmap&quot; init<br>=C2=A0(in lttng_ring_buffer_cl=
ient_overwrite_init() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ring-buffer-client.h:681)<br>libust[2225/2225]: LTT : ltt rin=
g buffer client &quot;relay-overwrite-rt-mmap&quot; init<br>=C2=A0(in lttng=
_ring_buffer_client_overwrite_rt_init() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)<br>libust[2225/22=
25]: LTT : ltt ring buffer client &quot;relay-discard-mmap&quot; init<br>=
=C2=A0(in lttng_ring_buffer_client_discard_init() at /home/poweroasis/bia/b=
uild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lt=
tng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.h:681)<br>libu=
st[2225/2225]: LTT : ltt ring buffer client &quot;relay-discard-rt-mmap&quo=
t; init<br>=C2=A0(in lttng_ring_buffer_client_discard_rt_init() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ring-buffer-client.=
h:681)<br>libust[2225/2227]: Info: sessiond not accepting connections to lo=
cal apps socket (in ust_listener_thread() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1221)<br>libust[2225/2227]: Wa=
iting for local apps sessiond (in wait_for_sessiond() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:1132)<br>libust[22=
25/2226]: Message Received &quot;Get Tracer Version&quot; (65), Handle &quo=
t;root&quot; (0) (in print_cmd() at /home/poweroasis/bia/build/am43-devboar=
d-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r=
0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value=
: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully=
 sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot=
;Create Session&quot; (64), Handle &quot;root&quot; (0) (in print_cmd() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:=
366)<br>libust[2225/2226]: Return value: 1 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Create Channel&quot; (81), Handle &=
quot;session&quot; (1) (in print_cmd() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: channe=
l data received (in handle_message() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Return v=
alue: 2 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successf=
ully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &=
quot;Create Stream&quot; (96), Handle &quot;channel&quot; (2) (in print_cmd=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:82=
4)<br>libust[2225/2226]: message successfully sent (in send_reply() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)=
<br>libust[2225/2226]: Message Received &quot;Create Context&quot; (112), H=
andle &quot;channel&quot; (2) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message=
 successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message R=
eceived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (2) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 3 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), H=
andle &quot;enabler&quot; (3) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message=
 successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message R=
eceived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (2) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 4 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), H=
andle &quot;enabler&quot; (4) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message=
 successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message R=
eceived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (2) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 5 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), H=
andle &quot;enabler&quot; (5) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message=
 successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message R=
eceived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (2) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 6 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), H=
andle &quot;enabler&quot; (6) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message=
 successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message R=
eceived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (2) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 7 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), H=
andle &quot;enabler&quot; (7) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message=
 successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message R=
eceived &quot;Create Event&quot; (97), Handle &quot;channel&quot; (2) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 8 (in handle_message=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply()=
 at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp=
-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-com=
m.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), H=
andle &quot;enabler&quot; (8) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 Return value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message=
 successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message R=
eceived &quot;Enable&quot; (128), Handle &quot;session&quot; (1) (in print_=
cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:366)<br>libust[2225/2226]: Sent register channel notification: cha=
n_id 0, header_type 1<br>=C2=A0(in ustcomm_register_channel() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)=
<br>libust[2225/2226]: just registered probe ust_baddr_statedump containing=
 1 events (in lttng_lazy_probe_register() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)<br>libust[2225/2226]: Retur=
n value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succe=
ssfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Receive=
d &quot;Wait for Quiescent State&quot; (67), Handle &quot;root&quot; (0) (i=
n print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_mess=
age() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_repl=
y() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Session&quo=
t; (64), Handle &quot;root&quot; (0) (in print_cmd() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225=
/2226]: Return value: 9 (in handle_message() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: =
message successfully sent (in send_reply() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Me=
ssage Received &quot;Create Channel&quot; (81), Handle &quot;session&quot; =
(9) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: channel data received (in=
 handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: Return value: 10 (in handle=
_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send=
_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Stream=
&quot; (96), Handle &quot;channel&quot; (10) (in print_cmd() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>lib=
ust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225=
/2226]: message successfully sent (in send_reply() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2=
226]: Message Received &quot;Create Context&quot; (112), Handle &quot;chann=
el&quot; (10) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0=
 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully se=
nt (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Cr=
eate Event&quot; (97), Handle &quot;channel&quot; (10) (in print_cmd() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:3=
66)<br>libust[2225/2226]: Return value: 11 (in handle_message() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>=
libust[2225/2226]: message successfully sent (in send_reply() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>li=
bust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;en=
abler&quot; (11) (in print_cmd() at /home/poweroasis/bia/build/am43-devboar=
d-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r=
0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value=
: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully=
 sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot=
;Create Event&quot; (97), Handle &quot;channel&quot; (10) (in print_cmd() a=
t /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-n=
eon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.=
c:366)<br>libust[2225/2226]: Return value: 12 (in handle_message() at /home=
/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia=
-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<=
br>libust[2225/2226]: message successfully sent (in send_reply() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br=
>libust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot=
;enabler&quot; (12) (in print_cmd() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return va=
lue: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfu=
lly sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquil=
a/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/l=
iblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &q=
uot;Create Event&quot; (97), Handle &quot;channel&quot; (10) (in print_cmd(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:366)<br>libust[2225/2226]: Return value: 13 (in handle_message() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:82=
4)<br>libust[2225/2226]: message successfully sent (in send_reply() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)=
<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle &q=
uot;enabler&quot; (13) (in print_cmd() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return=
 value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message succes=
sfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received=
 &quot;Create Event&quot; (97), Handle &quot;channel&quot; (10) (in print_c=
md() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust=
-comm.c:366)<br>libust[2225/2226]: Return value: 14 (in handle_message() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c=
:824)<br>libust[2225/2226]: message successfully sent (in send_reply() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:4=
81)<br>libust[2225/2226]: Message Received &quot;Enable&quot; (128), Handle=
 &quot;enabler&quot; (14) (in print_cmd() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Ret=
urn value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message suc=
cessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Recei=
ved &quot;Enable&quot; (128), Handle &quot;session&quot; (9) (in print_cmd(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:366)<br>libust[2225/2226]: Sent register channel notification: chan_id=
 0, header_type 1<br>=C2=A0(in ustcomm_register_channel() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1108)<br>=
libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2=
225/2226]: message successfully sent (in send_reply() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[222=
5/2226]: Message Received &quot;Wait for Quiescent State&quot; (67), Handle=
 &quot;root&quot; (0) (in print_cmd() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return =
value: 0 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-a=
quila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/g=
it/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message success=
fully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received =
&quot;Create Session&quot; (64), Handle &quot;root&quot; (0) (in print_cmd(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:366)<br>libust[2225/2226]: Return value: 15 (in handle_message() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:82=
4)<br>libust[2225/2226]: message successfully sent (in send_reply() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)=
<br>libust[2225/2226]: Message Received &quot;Create Channel&quot; (81), Ha=
ndle &quot;session&quot; (15) (in print_cmd() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]:=
 channel data received (in handle_message() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libust[2225/2226]: R=
eturn value: 16 (in handle_message() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message =
successfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Re=
ceived &quot;Create Stream&quot; (96), Handle &quot;channel&quot; (16) (in =
print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lt=
tng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_messag=
e() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Context&quot;=
 (112), Handle &quot;channel&quot; (16) (in print_cmd() at /home/poweroasis=
/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnue=
abi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2=
225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226=
]: message successfully sent (in send_reply() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]:=
 Message Received &quot;Create Event&quot; (97), Handle &quot;channel&quot;=
 (16) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 17 (in ha=
ndle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in =
send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&qu=
ot; (128), Handle &quot;enabler&quot; (17) (in print_cmd() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libus=
t[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2=
226]: message successfully sent (in send_reply() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/222=
6]: Message Received &quot;Create Event&quot; (97), Handle &quot;channel&qu=
ot; (16) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 18 (in=
 handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (=
in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work=
/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-us=
t/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable=
&quot; (128), Handle &quot;enabler&quot; (18) (in print_cmd() at /home/powe=
roasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linu=
x-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>li=
bust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasis/b=
ia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueab=
i/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[222=
5/2226]: message successfully sent (in send_reply() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/=
2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;channel=
&quot; (16) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 19 =
(in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sen=
t (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Ena=
ble&quot; (128), Handle &quot;enabler&quot; (19) (in print_cmd() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br=
>libust[2225/2226]: Return value: 0 (in handle_message() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[=
2225/2226]: message successfully sent (in send_reply() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[22=
25/2226]: Message Received &quot;Create Event&quot; (97), Handle &quot;chan=
nel&quot; (16) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-=
aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/=
git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: =
20 (in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully =
sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tm=
p/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblt=
tng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;=
Enable&quot; (128), Handle &quot;enabler&quot; (20) (in print_cmd() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)=
<br>libust[2225/2226]: Return value: 0 (in handle_message() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libu=
st[2225/2226]: message successfully sent (in send_reply() at /home/poweroas=
is/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gn=
ueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust=
[2225/2225]: Error: Timed out waiting for lttng-sessiond (in lttng_ust_init=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:1529)<br>libust[2225/2225]: Provider &quot;lttng_ust_tracef&quot; acc=
epted, version 1.0 is compatible with LTTng UST provider version 1.0. (in c=
heck_provider_version() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/lttng-probes.c:174)<br>libust[2225/2225]: adding probe lttng_ust_=
tracef containing 1 events to lazy registration list (in lttng_probe_regist=
er() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-pro=
bes.c:216)<br>libust[2225/2225]: just registered probe lttng_ust_tracef con=
taining 1 events (in lttng_lazy_probe_register() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)<br>liblttng_ust_trac=
epoint[2225/2225]: just registered a tracepoints section from 0xb700108c an=
d having 2 tracepoints (in tracepoint_register_lib() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:767)<br>liblttng_ust_tr=
acepoint[2225/2225]: registered tracepoint: org_po_threadtest:consume (in t=
racepoint_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/tracepoint.c:772)<br>liblttng_ust_tracepoint[2225/2225]: registe=
red tracepoint: org_po_threadtest:produce (in tracepoint_register_lib() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)=
<br>libust[2225/2225]: Provider &quot;ust_libc&quot; accepted, version 1.0 =
is compatible with LTTng UST provider version 1.0. (in check_provider_versi=
on() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf=
-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-pro=
bes.c:174)<br>libust[2225/2225]: adding probe ust_libc containing 6 events =
to lazy registration list (in lttng_probe_register() at /home/poweroasis/bi=
a/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi=
/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br>libust[2225/2=
225]: just registered probe ust_libc containing 6 events (in lttng_lazy_pro=
be_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/=
lttng-probes.c:115)<br>libust[2225/2226]: Message Received &quot;Create Ses=
sion&quot; (64), Handle &quot;root&quot; (0) (in print_cmd() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>lib=
ust[2225/2225]: Sent register event notification for name &quot;ust_libc:ma=
lloc&quot;: ret_code 0, event_id 4<br>=C2=A0(in ustcomm_register_event() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-c=
omm.c:1001)<br>libust[2225/2225]: Sent register event notification for name=
 &quot;ust_libc:free&quot;: ret_code 0, event_id 5<br>=C2=A0(in ustcomm_reg=
ister_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/c=
ortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-=
comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event notif=
ication for name &quot;ust_libc:calloc&quot;: ret_code 0, event_id 6<br>=C2=
=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent re=
gister event notification for name &quot;ust_libc:realloc&quot;: ret_code 0=
, event_id 7<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/=
build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/l=
ttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[=
2225/2225]: Sent register event notification for name &quot;ust_libc:memali=
gn&quot;: ret_code 0, event_id 8<br>=C2=A0(in ustcomm_register_event() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-com=
m.c:1001)<br>libust[2225/2225]: Sent register event notification for name &=
quot;ust_libc:posix_memalign&quot;: ret_code 0, event_id 9<br>=C2=A0(in ust=
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
_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2225]: Sent reg=
ister event notification for name &quot;ust_libc:malloc&quot;: ret_code 0, =
event_id 0<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[22=
25/2225]: Sent register event notification for name &quot;ust_libc:free&quo=
t;: ret_code 0, event_id 1<br>=C2=A0(in ustcomm_register_event() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:10=
01)<br>libust[2225/2225]: Sent register event notification for name &quot;u=
st_libc:calloc&quot;: ret_code 0, event_id 2<br>=C2=A0(in ustcomm_register_=
event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa=
9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/l=
ttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event notificatio=
n for name &quot;ust_libc:realloc&quot;: ret_code 0, event_id 3<br>=C2=A0(i=
n ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent registe=
r event notification for name &quot;ust_libc:memalign&quot;: ret_code 0, ev=
ent_id 4<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225=
/2225]: Sent register event notification for name &quot;ust_libc:posix_mema=
lign&quot;: ret_code 0, event_id 5<br>=C2=A0(in ustcomm_register_event() at=
 /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-ne=
on-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-c=
omm.c:1001)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tra=
cepoint ust_libc:posix_memalign (in __tracepoint_probe_register() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>li=
blttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_libc:=
memalign (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2=
225/2225]: Registering probe to tracepoint ust_libc:realloc (in __tracepoin=
t_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering p=
robe to tracepoint ust_libc:calloc (in __tracepoint_probe_register() at /ho=
me/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-b=
ia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br=
>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint ust_li=
bc:free (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[22=
25/2225]: Registering probe to tracepoint ust_libc:malloc (in __tracepoint_=
probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/tracepoint.c:563)<br>libust[2225/2226]: Return value: 21 (in handle_mess=
age() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9h=
f-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-us=
t-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send_repl=
y() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-=
vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-=
comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create Channel&quo=
t; (81), Handle &quot;session&quot; (21) (in print_cmd() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[=
2225/2226]: channel data received (in handle_message() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:720)<br>libust[22=
25/2226]: Return value: 22 (in handle_message() at /home/poweroasis/bia/bui=
ld/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttn=
g-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226=
]: message successfully sent (in send_reply() at /home/poweroasis/bia/build=
/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-=
ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]:=
 Message Received &quot;Create Stream&quot; (96), Handle &quot;channel&quot=
; (22) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/t=
mp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libl=
ttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (in ha=
ndle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in =
send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/co=
rtexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/l=
ttng-ust-comm.c:481)<br>liblttng_ust_tracepoint[2225/2225]: just registered=
 a tracepoints section from 0xb700108c and having 2 tracepoints (in tracepo=
int_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/w=
ork/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng=
-ust/tracepoint.c:767)<br>liblttng_ust_tracepoint[2225/2225]: registered tr=
acepoint: org_po_threadtest:consume (in tracepoint_register_lib() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>li=
blttng_ust_tracepoint[2225/2225]: registered tracepoint: org_po_threadtest:=
produce (in tracepoint_register_lib() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provider &q=
uot;ust_pthread&quot; accepted, version 1.0 is compatible with LTTng UST pr=
ovider version 1.0. (in check_provider_version() at /home/poweroasis/bia/bu=
ild/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/ltt=
ng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust[2225/2225]=
: adding probe ust_pthread containing 4 events to lazy registration list (i=
n lttng_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila=
/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/li=
blttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: just registered probe =
ust_pthread containing 4 events (in lttng_lazy_probe_register() at /home/po=
weroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-li=
nux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:115)<br>li=
bust[2225/2226]: Message Received &quot;Create Context&quot; (112), Handle =
&quot;channel&quot; (22) (in print_cmd() at /home/poweroasis/bia/build/am43=
-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2=
_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2225]: Sent=
 register event notification for name &quot;ust_pthread:pthread_mutex_lock_=
req&quot;: ret_code 0, event_id 0<br>=C2=A0(in ustcomm_register_event() at =
/home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neo=
n-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-co=
mm.c:1001)<br>libust[2225/2225]: Sent register event notification for name =
&quot;ust_pthread:pthread_mutex_lock_acq&quot;: ret_code 0, event_id 1<br>=
=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent=
 register event notification for name &quot;ust_pthread:pthread_mutex_trylo=
ck&quot;: ret_code 0, event_id 2<br>=C2=A0(in ustcomm_register_event() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-com=
m.c:1001)<br>libust[2225/2225]: Sent register event notification for name &=
quot;ust_pthread:pthread_mutex_unlock&quot;: ret_code 0, event_id 3<br>=C2=
=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepoint[22=
25/2225]: Registering probe to tracepoint ust_pthread:pthread_mutex_unlock =
(in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]=
: Registering probe to tracepoint ust_pthread:pthread_mutex_trylock (in __t=
racepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aqui=
la/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/=
liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Regis=
tering probe to tracepoint ust_pthread:pthread_mutex_lock_acq (in __tracepo=
int_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp=
/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/libltt=
ng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]: Registering=
 probe to tracepoint ust_pthread:pthread_mutex_lock_req (in __tracepoint_pr=
obe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/tracepoint.c:563)<br>libust[2225/2225]: Sent register event notification f=
or name &quot;ust_pthread:pthread_mutex_unlock&quot;: ret_code 0, event_id =
6<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-=
devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_=
2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]:=
 Sent register event notification for name &quot;ust_pthread:pthread_mutex_=
lock_req&quot;: ret_code 0, event_id 7<br>=C2=A0(in ustcomm_register_event(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-u=
st-comm.c:1001)<br>libust[2225/2225]: Sent register event notification for =
name &quot;ust_pthread:pthread_mutex_lock_acq&quot;: ret_code 0, event_id 8=
<br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-d=
evboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2=
.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracep=
oint[2225/2225]: Registering probe to tracepoint ust_pthread:pthread_mutex_=
lock_acq (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2=
225/2225]: Registering probe to tracepoint ust_pthread:pthread_mutex_lock_r=
eq (in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-dev=
board-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6=
.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/22=
25]: Registering probe to tracepoint ust_pthread:pthread_mutex_unlock (in _=
_tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboard-aq=
uila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/gi=
t/liblttng-ust/tracepoint.c:563)<br>libust[2225/2226]: Return value: 0 (in =
handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wor=
k/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-u=
st/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (i=
n send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/=
cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust=
/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Create =
Event&quot; (97), Handle &quot;channel&quot; (22) (in print_cmd() at /home/=
poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-=
linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<b=
r>libust[2225/2226]: Return value: 23 (in handle_message() at /home/poweroa=
sis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-g=
nueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libus=
t[2225/2226]: message successfully sent (in send_reply() at /home/poweroasi=
s/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnu=
eabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[=
2225/2226]: Message Received &quot;Enable&quot; (128), Handle &quot;enabler=
&quot; (23) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aqu=
ila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git=
/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 0 (=
in handle_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/=
work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttn=
g-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent=
 (in send_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:481)<br>liblttng_ust_tracepoint[2225/2225]: just regis=
tered a tracepoints section from 0xb700108c and having 2 tracepoints (in tr=
acepoint_register_lib() at /home/poweroasis/bia/build/am43-devboard-aquila/=
tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/lib=
lttng-ust/tracepoint.c:767)<br>liblttng_ust_tracepoint[2225/2225]: register=
ed tracepoint: org_po_threadtest:consume (in tracepoint_register_lib() at /=
home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon=
-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<=
br>liblttng_ust_tracepoint[2225/2225]: registered tracepoint: org_po_thread=
test:produce (in tracepoint_register_lib() at /home/poweroasis/bia/build/am=
43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust=
/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:772)<br>libust[2225/2225]: Provid=
er &quot;org_po_threadtest&quot; accepted, version 1.0 is compatible with L=
TTng UST provider version 1.0. (in check_provider_version() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:174)<br>libust=
[2225/2225]: adding probe org_po_threadtest containing 2 events to lazy reg=
istration list (in lttng_probe_register() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-probes.c:216)<br>libust[2225/2225]: just =
registered probe org_po_threadtest containing 2 events (in lttng_lazy_probe=
_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cor=
texa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lt=
tng-probes.c:115)<br>libust[2225/2226]: Message Received &quot;Create Event=
&quot; (97), Handle &quot;channel&quot; (22) (in print_cmd() at /home/power=
oasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux=
-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>lib=
ust[2225/2225]: Sent register event notification for name &quot;org_po_thre=
adtest:produce&quot;: ret_code 0, event_id 10<br>=C2=A0(in ustcomm_register=
_event() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/=
lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sent register event notificati=
on for name &quot;org_po_threadtest:consume&quot;: ret_code 0, event_id 11<=
br>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-de=
vboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.=
6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>liblttng_ust_tracepo=
int[2225/2225]: Registering probe to tracepoint org_po_threadtest:consume (=
in __tracepoint_probe_register() at /home/poweroasis/bia/build/am43-devboar=
d-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r=
0/git/liblttng-ust/tracepoint.c:563)<br>liblttng_ust_tracepoint[2225/2225]:=
 Registering probe to tracepoint org_po_threadtest:produce (in __tracepoint=
_probe_register() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/tracepoint.c:563)<br>libust[2225/2225]: Sent register event notificatio=
n for name &quot;org_po_threadtest:produce&quot;: ret_code 0, event_id 9<br=
>=C2=A0(in ustcomm_register_event() at /home/poweroasis/bia/build/am43-devb=
oard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.=
0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:1001)<br>libust[2225/2225]: Sen=
t register event notification for name &quot;org_po_threadtest:consume&quot=
;: ret_code 0, event_id 10<br>=C2=A0(in ustcomm_register_event() at /home/p=
oweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-l=
inux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust-comm/lttng-ust-comm.c:10=
01)<br>liblttng_ust_tracepoint[2225/2225]: Registering probe to tracepoint =
org_po_threadtest:consume (in __tracepoint_probe_register() at /home/powero=
asis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-=
gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>liblttng=
_ust_tracepoint[2225/2225]: Registering probe to tracepoint org_po_threadte=
st:produce (in __tracepoint_probe_register() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/tracepoint.c:563)<br>libust[2225/2226]: Retu=
rn value: 24 (in handle_message() at /home/poweroasis/bia/build/am43-devboa=
rd-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-=
r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message suc=
cessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboard=
-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0=
/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Recei=
ved &quot;Enable&quot; (128), Handle &quot;enabler&quot; (24) (in print_cmd=
() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-v=
fp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-c=
omm.c:366)<br>libust[2225/2226]: Return value: 0 (in handle_message() at /h=
ome/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-=
bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:82=
4)<br>libust[2225/2226]: message successfully sent (in send_reply() at /hom=
e/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bi=
a-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)=
<br>libust[2225/2226]: Message Received &quot;Create Session&quot; (64), Ha=
ndle &quot;root&quot; (0) (in print_cmd() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Ret=
urn value: 25 (in handle_message() at /home/poweroasis/bia/build/am43-devbo=
ard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0=
-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: message su=
ccessfully sent (in send_reply() at /home/poweroasis/bia/build/am43-devboar=
d-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r=
0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Message Rece=
ived &quot;Create Channel&quot; (81), Handle &quot;session&quot; (25) (in p=
rint_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:366)<br>libust[2225/2226]: channel data received (in handle_m=
essage() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:720)<br>libust[2225/2226]: Return value: 26 (in handle_message(=
) at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vf=
p-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-co=
mm.c:824)<br>libust[2225/2226]: message successfully sent (in send_reply() =
at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-=
neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm=
.c:481)<br>libust[2225/2226]: Message Received &quot;Create Stream&quot; (9=
6), Handle &quot;channel&quot; (26) (in print_cmd() at /home/poweroasis/bia=
/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/=
lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[2225/=
2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/build/a=
m43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-us=
t/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]: m=
essage successfully sent (in send_reply() at /home/poweroasis/bia/build/am4=
3-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/=
2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>libust[2225/2226]: Mes=
sage Received &quot;Create Event&quot; (97), Handle &quot;channel&quot; (26=
) (in print_cmd() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/wo=
rk/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-=
ust/lttng-ust-comm.c:366)<br>libust[2225/2226]: Return value: 27 (in handle=
_message() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cort=
exa9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/ltt=
ng-ust-comm.c:824)<br>libust[2225/2226]: message successfully sent (in send=
_reply() at /home/poweroasis/bia/build/am43-devboard-aquila/tmp/work/cortex=
a9hf-vfp-neon-bia-linux-gnueabi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng=
-ust-comm.c:481)<br>libust[2225/2226]: Message Received &quot;Enable&quot; =
(128), Handle &quot;enabler&quot; (27) (in print_cmd() at /home/poweroasis/=
bia/build/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnuea=
bi/lttng-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:366)<br>libust[22=
25/2226]: Return value: 0 (in handle_message() at /home/poweroasis/bia/buil=
d/am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng=
-ust/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:824)<br>libust[2225/2226]=
: message successfully sent (in send_reply() at /home/poweroasis/bia/build/=
am43-devboard-aquila/tmp/work/cortexa9hf-vfp-neon-bia-linux-gnueabi/lttng-u=
st/2_2.6.0-r0/git/liblttng-ust/lttng-ust-comm.c:481)<br>threadtest: threadt=
est.c:70: consumer: Assertion `buffer-&gt;len &gt;=3D 0&#39; failed.<br>Abo=
rted<br>root@am43-devboard-aquila-3dc40a:~# lttng stop<br>Waiting for data =
availability<br>Tracing stopped for session auto-20160113-190852<br>root@am=
43-devboard-aquila-3dc40a:~# lttng destroy<br>root@am43-devboard-aquila-3dc=
40a:~# babeltrace lttng-traces/auto-20160113-190852<br>[19:08:59.023256390]=
 (+?.?????????) am43-devboard-aquila-3dc40a org_po_threadtest:produce: { cp=
u_id =3D 0 }, { pthread_id =3D <a href=3D"tel:3046601744" value=3D"+1304660=
1744" target=3D"_blank">3046601744</a> }, { value_field =3D 846930886, buf_=
pos_field =3D 0 }<br>[19:08:59.116224140] (+0.092967750) am43-devboard-aqui=
la-3dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D 304=
6601744 }, { value_field =3D 1714636915, buf_pos_field =3D 1 }<br>[19:08:59=
.164360932] (+0.048136792) am43-devboard-aquila-3dc40a org_po_threadtest:pr=
oduce: { cpu_id =3D 0 }, { pthread_id =3D 3046601744 }, { value_field =3D 4=
24238335, buf_pos_field =3D 2 }<br>[19:08:59.249898432] (+0.085537500) am43=
-devboard-aquila-3dc40a org_po_threadtest:produce: { cpu_id =3D 0 }, { pthr=
ead_id =3D 3046601744 }, { value_field =3D 1649760492, buf_pos_field =3D 3 =
}<br>[19:08:59.266681973] (+0.016783541) am43-devboard-aquila-3dc40a org_po=
_threadtest:produce: { cpu_id =3D 0 }, { pthread_id =3D 3046601744 }, { val=
ue_field =3D 1189641421, buf_pos_field =3D 4 }<br>[19:08:59.269474015] (+0.=
002792042) am43-devboard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =
=3D 0 }, { pthread_id =3D 3038213136 }, { value_field =3D 1189641421, buf_p=
os_field =3D 4 }<br>[19:08:59.269517598] (+0.000043583) am43-devboard-aquil=
a-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D 3038=
213136 }, { value_field =3D 1649760492, buf_pos_field =3D 3 }<br>[19:08:59.=
269537140] (+0.000019542) am43-devboard-aquila-3dc40a org_po_threadtest:con=
sume: { cpu_id =3D 0 }, { pthread_id =3D 3038213136 }, { value_field =3D 42=
4238335, buf_pos_field =3D 2 }<br>[19:08:59.269555432] (+0.000018292) am43-=
devboard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =3D 0 }, { pthre=
ad_id =3D 3038213136 }, { value_field =3D 1714636915, buf_pos_field =3D 1 }=
<br>[19:08:59.269573140] (+0.000017708) am43-devboard-aquila-3dc40a org_po_=
threadtest:consume: { cpu_id =3D 0 }, { pthread_id =3D 3038213136 }, { valu=
e_field =3D 846930886, buf_pos_field =3D 0 }<br>[19:08:59.269628015] (+0.00=
0054875) am43-devboard-aquila-3dc40a org_po_threadtest:consume: { cpu_id =
=3D 0 }, { pthread_id =3D 3029824528 }, { value_field =3D -1265142768, buf_=
pos_field =3D 4294967295 }<br><br></div>I&#39;ve doubled checked with other=
 viewers but no ust_xxx events.<br><br></div>Am I doing something wrong wit=
h the lttng commands I&#39;m running?<br><br></div>Many Thanks,<br></div>Ma=
rtin<br><div><div><div><div><div><div><div><br><br></div></div></div></div>=
</div></div></div></div>
<br></div></div>_______________________________________________<br>lttng-de=
v mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a><span><font color=3D"#888888"><br></f=
ont></span></blockquote></div><span><font color=3D"#888888"><div><br></div>=
<div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"htt=
p://www.efficios.com" target=3D"_blank">http://www.efficios.com</a></div></=
font></span></div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a11417b305dafac0529c5a24b--


--===============1517407562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1517407562==--
