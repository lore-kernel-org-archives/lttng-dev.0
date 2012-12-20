From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] rculfhash: add cds_lfht_replace to the
	write	operations in the comments
Date: Thu, 20 Dec 2012 06:14:56 -0500
Message-ID: <20121220111456.GB19897__46144.3617627539$1356002134$gmane$org@Krystal>
References: <1355999373-1407-1-git-send-email-laijs@cn.fujitsu.com>
	<1355999373-1407-2-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tle5Z-0006MF-8x
	for lttng-dev@lists.lttng.org; Thu, 20 Dec 2012 06:14:57 -0500
Content-Disposition: inline
In-Reply-To: <1355999373-1407-2-git-send-email-laijs@cn.fujitsu.com>
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
>  rculfhash.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/rculfhash.c b/rculfhash.c
> index 7050d5c..3650ed3 100644
> --- a/rculfhash.c
> +++ b/rculfhash.c
> @@ -129,7 +129,7 @@
>   *  - cds_lfht_first followed iteration with cds_lfht_next (and/or
>   *    cds_lfht_next_duplicate, although less common).
>   *
> - * We define "write" operations as any of cds_lfht_add,
> + * We define "write" operations as any of cds_lfht_add, cds_lfht_replace,
>   * cds_lfht_add_unique (success), cds_lfht_add_replace, cds_lfht_del.
>   *
>   * When cds_lfht_add_unique succeeds (returns the node passed as
> -- 
> 1.7.4.4
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
