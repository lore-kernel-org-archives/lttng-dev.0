From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Use autoconf AM_MAINTAINER_MODE.
Date: Wed, 12 Mar 2014 18:59:37 +0000 (UTC)
Message-ID: <507471820.1743.1394650777447.JavaMail.zimbra__15601.4789631174$1394650889$gmane$org@efficios.com>
References: <1394615117-2388-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WNoNN-0002Po-Q3
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 14:59:46 -0400
In-Reply-To: <1394615117-2388-1-git-send-email-larper@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lars Persson <lars.persson@axis.com>
Cc: lttng-dev@lists.lttng.org, Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Lars Persson" <lars.persson@axis.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Lars Persson" <larper@axis.com>
> Sent: Wednesday, March 12, 2014 5:05:17 AM
> Subject: [lttng-dev] [PATCH babeltrace] Use autoconf AM_MAINTAINER_MODE.
> 
> Give distribution maintainers the option to skip rebuilding
> autoconf and automake generated files. The default behaviour
> is still to have the rebuild rules enabled.

I just did some reading on this, and found:

http://blogs.gnome.org/desrt/2011/09/08/am_maintainer_mode-is-not-cool/

So, in what use-case is --disable-maintainer-mode useful nowadays ? All
it seems to do is to stop ensuring that Makefile are consistent with changes
to Makefile.am.

Thanks,

Mathieu

> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  configure.ac |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 7a98612..faa3f98 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -11,6 +11,7 @@ AC_CONFIG_AUX_DIR([config])
>  AC_CANONICAL_TARGET
>  AC_CANONICAL_HOST
>  AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip])
> +AM_MAINTAINER_MODE([enable])
>  m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>  
>  AC_CONFIG_MACRO_DIR([m4])
> --
> 1.7.2.5
> 
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
