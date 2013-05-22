From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add parameter -f to rm
	in	Makefile clean target
Date: Wed, 22 May 2013 13:24:06 -0400
Message-ID: <20130522172405.GB14069__46057.0730072961$1369243481$gmane$org@Krystal>
References: <1369243114-26735-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UfClj-0002qs-6Z
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 13:24:07 -0400
Content-Disposition: inline
In-Reply-To: <1369243114-26735-1-git-send-email-simon.marchi@polymtl.ca>
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
> If the files we want to delete do not exist (for example after a failed
> build), the make clean fails.

merged, thanks!

Mathieu

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  liblttng-ust-java/Makefile.am | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/liblttng-ust-java/Makefile.am b/liblttng-ust-java/Makefile.am
> index 4c998dc..57b9532 100644
> --- a/liblttng-ust-java/Makefile.am
> +++ b/liblttng-ust-java/Makefile.am
> @@ -11,8 +11,8 @@ liblttng_ust_java_la_LIBADD = -lc -L$(top_builddir)/liblttng-ust/.libs -llttng-u
>  all: LTTngUst.class org_lttng_ust_LTTngUst.h liblttng-ust-java.jar
>  
>  clean-local:
> -	rm org_lttng_ust_LTTngUst.h
> -	rm liblttng-ust-java.jar
> +	rm -f org_lttng_ust_LTTngUst.h
> +	rm -f liblttng-ust-java.jar
>  	rm -rf org/
>  
>  LTTngUst.c: org_lttng_ust_LTTngUst.h
> -- 
> 1.8.1.2
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
