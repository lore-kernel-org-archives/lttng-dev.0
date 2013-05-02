From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space	(version
	7)
Date: Thu, 2 May 2013 16:30:19 -0400
Message-ID: <20130502203019.GF15675__34784.0096023448$1367526650$gmane$org@Krystal>
References: <1341322152-4380-1-git-send-email-francis.giraldeau@gmail.com>
	<20120704093821.35384043@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY08y-0006R6-Fo
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:30:20 -0400
Content-Disposition: inline
In-Reply-To: <20120704093821.35384043@skate>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Thomas Petazzoni (thomas.petazzoni@free-electrons.com) wrote:
> Hello,
> =

> Le Tue,  3 Jul 2012 15:29:12 +0200,
> Francis Giraldeau <francis.giraldeau@gmail.com> a =E9crit :
> =

> > By writing to the file /proc/lttng_uevent, a user-space application cre=
ates a
> > kernel event. The event's payload is by default UTF-8 text, but any dat=
a can be
> > written. The maximum size of the data is at most the size of a packet d=
efined
> > for the trace session. Null-character is optional and is not enforced. =
 The
> > event uses sequence for space efficiency and to store any data as paylo=
ad.
> =

> Shouldn't this be in the debugfs filesystem rather than the proc
> filesystem? The debugfs filesystem already has entries for various
> tracing facilities of the Linux kernel, and adding entries in /proc
> that are not process-related is frowned upon these days.

yes, I think this infrastructure should belong in debugfs.

Thanks,

Mathieu

> =

> Best regards,
> =

> Thomas
> -- =

> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
