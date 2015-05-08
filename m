From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] urcu:
	add	cds_list_for_each_entry_safe_from macro
Date: Fri, 8 May 2015 20:24:40 +0000 (UTC)
Message-ID: <1612543106.46350.1431116680270.JavaMail.zimbra__6208.28649630329$1431116875$gmane$org@efficios.com>
References: <1430394605-27519-1-git-send-email-jeff.layton@primarydata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YqopA-0007z4-9J
 for lttng-dev@lists.lttng.org; Fri, 08 May 2015 16:24:53 -0400
In-Reply-To: <1430394605-27519-1-git-send-email-jeff.layton@primarydata.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> Same as cds_list_for_each_entry_safe, but starts at an arbitrary point
> within the list instead of at the head.

Merged in urcu master branch, thanks!

Mathieu

> 
> Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
> ---
>  urcu/list.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/urcu/list.h b/urcu/list.h
> index b4962b445dfb..4aaf869351fe 100644
> --- a/urcu/list.h
> +++ b/urcu/list.h
> @@ -171,6 +171,15 @@ void cds_list_splice(struct cds_list_head *add, struct
> cds_list_head *head)
>  		&pos->member != (head); \
>  		pos = p, p = cds_list_entry(pos->member.next, __typeof__(*pos), member))
>  
> +/*
> + * Same as cds_list_for_each_entry_safe, but starts from "pos" which should
> + * point to an entry within the list.
> + */
> +#define cds_list_for_each_entry_safe_from(pos, p, head, member) \
> +        for (p = cds_list_entry(pos->member.next, __typeof__(*pos), member);
> \
> +                &pos->member != (head); \
> +                pos = p, p = cds_list_entry(pos->member.next,
> __typeof__(*pos), member))
> +
>  static inline
>  int cds_list_empty(struct cds_list_head *head)
>  {
> --
> 2.1.0
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
