From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Question about use libbabeltrace
Date: Thu, 13 Dec 2012 06:35:53 -0500
Message-ID: <20121213113553.GA9680__6870.45747549764$1355399197$gmane$org@Krystal>
References: <CANFwon0LGfGbP=a+OBHQMSKWz=_DYPKoEN=-udAmX6LiTTfCng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tj750-0003aS-Si
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 06:35:54 -0500
Content-Disposition: inline
In-Reply-To: <CANFwon0LGfGbP=a+OBHQMSKWz=_DYPKoEN=-udAmX6LiTTfCng@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hui Zhu <teawater@gmail.com>
Cc: Hui Zhu <hui_zhu@mentor.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Hui Zhu (teawater@gmail.com) wrote:
> Hi guys,
> 
> Maybe you had known that I am working on add CTF support to GDB that
> use libbabeltrace from my prev mail.
> 
> I use libbabeltrace in this patch
> http://sourceware.org/ml/gdb-patches/2012-11/msg00717.html
> 
> What I check if current machine have libbabeltrace in following way:
> +    if test "x$enable_glibtest" = "xyes" ; then
> +      ac_save_CFLAGS="$CFLAGS"
> +      ac_save_LIBS="$LIBS"
> +      CFLAGS="$CFLAGS $GLIB_CFLAGS"
> +      LIBS="$LIBS -lbabeltrace -lbabeltrace-ctf"
> +      rm -f conf.glibtest
> +      if test "$cross_compiling" = yes; then :
> +  $as_echo $ac_n "cross compiling; assumed OK... $ac_c"
> +else
> +  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> +/* end confdefs.h.  */
> +
> +#include <babeltrace/babeltrace.h>
> +#include <babeltrace/types.h>
> +#include <babeltrace/ctf/events.h>
> +#include <babeltrace/ctf/iterator.h>
> +
> +int
> +main ()
> +{
> +  if (!bt_context_create())
> +    return 1;
> +  return 0;
> +}
> +
> +_ACEOF
> +if ac_fn_c_try_run "$LINENO"; then :
> +
> +else
> +  no_glib=yes
> +fi
> 
> Just try to build example with -lbabeltrace -lbabeltrace-ctf.
> 
> My question is does libbabeltrace have better way to handle it?  For
> example: pkg-config

We don't have pkg-config support in babeltrace yet, but we would gladly
welcome a contribution adding it! :)

Thanks,

Mathieu

> 
> Thanks,
> Hui
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
