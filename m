From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix cross-compile
Date: Wed, 07 Nov 2012 15:17:29 -0500
Message-ID: <509AC1D9.5050704__12000.0240546235$1352319484$gmane$org@efficios.com>
References: <20121107201321.GA31570@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TWC44-0004A8-SR
	for lttng-dev@lists.lttng.org; Wed, 07 Nov 2012 15:17:32 -0500
In-Reply-To: <20121107201321.GA31570@Krystal>
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

Merged.

Thanks!

Mathieu Desnoyers:
> configure.ac should use --target, not --host to get the target info we
> want to compile for. --host is for the host that does the build.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/configure.ac b/configure.ac
> index a3120fc..49d324e 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -313,7 +313,7 @@ AS_ECHO("$version_description")
>  AS_ECHO()
>  
>  # Target architecture we're building for
> -target_arch=$host_cpu
> +target_arch=$target_cpu
>  [
>  for f in $CFLAGS; do
>          if test $f = "-m32"; then
> 
> 
