From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Help needed in getting first ust event running
Date: Thu, 18 Apr 2013 12:29:46 -0400
Message-ID: <20130418162946.GA30164__24094.8819359348$1366302617$gmane$org@Krystal>
References: <CAFw4v5-z8n-1C2_P89cugq3ayypby-CPr-N+SAxzcgOPEbwzTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1USriY-0004p1-8a
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 12:29:50 -0400
Content-Disposition: inline
In-Reply-To: <CAFw4v5-z8n-1C2_P89cugq3ayypby-CPr-N+SAxzcgOPEbwzTQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dror Granot <dror@reduxio.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It looks like you caught a bug in lttng-ust 2.2-rc1. I pushed the
following commit that should take care of it:

commit 99234da69ab197050d3d28ea428c54e08539667c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Apr 18 12:21:55 2013 -0400

    Fix: tracepoint.h incorrect assumption about constructor order
    
    Incorrect assumption about constructor execution order can trigger a
    segfault when trying to execute tracepoint_register_lib.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

You'll need to recompile your application and your probe provider.

Feedback is welcome,

Thanks!

Mathieu

* Dror Granot (dror@reduxio.com) wrote:
> Hi,
> I'm trying to add a simple ust event to my project, but I keep getting
> segmentation violation. I would really appreciate help in understanding
> what am I'm doing wrong. I'm running Ubuntu 12.04LTS and got lttng from
> git. I've ran the lttng with verbose but couldn't see anything valuable
> there. I'm using dynamic linkage (but the problem occurs also in static)
> and is as follows:
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000000000 in ?? ()
> (gdb) where
> #0  0x0000000000000000 in ?? ()
> #1  0x000000000041b03f in __tracepoints__ptrs_init () at
> /usr/local/include/lttng/tracepoint.h:349
> #2  0x000000000043e95d in __libc_csu_init ()
> #3  0x00007ffff71f1700 in __libc_start_main () from
> /lib/x86_64-linux-gnu/libc.so.6
> #4  0x00000000004039e9 in _start ()
> 
> 
> increasing the debug level shows:
> 
> ibust[6455/6455]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>  (in lttng_ring_buffer_metadata_client_init() at
> lttng-ring-buffer-metadata-client.h:313)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
>  (in lttng_ring_buffer_client_overwrite_init() at
> lttng-ring-buffer-client.h:562)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
> init
>  (in lttng_ring_buffer_client_overwrite_rt_init() at
> lttng-ring-buffer-client.h:562)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-mmap" init
>  (in lttng_ring_buffer_client_discard_init() at
> lttng-ring-buffer-client.h:562)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
>  (in lttng_ring_buffer_client_discard_rt_init() at
> lttng-ring-buffer-client.h:562)
> libust[6455/6457]: Info: sessiond not accepting connections to local apps
> socket (in ust_listener_thread() at lttng-ust-comm.c:939)
> libust[6455/6457]: Waiting for local apps sessiond (in wait_for_sessiond()
> at lttng-ust-comm.c:849)
> libust[6455/6456]: Message Received "Get Tracer Version", Handle "root" (0)
> (in print_cmd() at lttng-ust-comm.c:216)
> libust[6455/6456]: Return value: 0 (in handle_message() at
> lttng-ust-comm.c:589)
> libust[6455/6456]: message successfully sent (in send_reply() at
> lttng-ust-comm.c:331)
> libust[6455/6456]: Message Received "Registration Done", Handle "root" (0)
> (in print_cmd() at lttng-ust-comm.c:216)
> libust[6455/6456]: Return value: 0 (in handle_message() at
> lttng-ust-comm.c:589)
> libust[6455/6456]: message successfully sent (in send_reply() at
> lttng-ust-comm.c:331)
> libust[6455/6455]: adding probe tgtd_project containing 1 events to lazy
> registration list (in lttng_probe_register() at lttng-probes.c:179)
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> libust[6455/6455]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>  (in lttng_ring_buffer_metadata_client_init() at
> lttng-ring-buffer-metadata-client.h:313)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
>  (in lttng_ring_buffer_client_overwrite_init() at
> lttng-ring-buffer-client.h:562)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
> init
>  (in lttng_ring_buffer_client_overwrite_rt_init() at
> lttng-ring-buffer-client.h:562)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-mmap" init
>  (in lttng_ring_buffer_client_discard_init() at
> lttng-ring-buffer-client.h:562)
> libust[6455/6455]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
>  (in lttng_ring_buffer_client_discard_rt_init() at
> lttng-ring-buffer-client.h:562)
> [New Thread 0x7ffff653a700 (LWP 6458)]
> [New Thread 0x7ffff5d39700 (LWP 6459)]
> libust[6455/6459]: Info: sessiond not accepting connections to local apps
> socket (in ust_listener_thread() at lttng-ust-comm.c:939)
> libust[6455/6459]: Waiting for local apps sessiond (in wait_for_sessiond()
> at lttng-ust-comm.c:849)
> libust[6455/6458]: Message Received "Get Tracer Version", Handle "root" (0)
> (in print_cmd() at lttng-ust-comm.c:216)
> libust[6455/6458]: Return value: 0 (in handle_message() at
> lttng-ust-comm.c:589)
> libust[6455/6458]: message successfully sent (in send_reply() at
> lttng-ust-comm.c:331)
> libust[6455/6458]: Message Received "Registration Done", Handle "root" (0)
> (in print_cmd() at lttng-ust-comm.c:216)
> libust[6455/6458]: Return value: 0 (in handle_message() at
> lttng-ust-comm.c:589)
> libust[6455/6458]: message successfully sent (in send_reply() at
> lttng-ust-comm.c:331)
> libust[6455/6455]: adding probe check_project containing 1 events to lazy
> registration list (in lttng_probe_register() at lttng-probes.c:179)
> 
> and then it fails.
> The segmentation violations seems to be due to the fact that the
> tracepoint_register_lib is not initialized, but I don't understand what I'm
> missing...
> 
> print tracepoint_dlopen
> $1 = {liblttngust_handle = 0x7ffff7ff6030, tracepoint_register_lib = 0,
> tracepoint_unregister_lib = 0, rcu_read_lock_sym_bp = 0,
> rcu_read_unlock_sym_bp = 0,
>   rcu_dereference_sym_bp = 0}
> 
> Thanks
> Dror

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
