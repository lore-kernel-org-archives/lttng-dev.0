From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] ctf-text: hide packet_seq_num
 and	packet_seq_num_padding
Date: Mon, 13 Jul 2015 19:34:28 +0000 (UTC)
Message-ID: <437113548.187.1436816068235.JavaMail.zimbra__9929.5578701005$1436816131$gmane$org@efficios.com>
References: <1436801368-18117-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZEjUv-0001fO-8y
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 15:34:45 -0400
In-Reply-To: <1436801368-18117-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Following my discussion with Julien, we'll await an updated patch
that won't need "seq_num_padding" at all.

Thanks,

Mathieu

----- On Jul 13, 2015, at 11:29 AM, Julien Desfossez jdesfossez@efficios.com wrote:

> These fields are introduced in lttng-tools 2.7 and do not need to be
> output to the babeltrace CLI users for now.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
> formats/ctf-text/ctf-text.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
> index 9d5123a..0c2c388 100644
> --- a/formats/ctf-text/ctf-text.c
> +++ b/formats/ctf-text/ctf-text.c
> @@ -115,7 +115,9 @@ static GQuark Q_STREAM_PACKET_CONTEXT_TIMESTAMP_BEGIN,
> 	Q_STREAM_PACKET_CONTEXT_TIMESTAMP_END,
> 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED,
> 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE,
> -	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE;
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE,
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM,
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM_PADDING;
> 
> static
> void __attribute__((constructor)) init_quarks(void)
> @@ -125,6 +127,8 @@ void __attribute__((constructor)) init_quarks(void)
> 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED =
> 	g_quark_from_static_string("stream.packet.context.events_discarded");
> 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE =
> 	g_quark_from_static_string("stream.packet.context.content_size");
> 	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE =
> 	g_quark_from_static_string("stream.packet.context.packet_size");
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM =
> g_quark_from_static_string("stream.packet.context.packet_seq_num");
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM_PADDING =
> g_quark_from_static_string("stream.packet.context.packet_seq_num_padding");
> }
> 
> static
> @@ -152,6 +156,10 @@ int print_field(struct bt_definition *definition)
> 		return 0;
> 	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SIZE)
> 		return 0;
> +	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM)
> +		return 0;
> +	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM_PADDING)
> +		return 0;
> 
> 	return 1;
> }
> --
> 1.9.1
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
