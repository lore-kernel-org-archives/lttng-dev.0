From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] urcu: remove the wrong comma
Date: Fri, 7 Dec 2012 11:34:42 -0500
Message-ID: <20121207163442.GC11975__36075.3131601543$1354898127$gmane$org@Krystal>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
	<1354872295-32371-2-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Th0st-0002sO-Oi
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 11:34:43 -0500
Content-Disposition: inline
In-Reply-To: <1354872295-32371-2-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>

Merged, thanks!

Mathieu

> ---
>  tests/test_urcu_wfcq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tests/test_urcu_wfcq.c b/tests/test_urcu_wfcq.c
> index 939bf7a..17814a7 100644
> --- a/tests/test_urcu_wfcq.c
> +++ b/tests/test_urcu_wfcq.c
> @@ -544,7 +544,7 @@ int main(int argc, char **argv)
>  		       tot_enqueues, tot_dequeues);
>  	printf_verbose("total number of successful enqueues : %llu, "
>  		       "enqueues to empty dest : %llu, "
> -		       "successful dequeues %llu, ",
> +		       "successful dequeues %llu, "
>  		       "splice : %llu\n",
>  		       tot_successful_enqueues,
>  		       tot_empty_dest_enqueues,
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
