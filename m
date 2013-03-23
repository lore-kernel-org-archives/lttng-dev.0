From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] lttng-abi.c: fix the error check
Date: Sat, 23 Mar 2013 11:46:58 -0400
Message-ID: <20130323154658.GA28816__46904.2546269067$1364053668$gmane$org@Krystal>
References: <20130322215745.GB18746@Krystal> <maxin.john@enea.com>
	<20130323143435.GA55460@sestofb10.enea.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UJQeq-0002IF-JM
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 11:47:00 -0400
Content-Disposition: inline
In-Reply-To: <20130323143435.GA55460@sestofb10.enea.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Maxin B. John" <maxin.john@enea.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Maxin B. John (maxin.john@enea.com) wrote:
> I was trying to fix a random problem happened in hawkboard with =

> 3.9.0-rc3 kernel.
>  =

> root@hawkboard:~# uname -a
> Linux hawkboard 3.9.0-rc3-00244-g9217cbb #35 PREEMPT Fri Mar 22
> 18:03:26 CET 2013 armv5tejl GNU/Linux
>  =

> root@hawkboard:~# lttng create mysession
> Session mysession created.
> Traces will be written in
> /home/root/lttng-traces/mysession-20130321-131130
> root@hawkboard:~# lttng enable-event -a -k
> lttng-sessiond: page allocation failure: order:10, mode:0x10c0d0
> [<c001358c>] (unwind_backtrace+0x0/0xfc) from [<c037af14>]
> (dump_stack+0x20/0x24)
> [<c037af14>] (dump_stack+0x20/0x24) from [<c00b7de8>]
> (warn_alloc_failed+0xd0/0x114)
> [<c00b7de8>] (warn_alloc_failed+0xd0/0x114) from [<c00bad80>]
> (__alloc_pages_nodemask+0x620/0x8bc)
> [<c00bad80>] (__alloc_pages_nodemask+0x620/0x8bc) from [<c00bb03c>]
> (__get_free_pages+0x20/0x5c)
> [<c00bb03c>] (__get_free_pages+0x20/0x5c) from [<c00e9e50>]
> (kmalloc_order_trace+0x34/0xf4)
> [<c00e9e50>] (kmalloc_order_trace+0x34/0xf4) from [<bf09affc>]
> (lttng_syscalls_register+0x1a4/0x244 [lttng_tracer])
> [<bf09affc>] (lttng_syscalls_register+0x1a4/0x244 [lttng_tracer]) from

Oh! got it.

if we look at:

int lttng_syscalls_register(struct lttng_channel *chan, void *filter)

                /* create syscall table mapping syscall to events */
                chan->sc_table =3D kzalloc(sizeof(struct lttng_event *)
                                        * ARRAY_SIZE(sc_table), GFP_KERNEL);

we notice that if sc_table is huge (e.g. because some system call
numbers would be really, really high), then we could possibly run out of
memory when doing this allocation.

What is the range of system call numbers on your architecture ?

Thanks,

Mathieu



> [<bf082ce8>] (lttng_abi_create_event+0x7c/0x138 [lttng_tracer])
> [<bf082ce8>] (lttng_abi_create_event+0x7c/0x138 [lttng_tracer]) from
> [<bf083958>] (lttng_channel_ioctl+0x198/0x53c [lttng_tracer])
> [<bf083958>] (lttng_channel_ioctl+0x198/0x53c [lttng_tracer]) from
> [<c0100ecc>] (do_vfs_ioctl+0x8c/0x608)
> [<c0100ecc>] (do_vfs_ioctl+0x8c/0x608) from [<c01014c8>]
> (sys_ioctl+0x80/0x88)
> [<c01014c8>] (sys_ioctl+0x80/0x88) from [<c000e2e0>]
> (ret_fast_syscall+0x0/0x44)
> Mem-info:
> DMA per-cpu:
> CPU    0: hi:   18, btch:   3 usd:   0
> active_anon:789 inactive_anon:12 isolated_anon:0
>  active_file:2056 inactive_file:2348 isolated_file:0
>  unevictable:0 dirty:0 writeback:0 unstable:0
>  free:2790 slab_reclaimable:852 slab_unreclaimable:944
>  mapped:589 shmem:21 pagetables:134 bounce:0
>  free_cma:0
> DMA free:11160kB min:968kB low:1208kB high:1452kB active_anon:3156kB
> inactive_anon:48kB active_file:8224kB inactive_file:9392kB
> unevictable:0kB isolated(anon):0kB isolated(file):0kB present:65536kB
> managed:59016kB mlocked:0kB dirty:0kB writeback:0kB mapped:2356kB
> shmem:84kB slab_reclaimable:3408kB slab_unreclaimable:3776kB
> kernel_stack:448kB pagetables:536kB unstable:0kB bounce:0kB
> free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0
> DMA: 4*4kB (UEM) 9*8kB (UEM) 4*16kB (UEM) 8*32kB (EMR) 4*64kB (EMR)
> 4*128kB (EMR) 3*256kB (UER) 4*512kB (UEMR) 3*1024kB (UEM) 2*2048kB
> (UE) 0*4096kB =3D 11160kB
> 4432 total pagecache pages
> 16384 pages of RAM
> 2955 free pages
> 1571 reserved pages
> 1571 slab pages
> 264956 pages shared
> 0 pages swap cached
> PERROR: create event ioctl: Cannot allocate memory [in
> kernel_create_event() at kernel.c:206]
> All kernel events are enabled in channel channel0
> =

>  > The expected return values from lttng_syscalls_register are:
>  >=B7
>  > 0 -> success
>  > -EINVAL -> error
>  > -ENOMEM -> error
>  >=B7
>  > so whether we check for error with
>  >=B7
>  > if (ret)
>  > or
>  > if (ret < 0)
>  >=B7
>  > should yield to the exact same result, since we don't expect positive
>  > return values.
>  =

>  Now, I can see that my idea wasn't right. =

> =

>  > And for lttng_abi_create_event(), the original code flow is to execute=
 2
>  > kfree(), and then "return ret", which will return either -EINVAL or
>  > -ENOMEM to the caller.
>  >=B7
>  > So by adding this return -ENOMEM, you hide the real cause (-EINVAL or
>  > -ENOMEM), and you add 2 memory leaks.
>  =

>  Ahh.. Sorry!
>  =

>  > Or am I missing something ?
>  >=B7
>  > Thanks,
>  > Mathieu
>  =

>  Best Regards,
>  Maxin

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
