From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2]
	liblttng-ust-comm/lttng-ust-com.c:	remove unnecessary goto in
	ustcomm_accept_unix_sock()
Date: Tue, 26 Jun 2012 02:00:43 -0400
Message-ID: <20120626060043.GB11445__5931.34538871727$1340690466$gmane$org@Krystal>
References: <1340623371-22228-1-git-send-email-henrik@fiktivkod.org>
	<1340623371-22228-2-git-send-email-henrik@fiktivkod.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjOpR-00060z-6C
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 02:00:45 -0400
Content-Disposition: inline
In-Reply-To: <1340623371-22228-2-git-send-email-henrik@fiktivkod.org>
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

In this specific case, this is right that the goto appears to be really
useless. Although I would not merge this kind of change in all cases: if
in another situation the function appears to be bound to have other
calls in the future, using gotos allow to do the teardown of the
function in error cases in a symmetric way:

a = fct();
if (!a)
  goto error_a;
b = fct2();
if (!b)
  goto error_b;


return 0; /* OK */

error_b:
  teardown(a);
error_a:
  return -1;

So the intend in ustcomm_accept_unix_sock() was to ensure that as the
function grows to contain more calls, the teardown can be done
symmetrically in this way. But I guess it appears that it won't grow, so
I'm taking the cleanup.

Thanks,

Mathieu


> ---
>  liblttng-ust-comm/lttng-ust-comm.c |    6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/liblttng-ust-comm/lttng-ust-comm.c b/liblttng-ust-comm/lttng-ust-comm.c
> index 078b56a..1e2fd1a 100644
> --- a/liblttng-ust-comm/lttng-ust-comm.c
> +++ b/liblttng-ust-comm/lttng-ust-comm.c
> @@ -172,13 +172,9 @@ int ustcomm_accept_unix_sock(int sock)
>  	new_fd = accept(sock, (struct sockaddr *) &sun, &len);
>  	if (new_fd < 0) {
>  		perror("accept");
> -		goto error;
> +		return -1;
>  	}
> -
>  	return new_fd;
> -
> -error:
> -	return -1;
>  }
>  
>  /*
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
