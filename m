From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: How to disable an event that's been enabled by
	a	wildcard selection or -a?
Date: Thu, 2 May 2013 09:40:10 -0400
Message-ID: <20130502134010.GF7035__42658.3514818505$1367502057$gmane$org@Krystal>
References: <009B25148989C6458484484699278506985C0CFA@EU-MBX-01.mgc.mentorg.com>
	<20998D40D9A2B7499CA5A3A2666CB1EB19F968AF@ZURMSG1.QUANTUM.com>
	<5121EA9A.8080905@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UXtk4-000363-Kl
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 09:40:12 -0400
Content-Disposition: inline
In-Reply-To: <5121EA9A.8080905@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> Hi David,
> =

> On 02/14/2013 05:52 AM, David OShea wrote:
> > Hi,
> > =

> > My understanding (hopefully someone will correct me if I'm wrong) is th=
at each time you invoke 'lttng enable-event', your specification for the ev=
ents you want enabled is stored and applied, and/or potentially applied lat=
er if a new application connects to the session daemon.  All 'lttng disable=
-event' does is remove one of the specifications you previously provided to=
 'lttng enable-event', so you can't say 'enable-event *' and then 'disable-=
event foo:*' to get all events except 'foo:*'.
> > =

> > If you could constrain the application to use a particular trace provid=
er name for all of its tracepoints, say "app", then you could just do 'lttn=
g enable-event app:*'.  If you can't do that, then I think you need to fall=
 back on getting a list of all the available tracepoints using 'lttng list =
-u', parsing this to find all of the available tracepoints, extracting the =
trace provider name from them, then using 'lttng enable-event <provider>:*'=
 for each provider other than the provider from your uninteresting library.=
  I think there are APIs that can be used instead of issuing the 'lttng' co=
mmands.
> > =

> > I would certainly also like a way to be able to, say, enable all events=
 other than foo:* and bar:* using one command.
> =

> I submitted a patch that does exactly this a while ago:
> http://lists.lttng.org/pipermail/lttng-dev/2012-June/018179.html
> =

> Although it's not upstream it works well for us.

Hi Paul,

I would be interested to see this feature upstream. Previously was not a
good timing to pull it in, because we were adding the concept of event
"enablers" within lttng-ust.

One thing I'm curious about is how you present the logical combination
with exlusion match are present. For instance, if we only have
inclusion, we get:

lttng enable-event 'a'
lttng enable-event 'c'
lttng enable-event 'zc*'

it turns into :   (a || c || zc*)

I expect that negation would look like:

lttng enable-event 'a'
lttng enable-event '!abc*'
lttng enable-event 'c'
lttng enable-event '!cxx'
lttng enable-event 'zc*'

->  !(abc* || cxx) || (a || c || zc*)

Am I correct ? If yes, we should expand lttng-tools lttng(1) manpage and
cmd help with this info.

Can you make sure it works well with lttng-ust master branch ?

Thanks,

Mathieu

> =

> Thanks,
> Paul
> =

> =

> > =

> > Regards,
> > David
> > =

> >> -----Original Message-----
> >> From: Ikaheimonen, JP [mailto:jp_ikaheimonen@mentor.com]
> >> Sent: Friday, 8 February 2013 7:56 PM
> >> To: lttng-dev@lists.lttng.org
> >> Subject: [lttng-dev] How to disable an event that's been enabled by a
> >> wildcard selection or -a?
> >>
> >> Consider the following scenario.
> >> I want to write a script that traces all UST tracepoints of a given
> >> application. I have no idea what the names of these tracepoints are.
> >> Also, I know that the application uses a library that contains some
> >> tracepoints I am not interested about. Now I want to trace all UST
> >> tracepoints except the ones I already know about. Is this possible with
> >> the lttng commands?
> >>
> >> If I enable all tracepoints with "lttng enable-event -u -a" I get all
> >> events, even those I do not want. I've tried using "lttng disable-
> >> event", and "lttng enable-event" with a filter, but I cannot seem to be
> >> able to get rid of the specific events.
> >>
> >> Thank you,
> >>
> >> JP Ikaheimonen
> >> Mentor Graphics Embedded Systems Division
> >> Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS
> >>
> >> Android is a trademark of Google Inc. Use of this trademark is subject
> >> to Google Permissions.
> >> Linux is the registered trademark of Linus Torvalds in the U.S. and
> >> other countries.
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > =

> > ----------------------------------------------------------------------
> > The information contained in this transmission may be confidential. Any=
 disclosure, copying, or further distribution of confidential information i=
s not permitted unless such privilege is explicitly granted in writing by Q=
uantum. Quantum reserves the right to have electronic communications, inclu=
ding email and attachments, sent across its networks filtered through anti =
virus and spam software programs and retain such messages in order to compl=
y with applicable data security and retention requirements. Quantum is not =
responsible for the proper and complete transmission of the substance of th=
is communication or for any delay in its receipt.
> > =

> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > =

> =

> =

> -- =

> Paul Woegerer | SW Development Engineer
> http://go.mentor.com/sourceryanalyzer
> =

> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
> =

> Android is a trademark of Google Inc. Use of this trademark is subject
> to Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and
> other countries.
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
