From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Prerequsites for adding perf context
Date: Fri, 15 Jun 2012 11:13:42 -0400
Message-ID: <20120615151342.GB28295__43930.1183716909$1339773248$gmane$org@Krystal>
References: <1339746088.90723.YahooMailNeo@web161201.mail.bf1.yahoo.com>
	<4FDAEF5C.9030102@gmail.com>
	<524C960C5DFC794E82BE548D825F05CF283461BF@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SfYDX-0001Zu-Am
	for lttng-dev@lists.lttng.org; Fri, 15 Jun 2012 11:13:43 -0400
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF283461BF@EU-MBX-01.mgc.mentorg.com>
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

> =

> What exactly is needed on a system for
> =

> # lttng add-context -k -t perf:<something>
> =

> to work? Does perf have to be installed?
> =

> I have hw perfevents, but not perf, and get
> =

> hw perfevents: unable to reserve pmu

CONFIG_PERF_EVENTS. And what version of kernel do you use ?

> =

> =

> cheers,
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
