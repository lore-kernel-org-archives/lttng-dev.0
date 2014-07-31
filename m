From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 0/3] rculfhash: error checking fixes
Date: Thu, 31 Jul 2014 22:05:54 +0000 (UTC)
Message-ID: <1996010706.24303.1406844354939.JavaMail.zimbra__34678.5469599583$1406844401$gmane$org@efficios.com>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
 <1681102864.24131.1406840905204.JavaMail.zimbra@efficios.com>
 <20140731213500.GA662@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XCyU0-0006nV-3z
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 18:05:57 -0400
In-Reply-To: <20140731213500.GA662@dcvr.yhbt.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eric Wong <normalperson@yhbt.net>
Cc: e@80x24.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Eric Wong" <normalperson@yhbt.net>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, e@80x24.org
> Sent: Thursday, July 31, 2014 5:35:00 PM
> Subject: Re: [lttng-dev] [PATCH 0/3] rculfhash: error checking fixes
> 
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > All merged, thanks! Sorry for the delay, the past month has been quite
> > busy.
> 
> No worries.  I've been sidetracked into other projects, too.
> 
> > Eric Wong <normalperson@yhbt.net> wrote:
> > > In the future, it would also be nice if the alloc_bucket_table behavior
> > > could fail gracefully on ENOMEM, but that would break ABI...
> > 
> > We could pull this into master for an eventual 0.9 release. We already
> > have a few ABI breaking changes that require us to bump the ABI in
> > master.
> 
> OK.  I'll try to work on that (unless you have more time now, I've
> been sidetracked too :x)

I do have to focus on other things at the moment, so you are welcome
to contribute those changes!

> 
> While we're on ABI/API changes, there's also several other changes
> I would like:
> 
> * Remove the pthread_mutex_t requirement in the wfcqueue and lfstack
>   structures.

Indeed, the mutex is not needed for all users. However, it allows us
to implement APIs that can be used by end users who want all
synchronization to be taken care of for them. In opposition, we
have the __ prefixed API which require to read and understand the
comments about synchronization requirements.

I wonder: what is the issue with having this mutex field in there ?
Is it space ? Having a dependency on pthread ? other ?

> 
>   I suppose we could implement limited new classes and layer the
>   complete old ones on top to preserve ABI/API compatibility.

If we decide to remove the pthread_mutex_t field, this would indeed
be the way to do it.

> 
> * cmpxchg_double (cmpxchg16b on x86-64) so lfstack can use
>   a lock-free stack for single pop operations.  I'm currently using
>   ck_stack from ConcurrencyKit, but generally prefer using the
>   URCU APIs and it would be great if lfstack could support this
>   on some arches.

Is there a way to implement a fallback for architectures that don't
have the double cmpxchg ? My intent is that if we start doing
optimizations for some architectures, the APIs can still be used
as is by applications ported to other architectures (modulo a
performance penality cost if unavoidable).

> 
> Do you have any timeline for a 0.9 release?
> 

I would have liked to bring a major new feature like my RCU judy
array in 0.9, but unfortunately I keep getting side tracked on
other things :-/ I still need to rework the API and add more
tests. So no ETA for now.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
