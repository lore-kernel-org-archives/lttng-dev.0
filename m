From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 1/2] Fix: missing define when not
 building with gcc
Date: Thu, 4 Jul 2019 14:54:46 -0400 (EDT)
Message-ID: <1011124575.4180.1562266486484.JavaMail.zimbra__42455.4214043141$1562266499$gmane$org@efficios.com>
References: <20190704185137.24943-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45fnGH27j2z10Yv
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 14:54:47 -0400 (EDT)
In-Reply-To: <20190704185137.24943-1-jonathan.rajotte-julien@efficios.com>
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

Both patches merged into master, 2.11, 2.10, 2.9, thanks!

Mathieu

----- On Jul 4, 2019, at 2:51 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> include/lttng/bitfield.h | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/include/lttng/bitfield.h b/include/lttng/bitfield.h
> index 7faf23f9..92f1c2c9 100644
> --- a/include/lttng/bitfield.h
> +++ b/include/lttng/bitfield.h
> @@ -59,6 +59,7 @@
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
