From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space	(version
	6)
Date: Thu, 2 May 2013 16:21:41 -0400
Message-ID: <20130502202141.GC15675__48234.3348594897$1367526132$gmane$org@Krystal>
References: <1341266778-13735-1-git-send-email-francis.giraldeau@gmail.com>
	<20120702222340.GA1702@Krystal> <4FF28F07.6000901@gmail.com>
	<20120703113947.GA24563@Krystal> <4FF2F4DF.9030904@gmail.com>
	<20120703134031.GB32190@Krystal> <4FF3006C.5000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY00c-0006KV-N7
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:21:42 -0400
Content-Disposition: inline
In-Reply-To: <4FF3006C.5000308@gmail.com>
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

Just a bit of follow-up: has this been merged ? If not, is there a
latest version available somewhere ?

Thanks,

Mathieu

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Le 2012-07-03 15:40, Mathieu Desnoyers a =E9crit :
> >> It's not possible to remove the module while an active tracing session
> >> references the event lttng_uevent. I tested insertion/removal of the
> >> module while tracing with the previous version that was using RCU and =
it
> >> was working well.
> > =

> > But you don't need to have an active tracing session to perform the test
> > I point to above. Could you run it on this latest version ?
> =

> Ok. I updated the test to run in a loop rmmod/modprobe, while writing
> with 20 threads into /proc/lttng_uevent. The result is that the module
> can be unloaded properly, the test shows no race that prevent the module
> to be unloaded or other problems.
> =

> If somebody wants to test it for themselves, I added the code for this
> test under workload-kit/tests.
> =

>   * test-uevent : runs 4 times 20 threads each producing 64k events
>   * module-reload-forever.sh : rmmod/modprobe of lttng_uevent
>   * test-uevent.sh : quick wrapper for testing functionnality
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
EfficiOS Inc.
http://www.efficios.com
