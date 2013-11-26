From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] Parse CTF indexes
Date: Tue, 26 Nov 2013 19:22:04 +0000 (UTC)
Message-ID: <2094897621.76249.1385493724159.JavaMail.zimbra__48993.1158991114$1385493797$gmane$org@efficios.com>
References: <1385485686-13998-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlOD0-0005Xi-GX
	for lttng-dev@lists.lttng.org; Tue, 26 Nov 2013 14:22:13 -0500
In-Reply-To: <1385485686-13998-1-git-send-email-jdesfossez@efficios.com>
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
> Sent: Tuesday, November 26, 2013 12:08:06 PM
> Subject: [BABELTRACE PATCH] Parse CTF indexes
> 
> If a trace file has an associated index (same filename and .idx suffix
> in the "index" folder), we open it and use it instead of generating
> the index at open.
> The index folder is not mandatory and can be destroyed without any
> problem.
> 
> To use with LTTng, make sure you have lttng-tools commit :
> 50adc26400482c07210afcda8ef1d3322f75871d
> Mon Nov 25 15:32:38 2013 -0500
> Rename LTTng index in CTF index
> 
> Versions between commit 309167d2a6f59d0c8cbf64eb23ba912cdea76a34 and
> this commit have a different index format that will never be merged in
> Babeltrace, so if you have traces recorded between this period of
> time, just remove the index directory.

Merged, thanks!

