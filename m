From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 2/2] Fix: out-of-tree build: wrong
 file path for sed input
Date: Mon, 26 Jan 2015 17:24:39 +0000 (UTC)
Message-ID: <1341432595.52845.1422293079501.JavaMail.zimbra__4779.20807102254$1422293111$gmane$org@efficios.com>
References: <1422291031-28246-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1422291031-28246-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YFnOx-0005i3-KV
 for lttng-dev@lists.lttng.org; Mon, 26 Jan 2015 12:24:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 182193401D5
 for <lttng-dev@lists.lttng.org>; Mon, 26 Jan 2015 17:24:41 +0000 (UTC)
In-Reply-To: <1422291031-28246-2-git-send-email-jonathan.rajotte-julien@efficios.com>
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

All merged into master, thanks!

Mathieu

----- Original Message -----
> From: "Jonathan Rajotte" <jonathan.rajotte-julien@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "Jonathan Rajotte" <jonathan.rajotte-julien@efficios.com>
> Sent: Monday, January 26, 2015 11:50:31 AM
> Subject: [PATCH lttng-ust 2/2] Fix: out-of-tree build: wrong file path for sed input
> 
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  liblttng-ust-python-agent/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust-python-agent/Makefile.am
> b/liblttng-ust-python-agent/Makefile.am
> index 5d5b6ab..4b34964 100644
> --- a/liblttng-ust-python-agent/Makefile.am
> +++ b/liblttng-ust-python-agent/Makefile.am
> @@ -15,6 +15,6 @@ liblttng_ust_python_agent_la_LIBADD = -lc -llttng-ust \
>  		-L$(top_builddir)/liblttng-ust/.libs
>  
>  all:
> -	$(SED) 's|LIBDIR_STR|$(libdir)|g' < lttng_agent.py.in > lttng_agent.py
> +	$(SED) 's|LIBDIR_STR|$(libdir)|g' < $(srcdir)/lttng_agent.py.in >
> lttng_agent.py
>  
>  CLEANFILES = lttng_agent.py
> --
> 1.9.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
