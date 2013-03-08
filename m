From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] On-disk multiple
	tracefiles	circular buffer
Date: Fri, 8 Mar 2013 11:17:56 -0500
Message-ID: <20130308161756.GA5037__46327.3205714815$1362759541$gmane$org@Krystal>
References: <1362678382-11138-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UDzzg-00078z-IY
	for lttng-dev@lists.lttng.org; Fri, 08 Mar 2013 11:18:04 -0500
Content-Disposition: inline
In-Reply-To: <1362678382-11138-1-git-send-email-jdesfossez@efficios.com>
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
> This patch introduces the tracefile_size and tracefile_count parameters
> to the enable-channel command and the API.

I having similar questions as Daniel about tracefile-size and
tracefile-count.

for each stream, do we have max size used on disk = size * count
or size used = size ?

If there is a doubt about the semantic, maybe using clearer terms that
don't need to be explained might help. I guess the confusion here is:
what is a tracefile exactly ? The notion of "stream" is much clearer
than "tracefile" in the CTF spec, so we might want to consider:

--stream-chunks-num NUM: each stream, on disk, is divided in at most
   NUM chunks (one file per chunk). When the maximum number of chunks is
   reached, oldest chunks are deleted for this stream, thus creating
   a flight recorder on disk.

--stream-chunks-size SIZE: chunk size. Must be a multiple of
   subbuf-size. Default value: subbuffer size.

