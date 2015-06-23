From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Building the event list
 fails on fragmented memory
Date: Tue, 23 Jun 2015 21:04:18 +0000 (UTC)
Message-ID: <600744376.2021.1435093458623.JavaMail.zimbra__37434.943978633$1435093545$gmane$org@efficios.com>
References: <55755E0D.7010902@leisener.de>
 <1905517223.241.1433920494952.JavaMail.zimbra@efficios.com>
 <557838F1.9020808@leisener.de>
 <1586680029.1815.1434223948187.JavaMail.zimbra@efficios.com>
 <20150623134638.GA3944@hal>
 <1503217107.1784.1435088815111.JavaMail.zimbra@efficios.com>
 <1501535608.1867.1435090872005.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z7VMw-0007z0-KW
 for lttng-dev@lists.lttng.org; Tue, 23 Jun 2015 17:04:39 -0400
In-Reply-To: <1501535608.1867.1435090872005.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Nope, it wasn't it. metadata_written is always <= cache_alloc, so the
current upstream code looks correct.

I've just tried after changing the CPU configuration from "hypervisor
default" to "copy host cpu config" on my machine, and was then unable
to reproduce. I wonder if there is not an issue with __memcpy implementation
for specific x86_64 processors (e.g. reading too many bytes from the vmalloc'd
area).

Thoughts ?

Thanks,

Mathieu

