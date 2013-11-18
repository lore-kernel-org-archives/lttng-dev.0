From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: might_sleep warnings in overwrite mode
Date: Mon, 18 Nov 2013 13:30:36 -0600
Message-ID: <528A6ADC.8060609__8251.63524500585$1384803148$gmane$org@mentor.com>
References: <52803E5D.3050109@mentor.com> <52851395.3010306@mentor.com>
	<67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Nathan_Lynch@mentor.com>) id 1ViUX3-0000kD-Ek
	for lttng-dev@lists.lttng.org; Mon, 18 Nov 2013 14:30:56 -0500
In-Reply-To: <67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 11/14/2013 08:34 PM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Nathan Lynch" <Nathan_Lynch@mentor.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Thursday, November 14, 2013 1:16:53 PM
>> Subject: Re: [lttng-dev] might_sleep warnings in overwrite mode
>>
>> On 11/10/2013 08:18 PM, Nathan Lynch wrote:
>>> At this point I cannot trigger the issue without overwrite mode on
>>> 3.11.6, but on a 3.8-based vendor kernel I can recreate it regardless of
>>> the mode.
>>
>> Some updates on this:
>> - It's not specific to overwrite mode; I was able to provoke it on
>> 3.11.6 without --overwrite.  Overwrite mode does seem to recreate the
>> issue more readily.
>> - It seems to be GCC version-dependent.  4.8.1 and 4.8.2 produce code
>> which warns/bugs; 4.7.3 does not.
> 
> Looking at:
> 
> fs/ext3/incode.c:
> 
> __ext3_get_inode_loc()
> 
> we can see that a use of the inlined sb_getblk() appears close to a tracepoint.
> 
> The tracepoint includes preempt disable/enable, exactly those:
> 
> include/linux/preempt.h:
> 
> #define preempt_disable_notrace() \
> do { \
>         inc_preempt_count_notrace(); \
>         barrier(); \
> } while (0)
> 
> #define preempt_enable_notrace() \
> do { \
>         preempt_enable_no_resched_notrace(); \
>         barrier(); \
>         preempt_check_resched_context(); \
> } while (0)
> 
> 
> Can you try wrapping the _outside_ of those macros with barrier(), e.g.
> 
> 
> #define preempt_disable_notrace() \
> do { \
>         barrier(); \
>         inc_preempt_count_notrace(); \
>         barrier(); \
> } while (0)
> 
> #define preempt_enable_notrace() \
> do { \
>         preempt_enable_no_resched_notrace(); \
>         barrier(); \
>         preempt_check_resched_context(); \
>         barrier(); \
> } while (0)
> 
> and try it out with the apparently buggy compiler to see if it helps ?

