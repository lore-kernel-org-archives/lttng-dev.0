From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Xeon Phi memory barriers
Date: Tue, 19 Nov 2013 10:26:06 -0500
Message-ID: <CAFXXi0n784=HA5RKX91OM8=CTpgofd1dkqnC_b4avo0aAYBnOQ__15666.011212352$1384874861$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f49.google.com ([209.85.215.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1VinCN-0001NH-7M
	for lttng-dev@lists.lttng.org; Tue, 19 Nov 2013 10:26:49 -0500
Received: by mail-la0-f49.google.com with SMTP id er20so6139622lab.36
	for <lttng-dev@lists.lttng.org>; Tue, 19 Nov 2013 07:26:36 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello there,

liburcu does not build on the Intel Xeon Phi, because the chip is
recognized as x86_64, but lacks the {s,l,m}fence instructions found on
usual x86_64 processors. The following is taken from the Xeon Phi dev
guide:

The Intel=AE Xeon PhiTM coprocessor memory model is the same as that of
the Intel=AE Pentium processor. The reads and writes always appear in
programmed order at the system bus (or the ring interconnect in the
case of the Intel=AE Xeon PhiTM coprocessor); the exception being that
read misses are permitted to go ahead of buffered writes on the system
bus when all the buffered writes are cached hits and are, therefore,
not directed to the same address being accessed by the read miss.

As a consequence of its stricter memory ordering model, the Intel=AE
Xeon PhiTM coprocessor does not support the SFENCE, LFENCE, and MFENCE
instructions that provide a more efficient way of controlling memory
ordering on other Intel processors.

While reads and writes from an Intel=AE Xeon PhiTM coprocessor appear in
program order on the system bus, the compiler can still reorder
unrelated memory operations while maintaining program order on a
single Intel=AE Xeon PhiTM coprocessor (hardware thread). If software
running on an Intel=AE Xeon PhiTM coprocessor is dependent on the order
of memory operations on another Intel=AE Xeon PhiTM coprocessor then a
serializing instruction (e.g., CPUID, instruction with a LOCK prefix)
between the memory operations is required to guarantee completion of
all memory accesses issued prior to the serializing instruction before
any subsequent memory operations are started.

(end of quote)

From what I understand, it is safe to leave out any run-time memory
barriers, but we still need barriers that prevent the compiler from
reordering (using __asm__ __volatile__ ("":::"memory")). In
urcu/arch/x86.h, I see that when CONFIG_RCU_HAVE_FENCE is false,
memory barriers result in both compile-time and run-time memory
barriers:  __asm__ __volatile__ ("lock; addl $0,0(%%esp)":::"memory").
I guess this would work for the Phi, but the lock instruction does not
seem necessary.

So, should we just set CONFIG_RCU_HAVE_FENCE to false when compiling
for the Phi and go on with our lives, or should we add a specific
config for this case?

Simon
