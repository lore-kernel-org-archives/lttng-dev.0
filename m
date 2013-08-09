From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE RFC PATCH] Parse LTTng indexes
Date: Fri, 9 Aug 2013 11:53:21 -0400
Message-ID: <20130809155321.GE13969__17082.3492728688$1376063662$gmane$org@Krystal>
References: <1376061530-30485-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V7p0F-0007lN-EY
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 11:53:29 -0400
Content-Disposition: inline
In-Reply-To: <1376061530-30485-1-git-send-email-jdesfossez@efficios.com>
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
> If a trace file has an associated index (same filename and .idx suffix),
> we open it and use it instead of generating the index at open.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  formats/ctf/ctf.c              |  205 +++++++++++++++++++++++++++++++++++++++-
>  include/babeltrace/ctf/types.h |    1 +
>  include/lttng-index.h          |   44 +++++++++
>  3 files changed, 245 insertions(+), 5 deletions(-)
>  create mode 100644 include/lttng-index.h
> 
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 947b439..6f1064b 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -35,6 +35,7 @@
>  #include <babeltrace/context-internal.h>
>  #include <babeltrace/compat/uuid.h>
>  #include <babeltrace/endian.h>
> +#include <lttng-index.h>
>  #include <inttypes.h>
>  #include <stdio.h>
>  #include <sys/mman.h>
> @@ -1666,6 +1667,148 @@ error:
>  	return ret;
>  }
>  
> +static
> +int import_stream_packet_index(struct ctf_trace *td,
> +		struct ctf_file_stream *file_stream)
> +{
> +	struct ctf_stream_declaration *stream;
> +	struct ctf_stream_pos *pos;
> +	struct lttng_packet_index lttng_index;
> +	struct lttng_packet_index_file_hdr index_hdr;
> +	uint64_t packet_map_len = DEFAULT_HEADER_LEN;
> +	struct packet_index index;
> +	int ret, index_read;
> +	int first_packet = 1;
> +	size_t filesize;
> +	struct stat filestats;
> +
> +	pos = &file_stream->pos;
> +
> +	ret = read(pos->index_fd, &index_hdr, sizeof(index_hdr));

Should probably use fread(), unless you really want to handle buffering
and EINTR.

> +	if (ret < 0) {
> +		perror("read index file header");
> +		goto error;
> +	}
> +	/* Check the index header */
> +	if (strncmp(index_hdr.magic, INDEX_MAGIC, sizeof(index_hdr.magic)) != 0) {
> +		fprintf(stderr, "[error] wrong index magic\n");
> +		ret = -1;
> +		goto error;
> +	}
> +	if (be32toh(index_hdr.index_major) != INDEX_MAJOR ||
> +			be32toh(index_hdr.index_minor) != INDEX_MINOR) {
> +		fprintf(stderr, "[error] Incompatible index file %" PRIu64
> +				".%" PRIu64 ", supported %d.%d\n",
> +				be64toh(index_hdr.index_major),
> +				be64toh(index_hdr.index_minor), INDEX_MAJOR,
> +				INDEX_MINOR);
> +		ret = -1;
> +		goto error;
> +	}
> +
> +	while ((index_read = read(pos->index_fd, &lttng_index,
> +					sizeof(lttng_index)))) {
> +		uint64_t stream_id;
> +
> +		index.offset = be64toh(lttng_index.offset);
> +		index.packet_size = be64toh(lttng_index.packet_size);
> +		index.content_size = be64toh(lttng_index.content_size);
> +		index.timestamp_begin = be64toh(lttng_index.timestamp_begin);
> +		index.timestamp_end = be64toh(lttng_index.timestamp_end);
> +		index.events_discarded = be64toh(lttng_index.events_discarded);
> +		stream_id = be64toh(lttng_index.stream_id);
> +

can we do something like this here ?

		/* add index to packet array */
		g_array_append_val(file_stream->pos.packet_cycles_index, index);

                if (!first_packet) {
                        continue;
                }

                rest of the code for first packet....

so we save an indent level ?

> +		if (first_packet) {
> +			int len_index;
> +
> +			file_stream->parent.stream_id = stream_id;
> +			stream = g_ptr_array_index(td->streams, stream_id);
> +			if (!stream) {
> +				fprintf(stderr, "[error] Stream %" PRIu64
> +						" is not declared in metadata.\n",
> +						stream_id);
> +				ret = -EINVAL;
> +				goto error;
> +			}
> +			file_stream->parent.stream_class = stream;
> +			ret = create_stream_definitions(td, &file_stream->parent);
> +			if (ret)
> +				goto error;
> +
> +			ret = fstat(pos->fd, &filestats);
> +			if (ret < 0)
> +				goto error;
> +
> +			if (!filestats.st_size) {
> +				fprintf(stderr, "[error] Empty trace file\n");
> +				ret = -1;
> +				goto error;
> +			}
> +			filesize = filestats.st_size;
> +
> +			if (filesize - pos->mmap_offset < (packet_map_len >> LOG2_CHAR_BIT)) {
> +				packet_map_len = (filesize - pos->mmap_offset) << LOG2_CHAR_BIT;
> +			}
> +
> +			if (pos->base_mma) {
> +				/* unmap old base */
> +				ret = munmap_align(pos->base_mma);
> +				if (ret) {
> +					fprintf(stderr, "[error] Unable to unmap old base: %s.\n",
> +							strerror(errno));
> +					return ret;
> +				}
> +				pos->base_mma = NULL;
> +			}
> +			/* map new base. Need mapping length from header. */
> +			pos->base_mma = mmap_align(packet_map_len >> LOG2_CHAR_BIT, PROT_READ,
> +					MAP_PRIVATE, pos->fd, pos->mmap_offset);
> +			assert(pos->base_mma != MAP_FAILED);
> +			/*
> +			 * Use current mapping size as temporary content and packet
> +			 * size.
> +			 */
> +			pos->content_size = packet_map_len;
> +			pos->packet_size = packet_map_len;
> +			pos->offset = 0;	/* Position of the packet header */
> +
> +			/* update trace_packet_header and stream_packet_context */
> +			if (pos->prot != PROT_WRITE && file_stream->parent.trace_packet_header) {
> +				/* Read packet header */
> +				ret = generic_rw(&pos->parent, &file_stream->parent.trace_packet_header->p);
> +				assert(!ret);
> +			}
> +			if (pos->prot != PROT_WRITE && file_stream->parent.stream_packet_context) {
> +				/* Read packet context */
> +				ret = generic_rw(&pos->parent, &file_stream->parent.stream_packet_context->p);
> +				assert(!ret);
> +			}
> +			index.data_offset = pos->offset;
> +
> +			/* read events discarded len from header */
> +			len_index = bt_struct_declaration_lookup_field_index(
> +					file_stream->parent.stream_packet_context->declaration,
> +					g_quark_from_static_string("events_discarded"));
> +			if (len_index >= 0) {
> +				struct bt_definition *field;
> +
> +				field = bt_struct_definition_get_field_from_index(
> +						file_stream->parent.stream_packet_context,
> +						len_index);
> +				index.events_discarded_len = bt_get_int_len(field);
> +			}
> +			first_packet = 0;
> +		}
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
> @@ -1675,9 +1818,10 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
>  		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
>  			int whence))
>  {
> -	int ret, fd, closeret;
> +	int ret, fd, closeret, index_fd;
>  	struct ctf_file_stream *file_stream;
>  	struct stat statbuf;
> +	char *index_name;
>  
>  	fd = openat(td->dirfd, path, flags);
>  	if (fd < 0) {
> @@ -1700,6 +1844,8 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
>  
>  	file_stream = g_new0(struct ctf_file_stream, 1);
>  	file_stream->pos.last_offset = LAST_OFFSET_POISON;
> +	file_stream->pos.fd = -1;
> +	file_stream->pos.index_fd = -1;
>  
>  	strncpy(file_stream->parent.path, path, PATH_MAX);
>  	file_stream->parent.path[PATH_MAX - 1] = '\0';
> @@ -1722,19 +1868,60 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
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
> +	index_name = malloc((strlen(path) + 4) * sizeof(char));
> +	if (!index_name) {
> +		fprintf(stderr, "[error] Cannot allocate index filename\n");
> +		goto error_def;
> +	}
> +	sprintf(index_name, "%s.idx", path);
> +
> +	if (faccessat(td->dirfd, index_name, O_RDONLY, flags) == 0) {
> +		index_fd = openat(td->dirfd, index_name, flags);
> +		if (index_fd < 0) {
> +			perror("Index file openat()");
> +			ret = -1;
> +			goto error_free;
> +		}
> +		file_stream->pos.index_fd = index_fd;
> +		ret = import_stream_packet_index(td, file_stream);
> +		if (ret) {
> +			ret = -1;
> +			goto error_index;
> +		}
> +		ret = close(file_stream->pos.index_fd);
> +		if (ret < 0) {
> +			perror("close index");
> +			goto error_free;
> +		}
> +	} else {
> +		ret = create_stream_packet_index(td, file_stream);
> +		if (ret) {
> +			fprintf(stderr, "[error] Stream index creation error.\n");
> +			goto error_index;
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
> +	if (file_stream->pos.index_fd > 0) {
> +		ret = close(file_stream->pos.index_fd);
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
> @@ -1761,6 +1948,7 @@ int ctf_open_trace_read(struct ctf_trace *td,
>  	struct dirent *dirent;
>  	struct dirent *diriter;
>  	size_t dirent_len;
> +	char *ext;
>  
>  	td->flags = flags;
>  
> @@ -1816,6 +2004,13 @@ int ctf_open_trace_read(struct ctf_trace *td,
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
> diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
> index 715cdbd..c64b8d2 100644
> --- a/include/babeltrace/ctf/types.h
> +++ b/include/babeltrace/ctf/types.h
> @@ -61,6 +61,7 @@ struct packet_index {
>  struct ctf_stream_pos {
>  	struct bt_stream_pos parent;
>  	int fd;			/* backing file fd. -1 if unset. */
> +	int index_fd;		/* backing index file fd. -1 if unset. */
>  	GArray *packet_cycles_index;	/* contains struct packet_index in cycles */
>  	GArray *packet_real_index;	/* contains struct packet_index in ns */
>  	int prot;		/* mmap protection */
> diff --git a/include/lttng-index.h b/include/lttng-index.h
> new file mode 100644
> index 0000000..56f325a
> --- /dev/null
> +++ b/include/lttng-index.h
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

Info about endianness missing (comments).

Thanks,

Mathieu

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
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
