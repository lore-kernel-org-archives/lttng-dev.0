From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix linker library order
Date: Tue, 14 May 2013 17:51:53 -0400
Message-ID: <20130514215153.GB9634__27644.7636228569$1368568347$gmane$org@Krystal>
References: <1368318333-31522-1-git-send-email-francis.giraldeau@gmail.com>
	<20130512025917.GB405@Krystal> <519161C8.5000305@voxpopuli.im>
	<20130514065244.GA5066@Krystal> <20130514123724.GA24238@Krystal>
	<CAFXXi0nvJhHiiMK_FE=_OMkT4yK+0_WLv8h=Nanvh3g0E1re3g@mail.gmail.com>
	<5192A3B5.6080302@voxpopuli.im> <20130514214608.GA9634@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UcN8V-0005t4-8i
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 17:51:55 -0400
Content-Disposition: inline
In-Reply-To: <20130514214608.GA9634@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> > On 13-05-14 01:38 PM, Simon Marchi wrote:
> > > [...]
> > >
> > > If you read carefully the log sent by Alexandre, you see that it is
> > > when building the shared libs in this directory
> > > (lttng-ust-provider-ust-tests-demo.so) that the build fails. I don't
> > > know why it fails, but Alexandre hinted that passing "-fPIE -pie" to
> > > build a shared library is weird (it is usually -fPIC -pic). I am not
> > > sure where that comes from. This behaviour only happens when building
> > > the package, not when building manually.
> > 
> > We build the daily packages with all Debian security options (this is
> > kind of a future-proofing to find problems like this one, I don't think
> > the "real" Debian packages use it).
> > 
> > See
> > http://wiki.debian.org/Hardening#DEB_BUILD_HARDENING_PIE_.28gcc.2Fg.2B-.2B-_-fPIE_-pie.29
> > 
> > So far it handled the autotools-powered Makefiles correctly (libraries
> > are built with -fPIC, binaries with -fPIE), but it seems to cause
> > problems with hand-written Makefiles like the one in doc/examples/demo.
> > 
> > We could fix it with a package-specific patch, either by using autotools
> > to build this directory, or maybe not building it at all, since it's
> > just an example that we don't install...
> 
> has this been fixed by the recent revert ?

ok, I read the rest of my mailbox. Let's discuss this tomorrow when my
head is straightened up.

Thanks,

Mathieu

> 
> > 
> > 
> > Thanks all,
> > Alex
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