Mathieu

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  formats/ctf/ctf.c                  | 151
>  +++++++++++++++++++++++++++++++++++--
>  include/Makefile.am                |   1 +
>  include/babeltrace/ctf/ctf-index.h |  60 +++++++++++++++
>  include/babeltrace/ctf/types.h     |   1 +
>  4 files changed, 208 insertions(+), 5 deletions(-)
>  create mode 100644 include/babeltrace/ctf/ctf-index.h
> 
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 60d9c9f..a7e7903 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -35,6 +35,7 @@
>  #include <babeltrace/context-internal.h>
>  #include <babeltrace/compat/uuid.h>
>  #include <babeltrace/endian.h>
> +#include <babeltrace/ctf/ctf-index.h>
>  #include <inttypes.h>
>  #include <stdio.h>
>  #include <sys/mman.h>
> @@ -71,6 +72,8 @@
>  
>  #define NSEC_PER_SEC 1000000000ULL
>  
> +#define INDEX_PATH "./index/%s.idx"
> +
>  int opt_clock_cycles,
>  	opt_clock_seconds,
>  	opt_clock_date,
> @@ -1666,6 +1669,88 @@ error:
>  	return ret;
>  }
>  
> +static
> +int import_stream_packet_index(struct ctf_trace *td,
> +		struct ctf_file_stream *file_stream)
> +{
> +	struct ctf_stream_declaration *stream;
> +	struct ctf_stream_pos *pos;
> +	struct ctf_packet_index ctf_index;
> +	struct ctf_packet_index_file_hdr index_hdr;
> +	struct packet_index index;
> +	int index_read;
> +	int ret = 0;
> +	int first_packet = 1;
> +	size_t len;
> +
> +	pos = &file_stream->pos;
> +
> +	len = fread(&index_hdr, sizeof(index_hdr), 1, pos->index_fp);
> +	if (len != 1) {
> +		perror("read index file header");
> +		goto error;
> +	}
> +
> +	/* Check the index header */
> +	if (be32toh(index_hdr.magic) != CTF_INDEX_MAGIC) {
> +		fprintf(stderr, "[error] wrong index magic\n");
> +		ret = -1;
> +		goto error;
> +	}
> +	if (be32toh(index_hdr.index_major) != CTF_INDEX_MAJOR) {
> +		fprintf(stderr, "[error] Incompatible index file %" PRIu64
> +				".%" PRIu64 ", supported %d.%d\n",
> +				be64toh(index_hdr.index_major),
> +				be64toh(index_hdr.index_minor), CTF_INDEX_MAJOR,
> +				CTF_INDEX_MINOR);
> +		ret = -1;
> +		goto error;
> +	}
> +
> +	while ((index_read = fread(&ctf_index, index_hdr.packet_index_len, 1,
> +					pos->index_fp)) == 1) {
> +		uint64_t stream_id;
> +
> +		memset(&index, 0, sizeof(index));
> +		index.offset = be64toh(ctf_index.offset);
> +		index.packet_size = be64toh(ctf_index.packet_size);
> +		index.content_size = be64toh(ctf_index.content_size);
> +		index.timestamp_begin = be64toh(ctf_index.timestamp_begin);
> +		index.timestamp_end = be64toh(ctf_index.timestamp_end);
> +		index.events_discarded = be64toh(ctf_index.events_discarded);
> +		index.events_discarded_len = 64;
> +		stream_id = be64toh(ctf_index.stream_id);
> +
> +		if (!first_packet) {
> +			/* add index to packet array */
> +			g_array_append_val(file_stream->pos.packet_cycles_index, index);
> +			continue;
> +		}
> +
> +		file_stream->parent.stream_id = stream_id;
> +		stream = g_ptr_array_index(td->streams, stream_id);
> +		if (!stream) {
> +			fprintf(stderr, "[error] Stream %" PRIu64
> +					" is not declared in metadata.\n",
> +					stream_id);
> +			ret = -EINVAL;
> +			goto error;
> +		}
> +		file_stream->parent.stream_class = stream;
> +		ret = create_stream_definitions(td, &file_stream->parent);
> +		if (ret)
> +			goto error;
> +		first_packet = 0;
> +		/* add index to packet array */
> +		g_array_append_val(file_stream->pos.packet_cycles_index, index);
> +	}
> +
> +	ret = 0;
> +
> +error:
> +	return ret;
> +}
> +
>  /*
>   * Note: many file streams can inherit from the same stream class
>   * description (metadata).
> @@ -1678,6 +1763,7 @@ int ctf_open_file_stream_read(struct ctf_trace *td,
> const char *path, int flags,
>  	int ret, fd, closeret;
>  	struct ctf_file_stream *file_stream;
>  	struct stat statbuf;
> +	char *index_name;
>  
>  	fd = openat(td->dirfd, path, flags);
>  	if (fd < 0) {
> @@ -1693,13 +1779,18 @@ int ctf_open_file_stream_read(struct ctf_trace *td,
> const char *path, int flags,
>  		goto fstat_error;
>  	}
>  	if (S_ISDIR(statbuf.st_mode)) {
> -		fprintf(stderr, "[warning] Skipping directory '%s' found in trace\n",
> path);
> +		if (strncmp(path, "index", 5) != 0) {
> +			fprintf(stderr, "[warning] Skipping directory '%s' "
> +					"found in trace\n", path);
> +		}
>  		ret = 0;
>  		goto fd_is_dir_ok;
>  	}
>  
>  	file_stream = g_new0(struct ctf_file_stream, 1);
>  	file_stream->pos.last_offset = LAST_OFFSET_POISON;
> +	file_stream->pos.fd = -1;
> +	file_stream->pos.index_fp = NULL;
>  
>  	strncpy(file_stream->parent.path, path, PATH_MAX);
>  	file_stream->parent.path[PATH_MAX - 1] = '\0';
> @@ -1722,19 +1813,61 @@ int ctf_open_file_stream_read(struct ctf_trace *td,
> const char *path, int flags,
>  	 * For now, only a single clock per trace is supported.
>  	 */
>  	file_stream->parent.current_clock = td->parent.single_clock;
> -	ret = create_stream_packet_index(td, file_stream);
> -	if (ret) {
> -		fprintf(stderr, "[error] Stream index creation error.\n");
> -		goto error_index;
> +
> +	/*
> +	 * Allocate the index name for this stream and try to open it.
> +	 */
> +	index_name = malloc((strlen(path) + sizeof(INDEX_PATH)) * sizeof(char));
> +	if (!index_name) {
> +		fprintf(stderr, "[error] Cannot allocate index filename\n");
> +		goto error_def;
> +	}
> +	snprintf(index_name, strlen(path) + sizeof(INDEX_PATH),
> +			INDEX_PATH, path);
> +
> +	if (faccessat(td->dirfd, index_name, O_RDONLY, flags) < 0) {
> +		ret = create_stream_packet_index(td, file_stream);
> +		if (ret) {
> +			fprintf(stderr, "[error] Stream index creation error.\n");
> +			goto error_index;
> +		}
> +	} else {
> +		ret = openat(td->dirfd, index_name, flags);
> +		if (ret < 0) {
> +			perror("Index file openat()");
> +			ret = -1;
> +			goto error_free;
> +		}
> +		file_stream->pos.index_fp = fdopen(ret, "r");
> +		ret = import_stream_packet_index(td, file_stream);
> +		if (ret) {
> +			ret = -1;
> +			goto error_index;
> +		}
> +		ret = fclose(file_stream->pos.index_fp);
> +		if (ret < 0) {
> +			perror("close index");
> +			goto error_free;
> +		}
>  	}
> +	free(index_name);
> +
>  	/* Add stream file to stream class */
>  	g_ptr_array_add(file_stream->parent.stream_class->streams,
>  			&file_stream->parent);
>  	return 0;
>  
>  error_index:
> +	if (file_stream->pos.index_fp) {
> +		ret = fclose(file_stream->pos.index_fp);
> +		if (ret < 0) {
> +			perror("close index");
> +		}
> +	}
>  	if (file_stream->parent.trace_packet_header)
>  		bt_definition_unref(&file_stream->parent.trace_packet_header->p);
> +error_free:
> +	free(index_name);
>  error_def:
>  	closeret = ctf_fini_pos(&file_stream->pos);
>  	if (closeret) {
> @@ -1761,6 +1894,7 @@ int ctf_open_trace_read(struct ctf_trace *td,
>  	struct dirent *dirent;
>  	struct dirent *diriter;
>  	size_t dirent_len;
> +	char *ext;
>  
>  	td->flags = flags;
>  
> @@ -1816,6 +1950,13 @@ int ctf_open_trace_read(struct ctf_trace *td,
>  				|| !strcmp(diriter->d_name, "..")
>  				|| !strcmp(diriter->d_name, "metadata"))
>  			continue;
> +
> +		/* Ignore index files : *.idx */
> +		ext = strrchr(diriter->d_name, '.');
> +		if (ext && (!strcmp(ext, ".idx"))) {
> +			continue;
> +		}
> +
>  		ret = ctf_open_file_stream_read(td, diriter->d_name,
>  					flags, packet_seek);
>  		if (ret) {
> diff --git a/include/Makefile.am b/include/Makefile.am
> index ec927b9..d9996a7 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -38,6 +38,7 @@ noinst_HEADERS = \
>  	babeltrace/ctf-text/types.h \
>  	babeltrace/ctf/types.h \
>  	babeltrace/ctf/callbacks-internal.h \
> +	babeltrace/ctf/ctf-index.h \
>  	babeltrace/ctf-writer/ref-internal.h \
>  	babeltrace/ctf-writer/writer-internal.h \
>  	babeltrace/ctf-writer/event-types-internal.h \
> diff --git a/include/babeltrace/ctf/ctf-index.h
> b/include/babeltrace/ctf/ctf-index.h
> new file mode 100644
> index 0000000..0efa888
> --- /dev/null
> +++ b/include/babeltrace/ctf/ctf-index.h
> @@ -0,0 +1,60 @@
> +/*
> + * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
> + *                      Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *                      David Goulet <dgoulet@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> copy
> + * of this software and associated documentation files (the "Software"), to
> deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included
> in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
> OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE
> + * SOFTWARE.
> + */
> +
> +#ifndef LTTNG_INDEX_H
> +#define LTTNG_INDEX_H
> +
> +#include <limits.h>
> +
> +#define CTF_INDEX_MAGIC 0xC1F1DCC1
> +#define CTF_INDEX_MAJOR 1
> +#define CTF_INDEX_MINOR 0
> +
> +/*
> + * Header at the beginning of each index file.
> + * All integer fields are stored in big endian.
> + */
> +struct ctf_packet_index_file_hdr {
> +	uint32_t magic;
> +	uint32_t index_major;
> +	uint32_t index_minor;
> +	/* struct packet_index_len, in bytes */
> +	uint32_t packet_index_len;
> +} __attribute__((__packed__));
> +
> +/*
> + * Packet index generated for each trace packet store in a trace file.
> + * All integer fields are stored in big endian.
> + */
> +struct ctf_packet_index {
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
> diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
> index 96c5083..eeb0c57 100644
> --- a/include/babeltrace/ctf/types.h
> +++ b/include/babeltrace/ctf/types.h
> @@ -61,6 +61,7 @@ struct packet_index {
>  struct ctf_stream_pos {
>  	struct bt_stream_pos parent;
>  	int fd;			/* backing file fd. -1 if unset. */
> +	FILE *index_fp;		/* backing index file fp. NULL if unset. */
>  	GArray *packet_cycles_index;	/* contains struct packet_index in cycles */
>  	GArray *packet_real_index;	/* contains struct packet_index in ns */
>  	int prot;		/* mmap protection */
> --
> 1.8.3.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
