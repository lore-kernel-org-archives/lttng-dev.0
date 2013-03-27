From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] On-disk multiple
	tracefiles	circular buffer
Date: Wed, 27 Mar 2013 15:38:51 -0400
Message-ID: <20130327193851.GA13993__44419.0617571168$1364413203$gmane$org@Krystal>
References: <1364409938-26174-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UKwBU-00088i-Ii
	for lttng-dev@lists.lttng.org; Wed, 27 Mar 2013 15:38:56 -0400
Content-Disposition: inline
In-Reply-To: <1364409938-26174-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> From: Julien Desfossez <jdesfossez@efficios.com>
> 
> This patch introduces the tracefile_size and tracefile_count parameters
> to the enable-channel command and the API.
> 
> This allows to split a stream into multiple tracefiles and limit the
> amount of trace data to keep on disk. The tracefiles are readable
> independently or with the others as long as the metadata file is
> present.
> 
> For now only local traces are handled, relayd modifications coming soon.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  doc/man/lttng.1                              |    5 ++
>  include/lttng/lttng.h                        |    5 +-
>  src/bin/lttng-sessiond/channel.c             |   10 +++
>  src/bin/lttng-sessiond/consumer.c            |   12 ++-
>  src/bin/lttng-sessiond/consumer.h            |    8 +-
>  src/bin/lttng-sessiond/kernel-consumer.c     |    9 +-
>  src/bin/lttng-sessiond/kernel.c              |    3 +
>  src/bin/lttng-sessiond/trace-kernel.h        |    2 +
>  src/bin/lttng-sessiond/trace-ust.c           |    4 +
>  src/bin/lttng-sessiond/trace-ust.h           |    2 +
>  src/bin/lttng-sessiond/ust-app.c             |    3 +
>  src/bin/lttng-sessiond/ust-app.h             |    2 +
>  src/bin/lttng-sessiond/ust-consumer.c        |    4 +-
>  src/bin/lttng/commands/enable_channels.c     |   33 +++++++
>  src/common/consumer.c                        |  123 +++++++++++++++++++++++++-
>  src/common/consumer.h                        |   11 ++-
>  src/common/defaults.h                        |    8 ++
>  src/common/kernel-consumer/kernel-consumer.c |   21 ++---
>  src/common/sessiond-comm/sessiond-comm.h     |    4 +
>  src/common/ust-consumer/ust-consumer.c       |   39 ++------
>  src/lib/lttng-ctl/lttng-ctl.c                |    4 +
>  21 files changed, 253 insertions(+), 59 deletions(-)
> 
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 0a548f8..891e106 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -345,6 +345,11 @@ same type.
>          Use per PID buffer (\-u only). Each application has its own buffers.
>  \-\-buffers-global
>          Use shared buffer for the whole system (\-k only)
> +\-C, \-\-tracefile-size SIZE
> +        Maximum size of tracefiles per stream (in bytes)

of each tracefile within a stream

> +\-W, \-\-tracefile-count COUNT
> +        Number of tracefiles per stream

Can we beef up these descriptions so users can have a clue what this is
supposed to be used for ? An example would be good.

