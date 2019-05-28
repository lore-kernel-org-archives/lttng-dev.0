From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-ust RFC v3] Add setuid wrappers for per-UID
 buffers
Date: Tue, 28 May 2019 10:02:43 -0400 (EDT)
Message-ID: <914116098.15558.1559052163427.JavaMail.zimbra__8265.81749586097$1559052193$gmane$org@efficios.com>
References: <20190527215101.13744-1-gabriel.pollo-guilbert@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45CwXP6X3cz12FH
 for <lttng-dev@lists.lttng.org>; Tue, 28 May 2019 10:02:45 -0400 (EDT)
In-Reply-To: <20190527215101.13744-1-gabriel.pollo-guilbert@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 27, 2019, at 5:51 PM, Gabriel-Andrew Pollo-Guilbert gabriel.pollo-guilbert@efficios.com wrote:

> In case of a per-UID buffer, events following a change of user ID should be
> forwarded to buffers of the new UID. In order to do so, we add a wrapper around
> setuid(3), setreuid(3) and setresuid(2) that unregister and re-register the
> application from the session daemon.
> 
> While there exist some other functions such as seteuid(3) or setfsuid(2), we
> don't need to add a wrapper for them since they do not edit the real user ID,
> the actual ID returned by getuid(3) and used for creating the buffers.

The general approach looks good.

The missing part is adding tests within lttng-tools "destructive" tests (because
they will likely change the system configuration to add users (?)).

One nit below since we are here...

> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index 61dbb41b..0d0b9eb4 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -225,10 +225,12 @@ void ust_unlock(void)
>  *   daemon problems).
>  */
> static sem_t constructor_wait;
> +
> /*
>  * Doing this for both the global and local sessiond.
>  */
> -static int sem_count = { 2 };
> +#define LTTNG_UST_INIT_SEM_COUNT 2

I know I'm the one who asked for a #define, but in general, it's better
to use:

enum { LTTNG_UST_INIT_SEM_COUNT = 2 };

So we do not pollute the preprocessor namespace (e.g. output of gcc -dM -E file.c).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
