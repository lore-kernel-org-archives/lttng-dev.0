From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] rculfhash: error checking fixes
Date: Fri, 1 Aug 2014 01:44:17 +0000
Message-ID: <20140801014417.GA29924__10313.912938773$1406857517$gmane$org@dcvr.yhbt.net>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
 <1681102864.24131.1406840905204.JavaMail.zimbra@efficios.com>
 <20140731213500.GA662@dcvr.yhbt.net>
 <1996010706.24303.1406844354939.JavaMail.zimbra@efficios.com>
 <20140731222545.GA3947@dcvr.yhbt.net>
 <252105882.24338.1406851935525.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net ([64.71.152.64] ident=normalperson)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <normalperson@yhbt.net>) id 1XD1tJ-00085Z-Pt
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 21:44:18 -0400
Content-Disposition: inline
In-Reply-To: <252105882.24338.1406851935525.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: e@80x24.org, lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> I'm trying something with transparent union. See patch in separate
> email.

Thanks!  I didn't know about the transparent union feature in GCC,
looks much nicer than what I would've done :)

> > > > * cmpxchg_double (cmpxchg16b on x86-64) so lfstack can use
> > > >   a lock-free stack for single pop operations.  I'm currently using
> > > >   ck_stack from ConcurrencyKit, but generally prefer using the
> > > >   URCU APIs and it would be great if lfstack could support this
> > > >   on some arches.
> > > 
> > > Is there a way to implement a fallback for architectures that don't
> > > have the double cmpxchg ?
> > 
> > Unfortunately not.  I have completely separate code paths, also cannot
> > support early AMD64 machines which lack cmpxchg16b.
> 
> This means we would have to dynamically detect if the CPU supports
> the instruction, and fallback to a different way of doing things.
> So we would have to plan space (e.g. a union) for both the cmpxchg16b
> and the fallback, with possibly a compiler flag that would allow
> compiling out the fallback if the user really care about compactness,
> and not about portability.

Yeah, it's a bit of a pain :/

> > > My intent is that if we start doing
> > > optimizations for some architectures, the APIs can still be used
> > > as is by applications ported to other architectures (modulo a
> > > performance penality cost if unavoidable).
> > 
> > Understandable.  I wonder if regular cmpxchg with pointer-packing
> > for the generation counter works.  I'll have to try that.
> 
> Not sure I understand your idea here.

The lock-free pop in ck_stack relies on an extra generation counter
field to avoid ABA problem.  I could pack that counter into the normal
head pointer of the stack since current x86-64 only uses 48-bit address
space; so I could have 20 bits for the counter (including bits for
alignment).  I doubt it could be trusted on systems with many
cores/threads, though.

On the other hand, my choice of a lock-free stack already wastes cycles
spinning when the stack is empty; so I might choose something else
entirely.

Thanks for your responses!
