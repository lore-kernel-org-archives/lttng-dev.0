From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add compilation support for
	the	TileGX architecture.
Date: Fri, 9 Nov 2012 10:57:31 -0500
Message-ID: <20121109155731.GB8094__25104.7135367573$1352476686$gmane$org@Krystal>
References: <1352443711-8662-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWqxc-0007GL-4e
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 10:57:36 -0500
Content-Disposition: inline
In-Reply-To: <1352443711-8662-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

First detail: please remove dot from subject end of line.

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  configure.ac |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 7f12f23..97a9f65 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -213,6 +213,7 @@ changequote([,])dnl
>          armv5) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
>  	arm) LIBFORMAT="elf32-littlearm"; NO_UNALIGNED_ACCESS=1 ;;
>  	mips*) LIBFORMAT=""; NO_UNALIGNED_ACCESS=1;;
> +	tile) LIBFORMAT="elf64-tilegx-le"; NO_UNALIGNED_ACCESS=1;;

Not sure how this works, but I think there exists other "tile" flavors
out there besides the tilegx. Will they appear as "tile" from an
autotools point of view and then break when we specify their libformat
as elf64-tilegx-le ? Are there any way to distinguish between flavors ?
Please ask advice to Tilera if needed.

Thanks,

Mathieu

>  	*) AC_MSG_ERROR([unable to detect library format (unsupported architecture ($host_cpu)?)]) ;;
>  esac
>  AC_SUBST(LIBFORMAT)
> -- 
> 1.7.1
> 
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
