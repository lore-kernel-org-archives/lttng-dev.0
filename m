From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 ust] Add compilation support for
	Tile	architectures
Date: Thu, 24 Jan 2013 15:43:17 -0500
Message-ID: <20130124204317.GB9009__46277.9668313034$1359060242$gmane$org@Krystal>
References: <1359055113-25549-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TyTdm-0007r9-5h
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 15:43:18 -0500
Content-Disposition: inline
In-Reply-To: <1359055113-25549-1-git-send-email-simon.marchi@polymtl.ca>
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

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Also add missing space on the mips line for OCD purposes.

Merged, thanks!

Mathieu

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  configure.ac |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c4377a5..919b742 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -189,7 +189,8 @@ changequote([,])dnl
>  	s390) NO_UNALIGNED_ACCESS=1 ;;
>  	s390x) NO_UNALIGNED_ACCESS=1 ;;
>          arm*) NO_UNALIGNED_ACCESS=1 ;;
> -	mips*) NO_UNALIGNED_ACCESS=1;;
> +	mips*) NO_UNALIGNED_ACCESS=1 ;;
> +	tile*) NO_UNALIGNED_ACCESS=1 ;;
>  	*) AC_MSG_ERROR([unable to detect alignment requirements (unsupported architecture ($host_cpu)?)]) ;;
>  esac
>  
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
EfficiOS Inc.
http://www.efficios.com
