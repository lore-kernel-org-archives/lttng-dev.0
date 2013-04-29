From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: UST tracepoints, same provider, different files
Date: Mon, 29 Apr 2013 14:11:37 -0400
Message-ID: <20130429181137.GA3044__39534.0877272703$1367259140$gmane$org@Krystal>
References: <CAFXXi0=52W6vKHO6GA2dFPUPocVXPJD23HSG6K=riQTgWaDoTQ@mail.gmail.com>
	<20130429162537.GA17859@Krystal>
	<CAFXXi0=iUDV9NoRt++5qhbJ7ApCRSs3OAZahgB=0K4oPfMPhaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UWsY9-0005EO-CV
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 14:11:41 -0400
Content-Disposition: inline
In-Reply-To: <CAFXXi0=iUDV9NoRt++5qhbJ7ApCRSs3OAZahgB=0K4oPfMPhaA@mail.gmail.com>
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

yes, please open a bug on bugs.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Ok.
> 
> When trying to instrument a bigger application (memcached) with the
> same pattern, I witnessed a different behavior. No crash on assert,
> but only one tracepoint would get correctly registered at the
> application startup (as I mentionned on IRC this weekend). So the
> behavior when doing this seems undefined. Maybe this restriction
> should be documented ? It seemed natural to me at first to put each
> tracepoint in its own .tp file.
> 
> On 29 April 2013 12:25, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > You should not create two compilation units with the same provider name
> > in your application. This assertion is there to check just that.
> >
> > * Simon Marchi (simon.marchi@polymtl.ca) wrote:
> >> Hello !
> >>
> >> I am trying to add two tracepoints to a simple test application. If I
> >> put both tracepoints in different compilation units (two .c files),
> >> UST crashes when the application starts with the following message:
> >>
> >> test: /usr/local/include/lttng/ust-tracepoint-event.h:685:
> >> __lttng_events_init__my_project: Assertion `!ret' failed.
> >>
> >> I made an example [1] so you can simply run "make && ./test". I am
> >> using the latest git versions, on Ubuntu 13.04 x86_64.
> >>
> >> Thanks !
> >>
> >> Simon
> >>
> >> [1] http://git.dorsal.polymtl.ca/~smarchi?p=ust-test.git;a=summary
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
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
