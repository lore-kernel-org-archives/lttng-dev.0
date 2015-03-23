From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: oot build: missing
	top_builddir include.
Date: Mon, 23 Mar 2015 20:52:12 +0000 (UTC)
Message-ID: <1873775305.81643.1427143932504.JavaMail.zimbra__35383.29835651$1427144003$gmane$org@efficios.com>
References: <1427139477-14363-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ya9Kc-0001bD-Ko
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 16:52:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 88CDA340290
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2015 20:52:23 +0000 (UTC)
In-Reply-To: <1427139477-14363-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> lttng/tracepoint.h need lttng/ust-config.h which is
> generated on build. When in oot build mode ust_config.h is located in
> $(top_builddir)/include/. Only $(top_srcdir)/include/ was defined as
> includes source.
> 
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  liblttng-ust-python-agent/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust-python-agent/Makefile.am
> b/liblttng-ust-python-agent/Makefile.am
> index 4b34964..8b38132 100644
> --- a/liblttng-ust-python-agent/Makefile.am
> +++ b/liblttng-ust-python-agent/Makefile.am
> @@ -1,5 +1,5 @@
>  
> -AM_CPPFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/
> +AM_CPPFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/
> -I$(top_builddir)/include/
>  AM_CFLAGS = -fno-strict-aliasing
>  
>  EXTRA_DIST = lttng_agent.py.in
> --
> 2.1.4
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
