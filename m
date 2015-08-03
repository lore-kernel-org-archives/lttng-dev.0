From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE stable-1.2 PATCH] Hide the
	packet_seq_num field
Date: Mon, 3 Aug 2015 15:41:56 +0000 (UTC)
Message-ID: <819654622.3286.1438616516643.JavaMail.zimbra__44261.7197325037$1438616585$gmane$org@efficios.com>
References: <1438616138-29252-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZMHsQ-0000Nf-QF
 for lttng-dev@lists.lttng.org; Mon, 03 Aug 2015 11:42:14 -0400
In-Reply-To: <1438616138-29252-1-git-send-email-jdesfossez@efficios.com>
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

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Could we backport it to current babeltrace stable releases too ?

Thanks,

Mathieu

----- On Aug 3, 2015, at 11:35 AM, Julien Desfossez jdesfossez@efficios.com wrote:

> The packet_seq_num is a new field in LTTng 2.8 that should be hidden
> from the ctf-text output as it is not really relevant for the users of
> the text output.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
> formats/ctf-text/ctf-text.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
> index 9d5123a..2ba0823 100644
> --- a/formats/ctf-text/ctf-text.c
> +++ b/formats/ctf-text/ctf-text.c
> @@ -115,7 +115,8 @@ static GQuark Q_STREAM_PACKET_CONTEXT_TIMESTAMP_BEGIN,
> 	Q_STREAM_PACKET_CONTEXT_TIMESTAMP_END,
> 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED,
> 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE,
> -	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE;
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE,
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM;
> 
> static
> void __attribute__((constructor)) init_quarks(void)
> @@ -125,6 +126,7 @@ void __attribute__((constructor)) init_quarks(void)
> 	Q_STREAM_PACKET_CONTEXT_EVENTS_DISCARDED =
> 	g_quark_from_static_string("stream.packet.context.events_discarded");
> 	Q_STREAM_PACKET_CONTEXT_CONTENT_SIZE =
> 	g_quark_from_static_string("stream.packet.context.content_size");
> 	Q_STREAM_PACKET_CONTEXT_PACKET_SIZE =
> 	g_quark_from_static_string("stream.packet.context.packet_size");
> +	Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM =
> g_quark_from_static_string("stream.packet.context.packet_seq_num");
> }
> 
> static
> @@ -152,6 +154,8 @@ int print_field(struct bt_definition *definition)
> 		return 0;
> 	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SIZE)
> 		return 0;
> +	if (definition->path == Q_STREAM_PACKET_CONTEXT_PACKET_SEQ_NUM)
> +		return 0;
> 
> 	return 1;
> }
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
