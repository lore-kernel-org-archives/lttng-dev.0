From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Add compilation support for the	TileGX
	architecture.
Date: Fri, 9 Nov 2012 10:58:46 -0500
Message-ID: <20121109155846.GC8094__25799.0391845398$1352476777$gmane$org@Krystal>
References: <1352443614-8272-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWqyl-0007Hg-6p
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 10:58:47 -0500
Content-Disposition: inline
In-Reply-To: <1352443614-8272-1-git-send-email-simon.marchi@polymtl.ca>
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

should remove dot from EOL too.

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  configure.ac |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 1d04062..a4ef8c9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -77,6 +77,7 @@ AS_CASE([$host_cpu],
>  	[ia64], [ARCHTYPE="gcc"],
>  	[arm*], [ARCHTYPE="arm"],
>  	[mips*], [ARCHTYPE="mips"],
> +	[tile], [ARCHTYPE="gcc"],

So I guess you are adding support for the Tile architecture, not just
the TileGX. Can you resumbit after updating the patch subject to reflect
this ?

Thanks,

Mathieu

>  	[ARCHTYPE="unknown"]
>  )
>  
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
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
