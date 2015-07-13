From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES PATCH 1/3] Add stream instance id to the
	packet header
Date: Mon, 13 Jul 2015 18:02:00 +0000 (UTC)
Message-ID: <979381512.49.1436810520273.JavaMail.zimbra__9581.70831804655$1436810579$gmane$org@efficios.com>
References: <1436800165-14221-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZEi3N-00016e-2y
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 14:02:10 -0400
In-Reply-To: <1436800165-14221-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jul 13, 2015, at 11:09 AM, Julien Desfossez jdesfossez@efficios.com wrote:

> This new field allows the viewer to distinguish between trace files
> belonging to the same packet stream (in LTTng: the same CPU in the same
> channel).

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
> lttng-events.c             | 1 +
> lttng-ring-buffer-client.h | 2 ++
> 2 files changed, 3 insertions(+)
> 
> diff --git a/lttng-events.c b/lttng-events.c
> index 9769f89..3cbfcbf 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -1973,6 +1973,7 @@ int _lttng_session_metadata_statedump(struct lttng_session
> *session)
> 		"		uint32_t magic;\n"
> 		"		uint8_t  uuid[16];\n"
> 		"		uint32_t stream_id;\n"
> +		"		uint64_t stream_instance_id;\n"
> 		"	};\n"
> 		"};\n\n",
> 		lttng_alignof(uint8_t) * CHAR_BIT,
> diff --git a/lttng-ring-buffer-client.h b/lttng-ring-buffer-client.h
> index 7055e77..72fbf18 100644
> --- a/lttng-ring-buffer-client.h
> +++ b/lttng-ring-buffer-client.h
> @@ -57,6 +57,7 @@ struct packet_header {
> 					 */
> 	uint8_t uuid[16];
> 	uint32_t stream_id;
> +	uint64_t stream_instance_id;
> 
> 	struct {
> 		/* Stream packet context */
> @@ -351,6 +352,7 @@ static void client_buffer_begin(struct lib_ring_buffer *buf,
> u64 tsc,
> 	header->magic = CTF_MAGIC_NUMBER;
> 	memcpy(header->uuid, session->uuid.b, sizeof(session->uuid));
> 	header->stream_id = lttng_chan->id;
> +	header->stream_instance_id = buf->backend.cpu;
> 	header->ctx.timestamp_begin = tsc;
> 	header->ctx.timestamp_end = 0;
> 	header->ctx.content_size = ~0ULL; /* for debugging */
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
