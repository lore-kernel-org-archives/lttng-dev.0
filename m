From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] liblttng-ust/lttng-ust-comm.c:
	fixing	typo.
Date: Tue, 26 Jun 2012 01:52:27 -0400
Message-ID: <20120626055226.GA11445__30369.5529619747$1340689972$gmane$org@Krystal>
References: <1340623371-22228-1-git-send-email-henrik@fiktivkod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjOhQ-0005vD-Ie
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 01:52:28 -0400
Content-Disposition: inline
In-Reply-To: <1340623371-22228-1-git-send-email-henrik@fiktivkod.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Henrik Hautakoski <henrik@fiktivkod.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Henrik Hautakoski (henrik@fiktivkod.org) wrote:
> Signed-off-by: Henrik Hautakoski <henrik@fiktivkod.org>

merged, thanks!

Mathieu

> ---
>  liblttng-ust/lttng-ust-comm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index 4104a3f..deca7cb 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -681,7 +681,7 @@ error:
>   * This thread does not allocate any resource, except within
>   * handle_message, within mutex protection. This mutex protects against
>   * fork and exit.
> - * The other moment it allocates resources is at socket connexion, which
> + * The other moment it allocates resources is at socket connection, which
>   * is also protected by the mutex.
>   */
>  static
> -- 
> 1.7.9.5
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
