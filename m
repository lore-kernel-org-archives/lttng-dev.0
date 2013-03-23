From: "Maxin B. John" <maxin.john@enea.com>
Subject: Re: [PATCH] lttng-abi.c: fix the error check
Date: Sat, 23 Mar 2013 17:56:21 +0100
Message-ID: <20130323165621.GA62630__29268.7258137905$1364057833$gmane$org@sestofb10.enea.se>
References: <20130323160334.GB28816@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1869637879=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <Maxin.John@enea.com>) id 1UJRk3-0002pY-OZ
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 12:56:28 -0400
In-Reply-To: <20130323160334.GB28816@Krystal>
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

--===============1869637879==
Content-Type: text/plain; charset="unknown-8bit"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 On Sat, Mar 23, 2013 at 12:03:34PM -0400, Mathieu Desnoyers wrote:
 > * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
 > > * Maxin B. John (maxin.john@enea.com) wrote:
 > > > I was trying to fix a random problem happened in hawkboard with=C2=
=B7
 > > > 3.9.0-rc3 kernel.
 > > >
 > > > root@hawkboard:~# uname -a
 > > > Linux hawkboard 3.9.0-rc3-00244-g9217cbb #35 PREEMPT Fri Mar 22
 > > > 18:03:26 CET 2013 armv5tejl GNU/Linux
 <snip>

 > a look at:
 >
 > arch/arm/include/uapi/asm/unistd.h
 >
 > shows:
 >
 > #define __NR_OABI_SYSCALL_BASE  0x900000
 >
 > #if defined(__thumb__) || defined(__ARM_EABI__)
 > #define __NR_SYSCALL_BASE       0
 > #else
 > #define __NR_SYSCALL_BASE       __NR_OABI_SYSCALL_BASE
 > #endif
 >
 > So this offset "base" might be causing the large allocation. Can you try
 > the following patch and see if it helps ?
 > ---

I have applied the patch and tested it on the device. However, I can
still see the random page allocation failure (It works fine at first
time and then randomly fails). Could be a hardware problem.. I will
verify it in another similar board.

I forgot to mention that even before, with this page allocation failure,
lttng works as expected and I can see the output using babeltrace.

oot@hawkboard:~# lttng enable-event -a -k
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
(lttng_syscalls_register+0x1a4/0x240 [lttng_tracer])
[<bf09affc>] (lttng_syscalls_register+0x1a4/0x240 [lttng_tracer]) from
[<bf082ce8>] (lttng_abi_create_event+0x7c/0x138 [lttng_tracer])
[<bf082ce8>] (lttng_abi_create_event+0x7c/0x
....

Thanks & Regards,
Maxin


--===============1869637879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1869637879==--
