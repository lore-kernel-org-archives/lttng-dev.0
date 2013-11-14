From: Jon Bernard <jbernard@debian.org>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Thu, 14 Nov 2013 15:45:49 -0500
Message-ID: <20131114204549.GA26321__29527.363603893$1384462026$gmane$org@shaniqua>
References: <300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
	<20131020134521.GA97360@helmut.local>
	<1084047903.45979.1382281219903.JavaMail.zimbra@efficios.com>
	<20131020160434.GA2011@helmut.local>
	<20131103231921.GA6958@shaniqua>
	<376195559.63764.1384095140775.JavaMail.zimbra@efficios.com>
	<20131110152150.GA22826@shaniqua>
	<1699827701.63862.1384097350158.JavaMail.zimbra@efficios.com>
	<5282D901.2090509@gmail.com> <20131113170101.GA10480@shaniqua>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1Vh3nX-0006gA-Tt
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 15:46:02 -0500
Content-Disposition: inline
In-Reply-To: <20131113170101.GA10480@shaniqua>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jon Bernard <jbernard@debian.org> wrote:
> * Yannick Brosseau <yannick.brosseau@gmail.com> wrote:
> > On 11/10/13 10:29, Mathieu Desnoyers wrote:
> > > ----- Original Message -----
> > >> From: "Jon Bernard" <jbernard@debian.org>
> > >> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > >> Cc: "St=E9phane Graber" <stgraber@ubuntu.com>, "Alexandre Montplaisi=
r" <alexmonthy@voxpopuli.im>,
> > >> lttng-dev@lists.lttng.org
> > >> Sent: Sunday, November 10, 2013 10:21:50 AM
> > >> Subject: Re: [lttng-dev] LTTng packages in Debian sid out of sync
> > >>
> > >> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >>> Hi Jon,
> > >>>
> > >>> Thanks for the updates. Did you manage to get the upgrade path from
> > >>> older lttng versions to work, or do users still need to uninstall t=
he
> > >>> old package manually ?
> > >> I'm working on the upgrade packages now.
> > > Great!
> > >
> > >> I also just noticed a build
> > >> failure on armel[1] for lttng-tools.  It could be a debian-specific
> > >> problem in the compiler/toolchain, but I haven't had a chance to look
> > >> into it yet.  Let me know if you have any thoughts about this.
> > > We've already hit this one:
> > >
> > > https://bugs.lttng.org/issues/640
> > >
> > Yes, I've hit it in the fedora packages.
> > I've simply disabled the hardening Fedora option, so this temporary fix
> > might need another way to do it in debian:
> > (What it does is removing the -fPIE flag from the build option on arm)
> > =

> > http://pkgs.fedoraproject.org/cgit/lttng-tools.git/commit/?id=3Da9d92b4=
3548ec807b3b5485be092711c4c97f835
> =

> Yep, I'll have to do the same thing - should be easy enough.
> =

> I've finished the ust upgrade packages, I need only to test the possible
> scenarios to make sure all is well and I can upload.  And then I'll fix
> the arm issue.

I think I have fixed the upgrade path, packages have been uploaded and
fingers are crossed.  If this works then it leaves only the arm build
failure - which is cake.

-- =

Jon