> This allows to split a stream into multiple tracefiles and limit the
> amount of trace data to keep on disk.
> The tracefiles are readable independently or with the others as long as
> the metadata file is present.
> 
> For now only local traces are handled, relayd modifications coming soon.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  include/lttng/lttng.h                        |    7 +-
>  src/bin/lttng-sessiond/channel.c             |   10 ++
>  src/bin/lttng-sessiond/consumer.c            |   18 +++-
>  src/bin/lttng-sessiond/consumer.h            |   12 ++-
>  src/bin/lttng-sessiond/kernel-consumer.c     |   14 ++-
>  src/bin/lttng-sessiond/kernel.c              |    3 +
>  src/bin/lttng-sessiond/trace-kernel.h        |    2 +
>  src/bin/lttng-sessiond/trace-ust.c           |    4 +
>  src/bin/lttng-sessiond/trace-ust.h           |    2 +
>  src/bin/lttng-sessiond/ust-app.c             |    3 +
>  src/bin/lttng-sessiond/ust-app.h             |    2 +
>  src/bin/lttng-sessiond/ust-consumer.c        |    4 +-
>  src/bin/lttng/commands/enable_channels.c     |   31 ++++++
>  src/common/consumer.c                        |  140 +++++++++++++++++++++++++-
>  src/common/consumer.h                        |   21 +++-
>  src/common/defaults.h                        |    8 ++
>  src/common/kernel-consumer/kernel-consumer.c |   25 ++---
>  src/common/sessiond-comm/sessiond-comm.h     |    6 ++
>  src/common/ust-consumer/ust-consumer.c       |   44 ++------
>  src/lib/lttng-ctl/lttng-ctl.c                |    4 +
>  20 files changed, 294 insertions(+), 66 deletions(-)
> 
> diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
> index 6077047..24c17c7 100644
> --- a/include/lttng/lttng.h
> +++ b/include/lttng/lttng.h
> @@ -269,7 +269,9 @@ struct lttng_event_field {
>   *
>   * The structures should be initialized to zero before use.
>   */
> -#define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN + 32
> +#define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN + 32 \
> +						- 8 /* tracefile_size */ \
> +						- 8 /* tracefile_count */
>  struct lttng_channel_attr {
>  	int overwrite;                      /* 1: overwrite, 0: discard */
>  	uint64_t subbuf_size;               /* bytes */
> @@ -277,6 +279,9 @@ struct lttng_channel_attr {
>  	unsigned int switch_timer_interval; /* usec */
>  	unsigned int read_timer_interval;   /* usec */
>  	enum lttng_event_output output;     /* splice, mmap */
> +	/* LTTng 2.0 padding limit */
> +	uint64_t tracefile_size;                 /* bytes */
> +	uint64_t tracefile_count;                /* number of tracefiles */

We'll have padding problems between the enum and uint64_t. Sadly
lttng_channel_attr is not packed. We should ensure the first uint64_t is
on a 64-bit alignment within the structure. If necessary, we might need
to add a dummy field before the first uint64_t. Failure to ensure this
could cause new liblttng-ctl to write zeros beyond the size allocated by
applications.

>  
>  	char padding[LTTNG_CHANNEL_ATTR_PADDING1];
>  };
> diff --git a/src/bin/lttng-sessiond/channel.c b/src/bin/lttng-sessiond/channel.c
> index 7ebe4b1..a5beb24 100644
> --- a/src/bin/lttng-sessiond/channel.c
> +++ b/src/bin/lttng-sessiond/channel.c
> @@ -282,6 +282,16 @@ int channel_ust_create(struct ltt_ust_session *usess, int domain,
>  		goto error;
>  	}
>  
> +	/*
> +	 * The tracefile_size should not be < to the subbuf_size, otherwise
> +	 * we won't be able to write the packets on disk
> +	 */
> +	if ((attr->attr.tracefile_size > 0) &&
> +			(attr->attr.tracefile_size < attr->attr.subbuf_size)) {

Actually, you might want to consider that the stream-chunk-size need to
be a multiple of the subbuffer size. The check needs to be more strict.

> +		ret = LTTNG_ERR_INVALID;
> +		goto error;
> +	}
> +
>  	/* Create UST channel */
>  	uchan = trace_ust_create_channel(attr, usess->pathname);
>  	if (uchan == NULL) {
> diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
> index 92abcf2..1973059 100644
> --- a/src/bin/lttng-sessiond/consumer.c
> +++ b/src/bin/lttng-sessiond/consumer.c
> @@ -625,7 +625,9 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		gid_t gid,
>  		uint64_t relayd_id,
>  		uint64_t key,
> -		unsigned char *uuid)
> +		unsigned char *uuid,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count)
>  {
>  	assert(msg);
>  
> @@ -645,6 +647,8 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  	msg->u.ask_channel.gid = gid;
>  	msg->u.ask_channel.relayd_id = relayd_id;
>  	msg->u.ask_channel.key = key;
> +	msg->u.ask_channel.tracefile_size = tracefile_size;
> +	msg->u.ask_channel.tracefile_count = tracefile_count;
>  
>  	memcpy(msg->u.ask_channel.uuid, uuid, sizeof(msg->u.ask_channel.uuid));
>  
> @@ -670,7 +674,9 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		const char *name,
>  		unsigned int nb_init_streams,
>  		enum lttng_event_output output,
> -		int type)
> +		int type,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count)
>  {
>  	assert(msg);
>  
> @@ -687,6 +693,8 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  	msg->u.channel.nb_init_streams = nb_init_streams;
>  	msg->u.channel.output = output;
>  	msg->u.channel.type = type;
> +	msg->u.channel.tracefile_size = tracefile_size;
> +	msg->u.channel.tracefile_count = tracefile_count;
>  
>  	strncpy(msg->u.channel.pathname, pathname,
>  			sizeof(msg->u.channel.pathname));
> @@ -703,7 +711,9 @@ void consumer_init_stream_comm_msg(struct lttcomm_consumer_msg *msg,
>  		enum lttng_consumer_command cmd,
>  		uint64_t channel_key,
>  		uint64_t stream_key,
> -		int cpu)
> +		int cpu,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count)
>  {
>  	assert(msg);
>  
> @@ -713,6 +723,8 @@ void consumer_init_stream_comm_msg(struct lttcomm_consumer_msg *msg,
>  	msg->u.stream.channel_key = channel_key;
>  	msg->u.stream.stream_key = stream_key;
>  	msg->u.stream.cpu = cpu;
> +	msg->u.stream.tracefile_size = tracefile_size;
> +	msg->u.stream.tracefile_count = tracefile_count;
>  }
>  
>  /*
> diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
> index 3616d46..864a45b 100644
> --- a/src/bin/lttng-sessiond/consumer.h
> +++ b/src/bin/lttng-sessiond/consumer.h
> @@ -197,12 +197,16 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		gid_t gid,
>  		uint64_t relayd_id,
>  		uint64_t key,
> -		unsigned char *uuid);
> +		unsigned char *uuid,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count);
>  void consumer_init_stream_comm_msg(struct lttcomm_consumer_msg *msg,
>  		enum lttng_consumer_command cmd,
>  		uint64_t channel_key,
>  		uint64_t stream_key,
> -		int cpu);
> +		int cpu,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count);
>  void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		enum lttng_consumer_command cmd,
>  		uint64_t channel_key,
> @@ -214,7 +218,9 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		const char *name,
>  		unsigned int nb_init_streams,
>  		enum lttng_event_output output,
> -		int type);
> +		int type,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count);
>  int consumer_is_data_pending(uint64_t session_id,
>  		struct consumer_output *consumer);
>  
> diff --git a/src/bin/lttng-sessiond/kernel-consumer.c b/src/bin/lttng-sessiond/kernel-consumer.c
> index 837afdc..1b17380 100644
> --- a/src/bin/lttng-sessiond/kernel-consumer.c
> +++ b/src/bin/lttng-sessiond/kernel-consumer.c
> @@ -93,7 +93,9 @@ int kernel_consumer_add_channel(struct consumer_socket *sock,
>  			channel->channel->name,
>  			channel->stream_count,
>  			channel->channel->attr.output,
> -			CONSUMER_CHANNEL_TYPE_DATA);
> +			CONSUMER_CHANNEL_TYPE_DATA,
> +			channel->channel->attr.tracefile_size,
> +			channel->channel->attr.tracefile_count);
>  
>  	health_code_update();
>  
> @@ -173,7 +175,8 @@ int kernel_consumer_add_metadata(struct consumer_socket *sock,
>  			DEFAULT_METADATA_NAME,
>  			1,
>  			DEFAULT_KERNEL_CHANNEL_OUTPUT,
> -			CONSUMER_CHANNEL_TYPE_METADATA);
> +			CONSUMER_CHANNEL_TYPE_METADATA,
> +			0, 0);
>  
>  	health_code_update();
>  
> @@ -189,7 +192,8 @@ int kernel_consumer_add_metadata(struct consumer_socket *sock,
>  			LTTNG_CONSUMER_ADD_STREAM,
>  			session->metadata->fd,
>  			session->metadata_stream_fd,
> -			0);	/* CPU: 0 for metadata. */
> +			0, /* CPU: 0 for metadata. */
> +			0, 0); /* don't split metadata */
>  
>  	health_code_update();
>  
> @@ -234,7 +238,9 @@ int kernel_consumer_add_stream(struct consumer_socket *sock,
>  			LTTNG_CONSUMER_ADD_STREAM,
>  			channel->fd,
>  			stream->fd,
> -			stream->cpu);
> +			stream->cpu,
> +			stream->tracefile_size,
> +			stream->tracefile_count);
>  
>  	health_code_update();
>  
> diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
> index d3a6453..9519411 100644
> --- a/src/bin/lttng-sessiond/kernel.c
> +++ b/src/bin/lttng-sessiond/kernel.c
> @@ -536,6 +536,9 @@ int kernel_open_channel_stream(struct ltt_kernel_channel *channel)
>  			PERROR("fcntl session fd");
>  		}
>  
> +		lks->tracefile_size = channel->channel->attr.tracefile_size;
> +		lks->tracefile_count = channel->channel->attr.tracefile_count;
> +
>  		/* Add stream to channe stream list */
>  		cds_list_add(&lks->list, &channel->stream_list.head);
>  		channel->stream_count++;
> diff --git a/src/bin/lttng-sessiond/trace-kernel.h b/src/bin/lttng-sessiond/trace-kernel.h
> index 66ca8db..87807d9 100644
> --- a/src/bin/lttng-sessiond/trace-kernel.h
> +++ b/src/bin/lttng-sessiond/trace-kernel.h
> @@ -82,6 +82,8 @@ struct ltt_kernel_stream {
>  	int cpu;
>  	/* Format is %s_%d respectively channel name and CPU number. */
>  	char name[DEFAULT_STREAM_NAME_LEN];
> +	uint64_t tracefile_size;
> +	uint64_t tracefile_count;
>  	struct cds_list_head list;
>  };
>  
> diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
> index 5e06a84..6278ede 100644
> --- a/src/bin/lttng-sessiond/trace-ust.c
> +++ b/src/bin/lttng-sessiond/trace-ust.c
> @@ -302,6 +302,10 @@ struct ltt_ust_channel *trace_ust_create_channel(struct lttng_channel *chan,
>  		goto error_free_channel;
>  	}
>  
> +	/* On-disk circular buffer parameters */
> +	luc->tracefile_size = chan->attr.tracefile_size;
> +	luc->tracefile_count = chan->attr.tracefile_count;
> +
>  	DBG2("Trace UST channel %s created", luc->name);
>  
>  	return luc;
> diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
> index f5fa092..f8eb08f 100644
> --- a/src/bin/lttng-sessiond/trace-ust.h
> +++ b/src/bin/lttng-sessiond/trace-ust.h
> @@ -58,6 +58,8 @@ struct ltt_ust_channel {
>  	struct lttng_ht *ctx;
>  	struct lttng_ht *events;
>  	struct lttng_ht_node_str node;
> +	uint64_t tracefile_size;
> +	uint64_t tracefile_count;
>  };
>  
>  /* UST Metadata */
> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
> index 7288763..a708714 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -1288,6 +1288,9 @@ static void shadow_copy_channel(struct ust_app_channel *ua_chan,
>  	strncpy(ua_chan->name, uchan->name, sizeof(ua_chan->name));
>  	ua_chan->name[sizeof(ua_chan->name) - 1] = '\0';
>  
> +	ua_chan->tracefile_size = uchan->tracefile_size;
> +	ua_chan->tracefile_count = uchan->tracefile_count;
> +
>  	/* Copy event attributes since the layout is different. */
>  	ua_chan->attr.subbuf_size = uchan->attr.subbuf_size;
>  	ua_chan->attr.num_subbuf = uchan->attr.num_subbuf;
> diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
> index c6294d0..2b1db3b 100644
> --- a/src/bin/lttng-sessiond/ust-app.h
> +++ b/src/bin/lttng-sessiond/ust-app.h
> @@ -141,6 +141,8 @@ struct ust_app_channel {
>  	struct ust_app_session *session;
>  	struct lttng_ht *ctx;
>  	struct lttng_ht *events;
> +	uint64_t tracefile_size;
> +	uint64_t tracefile_count;
>  	/*
>  	 * UST event registry. The ONLY writer is the application thread.
>  	 */
> diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
> index 33cb6ff..b49ddbd 100644
> --- a/src/bin/lttng-sessiond/ust-consumer.c
> +++ b/src/bin/lttng-sessiond/ust-consumer.c
> @@ -133,7 +133,9 @@ static int ask_channel_creation(struct ust_app_session *ua_sess,
>  			ua_sess->gid,
>  			consumer->net_seq_index,
>  			ua_chan->key,
> -			ua_sess->registry.uuid);
> +			ua_sess->registry.uuid,
> +			ua_chan->tracefile_size,
> +			ua_chan->tracefile_count);
>  
>  	health_code_update();
>  
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
> index d9a3b02..f700b62 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -51,6 +51,8 @@ enum {
>  	OPT_READ_TIMER,
>  	OPT_USERSPACE,
>  	OPT_LIST_OPTIONS,
> +	OPT_TRACEFILE_SIZE,
> +	OPT_TRACEFILE_COUNT,
>  };
>  
>  static struct lttng_handle *handle;
> @@ -78,6 +80,8 @@ static struct poptOption long_options[] = {
>  	{"read-timer",     0,   POPT_ARG_INT, 0, OPT_READ_TIMER, 0, 0},
>  	{"list-options",   0, POPT_ARG_NONE, NULL, OPT_LIST_OPTIONS, NULL, NULL},
>  	{"output",         0,   POPT_ARG_STRING, &opt_output, 0, 0, 0},
> +	{"tracefile_size", 'C',   POPT_ARG_INT, 0, OPT_TRACEFILE_SIZE, 0, 0},
> +	{"tracefile_count", 'W',   POPT_ARG_INT, 0, OPT_TRACEFILE_COUNT, 0, 0},
>  	{0, 0, 0, 0, 0, 0, 0}
>  };
>  
> @@ -117,6 +121,8 @@ static void usage(FILE *ofp)
>  		DEFAULT_CHANNEL_READ_TIMER);
>  	fprintf(ofp, "      --output TYPE        Channel output type (Values: %s, %s)\n",
>  			output_mmap, output_splice);
> +	fprintf(ofp, "  -C, --tracefile-size NUM     Maximum size of tracefiles (in bytes)\n");
> +	fprintf(ofp, "  -W, --tracefile-count NUM    Number of tracefiles to keep\n");
>  	fprintf(ofp, "\n");
>  }
>  
> @@ -149,6 +155,12 @@ static void set_default_attr(struct lttng_domain *dom)
>  	if (chan.attr.output == -1) {
>  		chan.attr.output = default_attr.output;
>  	}
> +	if (chan.attr.tracefile_count == -1) {
> +		chan.attr.tracefile_count = default_attr.tracefile_count;
> +	}
> +	if (chan.attr.tracefile_size == -1) {
> +		chan.attr.tracefile_size = default_attr.tracefile_size;
> +	}
>  }
>  
>  /*
> @@ -175,6 +187,15 @@ static int enable_channel(char *session_name)
>  
>  	set_default_attr(&dom);
>  
> +	if ((chan.attr.tracefile_size > 0) &&
> +			(chan.attr.tracefile_size < chan.attr.subbuf_size)) {

Same issue about need for checking more strictly.

> +		ERR("Tracefile_size must be superior or equal to subbuf_size "
> +				"(%" PRIu64 " < %" PRIu64 ")",
> +				chan.attr.tracefile_size, chan.attr.subbuf_size);
> +		ret = CMD_ERROR;
> +		goto error;
> +	}
> +
>  	/* Setting channel output */
>  	if (opt_output) {
>  		if (!strncmp(output_mmap, opt_output, strlen(output_mmap))) {
> @@ -303,6 +324,16 @@ int cmd_enable_channels(int argc, const char **argv)
>  		case OPT_USERSPACE:
>  			opt_userspace = 1;
>  			break;
> +		case OPT_TRACEFILE_SIZE:
> +			chan.attr.tracefile_size = atoll(poptGetOptArg(pc));
> +			DBG("Maximum tracefile size set to %" PRIu64,
> +					chan.attr.tracefile_size);
> +			break;
> +		case OPT_TRACEFILE_COUNT:
> +			chan.attr.tracefile_count = atoll(poptGetOptArg(pc));
> +			DBG("Maximum tracefile count set to %" PRIu64,
> +					chan.attr.tracefile_count);
> +			break;
>  		case OPT_LIST_OPTIONS:
>  			list_cmd_options(stdout, long_options);
>  			goto end;
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 25f891a..0c316af 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -500,7 +500,9 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
>  		uint64_t session_id,
>  		int cpu,
>  		int *alloc_ret,
> -		enum consumer_channel_type type)
> +		enum consumer_channel_type type,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count)
>  {
>  	int ret;
>  	struct lttng_consumer_stream *stream;
> @@ -522,6 +524,8 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
>  	stream->gid = gid;
>  	stream->net_seq_idx = relayd_id;
>  	stream->session_id = session_id;
> +	stream->tracefile_size = tracefile_size;
> +	stream->tracefile_count = tracefile_count;
>  	pthread_mutex_init(&stream->lock, NULL);
>  
>  	/* If channel is the metadata, flag this stream as metadata. */
> @@ -777,7 +781,9 @@ struct lttng_consumer_channel *consumer_allocate_channel(unsigned long key,
>  		uid_t uid,
>  		gid_t gid,
>  		int relayd_id,
> -		enum lttng_event_output output)
> +		enum lttng_event_output output,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count)
>  {
>  	struct lttng_consumer_channel *channel;
>  
> @@ -794,6 +800,8 @@ struct lttng_consumer_channel *consumer_allocate_channel(unsigned long key,
>  	channel->gid = gid;
>  	channel->relayd_id = relayd_id;
>  	channel->output = output;
> +	channel->tracefile_size = tracefile_size;
> +	channel->tracefile_count = tracefile_count;
>  
>  	strncpy(channel->pathname, pathname, sizeof(channel->pathname));
>  	channel->pathname[sizeof(channel->pathname) - 1] = '\0';
> @@ -1240,6 +1248,102 @@ end:
>  }
>  
>  /*
> + * Create the tracefile on disk
> + */
> +int lttng_create_output_file(struct lttng_consumer_stream *stream)
> +{
> +	int ret;
> +	char full_path[PATH_MAX];
> +	char *path_name_id = NULL;
> +	char *path;
> +
> +	assert(stream);
> +
> +	ret = snprintf(full_path, sizeof(full_path), "%s/%s",
> +			stream->chan->pathname, stream->name);
> +	if (ret < 0) {
> +		PERROR("snprintf on_recv_stream");
> +		goto error;
> +	}
> +
> +	/* Opening the tracefile in write mode */
> +	if (stream->net_seq_idx == (uint64_t) -1ULL) {
> +		/*
> +		 * if we split the trace in multiple files, we have to add
> +		 * the tracefile current count at the end of the tracefile
> +		 * name
> +		 */
> +		if (stream->tracefile_size > 0) {
> +			ret = asprintf(&path_name_id, "%s_%" PRIu64, full_path,
> +					stream->tracefile_current_count);
> +			if (ret < 0) {
> +				PERROR("Allocating path name ID");
> +				goto error;
> +			}
> +			path = path_name_id;
> +		} else {
> +			path = full_path;
> +		}
> +
> +		ret = run_as_open(path, O_WRONLY | O_CREAT | O_TRUNC,
> +				S_IRWXU|S_IRWXG|S_IRWXO, stream->uid, stream->gid);
> +		if (ret < 0) {
> +			PERROR("open kernel stream path %s", full_path);
> +			goto error_free;
> +		}
> +		stream->out_fd = ret;
> +		stream->tracefile_current_size = 0;
> +		if (path_name_id) {

no need for the if() in c99: free() will check for NULL.

> +			free(path_name_id);
> +			path_name_id = NULL;

This free() is useless. It's done below.

> +		}
> +	}
> +
> +error_free:

these are not "error" labels, but rather "end" labels. You reach then
through non-error code paths.

> +	if (path_name_id) {
> +		free(path_name_id);

no need for the if() in c99: free() will check for NULL.

> +	}
> +error:
> +	return ret;
> +}
> +
> +/*
> + * Change the output tracefile according to the tracefile_size and
> + * tracefile_count parameters.
> + * stream->lock must be held before calling this function because
> + * we are modifying the stream status.
> + */
> +static int rotate_output_file(struct lttng_consumer_stream *stream)
> +{
> +	int ret;
> +
> +	ret = close(stream->out_fd);
> +	if (ret < 0) {
> +		PERROR("Closing tracefile");
> +		goto end;

this should be an error label.

> +	}

if close succeeds, it might be better to set out_fd to -1 so we don't
end up closing the same fd twice if we reach error path below and after
close the FD again when destroying the stream.

> +
> +	/* safety : should not happen with args validation */
> +	if (stream->tracefile_current_size == 0) {
> +		ERR("Tracefile size too small, rotating without writing in it");
> +		ret = -1;

ret = -EINVAL;

> +		goto end;

this should be an error label.

> +	}
> +
> +	if (stream->tracefile_count > 0) {
> +		stream->tracefile_current_count =
> +			(stream->tracefile_current_count + 1) % stream->tracefile_count;

here tracefile_current_count vs tracefile_count are misleading.

by tracefile_count, do you actually mean the maximum number of chunks ?

> +	} else {
> +		stream->tracefile_current_count++;
> +	}
> +
> +	return lttng_create_output_file(stream);
> +
> +end:
> +	return ret;
> +}
> +
> +/*
>   * Mmap the ring buffer, read it and write the data to the tracefile. This is a
>   * core function for writing trace buffers to either the local filesystem or
>   * the network.
> @@ -1345,6 +1449,22 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
>  	} else {
>  		/* No streaming, we have to set the len with the full padding */
>  		len += padding;
> +
> +		/*
> +		 * check if we need to change the tracefile before writing

what do you mean by "change" ? Please detail in the comment.

> +		 * the packet
> +		 */

could you wrap this check below into a separate function ? It is
specific to chunks rotation, and copy-pasted into both splice and mmap
code.

> +		if (stream->tracefile_size > 0 &&
> +				(stream->tracefile_current_size + len) >
> +				stream->tracefile_size) {
> +			ret = rotate_output_file(stream);
> +			if (ret < 0) {
> +				ERR("Rotating output file");
> +				goto end;
> +			}
> +			outfd = stream->out_fd;
> +		}
> +		stream->tracefile_current_size += len;
>  	}
>  
>  	while (len > 0) {
> @@ -1507,6 +1627,22 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  	} else {
>  		/* No streaming, we have to set the len with the full padding */
>  		len += padding;
> +
> +		/*
> +		 * check if we need to change the tracefile before writing
> +		 * the packet

change = ?

> +		 */
> +		if (stream->tracefile_size > 0 &&
> +				(stream->tracefile_current_size + len) >
> +				stream->tracefile_size) {
> +			ret = rotate_output_file(stream);
> +			if (ret < 0) {
> +				ERR("Rotating output file");
> +				goto end;
> +			}
> +			outfd = stream->out_fd;
> +		}
> +		stream->tracefile_current_size += len;
>  	}

