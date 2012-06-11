From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] [PATCH] -Werror=old-style-definition and
	UST	tracepoints
Date: Mon, 11 Jun 2012 09:52:29 -0400
Message-ID: <20120611135229.GA18709__14384.9272317768$1339422778$gmane$org@Krystal>
References: <4FD243CF.60104@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Se52k-0007Ao-Mx
	for lttng-dev@lists.lttng.org; Mon, 11 Jun 2012 09:52:30 -0400
Content-Disposition: inline
In-Reply-To: <4FD243CF.60104@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Hollis Blanchard (hollis_blanchard@mentor.com) wrote:
[...]
> I believe the problem comes from -Werror=old-style-definition not liking  
> that empty "()", i.e. tracepoint_cb_qemu_tb_hash___flushall() { ... }.  
> The following patch seems to work for me; is there a reason it isn't  
> already written this way?

Good catch !

Fixed as master commit:

commit 86637aa6452f66dee5f769461668c2ea059b3a30
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Jun 11 09:53:07 2012 -0400

    Fix: tracepoint.h should not generate old-style definitions

and merged into stable-2.0.

Thanks!

Mathieu


>
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
>
> index 4b773bb..60d8c73 100644
>
> --- a/include/lttng/tracepoint.h
>
> +++ b/include/lttng/tracepoint.h
>
> @@ -88,7 +88,7 @@ extern "C" {
>
>  #define _TP_EXDATA_VAR20(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t)      __tp_data,b,d,f,h,j,l,n,p,r,t
>
>  
>
>  /* _TP_EXPROTO* extract tuples of type, var */
>
> -#define _TP_EXPROTO0()
>
> +#define _TP_EXPROTO0()                                         void
>
>  #define _TP_EXPROTO2(a,b)                                      a b
>
>  #define _TP_EXPROTO4(a,b,c,d)                                  a b,c d
>
>  #define _TP_EXPROTO6(a,b,c,d,e,f)                              a b,c d,e f
>
>
> If this is OK, I'm happy to resend as a proper patch.
>
> -- 
> Hollis Blanchard
> Mentor Graphics, Embedded Systems Division
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
