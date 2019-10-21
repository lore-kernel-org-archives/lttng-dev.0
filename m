From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] fix: document proper liburcu
 version dependency
Date: Mon, 21 Oct 2019 14:38:24 -0400 (EDT)
Message-ID: <1397938997.1937.1571683104105.JavaMail.zimbra__27082.7243382641$1571683147$gmane$org@efficios.com>
References: <20191021170431.9141-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46xll46hDsz1QTs
 for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2019 14:38:24 -0400 (EDT)
In-Reply-To: <20191021170431.9141-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into UST 2.11, master, thanks!

Mathieu

----- On Oct 21, 2019, at 1:04 PM, Michael Jeanson mjeanson@efficios.com wrote:

> ---
> README.md | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README.md b/README.md
> index ff491701..fc2cc6c0 100644
> --- a/README.md
> +++ b/README.md
> @@ -11,7 +11,7 @@ user space tracing helpers for any application.
> Prerequisites
> -------------
> 
> -LTTng-UST depends on [liburcu](http://liburcu.org/) v0.7.2 at build and
> +LTTng-UST depends on **[liburcu](http://liburcu.org/) >= 0.11** at build and
> run times. It also optionally depends on libnuma.
> 
> 
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
