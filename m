From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [RFC PATCH CTF 2/3] Clarify monotonicity
 requirement on timestamp begin
Date: Tue, 28 Apr 2020 14:42:01 -0400 (EDT)
Message-ID: <1480394831.72907.1588099321783.JavaMail.zimbra@efficios.com>
References: <20200423205226.496-1-mathieu.desnoyers@efficios.com>
 <20200423205226.496-3-mathieu.desnoyers@efficios.com>
Reply-To: Philippe Proulx <pproulx@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49BVqh4tVTz1mtV
 for <lttng-dev@lists.lttng.org>; Tue, 28 Apr 2020 14:42:08 -0400 (EDT)
In-Reply-To: <20200423205226.496-3-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, gbastien+lttng <gbastien+lttng@versatic.net>, diamon-discuss@linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "gbastien+lttng" <gbastien+lttng@versatic.net>, "Matthew Khouzam" <matthew.khouzam@ericsson.com>,
> diamon-discuss@linuxfoundation.org, pproulx@efficios.com, "Jeremie Galarneau" <jgalar@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Thursday, 23 April, 2020 16:52:25
> Subject: [RFC PATCH CTF 2/3] Clarify monotonicity requirement on timestamp begin

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> common-trace-format-specification.md | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/common-trace-format-specification.md
> b/common-trace-format-specification.md
> index f5fea51..53b70f4 100644
> --- a/common-trace-format-specification.md
> +++ b/common-trace-format-specification.md
> @@ -836,10 +836,12 @@ TSDL metadata):
>     range between these timestamps should include all event timestamps
>     assigned to events contained within the packet. The timestamp at the
>     beginning of an event packet is guaranteed to be below or equal the
> -    timestamp at the end of that event packet. The timestamp at the end
> -    of an event packet is guaranteed to be below or equal the
> -    timestamps at the end of any following packet within the same stream.
> -    See [Clocks](#spec8) for more detail.
> +    timestamp at the end of that event packet. The timestamp at the
> +    beginning of an event packet is guaranteed to be above or equal the

"greater than or equal to"

> +    timestamps at the beginning of any prior packet within the same
> +    stream. The timestamp at the end of an event packet is guaranteed to
> +    be below or equal the timestamps at the end of any following packet

"less than or equal to"

Phil

> +    within the same stream. See [Clocks](#spec8) for more detail.
>   * **Events discarded count**. Snapshot of a per-stream
>     free-running counter, counting the number of events discarded that
>     were supposed to be written in the stream after the last event in
> --
> 2.11.0
