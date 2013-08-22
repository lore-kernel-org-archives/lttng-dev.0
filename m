From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] Add the CFLAGS for an "out of
	system"	building of the gen-tp example files.
Date: Thu, 22 Aug 2013 09:41:02 -0400
Message-ID: <20130822134102.GA27342__7506.82833972878$1377178912$gmane$org@Krystal>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<1377160051-12449-3-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125756.GD26852@Krystal>
	<CAD7SSK7=ZLdN_MuwO-mpJctN9kzzArg6056T2RUDE4_ZHFmy1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VCV8K-0001s6-Qc
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 09:41:05 -0400
Content-Disposition: inline
In-Reply-To: <CAD7SSK7=ZLdN_MuwO-mpJctN9kzzArg6056T2RUDE4_ZHFmy1A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Cc: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> 2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> > * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > >  %.o: %.tp %.c %.h
> > > -     $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
> > > +     CFLAGS="$(AM_CPPFLAGS)" $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
> >
> > The intent behind the examples is that they are installed in
> > /usr/share/doc, and should be built both from within the source tree and
> > when installed in the system. This dependency on AM_CPPFLAGS does not
> > meet this requirement.
> >
> Actually, the problem was if you add custom CFLAGS (a custom userspace-rcu
> location for example), they will not be set here, and thus, the build fails.

I understand that we might need to fix something, but I think this is
not done at the right level in your patches.

We could keep the CFLAGS/LDFLAGS/CPPFLAGS use as we have currently in
the tree, but also modify doc/examples/Makefile.am so it passes extra
flags (the AM_CFLAGS/AM_LDFLAGS/AM_CPPFLAGS) to the subdirectories when
invoking their respective makefile.

Therefore, it would not add automake-specific stuff into a Makefile that
is meant to be installed in /usr/share/doc.

Thanks,

Mathieu

> 
> Also, you are mixing CPPFLAGS and CFLAGS here.
> >
> Yes, indeed, it is messy, I will correct this, and send new patches if you
> allow
> me to.
> 
> 
> Thanks,
> >
> Thank you.
> -- 
> Jimmy Durand Wesolowski
> OpenWide R&D engineer
> OneAccess

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
