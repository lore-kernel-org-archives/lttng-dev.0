From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 16/18] Add serialized
 versions of lttng_event structs
Date: Thu, 18 Apr 2019 15:50:17 -0400 (EDT)
Message-ID: <23293796.1621.1555617017184.JavaMail.zimbra__46531.5965980821$1555617034$gmane$org@efficios.com>
References: <20190418161850.1536-1-ylamarre@efficios.com>
 <20190418161850.1536-17-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44lV7s6bSkz1KTj
 for <lttng-dev@lists.lttng.org>; Thu, 18 Apr 2019 15:50:17 -0400 (EDT)
In-Reply-To: <20190418161850.1536-17-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Apr 18, 2019, at 12:18 PM, Yannick Lamarre ylamarre@efficios.com wrote:

> Serialized version of lttng_snapshot_output is a packed structure to be
> used in communication protocols for consistent size across platforms.
> The serialized version is stripped of pointers and padding.
> 
> Pointers are removed since their size can vary on platforms supporting
> variable sized registers (x86-64).
> Padding is also removed since it defeats the purpose of a packed struct.

Same questions about explanation of "variable sized registers" and how
we extend without padding as prior commits.

Thanks,

Mathieu

> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
> include/lttng/snapshot-internal.h | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/include/lttng/snapshot-internal.h
> b/include/lttng/snapshot-internal.h
> index b7391c22..bf9dfbe4 100644
> --- a/include/lttng/snapshot-internal.h
> +++ b/include/lttng/snapshot-internal.h
> @@ -45,6 +45,14 @@ struct lttng_snapshot_output {
> 	char data_url[PATH_MAX];
> };
> 
> +struct lttng_snapshot_output_serialized {
> +	uint32_t id;
> +	uint64_t max_size;
> +	char name[LTTNG_NAME_MAX];
> +	char ctrl_url[PATH_MAX];
> +	char data_url[PATH_MAX];
> +} LTTNG_PACKED;
> +
> /*
>  * Snapshot output list object opaque to the user.
>  */
> --
> 2.11.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
