From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [babeltrace] FTS does not support large files
	on	32-bit
Date: Fri, 20 Jul 2012 14:07:30 -0400
Message-ID: <20120720180730.GA20073__46360.2218813778$1342807676$gmane$org@Krystal>
References: <20120630185335.GA31235@Krystal> <4FF4A996.8040606@gmail.com>
	<524C960C5DFC794E82BE548D825F05CF56CB608F@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SsHbw-0008TP-Nd
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 14:07:32 -0400
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF56CB608F@EU-MBX-04.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "jdesfossez@efficios.com" <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

* Oestman, Fredrik (Fredrik_Oestman@mentor.com) wrote:
> Hi Yannick and Julien,
> =

> =

> Yannick Brosseau wrote:
> > FTS does not use callbacks, which makes it easier to use.
> > Also since it was supposed to be part of the babeltrace API, not having
> > to manage a callbacks looked better.
> > =

> > Might had other reasons at the time, but now I don't see any more.
> =

> Are you making any progress in supplying large file support in babeltrace?
> =

> Would it be helpful if I filed a bug report?

Julien was on vacation last week. Hopefully he will make progress on
this issue within the next week. Adding a bug entry would be helpful to
track this issue, yes.

Thanks,

Mathieu

> =

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
