From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: namespace our gettid wrapper
Date: Mon, 3 Jun 2019 17:40:43 -0400 (EDT)
Message-ID: <542119639.26055.1559598043121.JavaMail.zimbra__28933.9609489375$1559598086$gmane$org@efficios.com>
References: <20190603192532.18903-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45HpQ52Jnvz10j8
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jun 2019 17:40:44 -0400 (EDT)
In-Reply-To: <20190603192532.18903-1-mjeanson@efficios.com>
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

Merged into master, backported to 2.11, 2.10, 2.9 branches, thanks!

Mathieu

----- On Jun 3, 2019, at 3:25 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Since glibc 2.30, a gettid wrapper was added that conflicts with our
> static declaration. Namespace our wrapper so there is no conflict,
> we'll add support for the glibc provided wrapper in a further commit.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> include/lttng/ust-tid.h           | 12 +++++++-----
> include/usterr-signal-safe.h      |  2 +-
> liblttng-ust/lttng-context-vtid.c |  2 +-
> 3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/lttng/ust-tid.h b/include/lttng/ust-tid.h
> index e669d7e7..e637718a 100644
> --- a/include/lttng/ust-tid.h
> +++ b/include/lttng/ust-tid.h
> @@ -31,23 +31,25 @@
> #include <syscall.h>
> #endif
> 
> -#if defined(_syscall0)
> -_syscall0(pid_t, gettid)
> -#elif defined(__NR_gettid)
> +#if defined(__NR_gettid)
> +
> #include <unistd.h>
> -static inline pid_t gettid(void)
> +static inline pid_t lttng_gettid(void)
> {
> 	return syscall(__NR_gettid);
> }
> +
> #else
> +
> #include <sys/types.h>
> #include <unistd.h>
> 
> /* Fall-back on getpid for tid if not available. */
> -static inline pid_t gettid(void)
> +static inline pid_t lttng_gettid(void)
> {
> 	return getpid();
> }
> +
> #endif
> 
> #endif /* _LTTNG_UST_TID_H */
> diff --git a/include/usterr-signal-safe.h b/include/usterr-signal-safe.h
> index 1df5ada0..d987c1f0 100644
> --- a/include/usterr-signal-safe.h
> +++ b/include/usterr-signal-safe.h
> @@ -95,7 +95,7 @@ do {									\
> 	do {					\
> 		sigsafe_print_err(UST_STR_COMPONENT "[%ld/%ld]: " fmt " (in %s() at " __FILE__
> 		":" UST_XSTR(__LINE__) ")\n", \
> 		(long) getpid(),		\
> -		(long) gettid(),		\
> +		(long) lttng_gettid(),		\
> 		## args, __func__);		\
> 	} while(0)
> 
> diff --git a/liblttng-ust/lttng-context-vtid.c
> b/liblttng-ust/lttng-context-vtid.c
> index 80661f63..36e5695d 100644
> --- a/liblttng-ust/lttng-context-vtid.c
> +++ b/liblttng-ust/lttng-context-vtid.c
> @@ -63,7 +63,7 @@ pid_t wrapper_getvtid(void)
> 
> 	vtid = CMM_LOAD_SHARED(URCU_TLS(cached_vtid));
> 	if (caa_unlikely(!vtid)) {
> -		vtid = gettid();
> +		vtid = lttng_gettid();
> 		CMM_STORE_SHARED(URCU_TLS(cached_vtid), vtid);
> 	}
> 	return vtid;
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
