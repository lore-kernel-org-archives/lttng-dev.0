From: Jon Bernard <jbernard@debian.org>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Sun, 20 Oct 2013 09:45:21 -0400
Message-ID: <20131020134521.GA97360__17034.7303887413$1382276773$gmane$org@helmut.local>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
	<856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
	<20131019211009.GA83292@helmut.local>
	<300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1VXtJv-0005o0-Vz
	for lttng-dev@lists.lttng.org; Sun, 20 Oct 2013 09:45:30 -0400
Content-Disposition: inline
In-Reply-To: <300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
> > From: "Jon Bernard" <jbernard@debian.org>
> > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > Cc: "St=E9phane Graber" <stgraber@ubuntu.com>, "Alexandre Montplaisir" =
<alexmonthy@voxpopuli.im>,
> > lttng-dev@lists.lttng.org
> > Sent: Saturday, October 19, 2013 5:10:09 PM
> > Subject: Re: LTTng packages in Debian sid out of sync
> > =

> > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > Hi Jon,
> > > =

> > > We've had a couple of user reports about lttng versions not working in
> > > Debian.
> > > =

> > > I'm looking at the current Debian sid, and here is the situation:
> > > =

> > > http://packages.debian.org/sid/lttng-tools : version 2.1.1-2
> > > http://packages.debian.org/sid/utils/ltt-bin : version 2.1.1-2
> > > http://packages.debian.org/sid/lttng-modules-dkms : version 2.3.0-1
> > > =

> > > Although it's possible that lttng-modules 2.3.x will work with lttng-=
tools
> > > 2.1.x, this combination of versions is unsupported. We require that
> > > ust/tools/modules be updated in locked step between minor versions (2=
.1
> > > with
> > > 2.1, 2.2 with 2.2, and so on). Also, 2.1 is starting to be quite old:=
 we're
> > > currently working on an upcoming 2.4, and the last version (2.3) prov=
ides
> > > lots
> > > of cool features including flight recorder tracing and snapshot suppo=
rt.
> > =

> > Yes, I do apologize for the current state.  My first priority was to re=
solve
> > the
> > blocked testing migration for ust and lttng-tools.  My upload yesterday=
 seems
> > to
> > have resolved the last of the ust package issues, and so now I need onl=
y to
> > upload the remaining fixes for lttng-tools and the two should be eligib=
le for
> > migration to testing.  I decided it would be easier to fix the migration
> > problem
> > first, and then update all of the versions to 2.3.x - it makes perfect =
sense
> > to
> > me as a packager, but I also see it's completely backwards from a user's
> > perspective.
> > =

> > Sid should have 2.3.x immediately and I will push these versions before=
 the
> > weekend ends.
> > =

> > The migration is also very important to me, as Jessie will freeze soon.=
  I
> > will
> > continue on that front after 2.3.x is in sid.
> > =

> > Does this sound like a reasonable plan?
> =

> Hi Jon,
> =

> We seem to have a problem here. The pace of packaging on Debian currently=
 does
> not seem to match our support cycle at all. You are currently targeting L=
TTng
> 2.1 for testing (and therefore next stable), while we specified a release
> policy back in August:
> http://lists.lttng.org/pipermail/lttng-dev/2013-August/021132.html which
> clearly states that we currently support LTTng 2.3, and only do security =
fix
> backports for 2.2. Therefore, 2.1 is clearly unsupported at this point.
> =

> I strongly advise to update packages in sid ASAP to LTTng 2.3, and we nee=
d to
> know how much time it takes to get it into testing, and figure out if it =
makes
> into the upcoming stable. I restate help offer on behalf of the LTTng
> community: if you lack time to update those packages, please let us know,=
 and
> we will give a hand ensuring that those are updated in sid soon after the
> upstream releases.
> =

> Thoughts ?

That is not exactly what I intended to convey, let me be more direct about =
my
view.  I completely agree that sid should have 2.3.x immediately.  I also a=
gree
that 2.3 should be targeted for testing, and therefore the next stable rele=
ase.

Last night I uploaded a lttng-modules update (2.3.2).  Just earlier I uploa=
ded
ust 2.3.0.  Once ust is accepted and available, I will upload lttng-tools 2=
.3.0
(since lttng-tools depends on ust to build successfully).  So I expect sid =
to
have a complete 2.3 suite very soon.  The only thing that will slow me down=
 are
the ftp masters - ust saw a soname bump which introduces a new package and
therefore requires human intervention - this can take up to a week for
processing.

If all goes well, these packages will move to testing after 10 days, and wi=
ll be
included in the next stable release.  There could be a problem with the tes=
ting
upgrade process, but that shouldn't be a difficult problem to solve.  I wil=
l try
to test the transition myself while I wait for the packages to land in sid.

In summary I think I'm very close to having everything in good order for bo=
th
sid and jessie.

Does this all make sense?

-- =

Jon
