From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] Escape minus signs in
 lttng-ust-cyg-profile	manpage
Date: Fri, 15 Nov 2013 15:35:20 +0000 (UTC)
Message-ID: <1540723835.68249.1384529720251.JavaMail.zimbra__28581.4808834859$1384529869$gmane$org@efficios.com>
References: <20131115141247.GA1634@shaniqua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VhLQX-0002tZ-LR
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 10:35:27 -0500
In-Reply-To: <20131115141247.GA1634@shaniqua>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@tuxion.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Jon Bernard" <jbernard@tuxion.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, November 15, 2013 9:12:47 AM
> Subject: [lttng-dev] [PATCH 2/2] Escape minus signs in lttng-ust-cyg-profile	manpage

merged into master, 2.3, 2.2, thanks!

Mathieu

> 
> By default, "-" chars are interpreted as hyphens (U+2010) by groff, not
> as minus signs (U+002D). Since options to programs use minus signs
> (U+002D), this means for example in UTF-8 locales that you cannot cut
> and paste options, nor search for them easily.
> 
> Source: http://lintian.debian.org/tags/hyphen-used-as-minus-sign.html
> 
> Signed-off-by: Jon Bernard <jbernard@tuxion.com>
> ---
>  doc/man/lttng-ust-cyg-profile.3 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/man/lttng-ust-cyg-profile.3
> b/doc/man/lttng-ust-cyg-profile.3
> index fa8cf4f..341d3ae 100644
> --- a/doc/man/lttng-ust-cyg-profile.3
> +++ b/doc/man/lttng-ust-cyg-profile.3
> @@ -43,7 +43,7 @@ call site address are recorded as
> lttng_ust_cyg_profile:func_entry and
>  lttng_ust_cyg_profile:func_exit.
>  .SH "USAGE"
>  To use function tracing you need to make sure the sources of your
>  application
> -are compiled with -finstrument-functions. It might be necessary to limit
> +are compiled with \-finstrument\-functions. It might be necessary to limit
>  the number of source files where this option is used to prevent excessive
>  amount of trace data to be generated during run time. Usually there are
>  additional compiler flags that allow you to specify more fine grained
>  selection
> --
> 1.8.4.rc3
> 
> 
> --
> Jon
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
