From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Cross-domain influence on overhead
Date: Mon, 7 Jan 2013 08:44:04 -0500
Message-ID: <20130107134404.GA30165__13402.8028850027$1357566306$gmane$org@Krystal>
References: <524C960C5DFC794E82BE548D825F05CF5BC8AEAD@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TsCzm-0007s1-CV
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 08:44:06 -0500
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF5BC8AEAD@EU-MBX-04.mgc.mentorg.com>
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

> I've noticed the following somewhat puzzling effect on both Intel and
> ARM architecture computers:
> =

> If all trace events are enabled in one domain only, either kernel or
> user space, and there are lots of static tracepoints instrumented in
> the other, then these inactive tracepoints start causing overhead of
> about the same magnitude as if they were active, as if trace events
> were enabled in this domain.
> =

> Is there any obvious explanation to this behaviour?

No, this would be really surprising.

Can you provide your test script, and more details about the way you
perform your benchmarks ? How is the overhead calculated ? From how many
tracepoints hit ? How many processes spawned/exec() done ? How many
tracepoints hit per process ?

Thanks,

Mathieu

> =

> Cheers,
> =

> Fredrik =D6stman
> =

> http://go.mentor.com/sourceryanalyzer/
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
