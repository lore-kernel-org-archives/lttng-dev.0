From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [urcu commit] list: implement
	cds_list_for_each_safe()
Date: Wed, 13 Mar 2013 09:46:18 -0700
Message-ID: <20130313164618.GU3725__10822.3387077034$1363193335$gmane$org@linux.vnet.ibm.com>
References: <20130313163030.GA17870@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1UFoqR-0004dS-N5
	for lttng-dev@lists.lttng.org; Wed, 13 Mar 2013 12:48:03 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 13 Mar 2013 10:47:48 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1D8BE19D805E
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 10:46:19 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r2DGkKL6082856
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 10:46:20 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r2DGmuPi025049
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 10:48:56 -0600
Content-Disposition: inline
In-Reply-To: <20130313163030.GA17870@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Wed, Mar 13, 2013 at 12:30:30PM -0400, Mathieu Desnoyers wrote:
> commit 7e5b9a4d1a4a63fac405ed74c42f93abdc223794
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Mar 13 12:23:11 2013 -0400
> 
>     list: implement cds_list_for_each_safe()
>     
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> diff --git a/urcu/list.h b/urcu/list.h
> index 5d04394..1d1c7b5 100644
> --- a/urcu/list.h
> +++ b/urcu/list.h
> @@ -140,12 +140,17 @@ cds_list_splice (struct cds_list_head *add, struct cds_list_head *head)
>  #define cds_list_for_each(pos, head) \
>    for (pos = (head)->next; pos != (head); pos = pos->next)
> 
> +/* Iterate forward over the elements list. The list elements can be
> +   removed from the list while doing this.  */
> +#define cds_list_for_each_safe(pos, p, head) \
> +  for (pos = (head)->next, p = pos->next; \
> +       pos != (head); \
> +       pos = p, p = pos->next)
> 
>  /* Iterate backward over the elements of the list.  */
>  #define cds_list_for_each_prev(pos, head) \
>    for (pos = (head)->prev; pos != (head); pos = pos->prev)
> 
> -
>  /* Iterate backwards over the elements list.  The list elements can be
>     removed from the list while doing this.  */
>  #define cds_list_for_each_prev_safe(pos, p, head) \
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
