From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS 2.4 RFC PATCH] Kernel consumer
	generate indexes
Date: Fri, 9 Aug 2013 11:42:53 -0400
Message-ID: <20130809154253.GA13969__40852.3599304774$1376063034$gmane$org@Krystal>
References: <1376061469-30350-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V7oq9-0006s2-Sw
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 11:43:04 -0400
Content-Disposition: inline
In-Reply-To: <1376061469-30350-1-git-send-email-jdesfossez@efficios.com>
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
> Some code will be refactored to share between kernel and UST, but
> before going further, I'd like to gather some feedbacks to make
> sure this design is acceptable.
> 
> Thanks,
> 
> Julien
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  include/lttng/lttng-index.h                  |   44 ++++++++++
>  src/common/consumer.c                        |    1 +
>  src/common/consumer.h                        |    4 +
>  src/common/kernel-consumer/kernel-consumer.c |  112 ++++++++++++++++++++++++++
>  src/common/kernel-ctl/kernel-ctl.c           |   36 +++++++++
>  src/common/kernel-ctl/kernel-ctl.h           |    8 ++
>  src/common/kernel-ctl/kernel-ioctl.h         |   13 +++
>  7 files changed, 218 insertions(+)
>  create mode 100644 include/lttng/lttng-index.h
> 
> diff --git a/include/lttng/lttng-index.h b/include/lttng/lttng-index.h
> new file mode 100644
> index 0000000..56f325a
> --- /dev/null
> +++ b/include/lttng/lttng-index.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
> + *                      David Goulet <dgoulet@efficios.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2 only,
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef LTTNG_INDEX_H
> +#define LTTNG_INDEX_H
> +
> +#include <limits.h>
> +
> +#define INDEX_MAGIC "CTFIDX"
> +#define INDEX_MAJOR 1
> +#define INDEX_MINOR 0
> +
> +struct lttng_packet_index_file_hdr {
> +	char magic[6];
> +	uint32_t index_major;
> +	uint32_t index_minor;
> +} __attribute__((__packed__));
> +
> +struct lttng_packet_index {
> +	uint64_t offset;		/* offset of the packet in the file, in bytes */
> +	uint64_t packet_size;		/* packet size, in bits */
> +	uint64_t content_size;		/* content size, in bits */
> +	uint64_t timestamp_begin;
> +	uint64_t timestamp_end;
> +	uint64_t events_discarded;
> +	uint64_t stream_id;
> +} __attribute__((__packed__));
> +
> +#endif /* LTTNG_INDEX_H */
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 221c348..a3dfea4 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -505,6 +505,7 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
>  	stream->session_id = session_id;
>  	stream->monitor = monitor;
>  	stream->endpoint_status = CONSUMER_ENDPOINT_ACTIVE;
> +	stream->index_fd = -1;
>  	pthread_mutex_init(&stream->lock, NULL);
>  
>  	/* If channel is the metadata, flag this stream as metadata. */
> diff --git a/src/common/consumer.h b/src/common/consumer.h
> index 5021a10..f4e6cfb 100644
> --- a/src/common/consumer.h
> +++ b/src/common/consumer.h
> @@ -318,6 +318,10 @@ struct lttng_consumer_stream {
>  	 * to the channel.
>  	 */
>  	uint64_t ust_metadata_pushed;
> +	/*
> +	 * FD of the index file for this stream.
> +	 */
> +	int index_fd;
>  };
>  
>  /*
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> index bfec4d2..f910d85 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -38,6 +38,7 @@
>  #include <common/relayd/relayd.h>
>  #include <common/utils.h>
>  #include <common/consumer-stream.h>
> +#include <lttng/lttng-index.h>
>  
>  #include "kernel-consumer.h"
>  
> @@ -843,6 +844,56 @@ error_fatal:
>  	return -1;
>  }
>  
> +static int get_index_values(struct lttng_packet_index *index, int infd)
> +{
> +	int ret;
> +
> +	ret = kernctl_get_timestamp_begin(infd, &index->timestamp_begin);
> +	if (ret < 0) {
> +		PERROR("kernctl_get_timestamp_begin");
> +		goto error;
> +	}
> +	index->timestamp_begin = htobe64(index->timestamp_begin);
> +
> +	ret = kernctl_get_timestamp_end(infd, &index->timestamp_end);
> +	if (ret < 0) {
> +		PERROR("kernctl_get_timestamp_end");
> +		goto error;
> +	}
> +	index->timestamp_end = htobe64(index->timestamp_end);
> +
> +	ret = kernctl_get_events_discarded(infd, &index->events_discarded);
> +	if (ret < 0) {
> +		PERROR("kernctl_get_events_discarded");
> +		goto error;
> +	}
> +	index->events_discarded = htobe64(index->events_discarded);
> +
> +	ret = kernctl_get_content_size(infd, &index->content_size);
> +	if (ret < 0) {
> +		PERROR("kernctl_get_content_size");
> +		goto error;
> +	}
> +	index->content_size = htobe64(index->content_size);
> +
> +	ret = kernctl_get_packet_size(infd, &index->packet_size);
> +	if (ret < 0) {
> +		PERROR("kernctl_get_packet_size");
> +		goto error;
> +	}
> +	index->packet_size = htobe64(index->packet_size);
> +
> +	ret = kernctl_get_stream_id(infd, &index->stream_id);
> +	if (ret < 0) {
> +		PERROR("kernctl_get_stream_id");
> +		goto error;
> +	}
> +	index->stream_id = htobe64(index->stream_id);
> +
> +error:
> +	return ret;
> +}
> +
>  /*
>   * Consume data on a file descriptor and write it on a trace file.
>   */
> @@ -853,6 +904,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
>  	int err;
>  	ssize_t ret = 0;
>  	int infd = stream->wait_fd;
> +	struct lttng_packet_index index;
>  
>  	DBG("In read_subbuffer (infd : %d)", infd);
>  	/* Get the next subbuffer */
> @@ -878,6 +930,14 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
>  		goto end;
>  	}
>  
> +	if (!stream->metadata_flag) {
> +		index.offset = htobe64(stream->out_fd_offset);
> +		ret = get_index_values(&index, infd);
> +		if (ret < 0) {
> +			goto end;
> +		}
> +	}
> +
>  	switch (stream->chan->output) {
>  	case CONSUMER_CHANNEL_SPLICE:
>  		/*
> @@ -888,6 +948,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
>  		subbuf_size = len;
>  		padding = 0;
>  
> +

extra whiteline to remove.

>  		/* splice the subbuffer to the tracefile */
>  		ret = lttng_consumer_on_read_subbuffer_splice(ctx, stream, subbuf_size,
>  				padding);
> @@ -954,10 +1015,54 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
>  		goto end;
>  	}
>  
> +	if (stream->index_fd < 0) {
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	ret = write(stream->index_fd, &index, sizeof(index));

you should handle EINTR. See other write() use in the tools code.

> +	if (ret < 0) {
> +		PERROR("Writing index file");
> +	}
> +	ret = 0;
> +
>  end:
>  	return ret;
>  }
>  
> +static int create_index_file(struct lttng_consumer_stream *stream)
> +{
> +	char *index_name;
> +	struct lttng_packet_index_file_hdr hdr;
> +	int ret;
> +
> +	ret = asprintf(&index_name, "%s.idx", stream->name);
> +	if (ret < 0) {
> +		PERROR("Allocating index name");
> +		goto error;
> +	}
> +	ret = utils_create_stream_file(stream->chan->pathname,
> +			index_name, 0, 0, stream->uid,
> +			stream->gid);
> +	free(index_name);
> +	if (ret < 0) {
> +		goto error;
> +	}
> +
> +	stream->index_fd = ret;
> +	strncpy(hdr.magic, INDEX_MAGIC, sizeof(hdr.magic));

If you use strncpy, it's because you don't trust that INDEX_MAGIC will
always fit within hdr.magic. If it is the case, then you should always
do:

hdr.magic[sizeof(hdr.magic) - 1] = '\0';

after the strncpy.

> +	hdr.index_major = htobe32(INDEX_MAJOR);
> +	hdr.index_minor = htobe32(INDEX_MINOR);
> +	ret = write(stream->index_fd, &hdr, sizeof(hdr));

you should handle EINTR.

> +	if (ret < 0) {
> +		PERROR("Writing index header");
> +	}

remove a whiteline.

The approach looks good to me!

Thanks,

Mathieu

> +
> +
> +error:
> +	return ret;
> +}
> +
>  int lttng_kconsumer_on_recv_stream(struct lttng_consumer_stream *stream)
>  {
>  	int ret;
> @@ -977,6 +1082,13 @@ int lttng_kconsumer_on_recv_stream(struct lttng_consumer_stream *stream)
>  		}
>  		stream->out_fd = ret;
>  		stream->tracefile_size_current = 0;
> +
> +		if (!stream->metadata_flag) {
> +			ret = create_index_file(stream);
> +			if (ret < 0) {
> +				goto error;
> +			}
> +		}
>  	}
>  
>  	if (stream->output == LTTNG_EVENT_MMAP) {
> diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
> index d850f38..495301e 100644
> --- a/src/common/kernel-ctl/kernel-ctl.c
> +++ b/src/common/kernel-ctl/kernel-ctl.c
> @@ -390,3 +390,39 @@ int kernctl_put_subbuf(int fd)
>  {
>  	return ioctl(fd, RING_BUFFER_PUT_SUBBUF);
>  }
> +
> +/* Returns the timestamp begin of the current sub-buffer. */
> +int kernctl_get_timestamp_begin(int fd, uint64_t *timestamp_begin)
> +{
> +	return ioctl(fd, LTTNG_RING_BUFFER_GET_TIMESTAMP_BEGIN, timestamp_begin);
> +}
> +
> +/* Returns the timestamp end of the current sub-buffer. */
> +int kernctl_get_timestamp_end(int fd, uint64_t *timestamp_end)
> +{
> +	return ioctl(fd, LTTNG_RING_BUFFER_GET_TIMESTAMP_END, timestamp_end);
> +}
> +
> +/* Returns the number of discarded events in the current sub-buffer. */
> +int kernctl_get_events_discarded(int fd, uint64_t *events_discarded)
> +{
> +	return ioctl(fd, LTTNG_RING_BUFFER_GET_EVENTS_DISCARDED, events_discarded);
> +}
> +
> +/* Returns the content size in the current sub-buffer. */
> +int kernctl_get_content_size(int fd, uint64_t *content_size)
> +{
> +	return ioctl(fd, LTTNG_RING_BUFFER_GET_CONTENT_SIZE, content_size);
> +}
> +
> +/* Returns the packet size in the current sub-buffer. */
> +int kernctl_get_packet_size(int fd, uint64_t *packet_size)
> +{
> +	return ioctl(fd, LTTNG_RING_BUFFER_GET_PACKET_SIZE, packet_size);
> +}
> +
> +/* Returns the stream id of the current sub-buffer. */
> +int kernctl_get_stream_id(int fd, uint64_t *stream_id)
> +{
> +	return ioctl(fd, LTTNG_RING_BUFFER_GET_STREAM_ID, stream_id);
> +}
> diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
> index ea2aa58..badf609 100644
> --- a/src/common/kernel-ctl/kernel-ctl.h
> +++ b/src/common/kernel-ctl/kernel-ctl.h
> @@ -67,4 +67,12 @@ int kernctl_put_subbuf(int fd);
>  
>  int kernctl_buffer_flush(int fd);
>  
> +/* index */
> +int kernctl_get_timestamp_begin(int fd, uint64_t *timestamp_begin);
> +int kernctl_get_timestamp_end(int fd, uint64_t *timestamp_end);
> +int kernctl_get_events_discarded(int fd, uint64_t *events_discarded);
> +int kernctl_get_content_size(int fd, uint64_t *content_size);
> +int kernctl_get_packet_size(int fd, uint64_t *packet_size);
> +int kernctl_get_stream_id(int fd, uint64_t *stream_id);
> +
>  #endif /* _LTTNG_KERNEL_CTL_H */
> diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
> index 75d6da0..1a3b169 100644
> --- a/src/common/kernel-ctl/kernel-ioctl.h
> +++ b/src/common/kernel-ctl/kernel-ioctl.h
> @@ -47,6 +47,19 @@
>  /* flush the current sub-buffer */
>  #define RING_BUFFER_FLUSH                   _IO(0xF6, 0x0C)
>  
> +/* returns the timestamp begin of the current sub-buffer */
> +#define LTTNG_RING_BUFFER_GET_TIMESTAMP_BEGIN     _IOR(0xF6, 0x20, uint64_t)
> +/* returns the timestamp end of the current sub-buffer */
> +#define LTTNG_RING_BUFFER_GET_TIMESTAMP_END       _IOR(0xF6, 0x21, uint64_t)
> +/* returns the number of events discarded */
> +#define LTTNG_RING_BUFFER_GET_EVENTS_DISCARDED    _IOR(0xF6, 0x22, uint64_t)
> +/* returns the packet payload size */
> +#define LTTNG_RING_BUFFER_GET_CONTENT_SIZE        _IOR(0xF6, 0x23, uint64_t)
> +/* returns the actual packet size */
> +#define LTTNG_RING_BUFFER_GET_PACKET_SIZE         _IOR(0xF6, 0x24, uint64_t)
> +/* returns the stream id */
> +#define LTTNG_RING_BUFFER_GET_STREAM_ID           _IOR(0xF6, 0x25, uint64_t)
> +
>  /* Old ABI (without support for 32/64 bits compat) */
>  /* LTTng file descriptor ioctl */
>  #define LTTNG_KERNEL_OLD_SESSION                _IO(0xF6, 0x40)
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
