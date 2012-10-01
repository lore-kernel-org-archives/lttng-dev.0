From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Wich interface to use for lttng ust
Date: Mon, 1 Oct 2012 10:59:25 -0400
Message-ID: <20121001145925.GC13423__48350.3803764053$1349103606$gmane$org@Krystal>
References: <14773128.185971349080793918.JavaMail.www@wsfrf1114>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TIhSw-0006qN-On
	for lttng-dev@lists.lttng.org; Mon, 01 Oct 2012 10:59:26 -0400
Content-Disposition: inline
In-Reply-To: <14773128.185971349080793918.JavaMail.www@wsfrf1114>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: paul.chavent@fnac.net, Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* paul.chavent@fnac.net (paul.chavent@fnac.net) wrote:
> Hi.
> =

> I would like to try lttng user space traces. I've found two documentation=
s :
> =A0- manual : http://lttng.org/files/ust/manual/ust.html
> =A0- man page : http://lttng.org/files/doc/man-pages/man3/lttng-ust.3.html
> =

> Is there any "prefered" choice for reference ?

lttng-ust(3).

> Should/Can i use
> ust_marker, tracepoint ?

ust_marker do not exist anymore.

Alexandre, can you remove the old
http://lttng.org/files/ust/manual/ust.html 0.x manpage ? Or make sure
you move it somewhere that clearly states it is outdated ?

Thanks,

Mathieu

> =

> Thank for your replies.
> =

> Paul.
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
