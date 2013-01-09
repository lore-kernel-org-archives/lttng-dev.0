From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH ust] Remove LIBFORMAT output in configure.
Date: Wed, 9 Jan 2013 15:42:41 -0500
Message-ID: <20130109204241.GA16429__43923.3075980612$1357764214$gmane$org@Krystal>
References: <1357763294-24232-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tt2U1-0004k2-63
	for lttng-dev@lists.lttng.org; Wed, 09 Jan 2013 15:42:45 -0500
Content-Disposition: inline
In-Reply-To: <1357763294-24232-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>

merged into ust master branch, thanks !

Mathieu

> ---
>  configure.ac |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c4377a5..a67e8f9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -309,7 +309,6 @@ AS_ECHO("$version_description")
>  # Report on the configuration options
>  AS_ECHO()
>  AS_ECHO("LTTng-UST will be built with the following options:")
> -AS_ECHO("Library format: $LIBFORMAT")
>  
>  AS_ECHO()
>  AS_ECHO_N("Java support (JNI): ")
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
