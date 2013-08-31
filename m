From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] adding into middle of RCU list
Date: Sat, 31 Aug 2013 14:32:28 -0700
Message-ID: <20130831213228.GF3871@linux.vnet.ibm.com>
References: <20130822213318.49a57fa2@nehalam.linuxnetplumber.net>
 <20130823164637.GB3871@linux.vnet.ibm.com>
 <20130823171653.GA16558@Krystal>
 <20130823210822.GD3871@linux.vnet.ibm.com>
 <20130830005733.GA20664@linux.vnet.ibm.com>
 <20130830021637.GA21862@leaf>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130830021637.GA21862@leaf>
Sender: linux-sparse-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Stephen Hemminger <stephen@networkplumber.org>, lttng-dev@lists.lttng.org, sparse@chrisli.org, linux-sparse@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Aug 29, 2013 at 07:16:37PM -0700, Josh Triplett wrote:
> On Thu, Aug 29, 2013 at 05:57:33PM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 23, 2013 at 02:08:22PM -0700, Paul E. McKenney wrote:
> > > On Fri, Aug 23, 2013 at 01:16:53PM -0400, Mathieu Desnoyers wrote:
> > > > #define __rcu_assign_pointer(p, v, space) \
> > > >         do { \
> > > >                 smp_wmb(); \
> > > >                 (p) = (typeof(*v) __force space *)(v); \
> > > >         } while (0)
> > > 
> > > Or I need to fix this one as well.  ;-)
> > 
> > In that vein...  Is there anything like typeof() that also preserves
> > sparse's notion of address space?  Wrapping an ACCESS_ONCE() around
> > "p" in the assignment above results in sparse errors.
> 
> typeof() will preserve sparse's notion of address space as long as you
> do typeof(p), not typeof(*p):
> 
> $ cat test.c
> #define as(n) __attribute__((address_space(n),noderef))
> #define __force __attribute__((force))
> 
> int main(void)
> {
>     int target = 0;
>     int as(1) *foo = (__force typeof(target) as(1) *) &target;
>     typeof(foo) bar = foo;
>     return *bar;
> }
> $ sparse test.c
> test.c:9:13: warning: dereference of noderef expression
> 
> Notice that sparse didn't warn on the assignment of foo to bar (because
> typeof propagated the address space of 1), and warned on the dereference
> of bar (because typeof propagated noderef).

Thank you for the info!

Suppose that I want to do something like this:

#define __rcu_assign_pointer(p, v, space) \
        do { \
                smp_wmb(); \
                ACCESS_ONCE(p) = (typeof(*v) __force space *)(v); \
        } while (0)

Now, this does typeof(*p), so as you noted above sparse complains about
address-space mismatches.  Thus far, I haven't been able to come up with
something that (1) does sparse address-space checking, (2) does C type
checking, and (3) forces the assignment to be volatile.

Any thoughts on how to do this?

							Thanx, Paul

