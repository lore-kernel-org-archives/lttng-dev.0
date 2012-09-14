From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE RFC PATCH] basic index creation and
	importing
Date: Fri, 14 Sep 2012 11:42:07 -0400
Message-ID: <20120914154206.GA25350__6967.05227387628$1347637364$gmane$org@Krystal>
References: <1347636009-12545-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TCY1w-0001qn-M7
	for lttng-dev@lists.lttng.org; Fri, 14 Sep 2012 11:42:08 -0400
Content-Disposition: inline
In-Reply-To: <1347636009-12545-1-git-send-email-jdesfossez@efficios.com>
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
> This patch provides a proof-of-concept of writing the index and importing it if
> it exists. The intent is to have the consumer (not babeltrace) write the index
> on disk while tracing and Babeltrace import it if possible.
> 
> I added the stream_id field in the packet_index structure, I think it won't be
> a problem since this field is in the tracer packet_header structure.
> 
> Like we discussed, we'll make sure to write the fields in network byte order.
> 
> This index should also be the basis of the live reading of streamed traces. I
> think with the timestamp_end of the indexes we will have enough information to
> do so : only read the trace data up to min(indexes.timestamp_end).
> 
> In the past, we discussed a separate synchronization file in which we would
> write the max sequence number that can be read for each stream, but I think we
> can simplify that by just reading this index.

No. The simplification you propose does not take into account streams
that do _not_ produce data. This is why the separate sync file is
required.

Thanks,

Mathieu

> 
> Before I start working on the consumer, I'd like your opinion on that.
> 
> Thanks,
> 
> Julien
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  formats/ctf/ctf.c              |   78 +++++++++++++++++++++++++++++++++++++---
>  include/babeltrace/ctf/types.h |    2 ++
>  2 files changed, 75 insertions(+), 5 deletions(-)
> 
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index f1fdba1..c82dd3c 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -1218,6 +1218,39 @@ error:
>  	return ret;
>  }
>  
> +static
> +int import_stream_packet_index(struct ctf_trace *td,
> +		struct ctf_file_stream *file_stream)
> +{
> +	struct ctf_stream_declaration *stream;
> +	struct ctf_stream_pos *pos;
> +	struct packet_index index;
> +	int ret, index_read;
> +	int first_packet = 1;
> +
> +	pos = &file_stream->pos;
> +
> +	while ((index_read = read(pos->index_fd, &index, sizeof(struct packet_index)))) {
> +		if (first_packet) {
> +			file_stream->parent.stream_id = index.stream_id;
> +			stream = g_ptr_array_index(td->streams, index.stream_id);
> +			if (!stream) {
> +				fprintf(stderr, "[error] Stream %" PRIu64 " is not declared in metadata.\n",
> +						index.stream_id);
> +				return -EINVAL;
> +			}
> +			file_stream->parent.stream_class = stream;
> +			ret = create_stream_definitions(td, &file_stream->parent);
> +			if (ret)
> +				return ret;
> +			first_packet = 0;
> +		}
> +		/* add index to packet array */
> +		g_array_append_val(file_stream->pos.packet_cycles_index, index);
> +	}
> +
> +	return 0;
> +}
>  
>  static
>  int create_stream_packet_index(struct ctf_trace *td,
> @@ -1323,6 +1356,7 @@ int create_stream_packet_index(struct ctf_trace *td,
>  
>  				field = struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
>  				stream_id = get_unsigned_int(field);
> +				packet_index.stream_id = stream_id;
>  			}
>  		}
>  
> @@ -1441,6 +1475,7 @@ int create_stream_packet_index(struct ctf_trace *td,
>  
>  		/* add index to packet array */
>  		g_array_append_val(file_stream->pos.packet_cycles_index, packet_index);
> +		write(pos->index_fd, &packet_index, sizeof(struct packet_index));
>  
>  		pos->mmap_offset += packet_index.packet_size / CHAR_BIT;
>  	}
> @@ -1481,9 +1516,10 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
>  		void (*packet_seek)(struct stream_pos *pos, size_t index,
>  			int whence))
>  {
> -	int ret, fd;
> +	int ret, fd, index_fd;
>  	struct ctf_file_stream *file_stream;
>  	struct stat statbuf;
> +	char *index_name;
>  
>  	fd = openat(td->dirfd, path, flags);
>  	if (fd < 0) {
> @@ -1523,9 +1559,40 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
>  	 * For now, only a single clock per trace is supported.
>  	 */
>  	file_stream->parent.current_clock = td->single_clock;
> -	ret = create_stream_packet_index(td, file_stream);
> -	if (ret)
> -		goto error_index;
> +
> +	index_name = malloc((strlen(td->path) + strlen(path)) * sizeof(char) + 5);
> +	if (!index_name) {
> +		fprintf(stderr, "[error] Cannot allocate index filename\n");
> +		goto error;
> +	}
> +	sprintf(index_name, "%s/idx_%s", td->path, path);
> +
> +	if (access(index_name, F_OK) != 0) {
> +		index_fd = open(index_name, O_WRONLY|O_CREAT, S_IRWXU|S_IRWXG|S_IRWXO);
> +		if (index_fd < 0) {
> +			perror("Index file openat()");
> +			ret = -1;
> +			goto error;
> +		}
> +		file_stream->pos.index_fd = index_fd;
> +		ret = create_stream_packet_index(td, file_stream);
> +		if (ret)
> +			goto error_index;
> +	} else {
> +		index_fd = open(index_name, O_RDONLY);
> +		if (index_fd < 0) {
> +			perror("Index file openat()");
> +			ret = -1;
> +			goto error;
> +		}
> +		file_stream->pos.index_fd = index_fd;
> +		ret = import_stream_packet_index(td, file_stream);
> +		if (ret)
> +			goto error_index;
> +	}
> +	close(file_stream->pos.index_fd);
> +	free(index_name);
> +
>  	/* Add stream file to stream class */
>  	g_ptr_array_add(file_stream->parent.stream_class->streams,
>  			&file_stream->parent);
> @@ -1607,7 +1674,8 @@ int ctf_open_trace_read(struct ctf_trace *td,
>  		/* Ignore hidden files, ., .. and metadata. */
>  		if (!strncmp(diriter->d_name, ".", 1)
>  				|| !strcmp(diriter->d_name, "..")
> -				|| !strcmp(diriter->d_name, "metadata"))
> +				|| !strcmp(diriter->d_name, "metadata")
> +				|| !strncmp(diriter->d_name, "idx_", 4))
>  			continue;
>  		ret = ctf_open_file_stream_read(td, diriter->d_name,
>  					flags, packet_seek);
> diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
> index 6a76c6b..ef79711 100644
> --- a/include/babeltrace/ctf/types.h
> +++ b/include/babeltrace/ctf/types.h
> @@ -43,6 +43,7 @@ struct packet_index {
>  	uint64_t timestamp_begin;
>  	uint64_t timestamp_end;
>  	uint64_t events_discarded;
> +	uint64_t stream_id;
>  	size_t events_discarded_len;	/* length of the field, in bits */
>  };
>  
> @@ -52,6 +53,7 @@ struct packet_index {
>  struct ctf_stream_pos {
>  	struct stream_pos parent;
>  	int fd;			/* backing file fd. -1 if unset. */
> +	int index_fd;		/* index file fd. -1 if unset. */
>  	GArray *packet_cycles_index;	/* contains struct packet_index in cycles */
>  	GArray *packet_real_index;	/* contains struct packet_index in ns */
>  	int prot;		/* mmap protection */
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
