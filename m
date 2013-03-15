From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH ctf] Typo fix in the tracers requirements
Date: Fri, 15 Mar 2013 17:37:12 -0400
Message-ID: <20130315213712.GA5443__48613.3697479547$1363383480$gmane$org@Krystal>
References: <1363382164-12487-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UGcJQ-0004zo-Fw
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 17:37:16 -0400
Content-Disposition: inline
In-Reply-To: <1363382164-12487-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

merged, thanks!

Mathieu

> ---
>  common-trace-format-reqs.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/common-trace-format-reqs.txt b/common-trace-format-reqs.txt
> index 66fe55a..e5e7c7a 100644
> --- a/common-trace-format-reqs.txt
> +++ b/common-trace-format-reqs.txt
> @@ -268,7 +268,7 @@ Enumerating these higher-level requirements influence=
 the trace format in many
>  ways. For instance, a requirement for compactness leads to schemes where=
 all
>  information repetition should be eliminated. Thus the need for optional
>  per-section context information. Another example is the requirement for =
speed
> -and streaming. The requirement for speed ans treaming leads to zero-copy
> +and streaming. The requirement for speed and streaming leads to zero-copy
>  implementations, which imply that the trace format should be written nat=
ively by
>  the tracer.  The tracer requirements stated in this section are stated t=
o ensure
>  that the trace format structure makes it possible for a tracer to cope w=
ith the
> -- =

> 1.8.1.5
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
