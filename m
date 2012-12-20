From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] urcu: fix comments for
	cds_list_for_each_prev()
Date: Thu, 20 Dec 2012 06:14:00 -0500
Message-ID: <20121220111400.GA19897__23575.1989916482$1356002084$gmane$org@Krystal>
References: <1355999373-1407-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tle4g-0006LQ-8c
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 06:14:02 -0500
Content-Disposition: inline
In-Reply-To: <1355999373-1407-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>

Merged, thanks!

Mathieu

> ---
>  urcu/list.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/urcu/list.h b/urcu/list.h
> index f27ff7b..5d04394 100644
> --- a/urcu/list.h
> +++ b/urcu/list.h
> @@ -141,7 +141,7 @@ cds_list_splice (struct cds_list_head *add, struct cds_list_head *head)
>    for (pos = (head)->next; pos != (head); pos = pos->next)
>  
>  
> -/* Iterate forward over the elements of the list.  */
> +/* Iterate backward over the elements of the list.  */
>  #define cds_list_for_each_prev(pos, head) \
>    for (pos = (head)->prev; pos != (head); pos = pos->prev)
>  
> -- 
> 1.7.4.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
