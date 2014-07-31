From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] rculfhash: error checking fixes
Date: Thu, 31 Jul 2014 22:25:45 +0000
Message-ID: <20140731222545.GA3947__19615.568748168$1406845588$gmane$org@dcvr.yhbt.net>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
 <1681102864.24131.1406840905204.JavaMail.zimbra@efficios.com>
 <20140731213500.GA662@dcvr.yhbt.net>
 <1996010706.24303.1406844354939.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net ([64.71.152.64] ident=normalperson)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <normalperson@yhbt.net>) id 1XCynC-0006vY-Dm
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 18:25:48 -0400
Content-Disposition: inline
In-Reply-To: <1996010706.24303.1406844354939.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: e@80x24.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> I do have to focus on other things at the moment, so you are welcome
> to contribute those changes!

OK, I'll try to get back to the rculfhash-using project in the next few
weeks (but no promises)

> > While we're on ABI/API changes, there's also several other changes
> > I would like:
> > 
> > * Remove the pthread_mutex_t requirement in the wfcqueue and lfstack
> >   structures.
> 
> Indeed, the mutex is not needed for all users. However, it allows us
> to implement APIs that can be used by end users who want all
> synchronization to be taken care of for them. In opposition, we
> have the __ prefixed API which require to read and understand the
> comments about synchronization requirements.
> 
> I wonder: what is the issue with having this mutex field in there ?
> Is it space ? Having a dependency on pthread ? other ?

Space.  On my current project, I can use a union and put other stuff
where the mutex is.

> >   I suppose we could implement limited new classes and layer the
> >   complete old ones on top to preserve ABI/API compatibility.
> 
> If we decide to remove the pthread_mutex_t field, this would indeed
> be the way to do it.

OK.  Then the hardest part is probably naming the new API :)

> > * cmpxchg_double (cmpxchg16b on x86-64) so lfstack can use
> >   a lock-free stack for single pop operations.  I'm currently using
> >   ck_stack from ConcurrencyKit, but generally prefer using the
> >   URCU APIs and it would be great if lfstack could support this
> >   on some arches.
> 
> Is there a way to implement a fallback for architectures that don't
> have the double cmpxchg ?

Unfortunately not.  I have completely separate code paths, also cannot
support early AMD64 machines which lack cmpxchg16b.

> My intent is that if we start doing
> optimizations for some architectures, the APIs can still be used
> as is by applications ported to other architectures (modulo a
> performance penality cost if unavoidable).

Understandable.  I wonder if regular cmpxchg with pointer-packing
for the generation counter works.  I'll have to try that.

> > Do you have any timeline for a 0.9 release?
> 
> I would have liked to bring a major new feature like my RCU judy
> array in 0.9, but unfortunately I keep getting side tracked on
> other things :-/ I still need to rework the API and add more
> tests. So no ETA for now.

OK, no worries.  I also noticed some rbtree work from the old days.
Is that still on the horizon?
