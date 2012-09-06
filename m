From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] fix timestamps on architectures
	without	CONFIG_KTIME_SCALAR
Date: Thu, 6 Sep 2012 10:27:27 -0400
Message-ID: <20120906142726.GJ3630__31143.4570503936$1346941670$gmane$org@Krystal>
References: <1346340992-27307-1-git-send-email-gerlando.falauto@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9d3I-0005LJ-KC
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 10:27:28 -0400
Content-Disposition: inline
In-Reply-To: <1346340992-27307-1-git-send-email-gerlando.falauto@keymile.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Gerlando Falauto (gerlando.falauto@keymile.com) wrote:
> trace_clock_monotonic_wrapper() should return a u64 representing the
> number of nanoseconds since system startup.
> ktime_get() provides that value directly within its .tv64 field only
> on those architectures defining CONFIG_KTIME_SCALAR, whereas in all
> other cases (e.g. PowerPC) a ktime_to_ns() conversion (which
> translates back to .tv64 when CONFIG_KTIME_SCALAR is defined)
> becomes necessary.

merged!

Will make its way into stable-2.0 too.

Thanks!

Mathieu

> 
> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
> ---
>  wrapper/trace-clock.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wrapper/trace-clock.h b/wrapper/trace-clock.h
> index 6ea9e81..bced61c 100644
> --- a/wrapper/trace-clock.h
> +++ b/wrapper/trace-clock.h
> @@ -46,7 +46,7 @@ static inline u64 trace_clock_monotonic_wrapper(void)
>  		return (u64) -EIO;
>  
>  	ktime = ktime_get();
> -	return (u64) ktime.tv64;
> +	return ktime_to_ns(ktime);
>  }
>  
>  static inline u32 trace_clock_read32(void)
> -- 
> 1.7.10.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
