From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] Parse LTTng indexes
Date: Fri, 22 Nov 2013 20:06:27 +0000 (UTC)
Message-ID: <1648426482.73571.1385150787035.JavaMail.zimbra__46154.6947634362$1385150846$gmane$org@efficios.com>
References: <1385049920-6597-1-git-send-email-jdesfossez@efficios.com>
	<2083404162.73184.1385126465506.JavaMail.zimbra@efficios.com>
	<528FB7AA.7050104@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vjwzk-0000PH-FB
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 15:06:35 -0500
In-Reply-To: <528FB7AA.7050104@efficios.com>
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
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Friday, November 22, 2013 2:59:38 PM
> Subject: Re: [BABELTRACE PATCH] Parse LTTng indexes
> 
> 
> 
> On 13-11-22 08:21 AM, Mathieu Desnoyers wrote:
> > ----- Original Message -----
> >> From: "Julien Desfossez" <jdesfossez@efficios.com>
> >> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> >> Cc: lttng-dev@lists.lttng.org, "Julien Desfossez"
> >> <jdesfossez@efficios.com>
> >> Sent: Thursday, November 21, 2013 11:05:20 AM
> >> Subject: [BABELTRACE PATCH] Parse LTTng indexes
> >>
> >> If a trace file has an associated index (same filename and .idx suffix in
> >> the
> >> "index" folder), we open it and use it instead of generating the index at
> >> open.
> > 
> > Please cut changelog at 72 or 76 lines. This is slightly too large for
> > git show.
> > 
> >>
> >> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> >> ---
> >>  formats/ctf/ctf.c                  | 216
> >>  ++++++++++++++++++++++++++++++++++++-
> >>  include/Makefile.am                |   1 +
> >>  include/babeltrace/ctf/ctf-index.h |  58 ++++++++++
> >>  include/babeltrace/ctf/types.h     |   1 +
> >>  4 files changed, 271 insertions(+), 5 deletions(-)
> >>  create mode 100644 include/babeltrace/ctf/ctf-index.h
> >>
> >> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> >> index 60d9c9f..7a0a383 100644
> >> --- a/formats/ctf/ctf.c
> >> +++ b/formats/ctf/ctf.c
> >> @@ -35,6 +35,7 @@
> >>  #include <babeltrace/context-internal.h>
> >>  #include <babeltrace/compat/uuid.h>
> >>  #include <babeltrace/endian.h>
> >> +#include <babeltrace/ctf/ctf-index.h>
> >>  #include <inttypes.h>
> >>  #include <stdio.h>
> >>  #include <sys/mman.h>
> >> @@ -71,6 +72,8 @@
> >>  
> >>  #define NSEC_PER_SEC 1000000000ULL
> >>  
> >> +#define INDEX_PATH "./index/%s.idx"
> >> +
> >>  int opt_clock_cycles,
> >>  	opt_clock_seconds,
> >>  	opt_clock_date,
> >> @@ -1666,6 +1669,153 @@ error:
> >>  	return ret;
> >>  }
> >>  
> >> +static
> >> +int import_stream_packet_index(struct ctf_trace *td,
> >> +		struct ctf_file_stream *file_stream)
> >> +{
> >> +	struct ctf_stream_declaration *stream;
> >> +	struct ctf_stream_pos *pos;
> >> +	struct ctf_packet_index ctf_index;
> >> +	struct ctf_packet_index_file_hdr index_hdr;
> >> +	uint64_t packet_map_len = DEFAULT_HEADER_LEN;
> >> +	struct packet_index index;
> >> +	int index_read;
> >> +	int ret = 0;
> >> +	int first_packet = 1;
> >> +	size_t filesize;
> >> +	struct stat filestats;
> >> +	size_t len;
> >> +
> >> +	pos = &file_stream->pos;
> >> +
> >> +	len = fread(&index_hdr, sizeof(index_hdr), 1, pos->index_fp);
> >> +	if (len != 1) {
> >> +		perror("read index file header");
> >> +		goto error;
> >> +	}
> >> +
> >> +	/* Check the index header */
> >> +	if (be32toh(index_hdr.magic) != CTF_INDEX_MAGIC) {
> >> +		fprintf(stderr, "[error] wrong index magic\n");
> >> +		ret = -1;
> >> +		goto error;
> >> +	}
> >> +	if (be32toh(index_hdr.index_major) != CTF_INDEX_MAJOR ||
> >> +			be32toh(index_hdr.index_minor) != CTF_INDEX_MINOR) {
> >> +		fprintf(stderr, "[error] Incompatible index file %" PRIu64
> >> +				".%" PRIu64 ", supported %d.%d\n",
> >> +				be64toh(index_hdr.index_major),
> >> +				be64toh(index_hdr.index_minor), CTF_INDEX_MAJOR,
> >> +				CTF_INDEX_MINOR);
> >> +		ret = -1;
> >> +		goto error;
> >> +	}
> >> +
> >> +	while((index_read = fread(&ctf_index, sizeof(ctf_index), 1,
> >> pos->index_fp))
> >> == 1) {
> > 
> > missing space after "while", should be cut into 2 lines.
> > 
> >> +		uint64_t stream_id;
> >> +		int len_index;
> >> +
> >> +		index.offset = be64toh(ctf_index.offset);
> >> +		index.packet_size = be64toh(ctf_index.packet_size);
> >> +		index.content_size = be64toh(ctf_index.content_size);
> >> +		index.timestamp_begin = be64toh(ctf_index.timestamp_begin);
> >> +		index.timestamp_end = be64toh(ctf_index.timestamp_end);
> >> +		index.events_discarded = be64toh(ctf_index.events_discarded);
> >> +		stream_id = be64toh(ctf_index.stream_id);
> >> +
> >> +		if (!first_packet) {
> >> +			/* add index to packet array */
> >> +			g_array_append_val(file_stream->pos.packet_cycles_index, index);
> >> +			continue;
> >> +		}
> >> +
> 
> [...]
> 
> >> +		/* map new base. Need mapping length from header. */
> >> +		pos->base_mma = mmap_align(packet_map_len >> LOG2_CHAR_BIT, PROT_READ,
> >> +				MAP_PRIVATE, pos->fd, pos->mmap_offset);
> >> +		assert(pos->base_mma != MAP_FAILED);
> > 
> > It makes no sense to map the trace packets when we should just be pulling
> > the index
> > from the index file. It makes the performance gain of having the index
> > useless.
> 
> We need to compute the data_offset because we don't have it in the
> index. But we only do this operation for the first packet of each
> stream. Is that really a problem ?

Yes, for huge traces, it defeats the entire purpose of the index: not seeking
at each packet when loading the trace.

We should let this offset information "unset" (e.g. -1), and set it lazily when the
trace packet is really accessed for the first time.

Thanks,

Mathieu

> 
> Thanks,
> 
> Julien
> 
> > 
> >> +		/*
> >> +		 * Use current mapping size as temporary content and packet
> >> +		 * size.
> >> +		 */
> >> +		pos->content_size = packet_map_len;
> >> +		pos->packet_size = packet_map_len;
> >> +		pos->offset = 0;	/* Position of the packet header */
> >> +
> >> +		/* update trace_packet_header and stream_packet_context */
> >> +		if (pos->prot != PROT_WRITE && file_stream->parent.trace_packet_header)
> >> {
> >> +			/* Read packet header */
> >> +			ret = generic_rw(&pos->parent,
> >> &file_stream->parent.trace_packet_header->p);
> >> +			assert(!ret);
> >> +		}
> >> +		if (pos->prot != PROT_WRITE &&
> >> file_stream->parent.stream_packet_context)
> >> {
> >> +			/* Read packet context */
> >> +			ret = generic_rw(&pos->parent,
> >> &file_stream->parent.stream_packet_context->p);
> >> +			assert(!ret);
> >> +		}
> >> +		index.data_offset = pos->offset;
> >> +
> >> +		/* read events discarded len from header */
> >> +		len_index = bt_struct_declaration_lookup_field_index(
> >> +				file_stream->parent.stream_packet_context->declaration,
> >> +				g_quark_from_static_string("events_discarded"));
> > 
> > The packet lost count in the index should already be extended to a 64-bit
> > counter
> > by the consumer daemon. We should not need to get the len_index from the
> > trace.
> > 
> > Is there any other reason why you map/unmap the trace ?
> > 
> >> +		if (len_index >= 0) {
> >> +			struct bt_definition *field;
> >> +
> >> +			field = bt_struct_definition_get_field_from_index(
> >> +					file_stream->parent.stream_packet_context,
> >> +					len_index);
> >> +			index.events_discarded_len = bt_get_int_len(field);
> >> +		}
> >> +		first_packet = 0;
> >> +		/* add index to packet array */
> >> +		g_array_append_val(file_stream->pos.packet_cycles_index, index);
> >> +	}
> >> +
> >> +	ret = 0;
> >> +
> >> +error:
> >> +	return ret;
> >> +}
> >> +
> >>  /*
> >>   * Note: many file streams can inherit from the same stream class
> >>   * description (metadata).
> >> @@ -1678,6 +1828,7 @@ int ctf_open_file_stream_read(struct ctf_trace *td,
> >> const char *path, int flags,
> >>  	int ret, fd, closeret;
> >>  	struct ctf_file_stream *file_stream;
> >>  	struct stat statbuf;
> >> +	char *index_name;
> >>  
> >>  	fd = openat(td->dirfd, path, flags);
> >>  	if (fd < 0) {
> >> @@ -1693,13 +1844,18 @@ int ctf_open_file_stream_read(struct ctf_trace
> >> *td,
> >> const char *path, int flags,
> >>  		goto fstat_error;
> >>  	}
> >>  	if (S_ISDIR(statbuf.st_mode)) {
> >> -		fprintf(stderr, "[warning] Skipping directory '%s' found in trace\n",
> >> path);
> >> +		if (strncmp(path, "index", 5) != 0) {
> >> +			fprintf(stderr, "[warning] Skipping directory '%s' "
> >> +					"found in trace\n", path);
> >> +		}
> >>  		ret = 0;
> >>  		goto fd_is_dir_ok;
> >>  	}
> >>  
> >>  	file_stream = g_new0(struct ctf_file_stream, 1);
> >>  	file_stream->pos.last_offset = LAST_OFFSET_POISON;
> >> +	file_stream->pos.fd = -1;
> >> +	file_stream->pos.index_fp = NULL;
> >>  
> >>  	strncpy(file_stream->parent.path, path, PATH_MAX);
> >>  	file_stream->parent.path[PATH_MAX - 1] = '\0';
> >> @@ -1722,19 +1878,61 @@ int ctf_open_file_stream_read(struct ctf_trace
> >> *td,
> >> const char *path, int flags,
> >>  	 * For now, only a single clock per trace is supported.
> >>  	 */
> >>  	file_stream->parent.current_clock = td->parent.single_clock;
> >> -	ret = create_stream_packet_index(td, file_stream);
> >> -	if (ret) {
> >> -		fprintf(stderr, "[error] Stream index creation error.\n");
> >> -		goto error_index;
> >> +
> >> +	/*
> >> +	 * Allocate the index name for this stream and try to open it.
> >> +	 */
> >> +	index_name = malloc((strlen(path) + sizeof(INDEX_PATH)) * sizeof(char));
> >> +	if (!index_name) {
> >> +		fprintf(stderr, "[error] Cannot allocate index filename\n");
> >> +		goto error_def;
> >> +	}
> >> +	snprintf(index_name, strlen(path) + sizeof(INDEX_PATH),
> >> +			INDEX_PATH, path);
> >> +
> >> +	if (faccessat(td->dirfd, index_name, O_RDONLY, flags) == 0) {
> > 
> > please exchange the ok and failure branches, and change the condition.
> > Everywhere else, the first branch is the " < 0" case (error).
> > 
> >> +		ret = openat(td->dirfd, index_name, flags);
> >> +		if (ret < 0) {
> >> +			perror("Index file openat()");
> >> +			ret = -1;
> >> +			goto error_free;
> >> +		}
> >> +		file_stream->pos.index_fp = fdopen(ret, "r");
> >> +		ret = import_stream_packet_index(td, file_stream);
> >> +		if (ret) {
> >> +			ret = -1;
> >> +			goto error_index;
> >> +		}
> >> +		ret = fclose(file_stream->pos.index_fp);
> >> +		if (ret < 0) {
> >> +			perror("close index");
> >> +			goto error_free;
> >> +		}
> >> +	} else {
> >> +		ret = create_stream_packet_index(td, file_stream);
> >> +		if (ret) {
> >> +			fprintf(stderr, "[error] Stream index creation error.\n");
> >> +			goto error_index;
> >> +		}
> >>  	}
> >> +	free(index_name);
> >> +
> >>  	/* Add stream file to stream class */
> >>  	g_ptr_array_add(file_stream->parent.stream_class->streams,
> >>  			&file_stream->parent);
> >>  	return 0;
> >>  
> >>  error_index:
> >> +	if (file_stream->pos.index_fp) {
> >> +		ret = fclose(file_stream->pos.index_fp);
> >> +		if (ret < 0) {
> >> +			perror("close index");
> >> +		}
> >> +	}
> >>  	if (file_stream->parent.trace_packet_header)
> >>  		bt_definition_unref(&file_stream->parent.trace_packet_header->p);
> >> +error_free:
> >> +	free(index_name);
> >>  error_def:
> >>  	closeret = ctf_fini_pos(&file_stream->pos);
> >>  	if (closeret) {
> >> @@ -1761,6 +1959,7 @@ int ctf_open_trace_read(struct ctf_trace *td,
> >>  	struct dirent *dirent;
> >>  	struct dirent *diriter;
> >>  	size_t dirent_len;
> >> +	char *ext;
> >>  
> >>  	td->flags = flags;
> >>  
> >> @@ -1816,6 +2015,13 @@ int ctf_open_trace_read(struct ctf_trace *td,
> >>  				|| !strcmp(diriter->d_name, "..")
> >>  				|| !strcmp(diriter->d_name, "metadata"))
> >>  			continue;
> >> +
> >> +		/* Ignore index files : *.idx */
> >> +		ext = strrchr(diriter->d_name, '.');
> >> +		if (ext && (!strcmp(ext, ".idx"))) {
> >> +			continue;
> >> +		}
> >> +
> >>  		ret = ctf_open_file_stream_read(td, diriter->d_name,
> >>  					flags, packet_seek);
> >>  		if (ret) {
> >> diff --git a/include/Makefile.am b/include/Makefile.am
> >> index ec927b9..d9996a7 100644
> >> --- a/include/Makefile.am
> >> +++ b/include/Makefile.am
> >> @@ -38,6 +38,7 @@ noinst_HEADERS = \
> >>  	babeltrace/ctf-text/types.h \
> >>  	babeltrace/ctf/types.h \
> >>  	babeltrace/ctf/callbacks-internal.h \
> >> +	babeltrace/ctf/ctf-index.h \
> >>  	babeltrace/ctf-writer/ref-internal.h \
> >>  	babeltrace/ctf-writer/writer-internal.h \
> >>  	babeltrace/ctf-writer/event-types-internal.h \
> >> diff --git a/include/babeltrace/ctf/ctf-index.h
> >> b/include/babeltrace/ctf/ctf-index.h
> >> new file mode 100644
> >> index 0000000..ee7ea26
> >> --- /dev/null
> >> +++ b/include/babeltrace/ctf/ctf-index.h
> >> @@ -0,0 +1,58 @@
> >> +/*
> >> + * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
> >> + *                      Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com>
> >> + *                      David Goulet <dgoulet@efficios.com>
> >> + *
> >> + * Permission is hereby granted, free of charge, to any person obtaining
> >> a
> >> copy
> >> + * of this software and associated documentation files (the "Software"),
> >> to
> >> deal
> >> + * in the Software without restriction, including without limitation the
> >> rights
> >> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> >> sell
> >> + * copies of the Software, and to permit persons to whom the Software is
> >> + * furnished to do so, subject to the following conditions:
> >> + *
> >> + * The above copyright notice and this permission notice shall be
> >> included
> >> in
> >> + * all copies or substantial portions of the Software.
> >> + *
> >> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >> EXPRESS
> >> OR
> >> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> >> MERCHANTABILITY,
> >> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
> >> SHALL
> >> THE
> >> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> >> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> >> ARISING
> >> FROM,
> >> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> >> IN
> >> THE
> >> + * SOFTWARE.
> >> + */
> >> +
> >> +#ifndef LTTNG_INDEX_H
> >> +#define LTTNG_INDEX_H
> >> +
> >> +#include <limits.h>
> >> +
> >> +#define CTF_INDEX_MAGIC 0xC11D81C1
> >> +#define CTF_INDEX_MAJOR 1
> >> +#define CTF_INDEX_MINOR 0
> >> +
> >> +/*
> >> + * Header at the beginning of each index file.
> >> + * All integer fields are stored in big endian.
> >> + */
> >> +struct ctf_packet_index_file_hdr {
> >> +	uint32_t magic;
> > 
> > You should submit the change to lttng-tools first.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> >> +	uint32_t index_major;
> >> +	uint32_t index_minor;
> >> +} __attribute__((__packed__));
> >> +
> >> +/*
> >> + * Packet index generated for each trace packet store in a trace file.
> >> + * All integer fields are stored in big endian.
> >> + */
> >> +struct ctf_packet_index {
> >> +	uint64_t offset;		/* offset of the packet in the file, in bytes */
> >> +	uint64_t packet_size;		/* packet size, in bits */
> >> +	uint64_t content_size;		/* content size, in bits */
> >> +	uint64_t timestamp_begin;
> >> +	uint64_t timestamp_end;
> >> +	uint64_t events_discarded;
> >> +	uint64_t stream_id;
> >> +} __attribute__((__packed__));
> >> +
> >> +#endif /* LTTNG_INDEX_H */
> >> diff --git a/include/babeltrace/ctf/types.h
> >> b/include/babeltrace/ctf/types.h
> >> index 96c5083..eeb0c57 100644
> >> --- a/include/babeltrace/ctf/types.h
> >> +++ b/include/babeltrace/ctf/types.h
> >> @@ -61,6 +61,7 @@ struct packet_index {
> >>  struct ctf_stream_pos {
> >>  	struct bt_stream_pos parent;
> >>  	int fd;			/* backing file fd. -1 if unset. */
> >> +	FILE *index_fp;		/* backing index file fp. NULL if unset. */
> >>  	GArray *packet_cycles_index;	/* contains struct packet_index in cycles
> >>  	*/
> >>  	GArray *packet_real_index;	/* contains struct packet_index in ns */
> >>  	int prot;		/* mmap protection */
> >> --
> >> 1.8.3.2
> >>
> >>
> > 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
