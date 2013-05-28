From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] Support old compilers
Date: Tue, 28 May 2013 13:32:50 -0400
Message-ID: <20130528173250.GE20859__29427.2677427672$1369762402$gmane$org@Krystal>
References: <1369747627-21626-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1369747627-21626-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UhNlV-00039e-15
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 13:32:53 -0400
Content-Disposition: inline
In-Reply-To: <1369747627-21626-2-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Thomas Petazzoni (thomas.petazzoni@free-electrons.com) wrote:
> Some old compilers do not use C99 as their default C language variant,
> for example gcc 4.3.x, which is used on some old machines. When such a
> compiler is used, by default, ULLONG_MAX is not visible. Adding
> -std=gnu99 is needed to make this definition visible.
> 
> In autoconf speak, this translates into the need of using
> AC_PROC_CC_STDC instead of AC_PROG_CC. See
> http://www.gnu.org/software/autoconf/manual/autoconf-2.65/html_node/C-Compiler.html
> for more details.

merged, thanks!

Mathieu

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  configure.ac |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 83822d6..3ddcb7c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -17,7 +17,7 @@ AC_CONFIG_HEADERS([config.h])
>  AC_SYS_LARGEFILE
>  
>  # Checks for programs.
> -AC_PROG_CC
> +AC_PROG_CC_STDC
>  AC_PROG_MAKE_SET
>  LT_INIT
>  AC_PROG_YACC
> -- 
> 1.7.9.5
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
