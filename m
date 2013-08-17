From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Compilation error in LTTng-UST 2.0.8
Date: Sat, 17 Aug 2013 18:46:54 -0400
Message-ID: <20130817224654.GA32749__47689.3232706518$1376779673$gmane$org@Krystal>
References: <CABRndgzoMJn3gQDidOBb+H=2yOi=F=3S0FLTVC9e1_EW08GdGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VApGq-0006Db-4t
	for lttng-dev@lists.lttng.org; Sat, 17 Aug 2013 18:46:58 -0400
Content-Disposition: inline
In-Reply-To: <CABRndgzoMJn3gQDidOBb+H=2yOi=F=3S0FLTVC9e1_EW08GdGg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Zvi Vered (veredz72@gmail.com) wrote:
> Hello,
> 
> I downloaded the file lttng-ust-2.0.8.tar.bz2, extracted it and the ran:
> ./configure
> make
> 
> After a while I got the following compilcation error:
> 
>   CC     ltt-probes.lo
>   CC     lttng-probe-ust.lo
> In file included from ../include/lttng/ust-tracepoint-event.h:506,
>                  from ../include/lttng/tracepoint-event.h:41,
>                  from probes/lttng-probe-ust.h:47,
>                  from probes/lttng-probe-ust.c:25:
> ././probes/lttng-probe-ust.h:27: error: weak declaration of
> '__ref_loglevel___lttng_ust___metadata' must be public
> ././probes/lttng-probe-ust.h:27: error:
> '__ref_loglevel___lttng_ust___metadata' defined both normally and as an
> alias
> make[2]: *** [lttng-probe-ust.lo] Error 1
> make[2]: Leaving directory `/home/zvivered/GNU/lttng-ust-2.0.8/liblttng-ust'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/zvivered/GNU/lttng-ust-2.0.8'
> make: *** [all] Error 2
> 
> 
> I'm working with Centos 5.9, gcc 4.1.2 20080704 (Red Hat 4.1.2-54)
> 
> Can you help ?

It seems related to:

http://bugs.lttng.org/issues/236

Even the Linux kernel will refuse to be compiled with gcc 4.1.0/4.1.1:

include/linux/compiler-gcc4.h:

/* GCC 4.1.[01] miscompiles __weak */
#ifdef __KERNEL__
# if GCC_VERSION >= 40100 &&  GCC_VERSION <= 40101
#  error Your version of gcc miscompiles the __weak directive
# endif
#endif

I suspect that the gcc 4.1.2 used by redhat might have a similar
behavior.

Can you try compiling a LTTng-UST probe with an upstream gcc 4.1.2
package from http://gcc.gnu.org and let us know the result ?
(http://gcc.gnu.org/gcc-4.1/)

Can you try compiling a recent kernel tree with the gcc 4.1.2 from
Centos and let us know the result ?

Thanks,

Mathieu

> 
> Thanks,
> Zvika

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
