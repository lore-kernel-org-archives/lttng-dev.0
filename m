From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: SUNRPC: Fix oops when trace
 sunrpc_task events in nfs client
Date: Thu, 12 Dec 2019 10:46:20 -0500 (EST)
Message-ID: <996784759.3725.1576165580909.JavaMail.zimbra__22742.0676661254$1576165603$gmane$org@efficios.com>
References: <20191205073532.1278-1-quanyang.wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47YdSZ3tJKz16hy
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2019 10:46:22 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id B4D696884D2
 for <lttng-dev@lists.lttng.org>; Thu, 12 Dec 2019 10:46:21 -0500 (EST)
In-Reply-To: <20191205073532.1278-1-quanyang.wang@windriver.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: quanyang wang <quanyang.wang@windriver.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into lttng-modules master, 2.11, 2.10 branches, thanks!

I added the following commits on top, taking care of another OOPS
that was missed by this patch, and adapting the type of the field
to a signed integer:

commit b6903d57e4c3234ec5b1c7f72e232023cdee0fab
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Dec 12 10:39:38 2019 -0500

    sunrpc: introduce lttng_get_clid helper
    
    Introduce the lttng_get_clid helper to always check for NULL pointer
    when getting the client id. While not always strictly needed depending
    on the tracepoint callsite, prefer robustness of instrumentation and
    always check for NULL rather than play whack-a-mole.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 70389e422dd3146161089d454f525367c9046ecd
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Dec 12 10:29:37 2019 -0500

    Fix: sunrpc: use signed integer for client id
    
    Within include/linux/sunrpc/clnt.h:struct rpc_cltn, the cl_clid field
    is an unsigned integer, which is the type expected by the tracepoint
    signature.
    
    However, looking into net/sunrpc/clnt.c:rpc_alloc_clid(), its allocation
    considers negative signed integer as errors.
    
    Therefore, in order to properly show "-1" in the trace output (rather
    than MAX_INT) when called with a NULL task->tk_client, move to a
    signed integer as backing type for the client_id field.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 032a74d83b263c4faead8e4c25d497fb8ea07b6e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Dec 12 10:29:02 2019 -0500

    Fix: sunrpc: null rpc_clnt dereference in rpc_task_queued tracepoint
    
    Based on upstream Linux commit:
    
    commit 0be283f676a1e7b208db0c992283197ef8b52158
    Author: Benjamin Coddington <bcodding@redhat.com>
    Date:   Tue Jan 23 09:32:35 2018 -0500
    
        SUNRPC: Fix null rpc_clnt dereference in rpc_task_queued tracepoint
    
        Backchannel tasks will not have a reference to the rpc_clnt.  Return -1 for
        cl_clid in that case.
    
        Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
        Signed-off-by: Trond Myklebust <trondmy@gmail.com>
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>




----- On Dec 5, 2019, at 2:35 AM, quanyang wang quanyang.wang@windriver.com wrote:

> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> See upstream commit :
> 
>	commit 2ca310fc4160ed0420da65534a21ae77b24326a8
>	Author: Ditang Chen <chendt.fnst@cn.fujitsu.com>
>	Date: Fri, 7 Mar 2014 13:27:57 +0800
>	Subject: SUNRPC: Fix oops when trace sunrpc_task events in nfs client
> 
>	When tracking sunrpc_task events in nfs client, the clnt pointer may be NULL.
> 
>	[  139.269266] BUG: unable to handle kernel NULL pointer dereference at
>	0000000000000004
>	[  139.269915] IP: [<ffffffffa026f216>]
>	ftrace_raw_event_rpc_task_running+0x86/0xf0 [sunrpc]
>	[  139.269915] PGD 1d293067 PUD 1d294067 PMD 0
>	[  139.269915] Oops: 0000 [#1] SMP
>	[  139.269915] Modules linked in: nfsv4 dns_resolver nfs lockd sunrpc fscache sg
>	ppdev e1000
>	serio_raw pcspkr parport_pc parport i2c_piix4 i2c_core microcode xfs libcrc32c
>	sd_mod sr_mod
>	cdrom ata_generic crc_t10dif crct10dif_common pata_acpi ahci libahci ata_piix
>	libata dm_mirror
>	dm_region_hash dm_log dm_mod
>	[  139.269915] CPU: 0 PID: 59 Comm: kworker/0:2 Not tainted 3.10.0-84.el7.x86_64
>	#1
>	[  139.269915] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
>	VirtualBox 12/01/2006
>	[  139.269915] Workqueue: rpciod rpc_async_schedule [sunrpc]
>	[  139.269915] task: ffff88001b598000 ti: ffff88001b632000 task.ti:
>	ffff88001b632000
>	[  139.269915] RIP: 0010:[<ffffffffa026f216>]  [<ffffffffa026f216>]
>	ftrace_raw_event_rpc_task_running+0x86/0xf0 [sunrpc]
>	[  139.269915] RSP: 0018:ffff88001b633d70  EFLAGS: 00010206
>	[  139.269915] RAX: ffff88001dfc5338 RBX: ffff88001cc37a00 RCX: ffff88001dfc5334
>	[  139.269915] RDX: ffff88001dfc5338 RSI: 0000000000000000 RDI: ffff88001dfc533c
>	[  139.269915] RBP: ffff88001b633db0 R08: 000000000000002c R09: 000000000000000a
>	[  139.269915] R10: 0000000000062180 R11: 00000020759fb9dc R12: ffffffffa0292c20
>	[  139.269915] R13: ffff88001dfc5334 R14: 0000000000000000 R15: 0000000000000000
>	[  139.269915] FS:  0000000000000000(0000) GS:ffff88001fc00000(0000)
>	knlGS:0000000000000000
>	[  139.269915] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>	[  139.269915] CR2: 0000000000000004 CR3: 000000001d290000 CR4: 00000000000006f0
>	[  139.269915] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>	[  139.269915] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>	[  139.269915] Stack:
>	[  139.269915]  000000001b633d98 0000000000000246 ffff88001df1dc00
>	ffff88001cc37a00
>	[  139.269915]  ffff88001bc35e60 0000000000000000 ffff88001ffa0a48
>	ffff88001bc35ee0
>	[  139.269915]  ffff88001b633e08 ffffffffa02704b5 0000000000010000
>	ffff88001cc37a70
>	[  139.269915] Call Trace:
>	[  139.269915]  [<ffffffffa02704b5>] __rpc_execute+0x1d5/0x400 [sunrpc]
>	[  139.269915]  [<ffffffffa0270706>] rpc_async_schedule+0x26/0x30 [sunrpc]
>	[  139.269915]  [<ffffffff8107867b>] process_one_work+0x17b/0x460
>	[  139.269915]  [<ffffffff8107942b>] worker_thread+0x11b/0x400
>	[  139.269915]  [<ffffffff81079310>] ? rescuer_thread+0x3e0/0x3e0
>	[  139.269915]  [<ffffffff8107fc80>] kthread+0xc0/0xd0
>	[  139.269915]  [<ffffffff8107fbc0>] ? kthread_create_on_node+0x110/0x110
>	[  139.269915]  [<ffffffff815d122c>] ret_from_fork+0x7c/0xb0
>	[  139.269915]  [<ffffffff8107fbc0>] ? kthread_create_on_node+0x110/0x110
>	[  139.269915] Code: 4c 8b 45 c8 48 8d 7d d0 89 4d c4 41 89 c9 b9 28 00 00 00 e8
>	9d b4 e9
>	e0 48 85 c0 49 89 c5 74 a2 48 89 c7 e8 9d 3f e9 e0 48 89 c2 <41> 8b 46 04 48 8b
>	7d d0 4c
>	89 e9 4c 89 e6 89 42 0c 0f b7 83 d4
>	[  139.269915] RIP  [<ffffffffa026f216>]
>	ftrace_raw_event_rpc_task_running+0x86/0xf0 [sunrpc]
>	[  139.269915]  RSP <ffff88001b633d70>
>	[  139.269915] CR2: 0000000000000004
>	[  140.946406] ---[ end trace ba486328b98d7622 ]---
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
> instrumentation/events/lttng-module/rpc.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/rpc.h
> b/instrumentation/events/lttng-module/rpc.h
> index 3798e8e..fb13106 100644
> --- a/instrumentation/events/lttng-module/rpc.h
> +++ b/instrumentation/events/lttng-module/rpc.h
> @@ -139,7 +139,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_running,
> 
> 	TP_FIELDS(
> 		ctf_integer(unsigned int, task_id, task->tk_pid)
> -		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
> +		ctf_integer(unsigned int, client_id, task->tk_client ?
> task->tk_client->cl_clid : -1)
> 		ctf_integer_hex(const void *, action, action)
> 		ctf_integer(unsigned long, runstate, task->tk_runstate)
> 		ctf_integer(int, status, task->tk_status)
> @@ -208,7 +208,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_running,
> 
> 	TP_FIELDS(
> 		ctf_integer(unsigned int, task_id, task->tk_pid)
> -		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
> +		ctf_integer(unsigned int, client_id, task->tk_client ?
> task->tk_client->cl_clid : -1)
> 		ctf_integer_hex(const void *, action, action)
> 		ctf_integer(unsigned long, runstate, task->tk_runstate)
> 		ctf_integer(int, status, task->tk_status)
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
