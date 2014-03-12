From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Support out of tree builds
 in	babeltrace.
Date: Wed, 12 Mar 2014 18:52:35 +0000 (UTC)
Message-ID: <2017755101.1736.1394650355257.JavaMail.zimbra__36724.7120746926$1394650416$gmane$org@efficios.com>
References: <1394608366-28338-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WNoGY-0002KU-TM
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 14:52:40 -0400
In-Reply-To: <1394608366-28338-1-git-send-email-larper@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lars Persson <lars.persson@axis.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>, Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

Merged, I removed the . at the end of the patch title.

Thanks,

Mathieu

----- Original Message -----
> From: "Lars Persson" <lars.persson@axis.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Lars Persson" <larper@axis.com>
> Sent: Wednesday, March 12, 2014 3:12:46 AM
> Subject: [lttng-dev] [PATCH babeltrace] Fix: Support out of tree builds in	babeltrace.
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  formats/lttng-live/Makefile.am |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/formats/lttng-live/Makefile.am b/formats/lttng-live/Makefile.am
> index c834699..2c6b0bd 100644
> --- a/formats/lttng-live/Makefile.am
> +++ b/formats/lttng-live/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
> -I$(top_builddir)/include
> +AM_CFLAGS = $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
> -I$(top_builddir)/include -I$(top_srcdir)
>  
>  lib_LTLIBRARIES = libbabeltrace-lttng-live.la
>  
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
