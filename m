From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [UST PATCH 2/2] LTTng ringbuffer ABI calls for
	index generation
Date: Fri, 16 Aug 2013 14:53:36 -0400
Message-ID: <20130816185336.GB487__44117.3681211241$1376679275$gmane$org@Krystal>
References: <1376678386-18607-1-git-send-email-jdesfossez@efficios.com>
	<1376678386-18607-2-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VAP9V-0003YV-Vl
	for lttng-dev@lists.lttng.org; Fri, 16 Aug 2013 14:53:43 -0400
Content-Disposition: inline
In-Reply-To: <1376678386-18607-2-git-send-email-jdesfossez@efficios.com>
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
> These new calls export the data required for the consumer to
> generate the index while tracing :
> - timestamp begin
> - timestamp end
> - events discarded
> - context size
> - packet size
> - stream id

technically good. A few style "nits" below.

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  include/lttng/ust-ctl.h                 |   14 ++++
>  liblttng-ust-ctl/ustctl.c               |  125 +++++++++++++++++++++++++++++++
>  liblttng-ust/lttng-rb-clients.h         |   19 +++++
>  liblttng-ust/lttng-ring-buffer-client.h |   91 ++++++++++++++++++++++
>  4 files changed, 249 insertions(+)
> 
> diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
> index 3c81e50..88112ad 100644
> --- a/include/lttng/ust-ctl.h
> +++ b/include/lttng/ust-ctl.h
> @@ -220,6 +220,20 @@ int ustctl_put_subbuf(struct ustctl_consumer_stream *stream);
>  void ustctl_flush_buffer(struct ustctl_consumer_stream *stream,
>  		int producer_active);
>  
> +/* index */
> +int ustctl_get_timestamp_begin(struct ustctl_consumer_stream *stream,
> +		uint64_t *timestamp_begin);
> +int ustctl_get_timestamp_end(struct ustctl_consumer_stream *stream,
> +	uint64_t *timestamp_end);
> +int ustctl_get_events_discarded(struct ustctl_consumer_stream *stream,
> +	uint64_t *events_discarded);
> +int ustctl_get_content_size(struct ustctl_consumer_stream *stream,
> +	uint64_t *content_size);
> +int ustctl_get_packet_size(struct ustctl_consumer_stream *stream,
> +	uint64_t *packet_size);
> +int ustctl_get_stream_id(struct ustctl_consumer_stream *stream,
> +		uint64_t *stream_id);
> +
>  /* event registry management */
>  
>  enum ustctl_socket_type {
> diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
> index 28dee5e..9255416 100644
> --- a/liblttng-ust-ctl/ustctl.c
> +++ b/liblttng-ust-ctl/ustctl.c
> @@ -31,6 +31,7 @@
>  #include "../libringbuffer/backend.h"
>  #include "../libringbuffer/frontend.h"
>  #include "../liblttng-ust/wait.h"
> +#include "../liblttng-ust/lttng-rb-clients.h"
>  
>  /*
>   * Number of milliseconds to retry before failing metadata writes on
> @@ -1461,6 +1462,130 @@ void ustctl_flush_buffer(struct ustctl_consumer_stream *stream,
>  		consumer_chan->chan->handle);
>  }
>  
> +static
> +struct lttng_ust_client_lib_ring_buffer_client_cb *get_client_cb(
> +		struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle)
> +{
> +	struct channel *chan;
> +	const struct lttng_ust_lib_ring_buffer_config *config;
> +	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
> +

I'm tempted to just keep the empty line between declarations and code,
and remove other empty lines.

> +	chan = shmp(handle, buf->backend.chan);
> +	config = &chan->backend.config;
> +
> +	if (!config->cb_ptr)
> +		return NULL;
> +
> +	client_cb = caa_container_of(config->cb_ptr,
> +			struct lttng_ust_client_lib_ring_buffer_client_cb,
> +			parent);
> +
> +	return client_cb;
> +}
> +
> +int ustctl_get_timestamp_begin(struct ustctl_consumer_stream *stream,
> +		uint64_t *timestamp_begin)
> +{
> +	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
> +	struct lttng_ust_lib_ring_buffer *buf = stream->buf;
> +	struct lttng_ust_shm_handle *handle = stream->chan->chan->handle;
> +

here too. (and others below)

> +	if (!stream || !timestamp_begin)
> +		return -EINVAL;
> +
> +	client_cb = get_client_cb(buf, handle);
> +	if (!client_cb)
> +		return -ENOSYS;
> +
> +	return client_cb->timestamp_begin(buf, handle, timestamp_begin);
> +}
> +
> +int ustctl_get_timestamp_end(struct ustctl_consumer_stream *stream,
> +	uint64_t *timestamp_end)
> +{
> +	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
> +	struct lttng_ust_lib_ring_buffer *buf = stream->buf;
> +	struct lttng_ust_shm_handle *handle = stream->chan->chan->handle;
> +
> +	if (!stream || !timestamp_end)
> +		return -EINVAL;
> +
> +	client_cb = get_client_cb(buf, handle);
> +	if (!client_cb)
> +		return -ENOSYS;
> +
> +	return client_cb->timestamp_end(buf, handle, timestamp_end);
> +}
> +
> +int ustctl_get_events_discarded(struct ustctl_consumer_stream *stream,
> +	uint64_t *events_discarded)
> +{
> +	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
> +	struct lttng_ust_lib_ring_buffer *buf = stream->buf;
> +	struct lttng_ust_shm_handle *handle = stream->chan->chan->handle;
> +
> +	if (!stream || !events_discarded)
> +		return -EINVAL;
> +
> +	client_cb = get_client_cb(buf, handle);
> +	if (!client_cb)
> +		return -ENOSYS;
> +
> +	return client_cb->events_discarded(buf, handle, events_discarded);
> +}
> +
> +int ustctl_get_content_size(struct ustctl_consumer_stream *stream,
> +	uint64_t *content_size)
> +{
> +	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
> +	struct lttng_ust_lib_ring_buffer *buf = stream->buf;
> +	struct lttng_ust_shm_handle *handle = stream->chan->chan->handle;
> +
> +	if (!stream || !content_size)
> +		return -EINVAL;
> +
> +	client_cb = get_client_cb(buf, handle);
> +	if (!client_cb)
> +		return -ENOSYS;
> +
> +	return client_cb->content_size(buf, handle, content_size);
> +}
> +
> +int ustctl_get_packet_size(struct ustctl_consumer_stream *stream,
> +	uint64_t *packet_size)
> +{
> +	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
> +	struct lttng_ust_lib_ring_buffer *buf = stream->buf;
> +	struct lttng_ust_shm_handle *handle = stream->chan->chan->handle;
> +
> +	if (!stream || !packet_size)
> +		return -EINVAL;
> +
> +	client_cb = get_client_cb(buf, handle);
> +	if (!client_cb)
> +		return -ENOSYS;
> +
> +	return client_cb->packet_size(buf, handle, packet_size);
> +}
> +
> +int ustctl_get_stream_id(struct ustctl_consumer_stream *stream,
> +		uint64_t *stream_id)
> +{
> +	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
> +	struct lttng_ust_lib_ring_buffer *buf = stream->buf;
> +	struct lttng_ust_shm_handle *handle = stream->chan->chan->handle;
> +
> +	if (!stream || !stream_id)
> +		return -EINVAL;
> +
> +	client_cb = get_client_cb(buf, handle);
> +	if (!client_cb)
> +		return -ENOSYS;
> +
> +	return client_cb->stream_id(buf, handle, stream_id);
> +}
> +
>  /*
>   * Returns 0 on success, negative error value on error.
>   */
> diff --git a/liblttng-ust/lttng-rb-clients.h b/liblttng-ust/lttng-rb-clients.h
> index c9a1619..c43aa75 100644
> --- a/liblttng-ust/lttng-rb-clients.h
> +++ b/liblttng-ust/lttng-rb-clients.h
> @@ -21,6 +21,25 @@
>  
>  struct lttng_ust_client_lib_ring_buffer_client_cb {
>  	struct lttng_ust_lib_ring_buffer_client_cb parent;
> +
> +	int (*timestamp_begin) (struct lttng_ust_lib_ring_buffer *buf,
> +			struct lttng_ust_shm_handle *handle,
> +			uint64_t *timestamp_begin);
> +	int (*timestamp_end) (struct lttng_ust_lib_ring_buffer *buf,
> +			struct lttng_ust_shm_handle *handle,
> +			uint64_t *timestamp_end);
> +	int (*events_discarded) (struct lttng_ust_lib_ring_buffer *buf,
> +			struct lttng_ust_shm_handle *handle,
> +			uint64_t *events_discarded);
> +	int (*content_size) (struct lttng_ust_lib_ring_buffer *buf,
> +			struct lttng_ust_shm_handle *handle,
> +			uint64_t *content_size);
> +	int (*packet_size) (struct lttng_ust_lib_ring_buffer *buf,
> +			struct lttng_ust_shm_handle *handle,
> +			uint64_t *packet_size);
> +	int (*stream_id) (struct lttng_ust_lib_ring_buffer *buf,
> +			struct lttng_ust_shm_handle *handle,
> +			uint64_t *stream_id);
>  };
>  
>  #endif /* _LTTNG_RB_CLIENT_H */
> diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
> index 383fce0..5ce672c 100644
> --- a/liblttng-ust/lttng-ring-buffer-client.h
> +++ b/liblttng-ust/lttng-ring-buffer-client.h
> @@ -386,6 +386,91 @@ static void client_buffer_finalize(struct lttng_ust_lib_ring_buffer *buf, void *
>  {
>  }
>  
> +static struct packet_header *client_packet_header(struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle)
> +{
> +	struct channel *chan = shmp(handle, buf->backend.chan);
> +	struct lttng_channel *lttng_chan = channel_get_private(chan);
> +	unsigned long sb_index;
> +	struct lttng_ust_lib_ring_buffer_backend *bufb;
> +	struct packet_header *header;
> +

here too.

> +	bufb = &buf->backend;
> +	sb_index = subbuffer_id_get_index(&lttng_chan->chan->backend.config,
> +			bufb->buf_rsb.id);
> +
> +	header = lib_ring_buffer_offset_address(bufb,
> +			sb_index * lttng_chan->chan->backend.subbuf_size,
> +			handle);
> +
> +	return header;
> +}
> +
> +static int client_timestamp_begin(struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle,
> +		uint64_t *timestamp_begin)
> +{
> +	struct packet_header *header = client_packet_header(buf, handle);
> +

here, I'm tempted to do the following:

struct packet_header *header;

header = client_packet_header(buf, handle);
*timestamp_begin = header->ctx.timestamp_begin;
return 0;

I don't enforce it strictly anywhere, but it's good IMO not to put
assignments on variable declarations when they are functions calls and
can possibly have side effects. It's then clear to the eye what is
declarations and what is "code".

So, e.g.:

 int myvar = somefct();

   -> ideally change into:

 int myvar;

 myvar = somefct();

However:

 int myvar = 5;

is fine, because the assignment cannot possible have side-effects.

The same applies to other functions below.

Thanks,

Mathieu

> +	*timestamp_begin = header->ctx.timestamp_begin;
> +
> +	return 0;
> +}
> +
> +static int client_timestamp_end(struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle,
> +		uint64_t *timestamp_end)
> +{
> +	struct packet_header *header = client_packet_header(buf, handle);
> +
> +	*timestamp_end = header->ctx.timestamp_end;
> +
> +	return 0;
> +}
> +
> +static int client_events_discarded(struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle,
> +		uint64_t *events_discarded)
> +{
> +	struct packet_header *header = client_packet_header(buf, handle);
> +
> +	*events_discarded = header->ctx.events_discarded;
> +
> +	return 0;
> +}
> +
> +static int client_content_size(struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle,
> +		uint64_t *content_size)
> +{
> +	struct packet_header *header = client_packet_header(buf, handle);
> +
> +	*content_size = header->ctx.content_size;
> +
> +	return 0;
> +}
> +
> +static int client_packet_size(struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle,
> +		uint64_t *packet_size)
> +{
> +	struct packet_header *header = client_packet_header(buf, handle);
> +
> +	*packet_size = header->ctx.packet_size;
> +
> +	return 0;
> +}
> +
> +static int client_stream_id(struct lttng_ust_lib_ring_buffer *buf,
> +		struct lttng_ust_shm_handle *handle,
> +		uint64_t *stream_id)
> +{
> +	struct packet_header *header = client_packet_header(buf, handle);
> +
> +	*stream_id = header->stream_id;
> +
> +	return 0;
> +}
>  static const
>  struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
>  	.parent = {
> @@ -397,6 +482,12 @@ struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
>  		.buffer_create = client_buffer_create,
>  		.buffer_finalize = client_buffer_finalize,
>  	},
> +	.timestamp_begin = client_timestamp_begin,
> +	.timestamp_end = client_timestamp_end,
> +	.events_discarded = client_events_discarded,
> +	.content_size = client_content_size,
> +	.packet_size = client_packet_size,
> +	.stream_id = client_stream_id,
>  };
>  
>  static const struct lttng_ust_lib_ring_buffer_config client_config = {
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
