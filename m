From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Xeon Phi memory barriers
Date: Fri, 6 Dec 2013 13:40:45 -0800
Message-ID: <20131206214045.GC24148__11555.2811687396$1386366127$gmane$org@linux.vnet.ibm.com>
References: <CAFXXi0n784=HA5RKX91OM8=CTpgofd1dkqnC_b4avo0aAYBnOQ@mail.gmail.com>
	<1816982181.80892.1386360938886.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1Vp396-0006C5-MR
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 16:41:17 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 6 Dec 2013 14:41:07 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
	(b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9B94C3E40040
	for <lttng-dev@lists.lttng.org>; Fri,  6 Dec 2013 14:41:05 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rB6JdDpe7864662
	for <lttng-dev@lists.lttng.org>; Fri, 6 Dec 2013 20:39:13 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id rB6Li55T012648
	for <lttng-dev@lists.lttng.org>; Fri, 6 Dec 2013 14:44:05 -0700
Content-Disposition: inline
In-Reply-To: <1816982181.80892.1386360938886.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Fri, Dec 06, 2013 at 08:15:38PM +0000, Mathieu Desnoyers wrote:
> ----- Original Message -----
> > From: "Simon Marchi" <simon.marchi@polymtl.ca>
> > To: lttng-dev@lists.lttng.org
> > Sent: Tuesday, November 19, 2013 4:26:06 PM
> > Subject: [lttng-dev] Xeon Phi memory barriers
> > =

> > Hello there,
> =

> Hi Simon,
> =

> While reading this reply, please keep in mind that I'm in a
> mindset where I've been in a full week of meeting, and it's late on
> Friday evening here. So YMMV ;-) I'm CCing Paul E. McKenney, so he can
> debunk my answer :)
> =

> > =

> > liburcu does not build on the Intel Xeon Phi, because the chip is
> > recognized as x86_64, but lacks the {s,l,m}fence instructions found on
> > usual x86_64 processors. The following is taken from the Xeon Phi dev
> > guide:
> =

> Let's have a look:
> =

> > =

> > The Intel=AE Xeon PhiTM coprocessor memory model is the same as that of
> > the Intel=AE Pentium processor. The reads and writes always appear in
> > programmed order at the system bus (or the ring interconnect in the
> > case of the Intel=AE Xeon PhiTM coprocessor); the exception being that
> > read misses are permitted to go ahead of buffered writes on the system
> > bus when all the buffered writes are cached hits and are, therefore,
> > not directed to the same address being accessed by the read miss.
> =

> OK, so reads can be reordered with respect to following writes.

That would be -preceding- writes, correct?

> > As a consequence of its stricter memory ordering model, the Intel=AE
> > Xeon PhiTM coprocessor does not support the SFENCE, LFENCE, and MFENCE
> > instructions that provide a more efficient way of controlling memory
> > ordering on other Intel processors.
> =

> I guess sfence and lfence are indeed completely useless, because we only
> can ever care about ordering reads vs writes (mfence). But even the mfence
> is not there.

The usual approach is an atomic operation to a dummy location on the
stack.  Is that the recommendation for Xeon Phi?

Either way, what should userspace RCU do to detect that it is being built
on a Xeon Phi?  I am sure that Mathieu would welcome the relevant patches
for this.  ;-)

> > While reads and writes from an Intel=AE Xeon PhiTM coprocessor appear in
> > program order on the system bus,
> =

> This part of the sentence seems misleading to me. Didn't the first
> sentence state the opposite ? "the exception being that
> read misses are permitted to go ahead of buffered writes on the system
> bus when all the buffered writes are cached hits and are, therefore,
> not directed to the same address being accessed by the read miss."
> =

> I'm probably missing something.

The trick might be that read misses are only allowed to pass write
-hits-, which would mean that the system bus would have already seen
the invalidate corresponding to the delayed write, and thus would
have no evidence of any misorderingr

> > the compiler can still reorder
> > unrelated memory operations while maintaining program order on a
> > single Intel=AE Xeon PhiTM coprocessor (hardware thread). If software
> > running on an Intel=AE Xeon PhiTM coprocessor is dependent on the order
> > of memory operations on another Intel=AE Xeon PhiTM coprocessor then a
> > serializing instruction (e.g., CPUID, instruction with a LOCK prefix)
> > between the memory operations is required to guarantee completion of
> > all memory accesses issued prior to the serializing instruction before
> > any subsequent memory operations are started.

OK, sounds like my guess of atomic instruction to dummy stack location
is correct, or perhaps carrying out a nearby assignment using an
xchg instruction.

> > (end of quote)
> > =

> > From what I understand, it is safe to leave out any run-time memory
> > barriers, but we still need barriers that prevent the compiler from
> > reordering (using __asm__ __volatile__ ("":::"memory")). In
> > urcu/arch/x86.h, I see that when CONFIG_RCU_HAVE_FENCE is false,
> > memory barriers result in both compile-time and run-time memory
> > barriers:  __asm__ __volatile__ ("lock; addl $0,0(%%esp)":::"memory").
> > I guess this would work for the Phi, but the lock instruction does not
> > seem necessary.
> =

> Actually, either a cpuid (core serializing) instruction or lock-prefixed
> instruction (serializing as a side-effect memory accesses) seems required.

It would certainly be safe.  One approach would be to keep it that way
unless/until someone showed it to be unnecessary.

> > So, should we just set CONFIG_RCU_HAVE_FENCE to false when compiling
> > for the Phi and go on with our lives, or should we add a specific
> > config for this case?
> =

> I _think_ we could get away with this mapping:
> =

> smp_wmb() -> barrier()
>   reasoning: write vs write are not reordered by the processor.
> =

> smp_rmb() -> barrier()
>   reasoning: read vs read not reordered by processor.
> =

> smp_mb() -> __asm__ __volatile__ ("lock; addl $0,0(%%esp)":::"memory")
>    or a cpuid instruction
>   reasoning: cpu can reorder reads vs later writes.
> =

> smp_read_barrier_depends() -> nothing at all (not needed at any level).

This should be safe, though I would argue for do { } while (0) for
smp_read_barrier_depends().

> Interestingly enough, AFAIU, this seems to map to x86-TSO. Maybe that ins=
tead
> of defining a compiling option specifically for Xeon Phi, we could instead
> define a x86-tso.h header variant in userspace RCU and use it in all Intel
> processors that map to TSO (hint: very vast majority). The only exceptions
> seems to be Pentium Pro (needing smp_rmb() -> lfence) and some Windchip
> processors which could reorder stores (thus needing smp_wmb() -> sfence).
> =

> Thoughts ?

As long as there is some reasonable way of detecting them.

Actually, why not use the locked add of zero for all x86 systems for
smp_mb()?

							Thanx, Paul

> Thanks,
> =

> Mathieu
> =

> > =

> > Simon
> > =

> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > =

> =

> -- =

> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> =
