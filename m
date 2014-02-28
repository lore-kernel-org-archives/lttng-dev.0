From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Turn base address dump into
 experimental feature
Date: Fri, 28 Feb 2014 13:05:13 +0000 (UTC)
Message-ID: <1526763030.32093.1393592713156.JavaMail.zimbra__11919.3442202688$1393592765$gmane$org@efficios.com>
References: <1393578120-18814-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJN7r-0003sR-LC
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 08:05:17 -0500
In-Reply-To: <1393578120-18814-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Paul Woegerer" <paul_woegerer@mentor.com>
> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Friday, February 28, 2014 4:02:00 AM
> Subject: [PATCH lttng-ust] Turn base address dump into experimental feature
> 
> Instead of having base address state dump enabled by default make it
> necessary to explicitly enable it with environment variable
> LTTNG_UST_WITH_EXPERIMENTAL_BADDR_STATEDUMP.
> 
> Documentation is updated to reflect this change and explain about the
> experimental nature of this feature.
> 
> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> ---
>  doc/man/lttng-ust.3            | 10 +++++++---
>  liblttng-ust/lttng-ust-baddr.c |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
> index 2fb287a..2c58fba 100644
> --- a/doc/man/lttng-ust.3
> +++ b/doc/man/lttng-ust.3
> @@ -366,9 +366,13 @@ Pthread identifier. Can be used on architectures where
> pthread_t maps
>  nicely to an unsigned long type.
>  .PP
>  
> -.SH "BASE ADDRESS STATEDUMP"
> +.SH "BASE ADDRESS STATEDUMP (Experimental feature)"
>  
>  .PP
> +Warning: This is an experimental feature known to cause deadlocks when the
> +traced application uses fork, clone or daemon. Only use it for debugging and
> +testing.  Do NOT use it in production.
> +
>  If an application that uses liblttng-ust.so becomes part of a session,
>  information about its currently loaded shared objects will be traced to the
>  session at session-enable time. To record this information, the following
>  event
> @@ -405,8 +409,8 @@ specified in milliseconds. The value 0 means "don't
> wait". The value
>  recommended for applications with time constraints on the process
>  startup time.
>  .PP
> -.IP "LTTNG_UST_WITHOUT_BADDR_STATEDUMP"
> -Prevent liblttng-ust to perform a base-address statedump on session-enable.
> +.IP "LTTNG_UST_WITH_EXPERIMENTAL_BADDR_STATEDUMP"
> +Experimentally allow liblttng-ust to perform a base-address statedump on
> session-enable.
>  .PP
>  
>  .SH "SEE ALSO"
> diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
> index 922899b..dec7e82 100644
> --- a/liblttng-ust/lttng-ust-baddr.c
> +++ b/liblttng-ust/lttng-ust-baddr.c
> @@ -176,7 +176,7 @@ int lttng_ust_baddr_statedump(void *owner)
>  {
>  	struct extract_data data;
>  
> -	if (getenv("LTTNG_UST_WITHOUT_BADDR_STATEDUMP"))
> +	if (!getenv("LTTNG_UST_WITH_EXPERIMENTAL_BADDR_STATEDUMP"))
>  		return 0;
>  
>  	data.owner = owner;
> --
> 1.9.0
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