Thanks,

Mathieu

>  
>  	while (len > 0) {
> diff --git a/src/common/consumer.h b/src/common/consumer.h
> index a3e1ec3..867c5ef 100644
> --- a/src/common/consumer.h
> +++ b/src/common/consumer.h
> @@ -136,6 +136,12 @@ struct lttng_consumer_channel {
>  	 * contiguousness and order.
>  	 */
>  	uint64_t contig_metadata_written;
> +
> +	/*
> +	 * On-disk circular buffer
> +	 */
> +	uint64_t tracefile_size;
> +	uint64_t tracefile_count;
>  };
>  
>  /*
> @@ -221,6 +227,12 @@ struct lttng_consumer_stream {
>  	/* Internal state of libustctl. */
>  	struct ustctl_consumer_stream *ustream;
>  	struct cds_list_head send_node;
> +
> +	/* On-disk circular buffer */
> +	uint64_t tracefile_size;
> +	uint64_t tracefile_count;
> +	uint64_t tracefile_current_size;
> +	uint64_t tracefile_current_count;
>  };
>  
>  /*
> @@ -431,7 +443,9 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
>  		uint64_t session_id,
>  		int cpu,
>  		int *alloc_ret,
> -		enum consumer_channel_type type);
> +		enum consumer_channel_type type,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count);
>  struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
>  		uint64_t session_id,
>  		const char *pathname,
> @@ -439,7 +453,9 @@ struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
>  		uid_t uid,
>  		gid_t gid,
>  		int relayd_id,
> -		enum lttng_event_output output);
> +		enum lttng_event_output output,
> +		uint64_t tracefile_size,
> +		uint64_t tracefile_count);
>  void consumer_del_stream(struct lttng_consumer_stream *stream,
>  		struct lttng_ht *ht);
>  void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
> @@ -464,6 +480,7 @@ struct lttng_consumer_local_data *lttng_consumer_create(
>  		int (*recv_stream)(struct lttng_consumer_stream *stream),
>  		int (*update_stream)(int sessiond_key, uint32_t state));
>  void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx);
> +int lttng_create_output_file(struct lttng_consumer_stream *stream);
>  ssize_t lttng_consumer_on_read_subbuffer_mmap(
>  		struct lttng_consumer_local_data *ctx,
>  		struct lttng_consumer_stream *stream, unsigned long len,
> diff --git a/src/common/defaults.h b/src/common/defaults.h
> index 83159d7..8a07ba0 100644
> --- a/src/common/defaults.h
> +++ b/src/common/defaults.h
> @@ -138,6 +138,10 @@
>  #define DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM   DEFAULT_CHANNEL_SUBBUF_NUM
>  /* See lttng-kernel.h enum lttng_kernel_output for channel output */
>  #define DEFAULT_KERNEL_CHANNEL_OUTPUT       LTTNG_EVENT_SPLICE
> +/* By default, unlimited tracefile size */
> +#define DEFAULT_KERNEL_CHANNEL_TRACEFILE_SIZE  0
> +/* By default, unlimited tracefile count */
> +#define DEFAULT_KERNEL_CHANNEL_TRACEFILE_COUNT 0
>  
>  /* User space defaults */
>  
> @@ -147,6 +151,10 @@
>  #define DEFAULT_UST_CHANNEL_SUBBUF_NUM      DEFAULT_CHANNEL_SUBBUF_NUM
>  /* See lttng-ust.h enum lttng_ust_output */
>  #define DEFAULT_UST_CHANNEL_OUTPUT          LTTNG_EVENT_MMAP
> +/* By default, unlimited tracefile size */
> +#define DEFAULT_UST_CHANNEL_TRACEFILE_SIZE  0
> +/* By default, unlimited tracefile count */
> +#define DEFAULT_UST_CHANNEL_TRACEFILE_COUNT 0
>  
>  /*
>   * Default timeout value for the sem_timedwait() call. Blocking forever is not
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> index ca1e98b..7ab1bf0 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -132,7 +132,9 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  		new_channel = consumer_allocate_channel(msg.u.channel.channel_key,
>  				msg.u.channel.session_id, msg.u.channel.pathname,
>  				msg.u.channel.name, msg.u.channel.uid, msg.u.channel.gid,
> -				msg.u.channel.relayd_id, msg.u.channel.output);
> +				msg.u.channel.relayd_id, msg.u.channel.output,
> +				msg.u.channel.tracefile_size,
> +				msg.u.channel.tracefile_count);
>  		if (new_channel == NULL) {
>  			lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_OUTFD_ERROR);
>  			goto end_nosignal;
> @@ -229,7 +231,9 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  				channel->session_id,
>  				msg.u.stream.cpu,
>  				&alloc_ret,
> -				channel->type);
> +				channel->type,
> +				channel->tracefile_size,
> +				channel->tracefile_count);
>  		if (new_stream == NULL) {
>  			switch (alloc_ret) {
>  			case -ENOMEM:
> @@ -501,28 +505,15 @@ end:
>  int lttng_kconsumer_on_recv_stream(struct lttng_consumer_stream *stream)
>  {
>  	int ret;
> -	char full_path[PATH_MAX];
>  
>  	assert(stream);
>  
> -	ret = snprintf(full_path, sizeof(full_path), "%s/%s",
> -			stream->chan->pathname, stream->name);
> +	ret = lttng_create_output_file(stream);
>  	if (ret < 0) {
> -		PERROR("snprintf on_recv_stream");
> +		ERR("Creating output file");
>  		goto error;
>  	}
>  
> -	/* Opening the tracefile in write mode */
> -	if (stream->net_seq_idx == (uint64_t) -1ULL) {
> -		ret = run_as_open(full_path, O_WRONLY | O_CREAT | O_TRUNC,
> -				S_IRWXU|S_IRWXG|S_IRWXO, stream->uid, stream->gid);
> -		if (ret < 0) {
> -			PERROR("open kernel stream path %s", full_path);
> -			goto error;
> -		}
> -		stream->out_fd = ret;
> -	}
> -
>  	if (stream->output == LTTNG_EVENT_MMAP) {
>  		/* get the len of the mmap region */
>  		unsigned long mmap_len;
> diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
> index 60a3ead..871027c 100644
> --- a/src/common/sessiond-comm/sessiond-comm.h
> +++ b/src/common/sessiond-comm/sessiond-comm.h
> @@ -273,10 +273,14 @@ struct lttcomm_consumer_msg {
>  			/* Use splice or mmap to consume this fd */
>  			enum lttng_event_output output;
>  			int type; /* Per cpu or metadata. */
> +			uint64_t tracefile_size; /* bytes */
> +			uint64_t tracefile_count; /* number of tracefiles */
>  		} LTTNG_PACKED channel; /* Only used by Kernel. */
>  		struct {
>  			uint64_t stream_key;
>  			uint64_t channel_key;
> +			uint64_t tracefile_size; /* bytes */
> +			uint64_t tracefile_count; /* number of tracefiles */
>  			int32_t cpu;	/* On which CPU this stream is assigned. */
>  		} LTTNG_PACKED stream;	/* Only used by Kernel. */
>  		struct {
> @@ -309,6 +313,8 @@ struct lttcomm_consumer_msg {
>  			uint64_t relayd_id;			/* Relayd id if apply. */
>  			uint64_t key;				/* Unique channel key. */
>  			unsigned char uuid[UUID_STR_LEN];	/* uuid for ust tracer. */
> +			uint64_t tracefile_size; 		/* bytes */
> +			uint64_t tracefile_count; 		/* number of tracefiles */
>  		} LTTNG_PACKED ask_channel;
>  		struct {
>  			uint64_t key;
> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
> index 5d9dc96..41fd49b 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -109,13 +109,14 @@ error:
>   */
>  static struct lttng_consumer_channel *allocate_channel(uint64_t session_id,
>  		const char *pathname, const char *name, uid_t uid, gid_t gid,
> -		int relayd_id, uint64_t key, enum lttng_event_output output)
> +		int relayd_id, uint64_t key, enum lttng_event_output output,
> +		uint64_t tracefile_size, uint64_t tracefile_count)
>  {
>  	assert(pathname);
>  	assert(name);
>  
>  	return consumer_allocate_channel(key, session_id, pathname, name, uid, gid,
> -			relayd_id, output);
> +			relayd_id, output, tracefile_size, tracefile_count);
>  }
>  
>  /*
> @@ -144,7 +145,8 @@ static struct lttng_consumer_stream *allocate_stream(int cpu, int key,
>  			channel->session_id,
>  			cpu,
>  			&alloc_ret,
> -			channel->type);
> +			channel->type,
> +			0, 0);
>  	if (stream == NULL) {
>  		switch (alloc_ret) {
>  		case -ENOENT:
> @@ -264,6 +266,8 @@ static int create_ust_streams(struct lttng_consumer_channel *channel,
>  			goto error_alloc;
>  		}
>  		stream->ustream = ustream;
> +		stream->tracefile_size = channel->tracefile_size;
> +		stream->tracefile_count = channel->tracefile_count;
>  		/*
>  		 * Store it so we can save multiple function calls afterwards since
>  		 * this value is used heavily in the stream threads. This is UST
> @@ -750,7 +754,9 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  				msg.u.ask_channel.pathname, msg.u.ask_channel.name,
>  				msg.u.ask_channel.uid, msg.u.ask_channel.gid,
>  				msg.u.ask_channel.relayd_id, msg.u.ask_channel.key,
> -				(enum lttng_event_output) msg.u.ask_channel.output);
> +				(enum lttng_event_output) msg.u.ask_channel.output,
> +				msg.u.ask_channel.tracefile_size,
> +				msg.u.ask_channel.tracefile_count);
>  		if (!channel) {
>  			goto end_channel_error;
>  		}
> @@ -1176,35 +1182,7 @@ end:
>   */
>  int lttng_ustconsumer_on_recv_stream(struct lttng_consumer_stream *stream)
>  {
> -	int ret;
> -	char full_path[PATH_MAX];
> -
> -	/* Opening the tracefile in write mode */
> -	if (stream->net_seq_idx != (uint64_t) -1ULL) {
> -		goto end;
> -	}
> -
> -	ret = snprintf(full_path, sizeof(full_path), "%s/%s",
> -			stream->chan->pathname, stream->name);
> -	if (ret < 0) {
> -		PERROR("snprintf on_recv_stream");
> -		goto error;
> -	}
> -
> -	ret = run_as_open(full_path, O_WRONLY | O_CREAT | O_TRUNC,
> -			S_IRWXU | S_IRWXG | S_IRWXO, stream->uid, stream->gid);
> -	if (ret < 0) {
> -		PERROR("open stream path %s", full_path);
> -		goto error;
> -	}
> -	stream->out_fd = ret;
> -
> -end:
> -	/* we return 0 to let the library handle the FD internally */
> -	return 0;
> -
> -error:
> -	return ret;
> +	return lttng_create_output_file(stream);
>  }
>  
>  /*
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 8f63bf3..f2a6107 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -1360,6 +1360,8 @@ void lttng_channel_set_default_attr(struct lttng_domain *domain,
>  		attr->subbuf_size = default_get_kernel_channel_subbuf_size();
>  		attr->num_subbuf = DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM;
>  		attr->output = DEFAULT_KERNEL_CHANNEL_OUTPUT;
> +		attr->tracefile_size = DEFAULT_KERNEL_CHANNEL_TRACEFILE_SIZE;
> +		attr->tracefile_count = DEFAULT_KERNEL_CHANNEL_TRACEFILE_COUNT;
>  		break;
>  	case LTTNG_DOMAIN_UST:
>  #if 0
> @@ -1374,6 +1376,8 @@ void lttng_channel_set_default_attr(struct lttng_domain *domain,
>  		attr->subbuf_size = default_get_ust_channel_subbuf_size();
>  		attr->num_subbuf = DEFAULT_UST_CHANNEL_SUBBUF_NUM;
>  		attr->output = DEFAULT_UST_CHANNEL_OUTPUT;
> +		attr->tracefile_size = DEFAULT_UST_CHANNEL_TRACEFILE_SIZE;
> +		attr->tracefile_count = DEFAULT_UST_CHANNEL_TRACEFILE_COUNT;
>  		break;
>  	default:
>  		/* Default behavior: leave set to 0. */
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
