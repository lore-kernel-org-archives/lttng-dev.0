From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Enable additional kernel probes
Date: Wed, 14 Nov 2012 11:07:58 -0500
Message-ID: <20121114160758.GB32677__42062.9533160993$1352909310$gmane$org@Krystal>
References: <50A394DF.70607@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TYfVQ-0001y0-0T
	for lttng-dev@lists.lttng.org; Wed, 14 Nov 2012 11:08:00 -0500
Content-Disposition: inline
In-Reply-To: <50A394DF.70607@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> To enable the extra kernel probes (see related thread: http://lists.lttng=
.org/pipermail/lttng-dev/2012-November/019046.html) the following patch is =
required for lttng-tools:
> =

> From fbf7bdae4af6d082ce71bc0976628e5d24a515fc Mon Sep 17 00:00:00 2001
> From: Paul Woegerer <paul_woegerer@mentor.com>
> Date: Wed, 14 Nov 2012 13:49:45 +0100
> Subject: [PATCH] Add additional kernel probes to module list.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> =

> ---
>  src/bin/lttng-sessiond/modprobe.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> =

> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/m=
odprobe.c
> index b3f2e57..f38d393 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -44,13 +44,30 @@ const struct kern_modules_param kern_modules_list[] =
=3D {
>  	{ "lttng-ring-buffer-metadata-mmap-client", 1 },
>  	{ "lttng-probe-lttng", 1 },
>  	{ "lttng-types", 0 },
> +	{ "lttng-probe-asoc", 0 },
>  	{ "lttng-probe-block", 0 },
> +	{ "lttng-probe-ext3", 0 },
> +	{ "lttng-probe-gpio", 0 },
>  	{ "lttng-probe-irq", 0 },
> +	{ "lttng-probe-jbd", 0 },
> +	{ "lttng-probe-jbd2", 0 },
> +	{ "lttng-probe-kmem", 0 },
>  	{ "lttng-probe-kvm", 0 },
> +	{ "lttng-probe-lock", 0 },
> +	{ "lttng-probe-modules", 0 },
> +	{ "lttng-probe-napi", 0 },
> +	{ "lttng-probe-net", 0 },
> +	{ "lttng-probe-power", 0 },
> +	{ "lttng-probe-regulator", 0 },
>  	{ "lttng-probe-sched", 0 },
> +	{ "lttng-probe-scsi", 0 },
>  	{ "lttng-probe-signal", 0 },
> +	{ "lttng-probe-skb", 0 },
> +	{ "lttng-probe-sock", 0 },
>  	{ "lttng-probe-statedump", 0 },
>  	{ "lttng-probe-timer", 0 },
> +	{ "lttng-probe-udp", 0 },
> +	{ "lttng-probe-vmscan", 0 },
>  };
>  =

>  /*
> -- =

> 1.7.10.4
> =

> =

> =

> -- =

> Paul Woegerer | SW Development Engineer
> http://go.mentor.com/sourceryanalyzer
> =

> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
> =

> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