> +
>  .fi
>  
>  .IP
> diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
> index 8566dea..9fa5844 100644
> --- a/include/lttng/lttng.h
> +++ b/include/lttng/lttng.h
> @@ -277,7 +277,7 @@ struct lttng_event_field {
>   *
>   * The structures should be initialized to zero before use.
>   */
> -#define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN + 32
> +#define LTTNG_CHANNEL_ATTR_PADDING1        LTTNG_SYMBOL_NAME_LEN + 20
>  struct lttng_channel_attr {
>  	int overwrite;                      /* 1: overwrite, 0: discard */
>  	uint64_t subbuf_size;               /* bytes */
> @@ -285,6 +285,9 @@ struct lttng_channel_attr {
>  	unsigned int switch_timer_interval; /* usec */
>  	unsigned int read_timer_interval;   /* usec */
>  	enum lttng_event_output output;     /* splice, mmap */
> +	/* LTTng 2.1 padding limit */
> +	uint64_t tracefile_size;                 /* bytes */
> +	uint32_t tracefile_count;                /* number of tracefiles */

why not uint64_t (same comment for all type use below) ?

>  
>  	char padding[LTTNG_CHANNEL_ATTR_PADDING1];
>  };
> diff --git a/src/bin/lttng-sessiond/channel.c b/src/bin/lttng-sessiond/channel.c
> index 6c7422b..1621bc6 100644
> --- a/src/bin/lttng-sessiond/channel.c
> +++ b/src/bin/lttng-sessiond/channel.c
> @@ -272,6 +272,16 @@ int channel_ust_create(struct ltt_ust_session *usess,
>  		goto error;
>  	}
>  
> +	/*
> +	 * The tracefile_size should not be < to the subbuf_size, otherwise
> +	 * we won't be able to write the packets on disk
> +	 */
> +	if ((attr->attr.tracefile_size > 0) &&
> +			(attr->attr.tracefile_size < attr->attr.subbuf_size)) {
> +		ret = LTTNG_ERR_INVALID;
> +		goto error;
> +	}
> +
>  	/* Create UST channel */
>  	uchan = trace_ust_create_channel(attr, usess->pathname);
>  	if (uchan == NULL) {
> diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
> index f0fb2dc..c3f53be 100644
> --- a/src/bin/lttng-sessiond/consumer.c
> +++ b/src/bin/lttng-sessiond/consumer.c
> @@ -663,7 +663,9 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		uint64_t relayd_id,
>  		uint64_t key,
>  		unsigned char *uuid,
> -		uint32_t chan_id)
> +		uint32_t chan_id,
> +		uint64_t tracefile_size,
> +		uint32_t tracefile_count)
>  {
>  	assert(msg);
>  
> @@ -684,6 +686,8 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  	msg->u.ask_channel.relayd_id = relayd_id;
>  	msg->u.ask_channel.key = key;
>  	msg->u.ask_channel.chan_id = chan_id;
> +	msg->u.ask_channel.tracefile_size = tracefile_size;
> +	msg->u.ask_channel.tracefile_count = tracefile_count;
>  
>  	memcpy(msg->u.ask_channel.uuid, uuid, sizeof(msg->u.ask_channel.uuid));
>  
> @@ -709,7 +713,9 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		const char *name,
>  		unsigned int nb_init_streams,
>  		enum lttng_event_output output,
> -		int type)
> +		int type,
> +		uint64_t tracefile_size,
> +		uint32_t tracefile_count)
>  {
>  	assert(msg);
>  
> @@ -726,6 +732,8 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  	msg->u.channel.nb_init_streams = nb_init_streams;
>  	msg->u.channel.output = output;
>  	msg->u.channel.type = type;
> +	msg->u.channel.tracefile_size = tracefile_size;
> +	msg->u.channel.tracefile_count = tracefile_count;
>  
>  	strncpy(msg->u.channel.pathname, pathname,
>  			sizeof(msg->u.channel.pathname));
> diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
> index b767589..c2631ba 100644
> --- a/src/bin/lttng-sessiond/consumer.h
> +++ b/src/bin/lttng-sessiond/consumer.h
> @@ -200,7 +200,9 @@ void consumer_init_ask_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		uint64_t relayd_id,
>  		uint64_t key,
>  		unsigned char *uuid,
> -		uint32_t chan_id);
> +		uint32_t chan_id,
> +		uint64_t tracefile_size,
> +		uint32_t tracefile_count);
>  void consumer_init_stream_comm_msg(struct lttcomm_consumer_msg *msg,
>  		enum lttng_consumer_command cmd,
>  		uint64_t channel_key,
> @@ -217,7 +219,9 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
>  		const char *name,
>  		unsigned int nb_init_streams,
>  		enum lttng_event_output output,
> -		int type);
> +		int type,
> +		uint64_t tracefile_size,
> +		uint32_t tracefile_count);
>  int consumer_is_data_pending(uint64_t session_id,
>  		struct consumer_output *consumer);
>  int consumer_close_metadata(struct consumer_socket *socket,
> diff --git a/src/bin/lttng-sessiond/kernel-consumer.c b/src/bin/lttng-sessiond/kernel-consumer.c
> index 3368da6..05e30e4 100644
> --- a/src/bin/lttng-sessiond/kernel-consumer.c
> +++ b/src/bin/lttng-sessiond/kernel-consumer.c
> @@ -94,7 +94,9 @@ int kernel_consumer_add_channel(struct consumer_socket *sock,
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
> @@ -174,7 +176,8 @@ int kernel_consumer_add_metadata(struct consumer_socket *sock,
>  			DEFAULT_METADATA_NAME,
>  			1,
>  			DEFAULT_KERNEL_CHANNEL_OUTPUT,
> -			CONSUMER_CHANNEL_TYPE_METADATA);
> +			CONSUMER_CHANNEL_TYPE_METADATA,
> +			0, 0);
>  
>  	health_code_update();
>  
> @@ -190,7 +193,7 @@ int kernel_consumer_add_metadata(struct consumer_socket *sock,
>  			LTTNG_CONSUMER_ADD_STREAM,
>  			session->metadata->fd,
>  			session->metadata_stream_fd,
> -			0);	/* CPU: 0 for metadata. */
> +			0); /* CPU: 0 for metadata. */
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
> index 66ca8db..ea30827 100644
> --- a/src/bin/lttng-sessiond/trace-kernel.h
> +++ b/src/bin/lttng-sessiond/trace-kernel.h
> @@ -82,6 +82,8 @@ struct ltt_kernel_stream {
>  	int cpu;
>  	/* Format is %s_%d respectively channel name and CPU number. */
>  	char name[DEFAULT_STREAM_NAME_LEN];
> +	uint64_t tracefile_size;
> +	uint32_t tracefile_count;
>  	struct cds_list_head list;
>  };
>  
> diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
> index 8f15a15..cd8ff10 100644
> --- a/src/bin/lttng-sessiond/trace-ust.c
> +++ b/src/bin/lttng-sessiond/trace-ust.c
> @@ -293,6 +293,10 @@ struct ltt_ust_channel *trace_ust_create_channel(struct lttng_channel *chan,
>  	luc->events = lttng_ht_new(0, LTTNG_HT_TYPE_STRING);
>  	luc->ctx = lttng_ht_new(0, LTTNG_HT_TYPE_ULONG);
>  
> +	/* On-disk circular buffer parameters */
> +	luc->tracefile_size = chan->attr.tracefile_size;
> +	luc->tracefile_count = chan->attr.tracefile_count;
> +
>  	DBG2("Trace UST channel %s created", luc->name);
>  
>  error:
> diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
> index 87fe412..588905a 100644
> --- a/src/bin/lttng-sessiond/trace-ust.h
> +++ b/src/bin/lttng-sessiond/trace-ust.h
> @@ -59,6 +59,8 @@ struct ltt_ust_channel {
>  	struct lttng_ht *ctx;
>  	struct lttng_ht *events;
>  	struct lttng_ht_node_str node;
> +	uint64_t tracefile_size;
> +	uint32_t tracefile_count;
>  };
>  
>  /* UST Metadata */
> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
> index fdcad1c..4c9d227 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -1298,6 +1298,9 @@ static void shadow_copy_channel(struct ust_app_channel *ua_chan,
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
> index 82694a7..b94603f 100644
> --- a/src/bin/lttng-sessiond/ust-app.h
> +++ b/src/bin/lttng-sessiond/ust-app.h
> @@ -143,6 +143,8 @@ struct ust_app_channel {
>  	struct ust_app_session *session;
>  	struct lttng_ht *ctx;
>  	struct lttng_ht *events;
> +	uint64_t tracefile_size;
> +	uint32_t tracefile_count;
>  	/*
>  	 * Node indexed by channel name in the channels' hash table of a session.
>  	 */
> diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
> index 7f01de9..93c1f71 100644
> --- a/src/bin/lttng-sessiond/ust-consumer.c
> +++ b/src/bin/lttng-sessiond/ust-consumer.c
> @@ -155,7 +155,9 @@ static int ask_channel_creation(struct ust_app_session *ua_sess,
>  			consumer->net_seq_index,
>  			ua_chan->key,
>  			registry->uuid,
> -			chan_id);
> +			chan_id,
> +			ua_chan->tracefile_size,
> +			ua_chan->tracefile_count);
>  
>  	health_code_update();
>  
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
> index 02a3180..d303bbd 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -49,6 +49,8 @@ enum {
>  	OPT_READ_TIMER,
>  	OPT_USERSPACE,
>  	OPT_LIST_OPTIONS,
> +	OPT_TRACEFILE_SIZE,
> +	OPT_TRACEFILE_COUNT,
>  };
>  
>  static struct lttng_handle *handle;
> @@ -73,6 +75,8 @@ static struct poptOption long_options[] = {
>  	{"buffers-uid",    0,	POPT_ARG_VAL, &opt_buffer_uid, 1, 0, 0},
>  	{"buffers-pid",    0,	POPT_ARG_VAL, &opt_buffer_pid, 1, 0, 0},
>  	{"buffers-global", 0,	POPT_ARG_VAL, &opt_buffer_global, 1, 0, 0},
> +	{"tracefile_size", 'C',   POPT_ARG_INT, 0, OPT_TRACEFILE_SIZE, 0, 0},
> +	{"tracefile_count", 'W',   POPT_ARG_INT, 0, OPT_TRACEFILE_COUNT, 0, 0},
>  	{0, 0, 0, 0, 0, 0, 0}
>  };
>  
> @@ -115,6 +119,10 @@ static void usage(FILE *ofp)
>  	fprintf(ofp, "      --buffers-uid        Use per UID buffer (-u only)\n");
>  	fprintf(ofp, "      --buffers-pid        Use per PID buffer (-u only)\n");
>  	fprintf(ofp, "      --buffers-global     Use shared buffer for the whole system (-k only)\n");
> +	fprintf(ofp, "  -C, --tracefile-size SIZE\n");
> +	fprintf(ofp, "                           Maximum size of tracefiles per stream (in bytes)\n");
> +	fprintf(ofp, "  -W, --tracefile-count COUNT\n");
> +	fprintf(ofp, "                           Number of tracefiles per stream to keep\n");

more info would be welcome, like the manpage.

>  	fprintf(ofp, "\n");
>  }
>  
> @@ -147,6 +155,12 @@ static void set_default_attr(struct lttng_domain *dom)
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
> @@ -179,6 +193,15 @@ static int enable_channel(char *session_name)
>  
>  	set_default_attr(&dom);
>  
> +	if ((chan.attr.tracefile_size > 0) &&
> +			(chan.attr.tracefile_size < chan.attr.subbuf_size)) {
> +		ERR("Tracefile_size must be superior or equal to subbuf_size "

superior -> higher

Thanks,

Mathieu

> +				"(%" PRIu64 " < %" PRIu64 ")",
> +				chan.attr.tracefile_size, chan.attr.subbuf_size);
> +		ret = CMD_ERROR;
> +		goto error;
> +	}
> +
>  	/* Setting channel output */
>  	if (opt_output) {
>  		if (!strncmp(output_mmap, opt_output, strlen(output_mmap))) {
> @@ -307,6 +330,16 @@ int cmd_enable_channels(int argc, const char **argv)
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
> +			DBG("Maximum tracefile count set to %" PRIu32,
> +					chan.attr.tracefile_count);
> +			break;
>  		case OPT_LIST_OPTIONS:
>  			list_cmd_options(stdout, long_options);
>  			goto end;
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 5f87f4b..0c59846 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -828,7 +828,9 @@ struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
>  		uid_t uid,
>  		gid_t gid,
>  		int relayd_id,
> -		enum lttng_event_output output)
> +		enum lttng_event_output output,
> +		uint64_t tracefile_size,
> +		uint32_t tracefile_count)
>  {
>  	struct lttng_consumer_channel *channel;
>  
> @@ -845,6 +847,8 @@ struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
>  	channel->gid = gid;
>  	channel->relayd_id = relayd_id;
>  	channel->output = output;
> +	channel->tracefile_size = tracefile_size;
> +	channel->tracefile_count = tracefile_count;
>  
>  	strncpy(channel->pathname, pathname, sizeof(channel->pathname));
>  	channel->pathname[sizeof(channel->pathname) - 1] = '\0';
> @@ -1284,6 +1288,93 @@ end:
>  }
>  
>  /*
> + * Create the tracefile on disk.
> + *
> + * Return 0 on success or else a negative value.
> + */
> +int lttng_create_output_file(struct lttng_consumer_stream *stream)
> +{
> +	int ret;
> +	char full_path[PATH_MAX];
> +	char *path_name_id = NULL;
> +	char *path;
> +
> +	assert(stream);
> +	assert(stream->net_seq_idx == (uint64_t) -1ULL);
> +
> +	ret = snprintf(full_path, sizeof(full_path), "%s/%s",
> +			stream->chan->pathname, stream->name);
> +	if (ret < 0) {
> +		PERROR("snprintf create output file");
> +		goto error;
> +	}
> +
> +	/*
> +	 * If we split the trace in multiple files, we have to add the tracefile
> +	 * current count at the end of the tracefile name
> +	 */
> +	if (stream->chan->tracefile_size > 0) {
> +		ret = asprintf(&path_name_id, "%s_%" PRIu32, full_path,
> +				stream->tracefile_count_current);
> +		if (ret < 0) {
> +			PERROR("Allocating path name ID");
> +			goto error;
> +		}
> +		path = path_name_id;
> +	} else {
> +		path = full_path;
> +	}
> +
> +	ret = run_as_open(path, O_WRONLY | O_CREAT | O_TRUNC,
> +			S_IRWXU | S_IRWXG | S_IRWXO, stream->uid, stream->gid);
> +	if (ret < 0) {
> +		PERROR("open stream path %s", path);
> +		goto error_open;
> +	}
> +	stream->out_fd = ret;
> +	stream->tracefile_size_current = 0;
> +
> +error_open:
> +	free(path_name_id);
> +error:
> +	return ret;
> +}
> +
> +/*
> + * Change the output tracefile according to the tracefile_size and
> + * tracefile_count parameters. The stream lock MUST be held before calling this
> + * function because we are modifying the stream status.
> + *
> + * Return 0 on success or else a negative value.
> + */
> +static int rotate_output_file(struct lttng_consumer_stream *stream)
> +{
> +	int ret;
> +
> +	assert(stream);
> +	assert(stream->tracefile_size_current);
> +
> +	ret = close(stream->out_fd);
> +	if (ret < 0) {
> +		PERROR("Closing tracefile");
> +		goto end;
> +	}
> +
> +	if (stream->chan->tracefile_count > 0) {
> +		stream->tracefile_count_current =
> +			(stream->tracefile_count_current + 1) %
> +			stream->chan->tracefile_count;
> +	} else {
> +		stream->tracefile_count_current++;
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
> @@ -1390,6 +1481,21 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
>  	} else {
>  		/* No streaming, we have to set the len with the full padding */
>  		len += padding;
> +
> +		/*
> +		 * Check if we need to change the tracefile before writing the packet.
> +		 */
> +		if (stream->chan->tracefile_size > 0 &&
> +				(stream->tracefile_size_current + len) >
> +				stream->chan->tracefile_size) {
> +			ret = rotate_output_file(stream);
> +			if (ret < 0) {
> +				ERR("Rotating output file");
> +				goto end;
> +			}
> +			outfd = stream->out_fd;
> +		}
> +		stream->tracefile_size_current += len;
>  	}
>  
>  	while (len > 0) {
> @@ -1552,6 +1658,21 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
>  	} else {
>  		/* No streaming, we have to set the len with the full padding */
>  		len += padding;
> +
> +		/*
> +		 * Check if we need to change the tracefile before writing the packet.
> +		 */
> +		if (stream->chan->tracefile_size > 0 &&
> +				(stream->tracefile_size_current + len) >
> +				stream->chan->tracefile_size) {
> +			ret = rotate_output_file(stream);
> +			if (ret < 0) {
> +				ERR("Rotating output file");
> +				goto end;
> +			}
> +			outfd = stream->out_fd;
> +		}
> +		stream->tracefile_size_current += len;
>  	}
>  
>  	while (len > 0) {
> diff --git a/src/common/consumer.h b/src/common/consumer.h
> index 4638752..6a15b0c 100644
> --- a/src/common/consumer.h
> +++ b/src/common/consumer.h
> @@ -146,6 +146,9 @@ struct lttng_consumer_channel {
>  	/* For metadata periodical flush */
>  	int switch_timer_enabled;
>  	timer_t switch_timer;
> +	/* On-disk circular buffer */
> +	uint64_t tracefile_size;
> +	uint32_t tracefile_count;
>  };
>  
>  /*
> @@ -233,6 +236,9 @@ struct lttng_consumer_stream {
>  	/* Internal state of libustctl. */
>  	struct ustctl_consumer_stream *ustream;
>  	struct cds_list_head send_node;
> +	/* On-disk circular buffer */
> +	uint64_t tracefile_size_current;
> +	uint32_t tracefile_count_current;
>  };
>  
>  /*
> @@ -460,7 +466,9 @@ struct lttng_consumer_channel *consumer_allocate_channel(uint64_t key,
>  		uid_t uid,
>  		gid_t gid,
>  		int relayd_id,
> -		enum lttng_event_output output);
> +		enum lttng_event_output output,
> +		uint64_t tracefile_size,
> +		uint32_t tracefile_count);
>  void consumer_del_stream(struct lttng_consumer_stream *stream,
>  		struct lttng_ht *ht);
>  void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
> @@ -486,6 +494,7 @@ struct lttng_consumer_local_data *lttng_consumer_create(
>  		int (*recv_stream)(struct lttng_consumer_stream *stream),
>  		int (*update_stream)(int sessiond_key, uint32_t state));
>  void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx);
> +int lttng_create_output_file(struct lttng_consumer_stream *stream);
>  ssize_t lttng_consumer_on_read_subbuffer_mmap(
>  		struct lttng_consumer_local_data *ctx,
>  		struct lttng_consumer_stream *stream, unsigned long len,
> diff --git a/src/common/defaults.h b/src/common/defaults.h
> index 94a2a35..fb6a975 100644
> --- a/src/common/defaults.h
> +++ b/src/common/defaults.h
> @@ -136,6 +136,10 @@
>  #define DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM   DEFAULT_CHANNEL_SUBBUF_NUM
>  /* See lttng-kernel.h enum lttng_kernel_output for channel output */
>  #define DEFAULT_KERNEL_CHANNEL_OUTPUT       LTTNG_EVENT_SPLICE
> +/* By default, unlimited tracefile size */
> +#define DEFAULT_KERNEL_CHANNEL_TRACEFILE_SIZE  0
> +/* By default, unlimited tracefile count */
> +#define DEFAULT_KERNEL_CHANNEL_TRACEFILE_COUNT 0
>  
>  #define DEFAULT_KERNEL_CHANNEL_SWITCH_TIMER	\
>  		DEFAULT_CHANNEL_SWITCH_TIMER
> @@ -149,6 +153,10 @@
>  #define DEFAULT_UST_CHANNEL_SUBBUF_NUM      DEFAULT_CHANNEL_SUBBUF_NUM
>  /* See lttng-ust.h enum lttng_ust_output */
>  #define DEFAULT_UST_CHANNEL_OUTPUT          LTTNG_EVENT_MMAP
> +/* By default, unlimited tracefile size */
> +#define DEFAULT_UST_CHANNEL_TRACEFILE_SIZE  0
> +/* By default, unlimited tracefile count */
> +#define DEFAULT_UST_CHANNEL_TRACEFILE_COUNT 0
>  
>  #define DEFAULT_UST_CHANNEL_SWITCH_TIMER	\
>  		DEFAULT_CHANNEL_SWITCH_TIMER
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> index 0de7344..385af87 100644
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
> @@ -501,28 +503,15 @@ end:
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
> index 63d4eda..5980ddf 100644
> --- a/src/common/sessiond-comm/sessiond-comm.h
> +++ b/src/common/sessiond-comm/sessiond-comm.h
> @@ -291,6 +291,8 @@ struct lttcomm_consumer_msg {
>  			/* Use splice or mmap to consume this fd */
>  			enum lttng_event_output output;
>  			int type; /* Per cpu or metadata. */
> +			uint64_t tracefile_size; /* bytes */
> +			uint32_t tracefile_count; /* number of tracefiles */
>  		} LTTNG_PACKED channel; /* Only used by Kernel. */
>  		struct {
>  			uint64_t stream_key;
> @@ -328,6 +330,8 @@ struct lttcomm_consumer_msg {
>  			uint64_t key;				/* Unique channel key. */
>  			unsigned char uuid[UUID_STR_LEN];	/* uuid for ust tracer. */
>  			uint32_t chan_id;			/* Channel ID on the tracer side. */
> +			uint64_t tracefile_size;	/* bytes */
> +			uint32_t tracefile_count;	/* number of tracefiles */
>  		} LTTNG_PACKED ask_channel;
>  		struct {
>  			uint64_t key;
> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
> index 431b946..95b0f62 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -112,13 +112,14 @@ error:
>   */
>  static struct lttng_consumer_channel *allocate_channel(uint64_t session_id,
>  		const char *pathname, const char *name, uid_t uid, gid_t gid,
> -		int relayd_id, uint64_t key, enum lttng_event_output output)
> +		int relayd_id, uint64_t key, enum lttng_event_output output,
> +		uint64_t tracefile_size, uint32_t tracefile_count)
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
> @@ -848,7 +849,9 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
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
> @@ -1283,35 +1286,7 @@ end:
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
