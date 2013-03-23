From: "Maxin B. John" <maxin.john@enea.com>
Subject: Re: [PATCH] lttng-abi.c: fix the error check
Date: Sat, 23 Mar 2013 15:34:35 +0100
Message-ID: <20130323143435.GA55460__25099.1037967198$1364050412$gmane$org@sestofb10.enea.se>
References: <20130322215745.GB18746@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0724140588=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Maxin.John@enea.com>) id 1UJPWs-0001jE-Fg
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 10:34:42 -0400
In-Reply-To: <20130322215745.GB18746@Krystal>
 <maxin.john@enea.com>
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

--===============0724140588==
Content-Type: text/plain; charset="unknown-8bit"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was trying to fix a random problem happened in hawkboard with=20
3.9.0-rc3 kernel.
=20
root@hawkboard:~# uname -a
Linux hawkboard 3.9.0-rc3-00244-g9217cbb #35 PREEMPT Fri Mar 22
18:03:26 CET 2013 armv5tejl GNU/Linux
=20
root@hawkboard:~# lttng create mysession
Session mysession created.
Traces will be written in
/home/root/lttng-traces/mysession-20130321-131130
root@hawkboard:~# lttng enable-event -a -k
lttng-sessiond: page allocation failure: order:10, mode:0x10c0d0
[<c001358c>] (unwind_backtrace+0x0/0xfc) from [<c037af14>]
(dump_stack+0x20/0x24)
[<c037af14>] (dump_stack+0x20/0x24) from [<c00b7de8>]
(warn_alloc_failed+0xd0/0x114)
[<c00b7de8>] (warn_alloc_failed+0xd0/0x114) from [<c00bad80>]
(__alloc_pages_nodemask+0x620/0x8bc)
[<c00bad80>] (__alloc_pages_nodemask+0x620/0x8bc) from [<c00bb03c>]
(__get_free_pages+0x20/0x5c)
[<c00bb03c>] (__get_free_pages+0x20/0x5c) from [<c00e9e50>]
(kmalloc_order_trace+0x34/0xf4)
[<c00e9e50>] (kmalloc_order_trace+0x34/0xf4) from [<bf09affc>]
(lttng_syscalls_register+0x1a4/0x244 [lttng_tracer])
[<bf09affc>] (lttng_syscalls_register+0x1a4/0x244 [lttng_tracer]) from
[<bf082ce8>] (lttng_abi_create_event+0x7c/0x138 [lttng_tracer])
[<bf082ce8>] (lttng_abi_create_event+0x7c/0x138 [lttng_tracer]) from
[<bf083958>] (lttng_channel_ioctl+0x198/0x53c [lttng_tracer])
[<bf083958>] (lttng_channel_ioctl+0x198/0x53c [lttng_tracer]) from
[<c0100ecc>] (do_vfs_ioctl+0x8c/0x608)
[<c0100ecc>] (do_vfs_ioctl+0x8c/0x608) from [<c01014c8>]
(sys_ioctl+0x80/0x88)
[<c01014c8>] (sys_ioctl+0x80/0x88) from [<c000e2e0>]
(ret_fast_syscall+0x0/0x44)
Mem-info:
DMA per-cpu:
CPU    0: hi:   18, btch:   3 usd:   0
active_anon:789 inactive_anon:12 isolated_anon:0
 active_file:2056 inactive_file:2348 isolated_file:0
 unevictable:0 dirty:0 writeback:0 unstable:0
 free:2790 slab_reclaimable:852 slab_unreclaimable:944
 mapped:589 shmem:21 pagetables:134 bounce:0
 free_cma:0
DMA free:11160kB min:968kB low:1208kB high:1452kB active_anon:3156kB
inactive_anon:48kB active_file:8224kB inactive_file:9392kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:65536kB
managed:59016kB mlocked:0kB dirty:0kB writeback:0kB mapped:2356kB
shmem:84kB slab_reclaimable:3408kB slab_unreclaimable:3776kB
kernel_stack:448kB pagetables:536kB unstable:0kB bounce:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 4*4kB (UEM) 9*8kB (UEM) 4*16kB (UEM) 8*32kB (EMR) 4*64kB (EMR)
4*128kB (EMR) 3*256kB (UER) 4*512kB (UEMR) 3*1024kB (UEM) 2*2048kB
(UE) 0*4096kB =3D 11160kB
4432 total pagecache pages
16384 pages of RAM
2955 free pages
1571 reserved pages
1571 slab pages
264956 pages shared
0 pages swap cached
PERROR: create event ioctl: Cannot allocate memory [in
kernel_create_event() at kernel.c:206]
All kernel events are enabled in channel channel0

 > The expected return values from lttng_syscalls_register are:
 >=C2=B7
 > 0 -> success
 > -EINVAL -> error
 > -ENOMEM -> error
 >=C2=B7
 > so whether we check for error with
 >=C2=B7
 > if (ret)
 > or
 > if (ret < 0)
 >=C2=B7
 > should yield to the exact same result, since we don't expect positive
 > return values.
=20
 Now, I can see that my idea wasn't right.=20

 > And for lttng_abi_create_event(), the original code flow is to execute 2
 > kfree(), and then "return ret", which will return either -EINVAL or
 > -ENOMEM to the caller.
 >=C2=B7
 > So by adding this return -ENOMEM, you hide the real cause (-EINVAL or
 > -ENOMEM), and you add 2 memory leaks.
=20
 Ahh.. Sorry!
=20
 > Or am I missing something ?
 >=C2=B7
 > Thanks,
 > Mathieu
=20
 Best Regards,
 Maxin


--===============0724140588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0724140588==--
