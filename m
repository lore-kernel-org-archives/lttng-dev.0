From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules v2] Fix: build failure on
	2.6.36
Date: Sun, 30 Aug 2015 01:09:12 +0000 (UTC)
Message-ID: <1064101723.31994.1440896952685.JavaMail.zimbra__18612.3412022882$1440897014$gmane$org@efficios.com>
References: <1440885353-1842-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZVr7c-0004v3-NG
 for lttng-dev@lists.lttng.org; Sat, 29 Aug 2015 21:09:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id F1D163401F1
 for <lttng-dev@lists.lttng.org>; Sun, 30 Aug 2015 01:09:19 +0000 (UTC)
In-Reply-To: <1440885353-1842-1-git-send-email-mjeanson@efficios.com>
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

----- On Aug 29, 2015, at 5:55 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Fixes build failure on the 2.6.36 kernel branch which misses the
> vzalloc() function.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> lttng-events.c    |  5 +++--
> wrapper/vzalloc.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 49 insertions(+), 2 deletions(-)
> create mode 100644 wrapper/vzalloc.h
> 
> diff --git a/lttng-events.c b/lttng-events.c
> index b49851b..c49174d 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -50,6 +50,7 @@
> #include "lttng-events.h"
> #include "lttng-tracer.h"
> #include "lttng-abi-old.h"
> +#include "wrapper/vzalloc.h"
> 
> #define METADATA_CACHE_DEFAULT_SIZE 4096
> 
> @@ -133,7 +134,7 @@ struct lttng_session *lttng_session_create(void)
> 			GFP_KERNEL);
> 	if (!metadata_cache)
> 		goto err_free_session;
> -	metadata_cache->data = vzalloc(METADATA_CACHE_DEFAULT_SIZE);
> +	metadata_cache->data = lttng_vzalloc(METADATA_CACHE_DEFAULT_SIZE);
> 	if (!metadata_cache->data)
> 		goto err_free_cache;
> 	metadata_cache->cache_alloc = METADATA_CACHE_DEFAULT_SIZE;
> @@ -1531,7 +1532,7 @@ int lttng_metadata_printf(struct lttng_session *session,
> 		tmp_cache_alloc_size = max_t(unsigned int,
> 				session->metadata_cache->cache_alloc + len,
> 				session->metadata_cache->cache_alloc << 1);
> -		tmp_cache_realloc = vzalloc(tmp_cache_alloc_size);
> +		tmp_cache_realloc = lttng_vzalloc(tmp_cache_alloc_size);
> 		if (!tmp_cache_realloc)
> 			goto err;
> 		if (session->metadata_cache->data) {
> diff --git a/wrapper/vzalloc.h b/wrapper/vzalloc.h
> new file mode 100644
> index 0000000..5b8f2b8
> --- /dev/null
> +++ b/wrapper/vzalloc.h
> @@ -0,0 +1,46 @@
> +#ifndef _LTTNG_WRAPPER_VZALLOC_H
> +#define _LTTNG_WRAPPER_VZALLOC_H
> +
> +/*
> + * wrapper/vzalloc.h
> + *
> + * Copyright (C) 2015 Michael Jeanson <mjeanson@efficios.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; only
> + * version 2.1 of the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <linux/version.h>
> +#include <linux/vmalloc.h>
> +
> +#if LTTNG_KERNEL_RANGE(2,6,36, 2,6,37)
> +static inline
> +void *lttng_vzalloc(unsigned long size)
> +{
> +	void *ret;
> +	ret = vmalloc(size);
> +	if (ret)
> +		memset(ret, 0, size);
> +	return ret;

It starts to look much better. Another thing to consider coding-style wise:
we always try to keep the nesting level to a minimum. It may not appear clear
why we do it for very small functions, but they have an unfortunate habit of
growing organically over time. In order to do so, whenever we detect an error
condition, we return or goto an error label, and don't usually nest the
"correct" path. This is a coding style pattern we're using throughout the
code base.

So here, I would recommend the following (replace 2 spaces by a tab):

static inline
void *lttng_vzalloc(unsigned long size)
{
  void *p;

  p = vmalloc(size);
  if (!p)
    return NULL;
  memset(p, 0, size);
  return p;
}

Thanks,

Mathieu

> +}
> +#else
> +static inline
> +void *lttng_vzalloc(unsigned long size)
> +{
> +	return vzalloc(size);
> +}
> +#endif
> +
> +
> +#endif /* _LTTNG_WRAPPER_VZALLOC_H */
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
