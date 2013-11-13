From: Jon Bernard <jbernard@debian.org>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Wed, 13 Nov 2013 16:02:23 -0500
Message-ID: <20131113210223.GA6682__33278.3387195834$1384376611$gmane$org@shaniqua>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
	<856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
	<20131019211009.GA83292@helmut.local>
	<300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
	<20131020134521.GA97360@helmut.local>
	<1084047903.45979.1382281219903.JavaMail.zimbra@efficios.com>
	<20131020160434.GA2011@helmut.local>
	<20131103231921.GA6958@shaniqua> <20131112153903.GC7321@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1Vgha2-0004WR-Sy
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 16:02:36 -0500
Content-Disposition: inline
In-Reply-To: <20131112153903.GC7321@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org, =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>
List-Id: lttng-dev@lists.lttng.org

* David Goulet <dgoulet@efficios.com> wrote:
> On 03 Nov (18:19:21), Jon Bernard wrote:
> > * Jon Bernard <jbernard@debian.org> wrote:
> > > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > > ----- Original Message -----
> > > > > From: "Jon Bernard" <jbernard@debian.org>
> > > > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > > > Cc: "St=E9phane Graber" <stgraber@ubuntu.com>, "Alexandre Montpla=
isir" <alexmonthy@voxpopuli.im>,
> > > > > lttng-dev@lists.lttng.org
> > > > > Sent: Sunday, October 20, 2013 9:45:21 AM
> > > > > Subject: Re: LTTng packages in Debian sid out of sync
> > > > > =

> > > > [...]
> > > > > =

> > > > > That is not exactly what I intended to convey, let me be more dir=
ect about my
> > > > > view.  I completely agree that sid should have 2.3.x immediately.=
  I also
> > > > > agree
> > > > > that 2.3 should be targeted for testing, and therefore the next s=
table
> > > > > release.
> > > > =

> > > > Allright :) I'm glad we're on the same page, sorry for the misunder=
standing.
> > > =

> > > No worries.  I'll add that future releases (like the upcoming 2.4) wi=
ll
> > > be prepared and tested all together prior to upload - to hopefully av=
oid
> > > the previous situation/nightmare that I managed to get myself into.
> > > =

> > > There can still be a sizable amount of work for 2.3 to fully land into
> > > testing, so that is my primary focus.  The freeze deadline is fast
> > > approaching, so I will be keeping a close eye on things as they
> > > progress.  As things settle I'll post status here.
> > =

> > lttng-tools 2.3.0 was just accepted, so on sid (unstable) we should now=
 be at
> > version 2.3.0 across the board.  Things look pretty good to me, but if =
anyone
> > has time to test the packages and let me know if something's missing, s=
tructured
> > incorrectly, or not behaving as expected - that would be awesome.
> =

> Why is lttng-tools depending on "lttng-modules-dkms"? It should not, it
> should only be a suggested package.
> =

> http://packages.debian.org/sid/lttng-tools

If you scroll down a bit, you'll see that it is a suggestion for all of
the current architectures.  I fixed this in the last upload, but the
packages view is misleading.  The powerpcspe should be removed, and
armel is failing - so the latest version is not being considered.

Once things settle, that view will look as it should.

-- =

Jon
