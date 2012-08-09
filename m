From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace-patch] Add BT_SEEK_LAST type to
	bt_iter_pos.
Date: Thu, 9 Aug 2012 16:40:45 -0400
Message-ID: <20120809204045.GA15109__32498.4421175488$1344544877$gmane$org@Krystal>
References: <1344542423-31441-1-git-send-email-francis.deslauriers@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SzZXD-0005hn-C4
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 16:40:47 -0400
Content-Disposition: inline
In-Reply-To: <1344542423-31441-1-git-send-email-francis.deslauriers@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Deslauriers <francis.deslauriers@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Deslauriers (francis.deslauriers@polymtl.ca) wrote:
> Signed-off-by: Francis Deslauriers <francis.deslauriers@polymtl.ca>
> ---
>  include/babeltrace/iterator.h |    1 +
>  lib/iterator.c                |  199 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 199 insertions(+), 1 deletion(-)
> 
> diff --git a/include/babeltrace/iterator.h b/include/babeltrace/iterator.h
> index aa6470e..c8edbd1 100644
> --- a/include/babeltrace/iterator.h
> +++ b/include/babeltrace/iterator.h
> @@ -48,6 +48,7 @@ struct bt_iter_pos {
>  		BT_SEEK_CUR,
>  		BT_SEEK_BEGIN,
>  		BT_SEEK_END,
> +		BT_SEEK_LAST

please add comma to last entry. This is a coding style I always follow
to make automated regexps easier.

>  	} type;
>  	union {
>  		uint64_t seek_time;
> diff --git a/lib/iterator.c b/lib/iterator.c
> index bcb77d8..5125afb 100644
> --- a/lib/iterator.c
> +++ b/lib/iterator.c
> @@ -3,7 +3,7 @@
>   *
>   * Babeltrace Library
>   *
> - * Copyright 2010-2011 EfficiOS Inc. and Linux Foundation
> +/ * Copyright 2010-2011 EfficiOS Inc. and Linux Foundation

This seems wrong.

>   *
>   * Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   *
> @@ -186,7 +186,185 @@ static int seek_ctf_trace_by_timestamp(struct ctf_trace *tin,
>  
>  	return found ? 0 : EOF;
>  }
> +int seek_last_element_ctf_file_stream(struct trace_collection *tc,
> +		struct ctf_file_stream **cfs, int max_packet,
> +		int max_stream_id, int max_stream_class_id,
> +		int max_trace_descriptor_id, uint64_t max_timestamp)
> +{
> +	int ret;
> +	struct trace_descriptor *max_td_read;
> +	struct ctf_trace *max_tin;
> +	struct ctf_stream_declaration *max_stream_class;
> +	struct ctf_stream_definition *max_stream;
> +	struct ctf_stream_pos *max_stream_pos;
> +
> +	/* get the targeted trace descriptor */
> +	max_td_read = g_ptr_array_index(tc->array,
> +					max_trace_descriptor_id);
> +	max_tin = container_of(max_td_read,
> +				struct ctf_trace, parent);
> +	/* get targeted stream class */
> +	max_stream_class = g_ptr_array_index(max_tin->streams,
> +						max_stream_class_id);
> +	/* get targeted stream */
> +	max_stream = g_ptr_array_index(max_stream_class->streams,
> +					max_stream_id);

One comment by line might be a bit much. I prefer to comment the
important things that must not be forgotten in the code, and sometimes,
if needed, a commend about what the function does before the function.

> +	*cfs = container_of(max_stream,
> +				struct ctf_file_stream, parent);
> +	max_stream_pos = &(*cfs)->pos;
> +	/* we seek to the last packet of the stream.*/

ah, this comment (above) is slightly more relevant.

> +	max_stream_pos->packet_seek(&max_stream_pos->parent,
> +				max_packet,
> +				SEEK_SET);
> +	/*
> +	* iterate over all the event until we reach on that

all the event -> every event

on that his.. -> an event such that its ...

> +	* his timestamp correspond with the max saved previously.
> +	*/
> +	do {
> +		ret = stream_read_event(*cfs);
> +	} while ((*cfs)->parent.real_timestamp != max_timestamp && ret == 0);
> +
> +	/* We insert the stream in the heap.*/

in -> into

missing space before */

> +	return ret;
> +}

missing whiteline.

please use checkpatch.pl provided in the linux kernel scripts against
your patch to identify style errors.

> +int find_last_event(struct ctf_file_stream *cfs,
> +		uint64_t *timestamp_end,
> +		int *packet)
> +{
> +	int ret = 0;
> +	int count = 0;
> +	int event_read = 0;

put all integers on the same line.

int ret = 0, count = 0, ......

> +	uint64_t tmp = 0;
> +	int i;
> +	struct ctf_stream_pos *stream_pos;
> +	stream_pos = &cfs->pos;

missing whiteline after variable declarations.

> +	/*
> +	 * we start by the last packet as the current one.
> +	 * If the current one is empty we go back one packet if possible.
> +	 */
> +	i = stream_pos->packet_real_index->len;
> +	/*
> +	 * Check if we have iterated on all the packets.
> +	 * If we are not short on packets, we check what
> +	 * made us leave the reading event loop.
> +	 */
> +	while (i >= 1 &&  count == 0) {

what a strangely-looking loop construct. Please use a straightforward
for () loop.

> +		i--;
> +		stream_pos->packet_seek(&stream_pos->parent, i, SEEK_SET);
> +		count = 0;
> +		/* read each event until we reach the end of the packet */
> +		do {
> +			tmp = cfs->parent.real_timestamp;
> +			ret = stream_read_event(cfs);
> +			if (ret == 0) {
> +				count++;
> +			}
> +		} while (ret == 0);
> +
> +		/*Error*/

missing spaces around /*  */

> +		if (ret > 0) {
> +			goto end;
> +		}
> +		event_read += count;
> +	}
> +	*packet = i;
> +	*timestamp_end = tmp;
> +
> +	/* Check if we read at least one event on the stream */
> +	if (event_read <= 1) {
> +		ret = 1;
> +		goto end;
> +	}
> +	ret = 0;
> +
> +end:
> +	return ret;
> +}
>  
> +int find_max_timestamp_ctf_file_stream(
> +		struct ctf_stream_declaration *stream_class, int *max_stream_id,
> +		int *packet, uint64_t *max_timestamp, int *new_max)
> +{
> +	struct ctf_file_stream *cfs;
> +	int i;
> +	int max_packet = 0;
> +	int ret = 0;
> +	int error = 1;

please combine those int into the same line.

> +	uint64_t savedtime;
> +	
> +	for (i = 0; i < stream_class->streams->len; i++) {
> +		struct ctf_stream_definition *stream;
> +		stream = g_ptr_array_index(
> +				stream_class->streams, i);
> +		if (!stream)
> +			continue;
> +		cfs = container_of(stream, struct ctf_file_stream, parent);
> +		ret = find_last_event(cfs, &savedtime, &max_packet);
> +		/* Can return either EOF, 0, or error (> 0). */
> +		if (ret == 0 && savedtime >= *max_timestamp) {
> +			*new_max = 1;
> +			*max_stream_id = i;
> +			*packet = max_packet;
> +			*max_timestamp = savedtime;
> +		}
> +		error = error & ret;
> +	}
> +	return error ;

extra space.

> +}
> +
> +int seek_last_ctf_file_stream(struct trace_collection *tc,
> +		struct ctf_file_stream **cfs)
> +{
> +	int i, j;
> +	int ret;
> +	int found = 0;
> +	int new_max_found;
> +	uint64_t max_timestamp = 0;
> +	int max_packet;
> +	int max_stream_id;
> +	int max_stream_class_id;
> +	int max_trace_descriptor_id;

combine int.

missing whileline.

I look forward to see the next round.

Thanks,

Mathieu

> +	/* For each trace in the trace_collection*/
> +	for (i = 0; i < tc->array->len; i++) {
> +		struct ctf_trace *tin;
> +		struct trace_descriptor *td_read;
> +		td_read = g_ptr_array_index(tc->array, i);
> +		if (!td_read)
> +			continue;
> +		tin = container_of(td_read, struct ctf_trace, parent);
> +		/* For each stream_class in the trace*/
> +		for (j = 0; j < tin->streams->len; j++) {
> +			struct ctf_stream_declaration *stream_class;
> +
> +			stream_class = g_ptr_array_index(tin->streams, j);
> +			if (!stream_class)
> +				continue;
> +			/* For each file_stream in the stream_class */
> +			new_max_found = 0;
> +			ret = find_max_timestamp_ctf_file_stream(stream_class,
> +					&max_stream_id, &max_packet,
> +					&max_timestamp, &new_max_found);
> +			if (!ret && new_max_found) {
> +				found = 1;
> +				max_trace_descriptor_id = i;
> +				max_stream_class_id = j;
> +			}
> +		}
> +	}
> +	/*
> +	 * Now we know in which trace, stream_class and stream is the
> +	 * last event of the trace_collection.
> +	 * We can seek to this targeted event.
> +	 */
> +	if (!found) {
> +		ret = -1;
> +	} else {
> +		ret = seek_last_element_ctf_file_stream(tc, cfs, max_packet,
> +				max_stream_id, max_stream_class_id,
> +				max_trace_descriptor_id, max_timestamp);
> +	}
> +	return ret;
> +}
>  int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
>  {
>  	struct trace_collection *tc;
> @@ -326,6 +504,25 @@ int bt_iter_set_pos(struct bt_iter *iter, const struct bt_iter_pos *iter_pos)
>  			}
>  		}
>  		break;
> +	case BT_SEEK_LAST:
> +	{
> +		struct ctf_file_stream *cfs;
> +		tc = iter->ctx->tc;
> +
> +		ret = seek_last_ctf_file_stream(tc, &cfs);
> +		if (ret < 0)
> +			goto error;
> +		/* remove all stream from the heap*/
> +		heap_free(iter->stream_heap);
> +		/* Create a new empty heap*/
> +		ret = heap_init(iter->stream_heap, 0, stream_compare);
> +		if (ret < 0)
> +			goto error;
> +		/* Insert the stream that contains the last event. */
> +		heap_insert(iter->stream_heap, cfs);
> +
> +		return 0;
> +	}
>  	default:
>  		/* not implemented */
>  		return -EINVAL;
> -- 
> 1.7.9.5
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
