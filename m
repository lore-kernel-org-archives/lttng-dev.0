From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: add missing ust-elf.h header
	to dist
Date: Fri, 4 Sep 2015 04:38:42 +0000 (UTC)
Message-ID: <728373014.36317.1441341522409.JavaMail.zimbra__46906.5937948928$1441341597$gmane$org@efficios.com>
References: <1441311281-3561-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZXim8-0008Hj-FQ
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 00:39:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C70ED3403A2
 for <lttng-dev@lists.lttng.org>; Fri,  4 Sep 2015 04:38:51 +0000 (UTC)
In-Reply-To: <1441311281-3561-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master, thanks!

Mathieu

----- On Sep 3, 2015, at 4:14 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> include/Makefile.am | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/Makefile.am b/include/Makefile.am
> index 44102ef..3c9cf24 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -24,7 +24,8 @@ nobase_include_HEADERS = \
> 	lttng/tracelog.h \
> 	lttng/lttng-ust-tracelog.h \
> 	lttng/ust-clock.h \
> -	lttng/ust-getcpu.h
> +	lttng/ust-getcpu.h \
> +	lttng/ust-elf.h
> 
> # note: usterr-signal-safe.h, core.h and share.h need namespace cleanup.
> 
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