I did this, and I think I'm pretty satisfied that it works around the
issue.  I haven't been able to provoke might_sleep or preempt count
warnings with multiple runs.  Complicating matters is that I keep
hitting a null pointer dereference in the mmc code which I wasn't seeing
before (and sorry about the line wrapping, I cannot make Thunderbird
behave well here):

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = 80004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT SMP ARM
Modules linked in: lttng_probe_writeback(O) lttng_probe_workqueue(O)
lttng_probe_vmscan(O) lttng_probe_udp(O) lttng_probe_timer(O)
lttng_probe_sunrpc(O) lttng_probe_statedump(O) lttng_probe_sock(O)
lttng_probe_skb(O) lttng_probe_signal(O) lttng_probe_scsi(O)
lttng_probe_sched(O) lttng_probe_rpm(O) lttng_probe_regulator(O)
lttng_probe_regmap(O) lttng_probe_rcu(O) lttng_probe_random(O)
lttng_probe_printk(O) lttng_probe_power(O) lttng_probe_net(O)
lttng_probe_napi(O) lttng_probe_module(O) lttng_probe_kmem(O)
lttng_probe_jbd2(O) lttng_probe_jbd(O) lttng_probe_irq(O)
lttng_probe_gpio(O) lttng_probe_ext4(O) lttng_probe_ext3(O)
lttng_probe_compaction(O) lttng_probe_block(O) lttng_probe_asoc(O)
lttng_types(O) lttng_ring_buffer_metadata_mmap_client(O)
lttng_ring_buffer_client_mmap_overwrite(O)
lttng_ring_buffer_client_mmap_discard(O)
lttng_ring_buffer_metadata_client(O)
lttng_ring_buffer_client_overwrite(O)
lttng_ring_buffer_client_discard(O) lttng_tracer(O) lttng_statedump(O)
lttng_ftrace(O) lttng_kprobes(O) lttng_lib_ring_buffer(O)
lttng_kretprobes(O)
CPU: 0 PID: 143 Comm: mmcqd/0 Tainted: G           O 3.11.6 #1
task: bf0d0900 ti: bf0be000 task.ti: bf0be000
PC is at sdhci_send_command+0x3fc/0xc58
LR is at sdhci_send_command+0x424/0xc58
pc : [<804371d0>]    lr : [<804371f8>]    psr: 80000093
sp : bf0bfd50  ip : bf0bfd50  fp : bf0bfdac
r10: 60000013  r9 : bfb7c440  r8 : 0000000f
r7 : 808da22c  r6 : bb39c000  r5 : bb3ebe18  r4 : bb3ebe80
r3 : 87654321  r2 : bfa12c10  r1 : 81802b22  r0 : 00000000
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7d  Table: 4ecb404a  DAC: 00000017
Process mmcqd/0 (pid: 143, stack limit = 0xbf0be238)
Stack: (0xbf0bfd50 to 0xbf0c0000)
fd40:                                     00000001 00000000 bf0bfd84
87654321
fd60: bfa12c10 7f0b700c bfb7c000 bb3ebda0 bfb7c440 00000001 bf0bfd94
bf0bfd88
fd80: 802d1af8 bfb7c000 bb3ebda0 bfb7c440 bfb7c518 40000013 00000001
bfb7c000
fda0: bf0bfdd4 bf0bfdb0 80438194 80436de0 bb3ebda0 bfb7c000 bb3ebd8c
00000000
fdc0: 00000001 00000001 bf0bfdec bf0bfdd8 804248d4 80437fd8 bb3ebec0
bf0bfe74
fde0: bf0bfe44 bf0bfdf0 804261b8 80424800 bf0be000 bf0be000 bf0be030
bb3ebc6c
fe00: bf0bfe44 00000000 bf0d0900 80047430 bf0bfe10 bf0bfe10 3aee2e82
bb368618
fe20: bb3ebc24 bb3c6000 bb317438 bb317438 bb3ebd9c bb3ebc00 bf0bfea4
bf0bfe48
fe40: 80433ba8 80425ef8 7f08d740 7f066a08 00000000 00000000 bf026000
00000000
fe60: bb3ebda0 00000000 bb3ebc00 00000000 00000038 cec07c38 cec07c00
bb317438
fe80: bb3c6000 bb3ebc24 bb368618 bfb7c000 bb3ebc00 bb3ebc00 bf0bfeec
bf0bfea8
fea0: 804342a4 80433800 bb3ebd9c bb3ebc00 bb317438 bb3ebc2c bb368618
5e565e55
fec0: bb3ebc00 bb3ebc24 bb317438 bb3ebc2c bb368618 bf0be030 bf0be000
00000001
fee0: bf0bff24 bf0bfef0 80434cb4 804341a4 00000000 122c8001 80434bec
bfa87bc4
ff00: 00000000 bb3ebc24 80434bec 00000000 00000000 00000000 bf0bffac
bf0bff28
ff20: 80046520 80434bf8 8182be80 00000000 8182be80 bb3ebc24 00000000
00000000
ff40: dead4ead ffffffff ffffffff 80942bfc 00000000 00000000 807877a5
bf0bff5c
ff60: bf0bff5c 00000000 00000000 dead4ead ffffffff ffffffff 80942bfc
00000000
ff80: 00000000 807877a5 bf0bff88 bf0bff88 bfa87bc4 80046464 00000000
00000000
ffa0: 00000000 bf0bffb0 8000e438 80046470 00000000 00000000 00000000
00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000
00000000
Backtrace:
[<80436dd4>] (sdhci_send_command+0x0/0xc58) from [<80438194>]
(sdhci_request+0x1c8/0x1e0)
[<80437fcc>] (sdhci_request+0x0/0x1e0) from [<804248d4>]
(mmc_start_request+0xe0/0xe8)
 r9:00000001 r8:00000001 r7:00000000 r6:bb3ebd8c r5:bfb7c000

[<804247f4>] (mmc_start_request+0x0/0xe8) from [<804261b8>]
(mmc_start_req+0x2cc/0x360)
 r5:bf0bfe74 r4:bb3ebec0
[<80425eec>] (mmc_start_req+0x0/0x360) from [<80433ba8>]
(mmc_blk_issue_rw_rq+0x3b4/0x9a4)
[<804337f4>] (mmc_blk_issue_rw_rq+0x0/0x9a4) from [<804342a4>]
(mmc_blk_issue_rq+0x10c/0x450)
[<80434198>] (mmc_blk_issue_rq+0x0/0x450) from [<80434cb4>]
(mmc_queue_thread+0xc8/0x164)
[<80434bec>] (mmc_queue_thread+0x0/0x164) from [<80046520>]
(kthread+0xbc/0xc8)
[<80046464>] (kthread+0x0/0xc8) from [<8000e438>] (ret_from_fork+0x14/0x20)
 r7:00000000 r6:00000000 r5:80046464 r4:bfa87bc4
Code: e1a00006 e3a08000 e158000a aa00000c (e5901000)

I've narrowed this down to sdhci_adma_table_pre() which is inlined, but
haven't gotten much further.  Anyway, I think it's probably unrelated --
surely it wouldn't be _caused_ by adding the barriers -- and I'll have
to figure out some way to work around it (perhaps it's fixed in 3.12).


> It does look like the preempt inc or dec is slipping out and somehow
> triggers the might_sleep() warning. I don't see clearly how this
> could happen yet, since each of the inc/dec and the test are touching
> preempt_count(), but it's worth a try.
> 
> Maybe on ARM the current_thread_info() macro somehow hides important
> info from the compiler and it mistakenly reorders inc/dec vs the
> test. Another thing to try out (in addition to the first one) would
> be to try changing current_thread_info(), e.g., by turning asm ("sp")
> into a volatile inline assembly, and by adding "memory" clobbers to
> it.

Haven't tried this yet.
