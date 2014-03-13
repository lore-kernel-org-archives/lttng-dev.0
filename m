From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Use autoconf AM_MAINTAINER_MODE.
Date: Thu, 13 Mar 2014 12:59:04 +0000 (UTC)
Message-ID: <794010096.2628.1394715544685.JavaMail.zimbra__12151.910752482$1394715652$gmane$org@efficios.com>
References: <1394615117-2388-1-git-send-email-larper@axis.com>
	<507471820.1743.1394650777447.JavaMail.zimbra@efficios.com>
	<771471B8871B5044A6CA7CCD9C26EEE10117E2935AF1@xmail2.se.axis.com>
	<53218095.4000105@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WO5E0-00039T-Jp
	for lttng-dev@lists.lttng.org; Thu, 13 Mar 2014 08:59:08 -0400
In-Reply-To: <53218095.4000105@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> To: "Lars Persson" <lars.persson@axis.com>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Thursday, March 13, 2014 5:55:33 AM
> Subject: Re: [lttng-dev] [PATCH babeltrace] Use autoconf AM_MAINTAINER_MODE.
> 
> On 03/13/2014 09:12 AM, Lars Persson wrote:
> > It is useful when unpacking the distribution tarballs into another revision
> > control system that doesn't preserve timestamps. If we retrigger autoconf,
> > then some developer workstations will fail on the builds because they have
> > outdated autoconf packages.
> 
> Without using AM_MAINTAINER_MODE we let users pay for something (having
> recent autotools installed on their machines) that they will not need in
> most cases. Using AM_MAINTAINER_MODE allows you to suppress the
> dependency to autotools if you are sure you do not really need it (e.g.
> you are not changing any Makefile.am or configure.ac).
> 
> If you ever tried to install a new version of LTTng on an ancient Linux
> installation running on a VM in another timezone you will be very happy
> if you do not need to also install new autotools packages prior to
> building and installing the lttng packages.

OK. That sheds some more light on the use case. Will merge those
patches then.

Thanks!

Mathieu

> 
> 
> --
> Thanks,
> Paul
> 
> 
> > 
> > - Lars
> > 
> >> -----Original Message-----
> >> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> >> Sent: den 12 mars 2014 20:00
> >> To: Lars Persson
> >> Cc: lttng-dev@lists.lttng.org; Lars Persson
> >> Subject: Re: [lttng-dev] [PATCH babeltrace] Use autoconf
> >> AM_MAINTAINER_MODE.
> >>
> >> ----- Original Message -----
> >>> From: "Lars Persson" <lars.persson@axis.com>
> >>> To: lttng-dev@lists.lttng.org
> >>> Cc: "Lars Persson" <larper@axis.com>
> >>> Sent: Wednesday, March 12, 2014 5:05:17 AM
> >>> Subject: [lttng-dev] [PATCH babeltrace] Use autoconf
> >> AM_MAINTAINER_MODE.
> >>>
> >>> Give distribution maintainers the option to skip rebuilding autoconf
> >>> and automake generated files. The default behaviour is still to have
> >>> the rebuild rules enabled.
> >>
> >> I just did some reading on this, and found:
> >>
> >> http://blogs.gnome.org/desrt/2011/09/08/am_maintainer_mode-is-not-cool/
> >>
> >> So, in what use-case is --disable-maintainer-mode useful nowadays ? All
> >> it seems to do is to stop ensuring that Makefile are consistent with
> >> changes to Makefile.am.
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >>>
> >>> Signed-off-by: Lars Persson <larper@axis.com>
> >>> ---
> >>>  configure.ac |    1 +
> >>>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/configure.ac b/configure.ac index 7a98612..faa3f98
> >> 100644
> >>> --- a/configure.ac
> >>> +++ b/configure.ac
> >>> @@ -11,6 +11,7 @@ AC_CONFIG_AUX_DIR([config])  AC_CANONICAL_TARGET
> >>> AC_CANONICAL_HOST  AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip])
> >>> +AM_MAINTAINER_MODE([enable])
> >>>  m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
> >>>
> >>>  AC_CONFIG_MACRO_DIR([m4])
> >>> --
> >>> 1.7.2.5
> >>>
> >>>
> >>> _______________________________________________
> >>> lttng-dev mailing list
> >>> lttng-dev@lists.lttng.org
> >>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>>
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> http://www.efficios.com
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 
> 
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
