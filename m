From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Re: How to disable an event that's been enabled
	by	a	wildcard selection or -a?
Date: Fri, 16 Aug 2013 12:08:56 +0000
Message-ID: <009B25148989C6458484484699278506E5385F9C__15895.0366815136$1376654990$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <009B25148989C6458484484699278506985C0CFA@EU-MBX-01.mgc.mentorg.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB19F968AF@ZURMSG1.QUANTUM.com>
	<5121EA9A.8080905@mentor.com> <20130502134010.GF7035@Krystal>
	<51839435.8010607@mentor.com> <20130507141558.GD5118@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VAIq1-0006ND-Tr
	for lttng-dev@lists.lttng.org; Fri, 16 Aug 2013 08:09:10 -0400
In-Reply-To: <20130507141558.GD5118@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


A question on the suggested feature below:

If we do the following set of commands:

lttng enable-event "a*" -u
lttng enable-event "!ab" -u

The intention is to enable all events starting with the letter 'a' except t=
he event 'ab'.
However, if the event 'ab' is already registered in the session, the first =
command would enable the event 'ab'.

Should the second command now disable the event 'ab', or should the command=
 only apply to future registrations of events ?

Thanks,

JP Ikaheimonen
Mentor Graphics

-----Original Message-----
From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

Sent: 7. toukokuuta 2013 17:16
To: Woegerer, Paul
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] How to disable an event that's been enabled by a w=
ildcard selection or -a?

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> On 05/02/2013 03:40 PM, Mathieu Desnoyers wrote:
> > Hi Paul,
> > =

> > I would be interested to see this feature upstream. Previously was =

> > not a good timing to pull it in, because we were adding the concept =

> > of event "enablers" within lttng-ust.
> =

> Sounds great. I will port our patch to master.
> =

> > =

> > One thing I'm curious about is how you present the logical =

> > combination with exlusion match are present. For instance, if we =

> > only have inclusion, we get:
> > =

> > lttng enable-event 'a'
> > lttng enable-event 'c'
> > lttng enable-event 'zc*'
> > =

> > it turns into :   (a || c || zc*)
> > =

> > I expect that negation would look like:
> > =

> > lttng enable-event 'a'
> > lttng enable-event '!abc*'
> > lttng enable-event 'c'
> > lttng enable-event '!cxx'
> =

> Our current solution does not handle '!cxx' correctly.
> I will fix that.
> =

> > lttng enable-event 'zc*'
> > =

> > ->  !(abc* || cxx) || (a || c || zc*)
> =

> Exactly. The "!something" wildcards are always first and will prevent fur=
ther matching with non-! wildcards.
> =

> > =

> > Am I correct ? If yes, we should expand lttng-tools lttng(1) manpage =

> > and cmd help with this info.
> =

> I will take care of documentation updates as well.
> =

> > =

> > Can you make sure it works well with lttng-ust master branch ?
> =

> Once I have a working, tested patch against master I will send it to you.

One thing I just remembered: Please make sure that the order of evaluation =
of filter expressions stays the same, because we plan to add "actions" asso=
ciated with the filter expressions in the future.

Therefore, if we have:

lttng enable-event 'a' --filter 'fielname=3D=3D1'           (1)
lttng enable-event '!abc*' --filter 'somename>2'        (2)
lttng enable-event 'c' --filter 'othername=3D=3D3'          (3)
lttng enable-event '!cxx' --filter 'thisname=3D"abc"'     (4)

We want to interpret the filter expressions in this order:

(1), then (2), then (3), then (4) within lttng-ust.

We also have to assign a clear semantic to those exclusions when a filter i=
s applied. Same for loglevels.

This is one of the reasons why I waited to pull your modification: I was im=
plementing the filter, and "enablers", back then. So now there everything i=
s in place, it should become clearer what needs to be done.

Thanks,

Mathieu



> =

> Thanks,
> Paul
> =

> --
> Paul Woegerer | SW Development Engineer =

> http://go.mentor.com/sourceryanalyzer
> =

> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria =

> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
> =

> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