----- On Jun 23, 2015, at 4:21 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> I think I found the culprit (testing now):
> 
> int lttng_metadata_printf(struct lttng_session *session,
>                          const char *fmt, ...)
> 
>                tmp_cache_alloc_size = max_t(unsigned int,
>                                session->metadata_cache->cache_alloc + len,
>                                session->metadata_cache->cache_alloc << 1)
> 
> should be:
> 
>                tmp_cache_alloc_size = max_t(unsigned int,
>                                session->metadata_cache->metadata_written + len,
>                                session->metadata_cache->cache_alloc << 1);
> 
> I think we have a possible memory corruption in the upstream code here.
> 
> More coming soon,
> 
> Thanks,
> 
> Mathieu
> 
> 
> ----- On Jun 23, 2015, at 3:46 PM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
>> ----- On Jun 23, 2015, at 9:46 AM, Jan Glauber jan.glauber@gmail.com wrote:
>> 
>>> On Sat, Jun 13, 2015 at 07:32:28PM +0000, Mathieu Desnoyers wrote:
>>>> ----- On Jun 10, 2015, at 9:17 AM, Martin Leisener martin@leisener.de wrote:
>>>> 
>>>> > Hi Mathieu,
>>>> > 
>>>> > sorry for sending the broken patch, I fell for some "smart" formating of my
>>>> > email client, I cannot utilize it myself the way I send it.
>>>> > Hence I now send the patch again as it was original intended. Sent to myself, I
>>>> > can apply it, so I hope it now works in general as well
>>>> > I examined as recommended diff -urN, it seems the output can be utilized by
>>>> > patch the same way as git diff.
>>>> > Hope it is now received the way I intended.
>>>> 
>>>> Hi Martin,
>>>> 
>>>> I tried you patch on a x86-64 machine (my laptop), and although taking a
>>>> single kernel trace worked fine, it appears to OOPS when I run
>>>> 
>>>> (in lttng-tools)
>>>> cd tests
>>>> ./run.sh root_regression
>>> 
>>> Hi Mathieu,
>>> 
>>> can you please share the oops message so I can have a look?
>> 
>> Sure,
>> 
>> Here is the backtrace happening with the attached patch over lttng-modules
>> commit 8c6e7f13c778701dec2d6549f1e2ca98970907a0. I modified your patch
>> slightly.
>> 
>> [ 4078.314978] BUG: unable to handle kernel paging request at ffffc900038d995e
>> [ 4078.315824] IP: [<ffffffff81316f12>] __memcpy+0x12/0x20
>> [ 4078.315824] PGD 236c92067 PUD 236c93067 PMD bac0c067 PTE 0
>> [ 4078.315824] Oops: 0000 [#1] SMP
>> [ 4078.315824] Modules linked in: lttng_probe_workqueue(O) lttng_probe_vmscan(O)
>> lttng_probe_udp(O) lttng_probe_timer(O) lttng_probe_sunrpc(O)
>> lttng_probe_statedump(O) lttng_probe_sock(O) lttng_probe_skb(O)
>> lttng_probe_signal(O) lttng_probe_scsi(O) lttng_probe_sched(O)
>> lttng_probe_regmap(O) lttng_probe_rcu(O) lttng_probe_random(O)
>> lttng_probe_printk(O) lttng_probe_power(O) lttng_probe_net(O)
>> lttng_probe_napi(O) lttng_probe_module(O) lttng_probe_kmem(O)
>> lttng_probe_jbd2(O) lttng_probe_irq(O) lttng_probe_ext4(O)
>> lttng_probe_compaction(O) lttng_probe_block(O) lttng_types(O)
>> lttng_ring_buffer_metadata_mmap_client(O)
>> lttng_ring_buffer_client_mmap_overwrite(O)
>> lttng_ring_buffer_client_mmap_discard(O) lttng_ring_buffer_metadata_client(O)
>> lttng_ring_buffer_client_overwrite(O) lttng_ring_buffer_client_discard(O)
>> lttng_tracer(O) lttng_statedump(O) lttng_kprobes(O) lttng_lib_ring_buffer(O)
>> lttng_kretprobes(O) virtio_blk virtio_net virtio_pci virtio_ring virtio
>> [ 4078.315824] CPU: 5 PID: 4258 Comm: lttng-consumerd Tainted: G           O
>> 4.1.0 #7
>> [ 4078.315824] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs
>> 01/01/2011
>> [ 4078.315824] task: ffff8802350c3660 ti: ffff8800bae84000 task.ti:
>> ffff8800bae84000
>> [ 4078.315824] RIP: 0010:[<ffffffff81316f12>]  [<ffffffff81316f12>]
>> __memcpy+0x12/0x20
>> [ 4078.315824] RSP: 0018:ffff8800bae87da0  EFLAGS: 00010246
>> [ 4078.315824] RAX: ffff880235439025 RBX: 0000000000000fd8 RCX: 00000000000001fb
>> [ 4078.315824] RDX: 0000000000000000 RSI: ffffc900038d995e RDI: ffff880235439025
>> [ 4078.315824] RBP: ffff8800bae87db8 R08: ffff8800bacecc00 R09: 0000000000008000
>> [ 4078.315824] R10: 0000000000000000 R11: 0000000000000246 R12: ffff8800bae87dc8
>> [ 4078.315824] R13: ffff88023466e800 R14: 0000000000000fd8 R15: 0000000000000fd8
>> [ 4078.315824] FS:  00007f5d3b1cc700(0000) GS:ffff8802372a0000(0000)
>> knlGS:0000000000000000
>> [ 4078.315824] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> [ 4078.315824] CR2: ffffc900038d995e CR3: 00000000bb1ed000 CR4: 00000000000006e0
>> [ 4078.315824] Stack:
>> [ 4078.315824]  ffffffffa01ac797 ffff8800bb5bd480 ffff8800bb5bd4d0
>> ffff8800bae87e48
>> [ 4078.315824]  ffffffffa0073060 ffff88023466e800 0000000000000000
>> 0000000000000fd8
>> [ 4078.315824]  ffffffff00000001 ffff8800bacecc00 0000000000000fd8
>> 0000000000008025
>> [ 4078.315824] Call Trace:
>> [ 4078.315824]  [<ffffffffa01ac797>] ? lttng_event_write+0x87/0xb0
>> [lttng_ring_buffer_metadata_client]
>> [ 4078.315824]  [<ffffffffa0073060>] lttng_metadata_output_channel+0xd0/0x120
>> [lttng_tracer]
>> [ 4078.315824]  [<ffffffffa00755f9>] lttng_metadata_ring_buffer_ioctl+0x79/0xd0
>> [lttng_tracer]
>> [ 4078.315824]  [<ffffffff8117ba10>] do_vfs_ioctl+0x2e0/0x4e0
>> [ 4078.315824]  [<ffffffff812b35c7>] ? file_has_perm+0x87/0xa0
>> [ 4078.315824]  [<ffffffff8117bc91>] SyS_ioctl+0x81/0xa0
>> [ 4078.315824]  [<ffffffff810115d1>] ? syscall_trace_leave+0xd1/0xe0
>> [ 4078.315824]  [<ffffffff818bbd37>] tracesys_phase2+0x84/0x89
>> [ 4078.315824] Code: 5b 5d c3 66 0f 1f 44 00 00 e8 6b fc ff ff eb e1 90 90 90 90
>> 90 90 90 90 90 0f 1f 44 00 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 <f3> 48 a5
>> 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3
>> [ 4078.315824] RIP  [<ffffffff81316f12>] __memcpy+0x12/0x20
>> [ 4078.315824]  RSP <ffff8800bae87da0>
>> [ 4078.315824] CR2: ffffc900038d995e
>> [ 4078.315824] ---[ end trace a05b652829ceda48 ]---
>> [ 4078.433848] LTTng: block device enumeration is not supported by kernel
>> 
>> 
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
