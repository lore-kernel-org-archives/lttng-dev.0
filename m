From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building	patches.
Date: Sat, 24 Aug 2013 13:59:09 -0400
Message-ID: <20130824175909.GA12409__23437.7546272755$1377367198$gmane$org@Krystal>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VDI7E-0006O7-Q4
	for lttng-dev@lists.lttng.org; Sat, 24 Aug 2013 13:59:15 -0400
Content-Disposition: inline
In-Reply-To: <CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand <jimmy.durand.wesolowski@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jimmy Durand (jimmy.durand.wesolowski@gmail.com) wrote:
> 2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> > * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > > Hi,
> > >
> > >
> > > Here are some patches to allow installing LTTng-ust out of the system
> > > directories, ie building with "./configure --prefix", without having to
> > set
> > > C/CPP/LDFLAGS at both the configure and the make building steps.
> >
> > Usually, setting CPPFLAGS/CFLAGS/LDFLAGS at configure time is enough,
> > e.g.:
> >
> > LDFLAGS=/usr/local/lib ./configure
> >
> > What feature is this patchset adding that is not covered by the usual
> > approach ? Or what is it fixing ?
> >
> Actually, this is enough for a regular system build, but if you wish to
> build
> it in another directory with --prefix=<PATH>, which is the case for cross-
> compiling, this not enough.

It might be a failure of my imagination but.. why is
CPPFLAGS/CFLAGS/LDFLAGS not enough to get UST to fetch the dependencies
it needs (e.g. userspace RCU) when they have been installed in
non-standard paths (because e.g. userspace RCU has been configured with
a --prefix path for sake of cross-compiling).

Can you give a more detailed use-case that CPPFLAGS/CFLAGS/LDFLAGS fail
to cover ?

Thanks,

Mathieu

> 
> 
> Thanks,
> 
> Thank you,
> -- 
> Jimmy Durand Wesolowski
> Linux System Engineer & amateur photographer
> OpenWide

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
