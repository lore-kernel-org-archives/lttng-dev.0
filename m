From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] Introduce configure --with-urcu-prefix
Date: Thu, 22 Aug 2013 08:56:31 -0400
Message-ID: <20130822125631.GC26852__1487.85210117257$1377176229$gmane$org@Krystal>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<1377160051-12449-2-git-send-email-jimmy.durand.wesolowski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VCURE-0006ay-Ep
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 08:56:33 -0400
Content-Disposition: inline
In-Reply-To: <1377160051-12449-2-git-send-email-jimmy.durand.wesolowski@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Cc: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> From: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>
> 

Missing Signed-off-by: line

The "From" line is usually extracted from the email header (but it's
still OK if there is another From below: the second From within the
message will be used).

Please refer to patch 0/2 for my questions,

Thanks,

Mathieu

> ---
>  configure.ac |   42 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 94f8182..164174d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -149,14 +149,34 @@ CFLAGS="-Wall $CFLAGS"
>  
>  # URCU
>  
> +AC_ARG_WITH([urcu-prefix],
> +	AS_HELP_STRING([--with-urcu-prefix=PREFIX],
> +                       [Specify the installation prefix of the URCU library.
> +		        Headers must be in PREFIX/include; libraries in
> +			PREFIX/lib.]),
> +			[
> +			  CPPFLAGS="$CPPFLAGS -I${withval}/include"
> +			  LDFLAGS="$LDFLAGS -L${withval}/lib"
> +			])
> +
>  # urcu - check if we just find the headers it out of the box.
> -AC_CHECK_HEADERS([urcu-bp.h], [], [AC_MSG_ERROR([Cannot find [URCU] headers (urcu-bp.h). Use [CPPFLAGS]=-Idir to specify their location.
> -This error can also occur when the liburcu package's configure script has not been run.])])
> +AC_CHECK_HEADERS([urcu-bp.h],
> +                 [],
> +                 [
> +			AC_MSG_ERROR([Cannot find [URCU] headers (urcu-bp.h).
> +			              Use --with-urcu-prefix=PREFIX to
> +				      specify its location.])
> +                 ])
>  
>  # urcu-cds - check that URCU Concurrent Data Structure lib is available to compilation
>  # Part of Userspace RCU library 0.7.2 or better.
> -AC_CHECK_LIB([urcu-cds], [_cds_lfht_new], [], [AC_MSG_ERROR([Cannot find
> -liburcu-cds lib, part of Userspace RCU 0.7 or better. Use [LDFLAGS]=-Ldir to specify its location.])])
> +AC_CHECK_LIB([urcu-cds], [_cds_lfht_new], [],
> +             [
> +		AC_MSG_ERROR([Cannot find liburcu-cds lib, part of Userspace
> +		              RCU 0.7 or better.
> +		              Use --with-urcu-prefix=PREFIX to
> +			      specify its location.])
> +             ])
>  
>  AC_MSG_CHECKING([caa_likely()])
>  AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
> @@ -175,10 +195,20 @@ void fct(void)
>  ])
>  
>  # urcu - check that URCU lib is available to compilation
> -AC_CHECK_LIB([urcu-bp], [synchronize_rcu_bp], [], [AC_MSG_ERROR([Cannot find liburcu-bp lib. Use [LDFLAGS]=-Ldir to specify its location.])])
> +AC_CHECK_LIB([urcu-bp], [synchronize_rcu_bp], [],
> +             [
> +		AC_MSG_ERROR([Cannot find liburcu-bp lib.
> +		              Use Use --with-urcu-prefix=PREFIX to
> +			      specify its location.])
> +             ])
>  
>  # urcu - check that URCU lib is at least version 0.6
> -AC_CHECK_LIB([urcu-bp], [call_rcu_bp], [], [AC_MSG_ERROR([liburcu 0.6 or newer is needed, please update your version or use [LDFLAGS]=-Ldir to specify the right location.])])
> +AC_CHECK_LIB([urcu-bp], [call_rcu_bp], [],
> +             [
> +		AC_MSG_ERROR([liburcu 0.6 or newer is needed, please update
> +		              your version or use --with-urcu-prefix=PREFIX to
> +			      specify its location.])
> +             ])
>  
>  AC_MSG_CHECKING([host system alignment requirements])
>  case $host_cpu in
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
