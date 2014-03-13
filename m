From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Use autoconf AM_MAINTAINER_MODE.
Date: Thu, 13 Mar 2014 12:58:34 +0000 (UTC)
Message-ID: <737279405.2627.1394715514213.JavaMail.zimbra__26390.0942205966$1394715586$gmane$org@efficios.com>
References: <1394615117-2388-1-git-send-email-larper@axis.com>
	<507471820.1743.1394650777447.JavaMail.zimbra@efficios.com>
	<771471B8871B5044A6CA7CCD9C26EEE10117E2935AF1@xmail2.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WO5DW-000396-Md
	for lttng-dev@lists.lttng.org; Thu, 13 Mar 2014 08:58:43 -0400
In-Reply-To: <771471B8871B5044A6CA7CCD9C26EEE10117E2935AF1@xmail2.se.axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lars Persson <lars.persson@axis.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Lars Persson" <lars.persson@axis.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Thursday, March 13, 2014 4:12:23 AM
> Subject: RE: [lttng-dev] [PATCH babeltrace] Use autoconf AM_MAINTAINER_MODE.
> 
> It is useful when unpacking the distribution tarballs into another revision
> control system that doesn't preserve timestamps. If we retrigger autoconf,
> then some developer workstations will fail on the builds because they have
> outdated autoconf packages.

That makes sense. Thanks for explaining the rationale to me.

Mathieu

> 
> - Lars
> 
> > -----Original Message-----
> > From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> > Sent: den 12 mars 2014 20:00
> > To: Lars Persson
> > Cc: lttng-dev@lists.lttng.org; Lars Persson
> > Subject: Re: [lttng-dev] [PATCH babeltrace] Use autoconf
> > AM_MAINTAINER_MODE.
> > 
> > ----- Original Message -----
> > > From: "Lars Persson" <lars.persson@axis.com>
> > > To: lttng-dev@lists.lttng.org
> > > Cc: "Lars Persson" <larper@axis.com>
> > > Sent: Wednesday, March 12, 2014 5:05:17 AM
> > > Subject: [lttng-dev] [PATCH babeltrace] Use autoconf
> > AM_MAINTAINER_MODE.
> > >
> > > Give distribution maintainers the option to skip rebuilding autoconf
> > > and automake generated files. The default behaviour is still to have
> > > the rebuild rules enabled.
> > 
> > I just did some reading on this, and found:
> > 
> > http://blogs.gnome.org/desrt/2011/09/08/am_maintainer_mode-is-not-cool/
> > 
> > So, in what use-case is --disable-maintainer-mode useful nowadays ? All
> > it seems to do is to stop ensuring that Makefile are consistent with
> > changes to Makefile.am.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > >
> > > Signed-off-by: Lars Persson <larper@axis.com>
> > > ---
> > >  configure.ac |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/configure.ac b/configure.ac index 7a98612..faa3f98
> > 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -11,6 +11,7 @@ AC_CONFIG_AUX_DIR([config])  AC_CANONICAL_TARGET
> > > AC_CANONICAL_HOST  AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip])
> > > +AM_MAINTAINER_MODE([enable])
> > >  m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
> > >
> > >  AC_CONFIG_MACRO_DIR([m4])
> > > --
> > > 1.7.2.5
> > >
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
