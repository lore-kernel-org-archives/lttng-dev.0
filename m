From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: When is tracepoint registration finished?
Date: Fri, 20 Jul 2012 14:21:02 -0400
Message-ID: <20120720182101.GD20073__12992.1559863307$1342808490$gmane$org@Krystal>
References: <524C960C5DFC794E82BE548D825F05CF56CB1DF1@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SsHp1-0000Aw-Kq
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 14:21:03 -0400
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF56CB1DF1@EU-MBX-04.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Oestman, Fredrik (Fredrik_Oestman@mentor.com) wrote:
> Hi,
> =

> Is there any way to know from within the instrumented application when
> tracepoint registration is finished?

No.

> =

> We have instrumented clib functions, which are used by LTTng and start
> producing trace events before all tracepoint registration is finished.

Yep, this is because the events are triggered before the constructor
that registers the tracepoint probes gets called.

> On ARM, this messes up LTTng UST and faulty events are recorded.

What do you mean by faulty events ?

> On all architectures, we trace function calls we aren't interested in.

Well, if you trace _all_ function calls, then you get all function calls
;) Not just those of your application, but also those of library
constructors.

Thanks,

Mathieu

> =

> Cheers,
> =

> Fredrik =D6stman
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
