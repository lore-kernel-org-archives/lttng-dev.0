From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Emitting events from shared object constructors
	is	(currently) not possible
Date: Thu, 22 Nov 2012 11:45:12 -0500
Message-ID: <20121122164512.GA16119__35060.5242340409$1353602803$gmane$org@Krystal>
References: <50AE31E8.4040507@mentor.com> <20121122153901.GA14685@Krystal>
	<50AE4CEF.9050809@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TbZtt-0005ux-Se
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 11:45:17 -0500
Content-Disposition: inline
In-Reply-To: <50AE4CEF.9050809@mentor.com>
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
> On 11/22/2012 04:39 PM, Mathieu Desnoyers wrote:
> > * Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> >> I recently stumbled over the following lttng-ust limitation:
> >>
> >> I tried to emit events from a shared objects constructor function:
> >>
> >> __attribute__((constructor))
> >> void func_constructor()
> >> {
> >>    tracepoint( foo, bar ); =

> >> }
> >>
> >> Unfortunately this doesn't work because the constructor functions of
> >> LTTng itself (__tracepoints__init and the ones from
> >> ust-tracepoint-event.h) are not yet run.
> >>
> >> Trying to solve this problem with explicit constructor priority on my
> >> side alone doesn't work:
> >>
> >> __attribute__((constructor (1111)))
> >> void func_constructor()
> >> {
> >>    tracepoint( foo, bar ); =

> >> }
> >>
> >> That's because whatever I specify as priority is irrelevant. LTTng's
> >> constructors without priority will always come last.
> >>
> >> After also adding priority to the lttng constructor I was able to make
> >> it work (see patch below):
> > =

> > Hi Paul,
> > =

> > I notice that you probably embed your probes along with your code within
> > the same shared object/executable, right ?
> > =

> > Unfortunately, this approach does not work if the probes are placed in a
> > different shared object than the program code. Here is an example:
> =

> Hi Mathieu,
> =

> In case the probes would be defined in different shared object from the
> one where they are used we wouldn't have a problem at all because the
> dynamic linker would invoke all the constructor functions for the probe
> shared object before the constructor functions of the shared object that
> has a dependency to the probe shared object, right ?

The instrumented code does not have dependency on the probe shared
object, so we can ship applications separately from their probe .so. So
unfortunately, the linker is not doing this for us.

> =

> And even if this is not the case I could explicitly dlopen the probe
> shared object from within my constructor function and thus make sure
> that the constructor function of the probe shared object gets called
> before I emit an event from my constructor function.

The idea would be to provide a nice API to facilitate this use-case, and
document it in the instrumentation guide-lines (lttng-ust(3)).

Thanks,

Mathieu

> =

> --
> Paul
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

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
