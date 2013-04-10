From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix link: move -lrt at the
	end	of the link line
Date: Wed, 10 Apr 2013 12:01:01 -0400
Message-ID: <20130410160101.GA5945__3047.9782414206$1365609694$gmane$org@Krystal>
References: <1364755218-27374-1-git-send-email-simon.marchi@polymtl.ca>
	<20130410142223.GA5448@Krystal>
	<CAFXXi0=sstDTxVts6kuHjyzVC5FSP490zHC7vY=GvPQQsr0HPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UPxSJ-0005ey-3o
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 12:01:03 -0400
Content-Disposition: inline
In-Reply-To: <CAFXXi0=sstDTxVts6kuHjyzVC5FSP490zHC7vY=GvPQQsr0HPw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> The problem was mentionned on the mailing list a few days ago [1].
> 
> "Recent" Ubuntus pass --as-needed to the linker [2], which makes it
> sensitive to the ordering of libraries on the command line. Libraries
> that resolve undefined symbols of other libs or objects must be
> specified after those other libs or objects (much like the behavior of
> old linkers, if I understand correctly). timer_settime is used in one
> of the LTTng libs and is defined in librt, so librt must be put after
> it. Me trying to compile lttng-tools on Ubuntu without the patch [3].
> 
> [1] http://lists.lttng.org/pipermail/lttng-dev/2013-March/019929.html
> [2] https://wiki.ubuntu.com/NattyNarwhal/ToolchainTransition
> [3] http://pastebin.com/G2pSkseF

OK, this should be added to the patch changelog.

Thanks,

Mathieu

> 
> On 10 April 2013 10:22, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > * Simon Marchi (simon.marchi@polymtl.ca) wrote:
> >> It has to be after libconsumer.la.
> >>
> >
> > why, what issue does it fix ?
> >
> >> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> >> ---
> >>  src/bin/lttng-consumerd/Makefile.am |    5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/src/bin/lttng-consumerd/Makefile.am b/src/bin/lttng-consumerd/Makefile.am
> >> index a418eb4..d340c68 100644
> >> --- a/src/bin/lttng-consumerd/Makefile.am
> >> +++ b/src/bin/lttng-consumerd/Makefile.am
> >> @@ -4,10 +4,11 @@ lttnglibexec_PROGRAMS = lttng-consumerd
> >>
> >>  lttng_consumerd_SOURCES = lttng-consumerd.c lttng-consumerd.h
> >>
> >> -lttng_consumerd_LDADD = -lrt \
> >> +lttng_consumerd_LDADD = \
> >>          $(top_builddir)/src/common/libconsumer.la \
> >>          $(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
> >> -        $(top_builddir)/src/common/libcommon.la
> >> +        $(top_builddir)/src/common/libcommon.la \
> >> +        -lrt
> >>
> >>  if HAVE_LIBLTTNG_UST_CTL
> >>  lttng_consumerd_LDADD += -llttng-ust-ctl
> >> --
> >> 1.7.10.4
> >>
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
