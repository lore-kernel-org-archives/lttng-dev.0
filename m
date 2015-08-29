From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: build failure on 2.6.36
Date: Sat, 29 Aug 2015 21:15:18 +0000 (UTC)
Message-ID: <2128637508.31661.1440882918105.JavaMail.zimbra__19221.4900664569$1440883002$gmane$org@efficios.com>
References: <1440867819-15122-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZVnTH-0003m9-8W
 for lttng-dev@lists.lttng.org; Sat, 29 Aug 2015 17:15:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7E2FB340380
 for <lttng-dev@lists.lttng.org>; Sat, 29 Aug 2015 21:15:26 +0000 (UTC)
In-Reply-To: <1440867819-15122-1-git-send-email-mjeanson@efficios.com>
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

----- On Aug 29, 2015, at 1:03 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Fixes build failure on the 2.6.36 kernel branch which misses the
> vzalloc() function.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> lttng-events.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/lttng-events.c b/lttng-events.c
> index b49851b..422a2dd 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -133,7 +133,12 @@ struct lttng_session *lttng_session_create(void)
> 			GFP_KERNEL);
> 	if (!metadata_cache)
> 		goto err_free_session;
> +#if LTTNG_KERNEL_RANGE(2,6,36, 2,6,37)
> +	metadata_cache->data = vmalloc(METADATA_CACHE_DEFAULT_SIZE);
> +	memset(metadata_cache->data, 0, METADATA_CACHE_DEFAULT_SIZE);

You need to test whether vmalloc returned NULL before writing
to it.

Moreover, I'm against putting such preprocessor conditionals
in the code. We should create a wrapper header for vzalloc
implementing lttng_vzalloc instead.

Thanks,

Mathieu

> +#else
> 	metadata_cache->data = vzalloc(METADATA_CACHE_DEFAULT_SIZE);
> +#endif
> 	if (!metadata_cache->data)
> 		goto err_free_cache;
> 	metadata_cache->cache_alloc = METADATA_CACHE_DEFAULT_SIZE;
> @@ -1531,7 +1536,12 @@ int lttng_metadata_printf(struct lttng_session *session,
> 		tmp_cache_alloc_size = max_t(unsigned int,
> 				session->metadata_cache->cache_alloc + len,
> 				session->metadata_cache->cache_alloc << 1);
> +#if LTTNG_KERNEL_RANGE(2,6,36, 2,6,37)
> +		tmp_cache_realloc = vmalloc(tmp_cache_alloc_size);
> +		memset(tmp_cache_realloc, 0, tmp_cache_alloc_size);
> +#else
> 		tmp_cache_realloc = vzalloc(tmp_cache_alloc_size);
> +#endif
> 		if (!tmp_cache_realloc)
> 			goto err;
> 		if (session->metadata_cache->data) {
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
