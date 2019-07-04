From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/2] Fix: missing define when
 not building with gcc
Date: Thu, 4 Jul 2019 16:14:49 -0400 (EDT)
Message-ID: <6777082.4587.1562271289886.JavaMail.zimbra__30284.2423015804$1562271305$gmane$org@efficios.com>
References: <20190704200213.21186-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45fq2g10QHz10gc
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 16:14:50 -0400 (EDT)
In-Reply-To: <20190704200213.21186-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Both merged into master, 2.11, 2.10, 2.9, thanks!

Mathieu

----- On Jul 4, 2019, at 4:02 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> lib/bitfield.h | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/lib/bitfield.h b/lib/bitfield.h
> index 2f7c01d..ebbe754 100644
> --- a/lib/bitfield.h
> +++ b/lib/bitfield.h
> @@ -44,6 +44,7 @@
> # define _BT_DIAG_PUSH
> # define _BT_DIAG_POP
> # define _BT_DIAG_IGNORE
> +# define _BT_DIAG_IGNORE_TYPE_LIMITS
> #endif
> 
> #define _bt_is_signed_type(type)	((type) -1 < (type) 0)
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
