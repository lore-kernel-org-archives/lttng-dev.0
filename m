From: Jon Bernard <jbernard@debian.org>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Tue, 29 Oct 2013 10:13:33 -0400
Message-ID: <20131029141238.GA9169__24767.7445448518$1383056080$gmane$org@shaniqua>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
	<856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
	<20131019211009.GA83292@helmut.local>
	<300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
	<20131020134521.GA97360@helmut.local>
	<1084047903.45979.1382281219903.JavaMail.zimbra@efficios.com>
	<20131020160434.GA2011@helmut.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1VbA3B-0004E6-A9
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 10:13:47 -0400
Content-Disposition: inline
In-Reply-To: <20131020160434.GA2011@helmut.local>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>, Alexandre Montplaisir <alexmonthy@voxpopuli.im>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jon Bernard <jbernard@debian.org> wrote:
> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > ----- Original Message -----
> > > From: "Jon Bernard" <jbernard@debian.org>
> > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > Cc: "St=E9phane Graber" <stgraber@ubuntu.com>, "Alexandre Montplaisir=
" <alexmonthy@voxpopuli.im>,
> > > lttng-dev@lists.lttng.org
> > > Sent: Sunday, October 20, 2013 9:45:21 AM
> > > Subject: Re: LTTng packages in Debian sid out of sync
> > > =

> > [...]
> > > =

> > > That is not exactly what I intended to convey, let me be more direct =
about my
> > > view.  I completely agree that sid should have 2.3.x immediately.  I =
also
> > > agree
> > > that 2.3 should be targeted for testing, and therefore the next stable
> > > release.
> > =

> > Allright :) I'm glad we're on the same page, sorry for the misunderstan=
ding.
> =

> No worries.  I'll add that future releases (like the upcoming 2.4) will
> be prepared and tested all together prior to upload - to hopefully avoid
> the previous situation/nightmare that I managed to get myself into.
> =

> There can still be a sizable amount of work for 2.3 to fully land into
> testing, so that is my primary focus.  The freeze deadline is fast
> approaching, so I will be keeping a close eye on things as they
> progress.  As things settle I'll post status here.

UST 2.3.0 was accepted into unstable (debian) this morning.  There are
a few points to be aware of:

  * I will now prepare an lttng-tools upload (2.3.0) so there will be
    a complete 2.3.0 stack in unstable hopefully very soon.

  * I have broken the upgrade path, which I started looking at last
    week.  It will be necessary for existing unstable users to first
    uninstall ust before upgrading.  The reason for this is the soname
    bump on liblttng-ust-ctl while the other libs remain unchanged
    - this will cause file collisions until I craft a smooth upgrade
    process.  This will likely mean breaking the ust libraries into
    separate packages (I see no better way, but if there are suggestions
    then please let me know).

    I realize this kinda sucks and I'll get it sorted as soon as I can.

  * I will block any possible testing migrations of the 2.3.0 packages
    until the upgrade path is sorted out.  Containing this problem in
    unstable and fixing there will cause the least amount of pain for
    all involved, that I can see.

Cheers,

-- =

Jon
