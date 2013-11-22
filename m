From: Jon Bernard <jbernard@debian.org>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Fri, 22 Nov 2013 13:57:15 -0500
Message-ID: <20131122185715.GA27557__44208.0704648562$1385146701$gmane$org@shaniqua>
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
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1Vjvut-0006QF-3l
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 13:57:29 -0500
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

I think I've got the UST upgrade packages in good shape and I uploaded
a new lttng-tools to fix the armel build earlier today.  So, hopefully
by just waiting a bit things should be in good shape and migrate into
testing in early December (~10 days from now).  At the moment, 2.3.0 is
complete in unstable (sid).

-- =

Jon
