Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBDAC43334
	for <lttng-dev@archiver.kernel.org>; Tue, 19 Jul 2022 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658259577;
	bh=1Zg3cTTNa3wxorhwe0ch7MTrZBxrfHvu9qvwfNRli8s=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Gu6Vmuzd9QOOmVxYH9Gadrz9f9UGCC7nS7MIYIgk2uTSr/+dYtpT0ZD71STxM0Elc
	 m81A6o09qp5zEmwUq0BlS0QAuIYLGlcUGK6gvvI2sdNKH6geNLg3FL11Rw6KdOQold
	 xN+r11w+fPrdjOqfRe7ri2HlarRp691p1VstCXeFCG3vo5gqSYlfUjZmzkTepGvha/
	 KzHhQoIPq/YWDF8sqGjMAcU48UgM8X2CQ4dM+aOXKGgkoPvFRGwimE6ubDQyBTQHhL
	 gySJHIdmA7taCwTafsSFuWRn2kulcnpZKix1bwhi7tg9sdeRYGLuw77kWcXxfOOTsT
	 qEZAxgy2NTFAg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LnTgD3WLMzPNj;
	Tue, 19 Jul 2022 15:39:36 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LnTgC20nVzPXD
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2022 15:39:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E953143138A
 for <lttng-dev@lists.lttng.org>; Tue, 19 Jul 2022 15:39:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id MIo2fWiL4cF7; Tue, 19 Jul 2022 15:39:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3FE90430FD3;
 Tue, 19 Jul 2022 15:39:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3FE90430FD3
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id C7SzIH-GVNxE; Tue, 19 Jul 2022 15:39:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 333B543111A;
 Tue, 19 Jul 2022 15:39:33 -0400 (EDT)
Date: Tue, 19 Jul 2022 15:39:33 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1399876011.74159.1658259573115.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220718215955.124991-1-nolange79@gmail.com>
References: <20220718215955.124991-1-nolange79@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: lttng_ust_init_thread: initialise cached context values
Thread-Index: 1ueMvWDwjqb1Nl2Ku9SkEUvymyrpXw==
Subject: Re: [lttng-dev] [PATCH 1/2] lttng_ust_init_thread: initialise
 cached context values
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jul 18, 2022, at 5:59 PM, Norbert Lange via lttng-dev lttng-dev@lists.lttng.org wrote:

> Modify all relevant *_alloc_tls functions so that they take an
> argument for 'init'. Setting this to 'true' will read
> the actual context value and store it into a thread local
> cache.
> 
> The function 'lttng_ust_init_thread' will use this to
> precalculate context values. Tracepoints can then avoid
> systemcalls.

Rather than integrating two unrelated things within "alloc_tls"
functions, I would prefer that we split things like this, e.g.:

keep lttng_cgroup_ns_alloc_tls() as is.

Introduce lttng_ust_cgroup_init_thread() which would
call (void)get_cgroup_ns().

Likewise for all other contexts.

Thoughts ?

Thanks,

Mathieu


> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>
> ---
> *   see
> https://lore.kernel.org/all/CADYdroN3=pAe66crtsVT9aHE4T+bT61-tvHFKCuwZYkHhuyFjw@mail.gmail.com/
> *   Will update docs after review, and do some more tests
>    during the week
> ---
> src/lib/lttng-ust/lttng-context-cgroup-ns.c |  4 +++-
> src/lib/lttng-ust/lttng-context-ipc-ns.c    |  4 +++-
> src/lib/lttng-ust/lttng-context-net-ns.c    |  4 +++-
> src/lib/lttng-ust/lttng-context-procname.c  |  4 +++-
> src/lib/lttng-ust/lttng-context-provider.c  |  4 ++--
> src/lib/lttng-ust/lttng-context-time-ns.c   |  4 +++-
> src/lib/lttng-ust/lttng-context-uts-ns.c    |  4 +++-
> src/lib/lttng-ust/lttng-context-vtid.c      |  4 +++-
> src/lib/lttng-ust/lttng-probes.c            |  4 ++--
> src/lib/lttng-ust/lttng-tracer-core.h       | 16 +++++++-------
> src/lib/lttng-ust/lttng-ust-comm.c          | 24 ++++++++++-----------
> src/lib/lttng-ust/lttng-ust-statedump.c     |  2 +-
> 12 files changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/src/lib/lttng-ust/lttng-context-cgroup-ns.c
> b/src/lib/lttng-ust/lttng-context-cgroup-ns.c
> index 34523ea1..3eb5ab5b 100644
> --- a/src/lib/lttng-ust/lttng-context-cgroup-ns.c
> +++ b/src/lib/lttng-ust/lttng-context-cgroup-ns.c
> @@ -155,7 +155,9 @@ error_find_context:
> /*
>  * Force a read (imply TLS allocation for dlopen) of TLS variables.
>  */
> -void lttng_cgroup_ns_alloc_tls(void)
> +void lttng_cgroup_ns_alloc_tls(bool init)
> {
> 	asm volatile ("" : : "m" (URCU_TLS(cached_cgroup_ns)));
> +	if (init)
> +		(void)get_cgroup_ns();
> }
> diff --git a/src/lib/lttng-ust/lttng-context-ipc-ns.c
> b/src/lib/lttng-ust/lttng-context-ipc-ns.c
> index 63401e8d..b68b939f 100644
> --- a/src/lib/lttng-ust/lttng-context-ipc-ns.c
> +++ b/src/lib/lttng-ust/lttng-context-ipc-ns.c
> @@ -153,7 +153,9 @@ error_find_context:
> /*
>  * Force a read (imply TLS allocation for dlopen) of TLS variables.
>  */
> -void lttng_ipc_ns_alloc_tls(void)
> +void lttng_ipc_ns_alloc_tls(bool init)
> {
> 	asm volatile ("" : : "m" (URCU_TLS(cached_ipc_ns)));
> +	if (init)
> +		(void)get_ipc_ns();
> }
> diff --git a/src/lib/lttng-ust/lttng-context-net-ns.c
> b/src/lib/lttng-ust/lttng-context-net-ns.c
> index 960591c2..93e574ad 100644
> --- a/src/lib/lttng-ust/lttng-context-net-ns.c
> +++ b/src/lib/lttng-ust/lttng-context-net-ns.c
> @@ -153,7 +153,9 @@ error_find_context:
> /*
>  * Force a read (imply TLS allocation for dlopen) of TLS variables.
>  */
> -void lttng_net_ns_alloc_tls(void)
> +void lttng_net_ns_alloc_tls(bool init)
> {
> 	asm volatile ("" : : "m" (URCU_TLS(cached_net_ns)));
> +	if (init)
> +		(void)get_net_ns();
> }
> diff --git a/src/lib/lttng-ust/lttng-context-procname.c
> b/src/lib/lttng-ust/lttng-context-procname.c
> index b5bf77be..95f6fe42 100644
> --- a/src/lib/lttng-ust/lttng-context-procname.c
> +++ b/src/lib/lttng-ust/lttng-context-procname.c
> @@ -122,7 +122,9 @@ error_find_context:
> /*
>  * Force a read (imply TLS allocation for dlopen) of TLS variables.
>  */
> -void lttng_procname_alloc_tls(void)
> +void lttng_procname_alloc_tls(bool init)
> {
> 	asm volatile ("" : : "m" (URCU_TLS(cached_procname)[0]));
> +	if (init)
> +		(void)wrapper_getprocname();
> }
> diff --git a/src/lib/lttng-ust/lttng-context-provider.c
> b/src/lib/lttng-ust/lttng-context-provider.c
> index 4e7e429f..ba24aad7 100644
> --- a/src/lib/lttng-ust/lttng-context-provider.c
> +++ b/src/lib/lttng-ust/lttng-context-provider.c
> @@ -67,7 +67,7 @@ struct lttng_ust_registered_context_provider
> *lttng_ust_context_provider_registe
> 	size_t name_len = strlen(provider->name);
> 	uint32_t hash;
> 
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 
> 	/* Provider name starts with "$app.". */
> 	if (strncmp("$app.", provider->name, strlen("$app.")) != 0)
> @@ -101,7 +101,7 @@ end:
> 
> void lttng_ust_context_provider_unregister(struct
> lttng_ust_registered_context_provider *reg_provider)
> {
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 
> 	if (ust_lock())
> 		goto end;
> diff --git a/src/lib/lttng-ust/lttng-context-time-ns.c
> b/src/lib/lttng-ust/lttng-context-time-ns.c
> index ec32a1de..a957409b 100644
> --- a/src/lib/lttng-ust/lttng-context-time-ns.c
> +++ b/src/lib/lttng-ust/lttng-context-time-ns.c
> @@ -152,7 +152,9 @@ error_find_context:
> /*
>  * Force a read (imply TLS allocation for dlopen) of TLS variables.
>  */
> -void lttng_time_ns_alloc_tls(void)
> +void lttng_time_ns_alloc_tls(bool init)
> {
> 	asm volatile ("" : : "m" (URCU_TLS(cached_time_ns)));
> +	if (init)
> +		(void)get_time_ns();
> }
> diff --git a/src/lib/lttng-ust/lttng-context-uts-ns.c
> b/src/lib/lttng-ust/lttng-context-uts-ns.c
> index 06a978fd..0c802188 100644
> --- a/src/lib/lttng-ust/lttng-context-uts-ns.c
> +++ b/src/lib/lttng-ust/lttng-context-uts-ns.c
> @@ -154,7 +154,9 @@ error_find_context:
> /*
>  * Force a read (imply TLS allocation for dlopen) of TLS variables.
>  */
> -void lttng_uts_ns_alloc_tls(void)
> +void lttng_uts_ns_alloc_tls(bool init)
> {
> 	asm volatile ("" : : "m" (URCU_TLS(cached_uts_ns)));
> +	if (init)
> +		(void)get_uts_ns();
> }
> diff --git a/src/lib/lttng-ust/lttng-context-vtid.c
> b/src/lib/lttng-ust/lttng-context-vtid.c
> index 880e34b9..d3c9863e 100644
> --- a/src/lib/lttng-ust/lttng-context-vtid.c
> +++ b/src/lib/lttng-ust/lttng-context-vtid.c
> @@ -112,7 +112,9 @@ error_find_context:
> /*
>  * Force a read (imply TLS allocation for dlopen) of TLS variables.
>  */
> -void lttng_vtid_alloc_tls(void)
> +void lttng_vtid_alloc_tls(bool init)
> {
> 	asm volatile ("" : : "m" (URCU_TLS(cached_vtid)));
> +	if (init)
> +		(void)wrapper_getvtid();
> }
> diff --git a/src/lib/lttng-ust/lttng-probes.c b/src/lib/lttng-ust/lttng-probes.c
> index e8e08ff1..314cb7a0 100644
> --- a/src/lib/lttng-ust/lttng-probes.c
> +++ b/src/lib/lttng-ust/lttng-probes.c
> @@ -231,7 +231,7 @@ struct lttng_ust_registered_probe
> *lttng_ust_probe_register(const struct lttng_u
> {
> 	struct lttng_ust_registered_probe *reg_probe = NULL;
> 
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 
> 	/*
> 	 * If version mismatch, don't register, but don't trigger assert
> @@ -269,7 +269,7 @@ end:
> 
> void lttng_ust_probe_unregister(struct lttng_ust_registered_probe *reg_probe)
> {
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 
> 	if (!reg_probe)
> 		return;
> diff --git a/src/lib/lttng-ust/lttng-tracer-core.h
> b/src/lib/lttng-ust/lttng-tracer-core.h
> index eadc43ed..dbb3bd9f 100644
> --- a/src/lib/lttng-ust/lttng-tracer-core.h
> +++ b/src/lib/lttng-ust/lttng-tracer-core.h
> @@ -34,28 +34,28 @@ void ust_lock_nocheck(void)
> void ust_unlock(void)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_ust_alloc_tls(void)
> +void lttng_ust_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_vtid_alloc_tls(void)
> +void lttng_vtid_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_procname_alloc_tls(void)
> +void lttng_procname_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_cgroup_ns_alloc_tls(void)
> +void lttng_cgroup_ns_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_ipc_ns_alloc_tls(void)
> +void lttng_ipc_ns_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_net_ns_alloc_tls(void)
> +void lttng_net_ns_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_time_ns_alloc_tls(void)
> +void lttng_time_ns_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> -void lttng_uts_ns_alloc_tls(void)
> +void lttng_uts_ns_alloc_tls(bool init)
> 	__attribute__((visibility("hidden")));
> 
> const char *lttng_ust_obj_get_name(int id)
> diff --git a/src/lib/lttng-ust/lttng-ust-comm.c
> b/src/lib/lttng-ust/lttng-ust-comm.c
> index 7f34efe7..ba0bd985 100644
> --- a/src/lib/lttng-ust/lttng-ust-comm.c
> +++ b/src/lib/lttng-ust/lttng-ust-comm.c
> @@ -407,21 +407,21 @@ void lttng_lttng_ust_urcu_alloc_tls(void)
> 	(void) lttng_ust_urcu_read_ongoing();
> }
> 
> -void lttng_ust_alloc_tls(void)
> +void lttng_ust_alloc_tls(bool init)
> {
> 	lttng_lttng_ust_urcu_alloc_tls();
> 	lttng_ringbuffer_alloc_tls();
> -	lttng_vtid_alloc_tls();
> +	lttng_vtid_alloc_tls(init);
> 	lttng_nest_count_alloc_tls();
> -	lttng_procname_alloc_tls();
> +	lttng_procname_alloc_tls(init);
> 	lttng_ust_mutex_nest_alloc_tls();
> 	lttng_ust_perf_counter_alloc_tls();
> 	lttng_ust_common_alloc_tls();
> -	lttng_cgroup_ns_alloc_tls();
> -	lttng_ipc_ns_alloc_tls();
> -	lttng_net_ns_alloc_tls();
> -	lttng_time_ns_alloc_tls();
> -	lttng_uts_ns_alloc_tls();
> +	lttng_cgroup_ns_alloc_tls(init);
> +	lttng_ipc_ns_alloc_tls(init);
> +	lttng_net_ns_alloc_tls(init);
> +	lttng_time_ns_alloc_tls(init);
> +	lttng_uts_ns_alloc_tls(init);
> 	lttng_ust_ring_buffer_client_discard_alloc_tls();
> 	lttng_ust_ring_buffer_client_discard_rt_alloc_tls();
> 	lttng_ust_ring_buffer_client_overwrite_alloc_tls();
> @@ -446,7 +446,7 @@ void lttng_ust_init_thread(void)
> 	 * ensure those are initialized before a signal handler nesting over
> 	 * this thread attempts to use them.
> 	 */
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(true);
> }
> 
> int lttng_get_notify_socket(void *owner)
> @@ -1815,7 +1815,7 @@ void *ust_listener_thread(void *arg)
> 	int sock, ret, prev_connect_failed = 0, has_waited = 0, fd;
> 	long timeout;
> 
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 	/*
> 	 * If available, add '-ust' to the end of this thread's
> 	 * process name
> @@ -2183,7 +2183,7 @@ void lttng_ust_ctor(void)
> 	 * to be the dynamic linker mutex) and ust_lock, taken within
> 	 * the ust lock.
> 	 */
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 
> 	lttng_ust_loaded = 1;
> 
> @@ -2497,7 +2497,7 @@ void lttng_ust_before_fork(sigset_t *save_sigset)
> 	int ret;
> 
> 	/* Allocate lttng-ust TLS. */
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 
> 	if (URCU_TLS(lttng_ust_nest_count))
> 		return;
> diff --git a/src/lib/lttng-ust/lttng-ust-statedump.c
> b/src/lib/lttng-ust/lttng-ust-statedump.c
> index 309a98fa..ee180a0d 100644
> --- a/src/lib/lttng-ust/lttng-ust-statedump.c
> +++ b/src/lib/lttng-ust/lttng-ust-statedump.c
> @@ -557,7 +557,7 @@ void lttng_ust_dl_update(void *ip)
> 	 * Force the allocation of lttng-ust TLS variables when called from
> 	 * dlopen/dlclose instrumentation.
> 	 */
> -	lttng_ust_alloc_tls();
> +	lttng_ust_alloc_tls(false);
> 
> 	data.exec_found = 0;
> 	data.first = true;
> --
> 2.35.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
