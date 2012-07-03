From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space	(version
	6)
Date: Tue, 3 Jul 2012 07:39:47 -0400
Message-ID: <20120703113947.GA24563__48034.8298013725$1341315655$gmane$org@Krystal>
References: <1341266778-13735-1-git-send-email-francis.giraldeau@gmail.com>
	<20120702222340.GA1702@Krystal> <4FF28F07.6000901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sm1SP-0008HJ-5s
	for lttng-dev@lists.lttng.org; Tue, 03 Jul 2012 07:39:49 -0400
Content-Disposition: inline
In-Reply-To: <4FF28F07.6000901@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Le 2012-07-03 00:23, Mathieu Desnoyers a =E9crit :
> > * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> >> By writing to the file /proc/lttng_uevent, a user-space application cr=
eates a
> >> kernel event. The event's payload is by default UTF-8 text, but any da=
ta can be
> >> written, up to 1024 bytes. Null-character is optional and is not enfor=
ced.
> > =

> > The 1024 byte limit is removed now, right ?
> =

> Exactly.

OK, please provide an updated version with the updated changelog.

> =

> >> + * Expose kernel tracer to user-space through /proc/lttng
> =

> I just saw a typo here, we should read "through /proc/lttng_uevent"

Same here.

> =

> >> + * Copyright (C) 2009-2012 Mathieu Desnoyers <mathieu.desnoyers@effic=
ios.com>
> > =

> > you might want to add your own copyright in here too.
> =

> I transfer you the copyright.

Thanks!

One more thing:

In the testing you did, did you try running, in parallel:

for a in $(seq 1 10000); do
        modprobe nameofuevent_module
        rmmod nameofevent_module
done

and in 4 another terminals:

echo "blahblahblah" > /proc/lttng_uevent

?

I understand that you tested only the write path in parallel, but I'm
not sure, from your changelog, that you stress-tested load/unload vs
write.

Thanks,

Mathieu

> =

> Thanks!
> =

> Francis
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
