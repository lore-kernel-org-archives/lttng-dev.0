From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [UST PATCH 1/2] Specialize
	lttng_ust_lib_ring_buffer_client_cb
Date: Fri, 16 Aug 2013 20:17:19 -0400
Message-ID: <20130817001719.GB4233__9038.48362290791$1376698688$gmane$org@Krystal>
References: <1376696166-32632-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VAUCn-0000WS-4u
	for lttng-dev@lists.lttng.org; Fri, 16 Aug 2013 20:17:22 -0400
Content-Disposition: inline
In-Reply-To: <1376696166-32632-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> Prepare the ring-buffer config to have custom callbacks. These custom
> callbacks are not related to the ring-buffer operations but allow
> applications to add custom functions.
> No additional feature or change in behaviour in this patch.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>

Thanks!

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>  include/lttng/ringbuffer-config.h                |    4 +++-
>  include/lttng/ust-events.h                       |    6 ++---
>  liblttng-ust/Makefile.am                         |    1 +
>  liblttng-ust/lttng-rb-clients.h                  |   26 ++++++++++++++++++++++
>  liblttng-ust/lttng-ring-buffer-client.h          |   18 ++++++++++++++-
>  liblttng-ust/lttng-ring-buffer-metadata-client.h |   18 ++++++++++++++-
>  6 files changed, 67 insertions(+), 6 deletions(-)
>  create mode 100644 liblttng-ust/lttng-rb-clients.h
> 
> diff --git a/include/lttng/ringbuffer-config.h b/include/lttng/ringbuffer-config.h
> index 3b7d348..9de9a73 100644
> --- a/include/lttng/ringbuffer-config.h
> +++ b/include/lttng/ringbuffer-config.h
> @@ -133,7 +133,7 @@ struct lttng_ust_lib_ring_buffer_client_cb {
>   * RING_BUFFER_WAKEUP_NONE does not perform any wakeup whatsoever. The client
>   * has the responsibility to perform wakeups.
>   */
> -#define LTTNG_UST_RING_BUFFER_CONFIG_PADDING	32
> +#define LTTNG_UST_RING_BUFFER_CONFIG_PADDING	20
>  
>  enum lttng_ust_lib_ring_buffer_alloc_types {
>  	RING_BUFFER_ALLOC_PER_CPU,
> @@ -204,6 +204,8 @@ struct lttng_ust_lib_ring_buffer_config {
>  	 * callbacks and update the cb pointers.
>  	 */
>  	int client_type;
> +	int _unused1;
> +	const struct lttng_ust_lib_ring_buffer_client_cb *cb_ptr;
>  	char padding[LTTNG_UST_RING_BUFFER_CONFIG_PADDING];
>  };
>  
> diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
> index f40c044..74a3bc6 100644
> --- a/include/lttng/ust-events.h
> +++ b/include/lttng/ust-events.h
> @@ -569,9 +569,9 @@ int lttng_add_ip_to_ctx(struct lttng_ctx **ctx);
>  void lttng_context_vtid_reset(void);
>  void lttng_context_vpid_reset(void);
>  
> -extern const struct lttng_ust_lib_ring_buffer_client_cb *lttng_client_callbacks_metadata;
> -extern const struct lttng_ust_lib_ring_buffer_client_cb *lttng_client_callbacks_discard;
> -extern const struct lttng_ust_lib_ring_buffer_client_cb *lttng_client_callbacks_overwrite;
> +extern const struct lttng_ust_client_lib_ring_buffer_client_cb *lttng_client_callbacks_metadata;
> +extern const struct lttng_ust_client_lib_ring_buffer_client_cb *lttng_client_callbacks_discard;
> +extern const struct lttng_ust_client_lib_ring_buffer_client_cb *lttng_client_callbacks_overwrite;
>  
>  struct lttng_transport *lttng_transport_find(const char *name);
>  
> diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
> index 1e6401a..5a43cf5 100644
> --- a/liblttng-ust/Makefile.am
> +++ b/liblttng-ust/Makefile.am
> @@ -47,6 +47,7 @@ liblttng_ust_support_la_SOURCES = \
>  	lttng-tracer.h \
>  	lttng-tracer-core.h \
>  	ust-core.c \
> +	lttng-rb-clients.h \
>  	lttng-ring-buffer-client.h \
>  	lttng-ring-buffer-client-discard.c \
>  	lttng-ring-buffer-client-discard-rt.c \
> diff --git a/liblttng-ust/lttng-rb-clients.h b/liblttng-ust/lttng-rb-clients.h
> new file mode 100644
> index 0000000..c9a1619
> --- /dev/null
> +++ b/liblttng-ust/lttng-rb-clients.h
> @@ -0,0 +1,26 @@
> +#ifndef _LTTNG_RB_CLIENT_H
> +#define _LTTNG_RB_CLIENT_H
> +
> +/*
> + * Copyright (c) 2013 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
> +struct lttng_ust_client_lib_ring_buffer_client_cb {
> +	struct lttng_ust_lib_ring_buffer_client_cb parent;
> +};
> +
> +#endif /* _LTTNG_RB_CLIENT_H */
> diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
> index 72b6d2c..383fce0 100644
> --- a/liblttng-ust/lttng-ring-buffer-client.h
> +++ b/liblttng-ust/lttng-ring-buffer-client.h
> @@ -161,6 +161,7 @@ unsigned char record_header_size(const struct lttng_ust_lib_ring_buffer_config *
>  }
>  
>  #include "../libringbuffer/api.h"
> +#include "lttng-rb-clients.h"
>  
>  static
>  void lttng_write_event_header_slow(const struct lttng_ust_lib_ring_buffer_config *config,
> @@ -385,6 +386,19 @@ static void client_buffer_finalize(struct lttng_ust_lib_ring_buffer *buf, void *
>  {
>  }
>  
> +static const
> +struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
> +	.parent = {
> +		.ring_buffer_clock_read = client_ring_buffer_clock_read,
> +		.record_header_size = client_record_header_size,
> +		.subbuffer_header_size = client_packet_header_size,
> +		.buffer_begin = client_buffer_begin,
> +		.buffer_end = client_buffer_end,
> +		.buffer_create = client_buffer_create,
> +		.buffer_finalize = client_buffer_finalize,
> +	},
> +};
> +
>  static const struct lttng_ust_lib_ring_buffer_config client_config = {
>  	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
>  	.cb.record_header_size = client_record_header_size,
> @@ -404,9 +418,11 @@ static const struct lttng_ust_lib_ring_buffer_config client_config = {
>  	.ipi = RING_BUFFER_NO_IPI_BARRIER,
>  	.wakeup = LTTNG_CLIENT_WAKEUP,
>  	.client_type = LTTNG_CLIENT_TYPE,
> +
> +	.cb_ptr = &client_cb.parent,
>  };
>  
> -const struct lttng_ust_lib_ring_buffer_client_cb *LTTNG_CLIENT_CALLBACKS = &client_config.cb;
> +const struct lttng_ust_client_lib_ring_buffer_client_cb *LTTNG_CLIENT_CALLBACKS = &client_cb;
>  
>  static
>  struct lttng_channel *_channel_create(const char *name,
> diff --git a/liblttng-ust/lttng-ring-buffer-metadata-client.h b/liblttng-ust/lttng-ring-buffer-metadata-client.h
> index 89f2620..0d2a1f8 100644
> --- a/liblttng-ust/lttng-ring-buffer-metadata-client.h
> +++ b/liblttng-ust/lttng-ring-buffer-metadata-client.h
> @@ -61,6 +61,7 @@ unsigned char record_header_size(const struct lttng_ust_lib_ring_buffer_config *
>  }
>  
>  #include "../libringbuffer/api.h"
> +#include "lttng-rb-clients.h"
>  
>  static uint64_t client_ring_buffer_clock_read(struct channel *chan)
>  {
> @@ -153,6 +154,19 @@ static void client_buffer_finalize(struct lttng_ust_lib_ring_buffer *buf,
>  {
>  }
>  
> +static const
> +struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
> +	.parent = {
> +		.ring_buffer_clock_read = client_ring_buffer_clock_read,
> +		.record_header_size = client_record_header_size,
> +		.subbuffer_header_size = client_packet_header_size,
> +		.buffer_begin = client_buffer_begin,
> +		.buffer_end = client_buffer_end,
> +		.buffer_create = client_buffer_create,
> +		.buffer_finalize = client_buffer_finalize,
> +	},
> +};
> +
>  static const struct lttng_ust_lib_ring_buffer_config client_config = {
>  	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
>  	.cb.record_header_size = client_record_header_size,
> @@ -172,9 +186,11 @@ static const struct lttng_ust_lib_ring_buffer_config client_config = {
>  	.ipi = RING_BUFFER_NO_IPI_BARRIER,
>  	.wakeup = RING_BUFFER_WAKEUP_BY_WRITER,
>  	.client_type = LTTNG_CLIENT_TYPE,
> +
> +	 .cb_ptr = &client_cb.parent,
>  };
>  
> -const struct lttng_ust_lib_ring_buffer_client_cb *LTTNG_CLIENT_CALLBACKS = &client_config.cb;
> +const struct lttng_ust_client_lib_ring_buffer_client_cb *LTTNG_CLIENT_CALLBACKS = &client_cb;
>  
>  static
>  struct lttng_channel *_channel_create(const char *name,
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
