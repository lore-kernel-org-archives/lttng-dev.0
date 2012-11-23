From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH lttng-modules] Fix compilation for 3.0
 kernels that are named 2.6.40
Date: Fri, 23 Nov 2012 17:56:05 -0500
Message-ID: <CAFXXi0mVqrBr29fr_QDBG0i3F5FF2+TL8U4W4nedD+2ojq3Fdg__47195.9017603242$1353711434$gmane$org@mail.gmail.com>
References: <1353711280-8395-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1Tc2Ar-0002aJ-D1
	for lttng-dev@lists.lttng.org; Fri, 23 Nov 2012 17:56:41 -0500
Received: by mail-pb0-f48.google.com with SMTP id rq13so6860341pbb.35
	for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2012 14:56:35 -0800 (PST)
In-Reply-To: <1353711280-8395-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Please ignore, I sent only this one patch instead of the two I intended.

On Fri, Nov 23, 2012 at 5:54 PM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> Since some distro released the 3.0 kernel as 2.6.40, it might be useful
> to adjust some checks to treat 2.6.40 kernels as 3.0.
>
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  instrumentation/events/lttng-module/net.h |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/instrumentation/events/lttng-module/net.h b/instrumentation/events/lttng-module/net.h
> index a444b07..e552cf7 100644
> --- a/instrumentation/events/lttng-module/net.h
> +++ b/instrumentation/events/lttng-module/net.h
> @@ -12,7 +12,7 @@
>
>  TRACE_EVENT(net_dev_xmit,
>
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
>         TP_PROTO(struct sk_buff *skb,
>                  int rc,
>                  struct net_device *dev,
> @@ -30,14 +30,14 @@ TRACE_EVENT(net_dev_xmit,
>                 __field(        void *,         skbaddr         )
>                 __field(        unsigned int,   len             )
>                 __field(        int,            rc              )
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
>                 __string(       name,           dev->name       )
>  #else
>                 __string(       name,           skb->dev->name  )
>  #endif
>         ),
>
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
>         TP_fast_assign(
>                 tp_assign(skbaddr, skb)
>                 tp_assign(len, skb_len)
> --
> 1.7.1
>
