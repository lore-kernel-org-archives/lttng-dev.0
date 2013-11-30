From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] Fix data_offset when importing
	the indexes
Date: Sat, 30 Nov 2013 11:19:11 +0000 (UTC)
Message-ID: <601953286.77905.1385810351942.JavaMail.zimbra__18333.4465291866$1385810413$gmane$org@efficios.com>
References: <1385765019-2963-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VmiZt-00071r-C4
	for lttng-dev@lists.lttng.org; Sat, 30 Nov 2013 06:19:19 -0500
In-Reply-To: <1385765019-2963-1-git-send-email-jdesfossez@efficios.com>
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

----- Original Message -----
> From: "Julien Desfossez" <jdesfossez@efficios.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Julien Desfossez" <jdesfossez@efficios.com>
> Sent: Friday, November 29, 2013 11:43:39 PM
> Subject: [BABELTRACE PATCH] Fix data_offset when importing the indexes
> 
> When importing an index, we don't have the data_offset and we want to
> mmap the tracefile only when needed, so we introduce a new function to
> only compute this information when we are going to use a new packet.

Merged with tiny cleanup.

Thanks!

Mathieu

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  formats/ctf/ctf.c | 106
>  +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 5cf8097..b8103c5 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -627,6 +627,103 @@ error:
>  	return ret;
>  }
>  
> +static
> +int find_data_offset(struct ctf_stream_pos *pos,
> +		struct ctf_file_stream *file_stream,
> +		struct packet_index *packet_index)
> +{
> +	uint64_t packet_map_len = DEFAULT_HEADER_LEN, tmp_map_len;
> +	struct stat filestats;
> +	int ret;
> +	size_t filesize;
> +
> +	pos = &file_stream->pos;
> +
> +	ret = fstat(pos->fd, &filestats);
> +	if (ret < 0)
> +		return ret;
> +	filesize = filestats.st_size;
> +
> +	/* Deal with empty files */
> +	if (!filesize) {
> +		return 0;
> +	}
> +
> +begin:
> +	if (filesize - pos->mmap_offset < (packet_map_len >> LOG2_CHAR_BIT)) {
> +		packet_map_len = (filesize - pos->mmap_offset) << LOG2_CHAR_BIT;
> +	}
> +
> +	if (pos->base_mma) {
> +		/* unmap old base */
> +		ret = munmap_align(pos->base_mma);
> +		if (ret) {
> +			fprintf(stderr, "[error] Unable to unmap old base: %s.\n",
> +					strerror(errno));
> +			return ret;
> +		}
> +		pos->base_mma = NULL;
> +	}
> +	/* map new base. Need mapping length from header. */
> +	pos->base_mma = mmap_align(packet_map_len >> LOG2_CHAR_BIT, PROT_READ,
> +			MAP_PRIVATE, pos->fd, pos->mmap_offset);
> +	assert(pos->base_mma != MAP_FAILED);
> +
> +	pos->content_size = packet_map_len;
> +	pos->packet_size = packet_map_len;
> +	pos->offset = 0;	/* Position of the packet header */
> +
> +	/* update trace_packet_header and stream_packet_context */
> +	if (pos->prot != PROT_WRITE && file_stream->parent.trace_packet_header) {
> +		/* Read packet header */
> +		ret = generic_rw(&pos->parent,
> &file_stream->parent.trace_packet_header->p);
> +		if (ret) {
> +			if (ret == -EFAULT)
> +				goto retry;
> +		}
> +	}
> +	if (pos->prot != PROT_WRITE && file_stream->parent.stream_packet_context) {
> +		/* Read packet context */
> +		ret = generic_rw(&pos->parent,
> &file_stream->parent.stream_packet_context->p);
> +		if (ret) {
> +			if (ret == -EFAULT)
> +				goto retry;
> +		}
> +	}
> +	packet_index->data_offset = pos->offset;
> +
> +	/* unmap old base */
> +	ret = munmap_align(pos->base_mma);
> +	if (ret) {
> +		fprintf(stderr, "[error] Unable to unmap old base: %s.\n",
> +				strerror(errno));
> +		return ret;
> +	}
> +	pos->base_mma = NULL;
> +
> +	return 0;
> +
> +	/* Retry with larger mapping */
> +retry:
> +	if (packet_map_len == ((filesize - pos->mmap_offset) << LOG2_CHAR_BIT)) {
> +		/*
> +		 * Reached EOF, but still expecting header/context data.
> +		 */
> +		fprintf(stderr, "[error] Reached end of file, but still expecting header
> or context fields.\n");
> +		return -EFAULT;
> +	}
> +	/* Double the mapping len, and retry */
> +	tmp_map_len = packet_map_len << 1;
> +	if (tmp_map_len >> 1 != packet_map_len) {
> +		/* Overflow */
> +		fprintf(stderr, "[error] Packet mapping length overflow\n");
> +		return -EFAULT;
> +	}
> +	packet_map_len = tmp_map_len;
> +	goto begin;
> +}
> +
> +
>  int ctf_init_pos(struct ctf_stream_pos *pos, struct bt_trace_descriptor
>  *trace,
>  		int fd, int open_flags)
>  {
> @@ -845,11 +942,17 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos,
> size_t index, int whence)
>  				struct packet_index,
>  				pos->cur_index);
>  		file_stream->parent.real_timestamp = packet_index->timestamp_begin;
> -		pos->mmap_offset = packet_index->offset;
>  
>  		/* Lookup context/packet size in index */
> +		if (packet_index->data_offset == -1) {
> +			ret = find_data_offset(pos, file_stream, packet_index);
> +			if (ret < 0) {
> +				return;
> +			}
> +		}
>  		pos->content_size = packet_index->content_size;
>  		pos->packet_size = packet_index->packet_size;
> +		pos->mmap_offset = packet_index->offset;
>  		if (packet_index->data_offset < packet_index->content_size) {
>  			pos->offset = 0;	/* will read headers */
>  		} else if (packet_index->data_offset == packet_index->content_size) {
> @@ -1748,6 +1851,7 @@ int import_stream_packet_index(struct ctf_trace *td,
>  		index.timestamp_end = be64toh(ctf_index.timestamp_end);
>  		index.events_discarded = be64toh(ctf_index.events_discarded);
>  		index.events_discarded_len = 64;
> +		index.data_offset = -1;
>  		stream_id = be64toh(ctf_index.stream_id);
>  
>  		if (!first_packet) {
> --
> 1.8.3.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
