From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Questions about LTTNG_UST_REGISTER_TIMEOUT
Date: Wed, 31 Jul 2013 14:41:44 -0400
Message-ID: <CA+jJMxubtNopJ0ftBhZZ2_3yPPGapqFFEDDRsUDHqL+fz+-ZpQ__39879.5139547021$1375296184$gmane$org@mail.gmail.com>
References: <CACsXv7Dfq5h+69JL2ZuiW2xto7Cfm9ABaUKF0eV-yT-8_ooDQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f177.google.com ([74.125.82.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V4bLK-0005cI-PI
	for lttng-dev@lists.lttng.org; Wed, 31 Jul 2013 14:41:56 -0400
Received: by mail-we0-f177.google.com with SMTP id m46so899256wev.8
	for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2013 11:41:44 -0700 (PDT)
In-Reply-To: <CACsXv7Dfq5h+69JL2ZuiW2xto7Cfm9ABaUKF0eV-yT-8_ooDQQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?Martin_=DCnsal?= <martinunsal@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Fri, Jul 26, 2013 at 3:29 PM, Martin =DCnsal <martinunsal@gmail.com> wro=
te:
> Hi all,
>
> I am a new lttng-ust user. I would like to leave tracepoints compiled into
> production code. I have verified that inactive tracepoints have extremely
> low overhead, but I am concerned about startup time and
> LTTNG_UST_REGISTER_TIMEOUT. Our typical use case is that we are not traci=
ng
> and there is no lttng-sessiond, we enable tracing only in development or =
QA.
>
> The specific questions:
>
> 1) What scenarios might the timeout come into play? I have tested with and
> without lttng-sessiond running and I have seen no more than 10ms overhead
> during app startup caused by lttng. That's no problem, but if there is so=
me
> unforeseen scenario where I introduce 3s overhead I am in a world of hurt!
>

This timeout is in place because the applications' registration to the
session daemon may take a long time if a lot of instrumented
applications are launched simultaneously. The only time I see the
launch time affected on the order of seconds, on my development
machine, is when performing stress tests; e.g. launching a couple of
thousands instrumented applications at once. Only you know if that's a
realistic load you may encounter.

> 2) If I set LTTNG_UST_REGISTER_TIMEOUT=3D0, what scenario would this fail=
 and
> how would it fail? (Silently or detectably?)
>

It will fail if the registration request cannot be served right-away.
The registration failing only means that the events won't be saved. It
should not impact your application in any other way.

I don't know how you could easily detect the registration's outcome
from your application, though... I can certainly see how that would be
useful.

The work-around I can propose is to use the lttng-ctl API to probe the
session daemon from your application. You could use the
lttng_list_sessions(), lttng_list_channels() and lttng_list_events()
functions to check all enabled events for your application's PID.

Have a look at the "lttng.h" header (lttng-tools) and let me know if
you need further clarifications.

> Actually I think these are more or less the same question viewed from two
> different angles.
>
> Thanks much. BTW I should say, I've been doing coordinated userspace and
> kernel tracing for performance issues in Linux for many, many years using=
 a
> variety of homegrown tools and LTTng is fantastic, just the right feature
> set and excellent performance. It's what I wish I'd built. :)

We're always looking for contributors! :-)

Regards,
J=E9r=E9mie

>
> Martin
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
