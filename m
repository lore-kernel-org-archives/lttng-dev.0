From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: current_thread_info() not respecting program order
 with gcc 4.8.x
Date: Fri, 22 Nov 2013 13:02:26 +0000 (UTC)
Message-ID: <66040128.73116.1385125346036.JavaMail.zimbra__9955.11690057374$1385125410$gmane$org@efficios.com>
References: <52803E5D.3050109@mentor.com> <528E94E2.3080102@ahsoftware.de>
	<CANxoKds1iLpXK0yb1qW_Z4tLSRccrf69nYUV7mLSJBMwSrjwmQ@mail.gmail.com>
	<20131122003904.GT892@tucnak.redhat.com>
	<894043206.72860.1385085446389.JavaMail.zimbra@efficios.com>
	<CANxoKdsUjG4McOVR8A3dZekNmCwyEztJ7rabCJ8p-G7mNmjiLA@mail.gmail.com>
	<2038513765.72947.1385091506781.JavaMail.zimbra@efficios.com>
	<CANxoKduwK=9__0WFXFcTWjQn3Rbn+HgSWZyL0FN_VuJ2Q_2TPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0319126766=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VjqNT-0008Sr-Pm
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 08:02:36 -0500
In-Reply-To: <CANxoKduwK=9__0WFXFcTWjQn3Rbn+HgSWZyL0FN_VuJ2Q_2TPQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Luis Lozano <llozano@chromium.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Han Shen <shenhan@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nathan Lynch <Nathan_Lynch@mentor.com>, lttng-dev@lists.lttng.org, Bhaskar Janakiraman <bjanakiraman@chromium.org>, Alexander Holler <holler@ahsoftware.de>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>
List-Id: lttng-dev@lists.lttng.org

--===============0319126766==
Content-Type: multipart/alternative;
	boundary="----=_Part_73115_195880197.1385125346035"

------=_Part_73115_195880197.1385125346035
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "Luis Lozano" <llozano@chromium.org>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Jakub Jelinek" <jakub@redhat.com>, "Alexander Holler"
> <holler@ahsoftware.de>, "Linus Torvalds" <torvalds@linux-foundation.org>,
> "Richard Henderson" <rth@twiddle.net>, "Linux Kernel Mailing List"
> <linux-kernel@vger.kernel.org>, "Will Deacon" <will.deacon@arm.com>,
> "Catalin Marinas" <catalin.marinas@arm.com>, "Peter Zijlstra"
> <peterz@infradead.org>, lttng-dev@lists.lttng.org, "Nathan Lynch"
> <Nathan_Lynch@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
> "Andrew Morton" <akpm@linux-foundation.org>, "Bhaskar Janakiraman"
> <bjanakiraman@chromium.org>, "Han Shen" <shenhan@chromium.org>
> Sent: Friday, November 22, 2013 3:16:27 AM
> Subject: Re: current_thread_info() not respecting program order with gcc
> 4.8.x

> On Thu, Nov 21, 2013 at 7:38 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

> > ----- Original Message -----
> 
> > > From: "Luis Lozano" < llozano@google.com >
> 
> > > To: "Mathieu Desnoyers" < mathieu.desnoyers@efficios.com >
> 
> > > Cc: "Jakub Jelinek" < jakub@redhat.com >, "Alexander Holler" <
> > > holler@ahsoftware.de >, "Linus Torvalds"
> 
> > > < torvalds@linux-foundation.org >, "Richard Henderson" < rth@twiddle.net
> > > >,
> > > "Linux Kernel Mailing List"
> 
> > > < linux-kernel@vger.kernel.org >, "Will Deacon" < will.deacon@arm.com >,
> > > "Catalin Marinas" < catalin.marinas@arm.com >,
> 
> > > "Peter Zijlstra" < peterz@infradead.org >, lttng-dev@lists.lttng.org ,
> > > "Nathan Lynch" < Nathan_Lynch@mentor.com >, "Paul
> 
> > > E. McKenney" < paulmck@linux.vnet.ibm.com >, "Andrew Morton" <
> > > akpm@linux-foundation.org >, "Bhaskar Janakiraman"
> 
> > > < bjanakiraman@chromium.org >, "Han Shen" < shenhan@chromium.org >
> 
> > > Sent: Thursday, November 21, 2013 9:36:27 PM
> 
> > > Subject: Re: current_thread_info() not respecting program order with gcc
> > > 4.8.x
> 
> > >
> 
> > > Hi Mathieu,
> 
> > >
> 
> > > Yes the problem we were seeing with GCC bug 58854 is that an interrupt
> 
> > > handler was corrupting the stack of a routine which had an invalid
> 
> > > value of SP (not really on "top" of the stack) for part of the
> 
> > > routine.
> 
> > > But in the assembly code you sent, I don't see where sp is being
> 
> > > modified... or where the access to "below" sp is happening.
> 

> > The following instruction
> 

> > f1c: e50b1048 str r1, [fp, #-72] ; 0xffffffb8
> 

> > appears in the assembly generated by gcc 4.8.2, but not in the one
> 
> > generated by 4.7.3, which makes me wonder if it's good or not.
> 
> It is there in 4.7.3 just a few lines difference.
> I don't see any meaningful difference between the 2 assembly snippets...
> Just instructions ordered a little different?

Assembly generated by 4.7.3 vs 4.8.2 are much more different. 

The diff I've presented yesterday is between 4.8.2 and 4.8.2+barrier() at the end of 
the function error path. When I can get a cross compiler to work, I will send out more 
the complete assembly listings of the function. 

Thanks, 

Mathieu 

> Luis

> > With
> 
> > slightly different build output from the diff (probably a different config
> 
> > from Nathan), the first function instructions look like:
> 

> > 00000efc <lttng_event_reserve>:
> 
> > efc: e1a0c00d mov ip, sp
> 
> > f00: e92ddff0 push {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
> 
> > f04: e24cb004 sub fp, ip, #4
> 
> > f08: e24dd03c sub sp, sp, #60 ; 0x3c
> 
> > f0c: e52de004 push {lr} ; (str lr, [sp, #-4]!)
> 
> > f10: ebfffffe bl 0 <__gnu_mcount_nc>
> 
> > f14: e5903000 ldr r3, [r0]
> 
> > f18: e1a04000 mov r4, r0
> 
> > f1c: e1a0000d mov r0, sp
> 
> > f20: e5936030 ldr r6, [r3, #48] ; 0x30
> 
> > f24: e3c03d7f bic r3, r0, #8128 ; 0x1fc0
> 
> > f28: e3c3303f bic r3, r3, #63 ; 0x3f
> 
> > f2c: e50b104c str r1, [fp, #-76] ; 0xffffffb4
> 
> > f30: e5932004 ldr r2, [r3, #4]
> 
> > f34: e2822001 add r2, r2, #1
> 
> > f38: e5832004 str r2, [r3, #4]
> 
> > f3c: ebfffffe bl 0 <debug_smp_processor_id>
> 
> > f40: e59f2e44 ldr r2, [pc, #3652] ; 1d8c <lttng_event_reserve+0xe90>
> 
> > f44: e59f3e44 ldr r3, [pc, #3652] ; 1d90 <lttng_event_reserve+0xe94>
> 
> > f48: e7921100 ldr r1, [r2, r0, lsl #2]
> 
> > f4c: e1a05000 mov r5, r0
> 
> > f50: e7932001 ldr r2, [r3, r1]
> 

> > My rusty ARM assembler knowledge analyzes this like:
> 

> > ip = sp (ip being the scratch register)
> 
> > push 11 registers * 4 bytes = 44 bytes onto the stack
> 
> > fp = ip - 4
> 
> > sp = sp - 60 (sp = ip - 104)
> 
> > push {lr} bl
> 
> > 0 <__gnu_mcount_nc> (dynamically patched to a pop {lr})
> 
> > [...]
> 
> > store r1 into mem location fp - 76
> 

> > So yes, it does look like the -76 from fp is within the stack.
> 

> > > In GCC bug 58854 it was pretty clear that the restore of the sp
> 
> > > register in the epilogue is moved to somewhere close to the prologue
> 
> > > of the routine.
> 
> > > Are we missing some diffs from the assembly comparison?
> 

> > My next step is to setup my own 4.8.2 ARM cross-compiler. I've tried this
> > morning,
> 
> > did not manage to get one working even after following 2 howtos, trying
> > with
> > Debian
> 
> > packages, etc. Nathan told me this diff was the full comparison between the
> > two
> 
> > functions, but you'll understand that at this point I want to reproduce
> 
> > everything myself, because this is a _weird_ issue.
> 

> > But after a long day of debugging, it's time for some sleep. I will get
> > back
> > to this
> 
> > tomorrow,
> 

> > Thanks,
> 

> > Mathieu
> 

> > >
> 
> > > Thanks
> 
> > >
> 
> > > Luis
> 
> > >
> 
> > >
> 
> > >
> 
> > >
> 
> > > On Thu, Nov 21, 2013 at 5:57 PM, Mathieu Desnoyers
> 
> > > < mathieu.desnoyers@efficios.com > wrote:
> 
> > > > ----- Original Message -----
> 
> > > >> From: "Jakub Jelinek" < jakub@redhat.com >
> 
> > > >> To: "Luis Lozano" < llozano@google.com >
> 
> > > >> Cc: "Alexander Holler" < holler@ahsoftware.de >, "Linus Torvalds"
> 
> > > >> < torvalds@linux-foundation.org >, "Mathieu Desnoyers"
> 
> > > >> < mathieu.desnoyers@efficios.com >, "Richard Henderson" <
> > > >> rth@twiddle.net >,
> 
> > > >> "Linux Kernel Mailing List"
> 
> > > >> < linux-kernel@vger.kernel.org >, "Will Deacon" < will.deacon@arm.com
> > > >> >,
> 
> > > >> "Catalin Marinas" < catalin.marinas@arm.com >,
> 
> > > >> "Peter Zijlstra" < peterz@infradead.org >, lttng-dev@lists.lttng.org ,
> 
> > > >> "Nathan Lynch" < Nathan_Lynch@mentor.com >, "Paul
> 
> > > >> E. McKenney" < paulmck@linux.vnet.ibm.com >, "Andrew Morton"
> 
> > > >> < akpm@linux-foundation.org >, "Bhaskar Janakiraman"
> 
> > > >> < bjanakiraman@chromium.org >, "Han Shen" < shenhan@chromium.org >
> 
> > > >> Sent: Thursday, November 21, 2013 7:39:04 PM
> 
> > > >> Subject: Re: current_thread_info() not respecting program order with
> > > >> gcc
> 
> > > >> 4.8.x
> 
> > > >>
> 
> > > >> On Thu, Nov 21, 2013 at 03:45:35PM -0800, Luis Lozano wrote:
> 
> > > >> > I think we need a reproducer. Without this we may all be going on
> > > >> > the
> 
> > > >> > wrong path. This whole conversation started on an *assumption* that
> 
> > > >> > some accesses were being reordered.
> 
> > > >> >
> 
> > > >> > evidence of the reorder or reproducer please?
> 
> > > >>
> 
> > > >> Yeah, if a compiler bug is suspected, can anybody please open
> 
> > > >> a bugreport in http://gcc.gnu.org/bugzilla/ with the preprocessed
> > > >> source,
> 
> > > >> compiler version, flags and how it was configured and some hint in
> > > >> which
> 
> > > >> function to look for what exactly? We don't necessarily need a runtime
> 
> > > >> small reproducer, but if it can be shown in the assembly what has been
> 
> > > >> reordered and why you think it shouldn't, with the above mentioned
> > > >> input
> 
> > > >> that ought to be sufficient. Thanks.
> 
> > > >
> 
> > > > OK OK, let me reply on list first so I can share the result of a full
> > > > day
> 
> > > > of bug hunting. We're not there yet, but many options have been
> > > > eliminated.
> 
> > > >
> 
> > > > The issue shows up in stress test, when tracing with lttng-modules
> > > > 2.4-rc1,
> 
> > > > on ARM. It's been reproduced with a Linux kernel 3.12 so far, with
> 
> > > > lttng-modules
> 
> > > > compiled against that kernel.
> 
> > > >
> 
> > > > First, I asked Nathan to compile his kernel with gcc 4.7, and
> > > > lttng-modules
> 
> > > > with gcc 4.8.x (and vice-versa). The problem only appears when
> 
> > > > lttng-modules
> 
> > > > are compiled with gcc 4.8.x. The compiler version used to compile the
> > > > rest
> 
> > > > of the kernel does not matter.
> 
> > > >
> 
> > > > Then I looked at gcc 4.8 changelog for ARM, new feature:
> 
> > > > -fno-sched-pressure
> 
> > > > (sched pressure is there by default). Nathan tried compiling
> > > > lttng-modules
> 
> > > > with
> 
> > > > -fno-sched-pressure. The problem still reproduces.
> 
> > > >
> 
> > > > Knowing that adding barrier() outside of preempt_disable()/enable() was
> 
> > > > fixing the issue, we tried identifying which code location was
> > > > responsible
> 
> > > > for working around the issue. Skipping a long investigation, here is
> > > > the
> 
> > > > executive summary:
> 
> > > >
> 
> > > > http://git.lttng.org/?p=lttng-modules.git;a=blob;f=lttng-ring-buffer-client.h;h=50c47b3bf49f6c2dd24e250cf1a9b97808cd8e27;hb=HEAD
> 
> > > >
> 
> > > > Has the following function. We identified that adding a barrier() as
> > > > shown
> 
> > > > below
> 
> > > > works around the issue:
> 
> > > >
> 
> > > > static
> 
> > > > int lttng_event_reserve(struct lib_ring_buffer_ctx *ctx,
> 
> > > > uint32_t event_id)
> 
> > > > {
> 
> > > > struct lttng_channel *lttng_chan = channel_get_private(ctx->chan);
> 
> > > > int ret, cpu;
> 
> > > >
> 
> > > > cpu = lib_ring_buffer_get_cpu(&client_config);
> 
> > > > if (cpu < 0)
> 
> > > > return -EPERM;
> 
> > > > ctx->cpu = cpu;
> 
> > > >
> 
> > > > switch (lttng_chan->header_type) {
> 
> > > > case 1: /* compact */
> 
> > > > if (event_id > 30)
> 
> > > > ctx->rflags |= LTTNG_RFLAG_EXTENDED;
> 
> > > > break;
> 
> > > > case 2: /* large */
> 
> > > > if (event_id > 65534)
> 
> > > > ctx->rflags |= LTTNG_RFLAG_EXTENDED;
> 
> > > > break;
> 
> > > > default:
> 
> > > > WARN_ON_ONCE(1);
> 
> > > > }
> 
> > > >
> 
> > > > ret = lib_ring_buffer_reserve(&client_config, ctx);
> 
> > > > if (ret)
> 
> > > > goto put;
> 
> > > > lttng_write_event_header(&client_config, ctx, event_id);
> 
> > > > return 0;
> 
> > > > put:
> 
> > > > lib_ring_buffer_put_cpu(&client_config);
> 
> > > > ---------------> barrier() added here;
> 
> > > > <----------------------------
> 
> > > > return ret;
> 
> > > > }
> 
> > > >
> 
> > > > Where barrier() is the usual asm volatile with "memory" clobber,
> > > > nothing
> 
> > > > else.
> 
> > > >
> 
> > > > Nathan gave me the binary diff for the assembly generated for this
> > > > function
> 
> > > > without
> 
> > > > the barrier and with the barrier:
> 
> > > >
> 
> > > > --- /tmp/lttng_event_reserve-4.8.2.dump 2013-11-21 11:14:14.536495079
> > > > -0600
> 
> > > > +++ /tmp/lttng_event_reserve-with-barrier-4.8.2.dump 2013-11-21
> 
> > > > 14:12:52.997355907 -0600
> 
> > > > @@ -7,11 +7,11 @@
> 
> > > > f10: ebfffffe bl 0 <__gnu_mcount_nc>
> 
> > > > f14: e5903000 ldr r3, [r0]
> 
> > > > f18: e1a04000 mov r4, r0
> 
> > > > - f1c: e50b1048 str r1, [fp, #-72] ; 0xffffffb8
> 
> > > > + f1c: e1a0000d mov r0, sp
> 
> > > > f20: e5936030 ldr r6, [r3, #48] ; 0x30
> 
> > > > - f24: e1a0000d mov r0, sp
> 
> > > > - f28: e3c03d7f bic r3, r0, #8128 ; 0x1fc0
> 
> > > > - f2c: e3c3303f bic r3, r3, #63 ; 0x3f
> 
> > > > + f24: e3c03d7f bic r3, r0, #8128 ; 0x1fc0
> 
> > > > + f28: e3c3303f bic r3, r3, #63 ; 0x3f
> 
> > > > + f2c: e50b1048 str r1, [fp, #-72] ; 0xffffffb8
> 
> > > > f30: e5932004 ldr r2, [r3, #4]
> 
> > > > f34: e2822001 add r2, r2, #1
> 
> > > > f38: e5832004 str r2, [r3, #4]
> 
> > > > @@ -53,7 +53,7 @@
> 
> > > > fc8: e3c3303f bic r3, r3, #63 ; 0x3f
> 
> > > > fcc: e5933000 ldr r3, [r3]
> 
> > > > fd0: e3130002 tst r3, #2
> 
> > > > - fd4: 0a000000 beq fdc <lttng_event_reserve+0xe0>
> 
> > > > + fd4: 0a0002be beq 1ad4 <lttng_event_reserve+0xbd8>
> 
> > > > fd8: ebfffffe bl 0 <preempt_schedule>
> 
> > > > fdc: ea0002bc b 1ad4 <lttng_event_reserve+0xbd8>
> 
> > > > fe0: e3500000 cmp r0, #0
> 
> > > >
> 
> > > > We tried disabling the ftrace function tracing to get mcount out of the
> 
> > > > way,
> 
> > > > and the problem still reproduces.
> 
> > > >
> 
> > > > I'm stopping here in terms of details about the disassembly, because I
> 
> > > > need to double check with Nathan that I get the right disassembly for
> > > > the
> 
> > > > right
> 
> > > > cases. I also terribly need to setup a 4.8.2 ARM cross-compiler on my
> 
> > > > machine.
> 
> > > >
> 
> > > > I'm attaching Nathan's ARM configuration.
> 
> > > >
> 
> > > > It does look behave a bit like this bug pointed out by Luis:
> 
> > > >
> 
> > > > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
> 
> > > >
> 
> > > > AFAIU (please correct me if I am wrong), ARM's interrupt handler run
> 
> > > > on top of the thread stack (?). If it's the case, then anything stored
> 
> > > > on the stack below "sp" could be overwritten by an interrupt handler.
> 
> > > > This would fit well the reproduction scenario for this bug: Nathan runs
> 
> > > > LTTng tracing of kmem_cache_free tracepoint with hackbench running.
> 
> > > > A race between a short window of stack use below sp and interrupt
> > > > handlers
> 
> > > > would trigger with this kind of stress-test.
> 
> > > >
> 
> > > > Thoughts ?
> 
> > > >
> 
> > > > Thanks,
> 
> > > >
> 
> > > > Mathieu
> 
> > > >
> 
> > > >
> 
> > > > --
> 
> > > > Mathieu Desnoyers
> 
> > > > EfficiOS Inc.
> 
> > > > http://www.efficios.com
> 
> > >
> 
> > >
> 
> > >
> 
> > > --
> 
> > >
> 
> > > Luis A. Lozano | Software Engineer | llozano@google.com | +1
> > > (408)431-5164
> 
> > >
> 

> > --
> 
> > Mathieu Desnoyers
> 
> > EfficiOS Inc.
> 
> > http://www.efficios.com
> 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_73115_195880197.1385125346035
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"Luis Lozano" &lt;lloza=
no@chromium.org&gt;<br><b>To: </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers=
@efficios.com&gt;<br><b>Cc: </b>"Jakub Jelinek" &lt;jakub@redhat.com&gt;, "=
Alexander Holler" &lt;holler@ahsoftware.de&gt;, "Linus Torvalds" &lt;torval=
ds@linux-foundation.org&gt;, "Richard Henderson" &lt;rth@twiddle.net&gt;, "=
Linux Kernel Mailing List" &lt;linux-kernel@vger.kernel.org&gt;, "Will Deac=
on" &lt;will.deacon@arm.com&gt;, "Catalin Marinas" &lt;catalin.marinas@arm.=
com&gt;, "Peter Zijlstra" &lt;peterz@infradead.org&gt;, lttng-dev@lists.ltt=
ng.org, "Nathan Lynch" &lt;Nathan_Lynch@mentor.com&gt;, "Paul E. McKenney" =
&lt;paulmck@linux.vnet.ibm.com&gt;, "Andrew Morton" &lt;akpm@linux-foundati=
on.org&gt;, "Bhaskar Janakiraman" &lt;bjanakiraman@chromium.org&gt;, "Han S=
hen" &lt;shenhan@chromium.org&gt;<br><b>Sent: </b>Friday, November 22, 2013=
 3:16:27 AM<br><b>Subject: </b>Re: current_thread_info() not respecting pro=
gram order with gcc 4.8.x<br><div><br></div><div dir=3D"ltr"><br><div class=
=3D"gmail_extra"><br><div><br></div><div class=3D"gmail_quote">On Thu, Nov =
21, 2013 at 7:38 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@eff=
icios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"im">----- Original Message -----<br>
&gt; From: "Luis Lozano" &lt;<a href=3D"mailto:llozano@google.com" target=
=3D"_blank">llozano@google.com</a>&gt;<br>
&gt; To: "Mathieu Desnoyers" &lt;<a href=3D"mailto:mathieu.desnoyers@effici=
os.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt; Cc: "Jakub Jelinek" &lt;<a href=3D"mailto:jakub@redhat.com" target=3D"=
_blank">jakub@redhat.com</a>&gt;, "Alexander Holler" &lt;<a href=3D"mailto:=
holler@ahsoftware.de" target=3D"_blank">holler@ahsoftware.de</a>&gt;, "Linu=
s Torvalds"<br>

&gt; &lt;<a href=3D"mailto:torvalds@linux-foundation.org" target=3D"_blank"=
>torvalds@linux-foundation.org</a>&gt;, "Richard Henderson" &lt;<a href=3D"=
mailto:rth@twiddle.net" target=3D"_blank">rth@twiddle.net</a>&gt;, "Linux K=
ernel Mailing List"<br>

&gt; &lt;<a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_blank">=
linux-kernel@vger.kernel.org</a>&gt;, "Will Deacon" &lt;<a href=3D"mailto:w=
ill.deacon@arm.com" target=3D"_blank">will.deacon@arm.com</a>&gt;, "Catalin=
 Marinas" &lt;<a href=3D"mailto:catalin.marinas@arm.com" target=3D"_blank">=
catalin.marinas@arm.com</a>&gt;,<br>

&gt; "Peter Zijlstra" &lt;<a href=3D"mailto:peterz@infradead.org" target=3D=
"_blank">peterz@infradead.org</a>&gt;, <a href=3D"mailto:lttng-dev@lists.lt=
tng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>, "Nathan Lynch" &l=
t;<a href=3D"mailto:Nathan_Lynch@mentor.com" target=3D"_blank">Nathan_Lynch=
@mentor.com</a>&gt;, "Paul<br>

&gt; E. McKenney" &lt;<a href=3D"mailto:paulmck@linux.vnet.ibm.com" target=
=3D"_blank">paulmck@linux.vnet.ibm.com</a>&gt;, "Andrew Morton" &lt;<a href=
=3D"mailto:akpm@linux-foundation.org" target=3D"_blank">akpm@linux-foundati=
on.org</a>&gt;, "Bhaskar Janakiraman"<br>

&gt; &lt;<a href=3D"mailto:bjanakiraman@chromium.org" target=3D"_blank">bja=
nakiraman@chromium.org</a>&gt;, "Han Shen" &lt;<a href=3D"mailto:shenhan@ch=
romium.org" target=3D"_blank">shenhan@chromium.org</a>&gt;<br></div><div cl=
ass=3D"im">&gt; Sent: Thursday, November 21, 2013 9:36:27 PM<br>
&gt; Subject: Re: current_thread_info() not respecting program order with g=
cc 4.8.x<br>
&gt;<br></div><div class=3D"im">&gt; Hi Mathieu,<br>
&gt;<br>
&gt; Yes the problem we were seeing with GCC bug 58854 is that an interrupt=
<br>
&gt; handler was corrupting the stack of a routine which had an invalid<br>
&gt; value of SP (not really on "top" of the stack) for part of the<br>
&gt; routine.<br>
&gt; But in the assembly code you sent, I don't see where sp is being<br>
&gt; modified... or where the access to "below" sp is happening.<br><br></d=
iv>The following instruction<br><div class=3D"im"><br>
&nbsp; f1c: &nbsp; &nbsp; &nbsp;e50b1048 &nbsp; &nbsp; &nbsp; &nbsp;str &nb=
sp; &nbsp; r1, [fp, #-72] &nbsp;; 0xffffffb8<br><br></div>appears in the as=
sembly generated by gcc 4.8.2, but not in the one<br>
generated by 4.7.3, which makes me wonder if it's good or not.</blockquote>=
<div><br></div><div><br></div><div>It is there in 4.7.3 just a few lines di=
fference.&nbsp;</div><div>I don't see any meaningful difference between the=
 2 assembly snippets...&nbsp;</div><div>Just instructions ordered a little =
different?&nbsp;</div></div></div></div></blockquote><div><br></div><div>As=
sembly generated by 4.7.3 vs 4.8.2 are much more different.<br></div><div><=
br></div><div>The diff I've presented yesterday is between 4.8.2 and 4.8.2+=
barrier() at the end of<br></div><div>the function error path. When I can g=
et a cross compiler to work, I will send out more<br></div><div>the complet=
e assembly listings of the function.<br></div><div><br></div><div>Thanks,<b=
r></div><div><br></div><div>Mathieu<br></div><blockquote style=3D"border-le=
ft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weigh=
t:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial=
,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_extra"><d=
iv class=3D"gmail_quote"><div><br></div><div>Luis</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"> With<br>
slightly different build output from the diff (probably a different config<=
br>
from Nathan), the first function instructions look like:<br><br>
00000efc &lt;lttng_event_reserve&gt;:<br>
&nbsp; &nbsp; &nbsp;efc: &nbsp; &nbsp; &nbsp; e1a0c00d &nbsp; &nbsp; &nbsp;=
 &nbsp;mov &nbsp; &nbsp; ip, sp<br>
&nbsp; &nbsp; &nbsp;f00: &nbsp; &nbsp; &nbsp; e92ddff0 &nbsp; &nbsp; &nbsp;=
 &nbsp;push &nbsp; &nbsp;{r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}<br>
&nbsp; &nbsp; &nbsp;f04: &nbsp; &nbsp; &nbsp; e24cb004 &nbsp; &nbsp; &nbsp;=
 &nbsp;sub &nbsp; &nbsp; fp, ip, #4<br>
&nbsp; &nbsp; &nbsp;f08: &nbsp; &nbsp; &nbsp; e24dd03c &nbsp; &nbsp; &nbsp;=
 &nbsp;sub &nbsp; &nbsp; sp, sp, #60 &nbsp; &nbsp; ; 0x3c<br>
&nbsp; &nbsp; &nbsp;f0c: &nbsp; &nbsp; &nbsp; e52de004 &nbsp; &nbsp; &nbsp;=
 &nbsp;push &nbsp; &nbsp;{lr} &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;; (s=
tr lr, [sp, #-4]!)<br><div class=3D"im">&nbsp; &nbsp; &nbsp;f10: &nbsp; &nb=
sp; &nbsp; ebfffffe &nbsp; &nbsp; &nbsp; &nbsp;bl &nbsp; &nbsp; &nbsp;0 &lt=
;__gnu_mcount_nc&gt;<br>
&nbsp; &nbsp; &nbsp;f14: &nbsp; &nbsp; &nbsp; e5903000 &nbsp; &nbsp; &nbsp;=
 &nbsp;ldr &nbsp; &nbsp; r3, [r0]<br>
&nbsp; &nbsp; &nbsp;f18: &nbsp; &nbsp; &nbsp; e1a04000 &nbsp; &nbsp; &nbsp;=
 &nbsp;mov &nbsp; &nbsp; r4, r0<br></div><div class=3D"im">&nbsp; &nbsp; &n=
bsp;f1c: &nbsp; &nbsp; &nbsp; e1a0000d &nbsp; &nbsp; &nbsp; &nbsp;mov &nbsp=
; &nbsp; r0, sp<br>
&nbsp; &nbsp; &nbsp;f20: &nbsp; &nbsp; &nbsp; e5936030 &nbsp; &nbsp; &nbsp;=
 &nbsp;ldr &nbsp; &nbsp; r6, [r3, #48] &nbsp; ; 0x30<br></div><div class=3D=
"im">&nbsp; &nbsp; &nbsp;f24: &nbsp; &nbsp; &nbsp; e3c03d7f &nbsp; &nbsp; &=
nbsp; &nbsp;bic &nbsp; &nbsp; r3, r0, #8128 &nbsp; ; 0x1fc0<br></div><div c=
lass=3D"im">&nbsp; &nbsp; &nbsp;f28: &nbsp; &nbsp; &nbsp; e3c3303f &nbsp; &=
nbsp; &nbsp; &nbsp;bic &nbsp; &nbsp; r3, r3, #63 &nbsp; &nbsp; ; 0x3f<br></=
div>&nbsp; &nbsp; &nbsp;f2c: &nbsp; &nbsp; &nbsp; e50b104c &nbsp; &nbsp; &n=
bsp; &nbsp;str &nbsp; &nbsp; r1, [fp, #-76] &nbsp;; 0xffffffb4<br><div clas=
s=3D"im">&nbsp; &nbsp; &nbsp;f30: &nbsp; &nbsp; &nbsp; e5932004 &nbsp; &nbs=
p; &nbsp; &nbsp;ldr &nbsp; &nbsp; r2, [r3, #4]<br>
&nbsp; &nbsp; &nbsp;f34: &nbsp; &nbsp; &nbsp; e2822001 &nbsp; &nbsp; &nbsp;=
 &nbsp;add &nbsp; &nbsp; r2, r2, #1<br>
&nbsp; &nbsp; &nbsp;f38: &nbsp; &nbsp; &nbsp; e5832004 &nbsp; &nbsp; &nbsp;=
 &nbsp;str &nbsp; &nbsp; r2, [r3, #4]<br></div>&nbsp; &nbsp; &nbsp;f3c: &nb=
sp; &nbsp; &nbsp; ebfffffe &nbsp; &nbsp; &nbsp; &nbsp;bl &nbsp; &nbsp; &nbs=
p;0 &lt;debug_smp_processor_id&gt;<br>
&nbsp; &nbsp; &nbsp;f40: &nbsp; &nbsp; &nbsp; e59f2e44 &nbsp; &nbsp; &nbsp;=
 &nbsp;ldr &nbsp; &nbsp; r2, [pc, #3652] ; 1d8c &lt;lttng_event_reserve+0xe=
90&gt;<br>
&nbsp; &nbsp; &nbsp;f44: &nbsp; &nbsp; &nbsp; e59f3e44 &nbsp; &nbsp; &nbsp;=
 &nbsp;ldr &nbsp; &nbsp; r3, [pc, #3652] ; 1d90 &lt;lttng_event_reserve+0xe=
94&gt;<br>
&nbsp; &nbsp; &nbsp;f48: &nbsp; &nbsp; &nbsp; e7921100 &nbsp; &nbsp; &nbsp;=
 &nbsp;ldr &nbsp; &nbsp; r1, [r2, r0, lsl #2]<br>
&nbsp; &nbsp; &nbsp;f4c: &nbsp; &nbsp; &nbsp; e1a05000 &nbsp; &nbsp; &nbsp;=
 &nbsp;mov &nbsp; &nbsp; r5, r0<br>
&nbsp; &nbsp; &nbsp;f50: &nbsp; &nbsp; &nbsp; e7932001 &nbsp; &nbsp; &nbsp;=
 &nbsp;ldr &nbsp; &nbsp; r2, [r3, r1]<br><br>
My rusty ARM assembler knowledge analyzes this like:<br><br>
ip =3D sp &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(ip being the scratch re=
gister)<br>
push 11 registers * 4 bytes =3D 44 bytes onto the stack<br>
fp =3D ip - 4<br>
sp =3D sp - 60 &nbsp; (sp =3D ip - 104)<br>
push {lr} bl<br>
0 &lt;__gnu_mcount_nc&gt; &nbsp;(dynamically patched to a pop {lr})<br>
[...]<br>
store r1 into mem location fp - 76<br><br>
So yes, it does look like the -76 from fp is within the stack.<br><div clas=
s=3D"im"><br><br>
&gt; In GCC bug 58854 it was pretty clear that the restore of the sp<br>
&gt; register in the epilogue is moved to somewhere close to the prologue<b=
r>
&gt; of the routine.<br>
&gt; Are we missing some diffs from the assembly comparison?<br><br></div>M=
y next step is to setup my own 4.8.2 ARM cross-compiler. I've tried this mo=
rning,<br>
did not manage to get one working even after following 2 howtos, trying wit=
h Debian<br>
packages, etc. Nathan told me this diff was the full comparison between the=
 two<br>
functions, but you'll understand that at this point I want to reproduce<br>
everything myself, because this is a _weird_ issue.<br><br>
But after a long day of debugging, it's time for some sleep. I will get bac=
k to this<br>
tomorrow,<br><br>
Thanks,<br><br>
Mathieu<br><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Luis<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Nov 21, 2013 at 5:57 PM, Mathieu Desnoyers<br>
&gt; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank=
">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br>
&gt; &gt; ----- Original Message -----<br>
&gt; &gt;&gt; From: "Jakub Jelinek" &lt;<a href=3D"mailto:jakub@redhat.com"=
 target=3D"_blank">jakub@redhat.com</a>&gt;<br>
&gt; &gt;&gt; To: "Luis Lozano" &lt;<a href=3D"mailto:llozano@google.com" t=
arget=3D"_blank">llozano@google.com</a>&gt;<br>
&gt; &gt;&gt; Cc: "Alexander Holler" &lt;<a href=3D"mailto:holler@ahsoftwar=
e.de" target=3D"_blank">holler@ahsoftware.de</a>&gt;, "Linus Torvalds"<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:torvalds@linux-foundation.org" target=
=3D"_blank">torvalds@linux-foundation.org</a>&gt;, "Mathieu Desnoyers"<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=
=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;, "Richard Henderson" &lt=
;<a href=3D"mailto:rth@twiddle.net" target=3D"_blank">rth@twiddle.net</a>&g=
t;,<br>
&gt; &gt;&gt; "Linux Kernel Mailing List"<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D=
"_blank">linux-kernel@vger.kernel.org</a>&gt;, "Will Deacon" &lt;<a href=3D=
"mailto:will.deacon@arm.com" target=3D"_blank">will.deacon@arm.com</a>&gt;,=
<br>
&gt; &gt;&gt; "Catalin Marinas" &lt;<a href=3D"mailto:catalin.marinas@arm.c=
om" target=3D"_blank">catalin.marinas@arm.com</a>&gt;,<br>
&gt; &gt;&gt; "Peter Zijlstra" &lt;<a href=3D"mailto:peterz@infradead.org" =
target=3D"_blank">peterz@infradead.org</a>&gt;, <a href=3D"mailto:lttng-dev=
@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>,<br>
&gt; &gt;&gt; "Nathan Lynch" &lt;<a href=3D"mailto:Nathan_Lynch@mentor.com"=
 target=3D"_blank">Nathan_Lynch@mentor.com</a>&gt;, "Paul<br>
&gt; &gt;&gt; E. McKenney" &lt;<a href=3D"mailto:paulmck@linux.vnet.ibm.com=
" target=3D"_blank">paulmck@linux.vnet.ibm.com</a>&gt;, "Andrew Morton"<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:akpm@linux-foundation.org" target=3D"_b=
lank">akpm@linux-foundation.org</a>&gt;, "Bhaskar Janakiraman"<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:bjanakiraman@chromium.org" target=3D"_b=
lank">bjanakiraman@chromium.org</a>&gt;, "Han Shen" &lt;<a href=3D"mailto:s=
henhan@chromium.org" target=3D"_blank">shenhan@chromium.org</a>&gt;<br>
&gt; &gt;&gt; Sent: Thursday, November 21, 2013 7:39:04 PM<br>
&gt; &gt;&gt; Subject: Re: current_thread_info() not respecting program ord=
er with gcc<br>
&gt; &gt;&gt; 4.8.x<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Thu, Nov 21, 2013 at 03:45:35PM -0800, Luis Lozano wrote:<=
br>
&gt; &gt;&gt; &gt; I think we need a reproducer. Without this we may all be=
 going on the<br>
&gt; &gt;&gt; &gt; wrong path. This whole conversation started on an *assum=
ption* that<br>
&gt; &gt;&gt; &gt; some accesses were being reordered.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; evidence of the reorder or reproducer please?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Yeah, if a compiler bug is suspected, can anybody please open=
<br>
&gt; &gt;&gt; a bugreport in <a href=3D"http://gcc.gnu.org/bugzilla/" targe=
t=3D"_blank">http://gcc.gnu.org/bugzilla/</a> with the preprocessed source,=
<br>
&gt; &gt;&gt; compiler version, flags and how it was configured and some hi=
nt in which<br>
&gt; &gt;&gt; function to look for what exactly? &nbsp;We don't necessarily=
 need a runtime<br>
&gt; &gt;&gt; small reproducer, but if it can be shown in the assembly what=
 has been<br>
&gt; &gt;&gt; reordered and why you think it shouldn't, with the above ment=
ioned input<br>
&gt; &gt;&gt; that ought to be sufficient. &nbsp;Thanks.<br>
&gt; &gt;<br>
&gt; &gt; OK OK, let me reply on list first so I can share the result of a =
full day<br>
&gt; &gt; of bug hunting. We're not there yet, but many options have been e=
liminated.<br>
&gt; &gt;<br>
&gt; &gt; The issue shows up in stress test, when tracing with lttng-module=
s 2.4-rc1,<br>
&gt; &gt; on ARM. It's been reproduced with a Linux kernel 3.12 so far, wit=
h<br>
&gt; &gt; lttng-modules<br>
&gt; &gt; compiled against that kernel.<br>
&gt; &gt;<br>
&gt; &gt; First, I asked Nathan to compile his kernel with gcc 4.7, and ltt=
ng-modules<br>
&gt; &gt; with gcc 4.8.x (and vice-versa). The problem only appears when<br=
>
&gt; &gt; lttng-modules<br>
&gt; &gt; are compiled with gcc 4.8.x. The compiler version used to compile=
 the rest<br>
&gt; &gt; of the kernel does not matter.<br>
&gt; &gt;<br>
&gt; &gt; Then I looked at gcc 4.8 changelog for ARM, new feature:<br>
&gt; &gt; -fno-sched-pressure<br>
&gt; &gt; (sched pressure is there by default). Nathan tried compiling lttn=
g-modules<br>
&gt; &gt; with<br>
&gt; &gt; -fno-sched-pressure. The problem still reproduces.<br>
&gt; &gt;<br>
&gt; &gt; Knowing that adding barrier() outside of preempt_disable()/enable=
() was<br>
&gt; &gt; fixing the issue, we tried identifying which code location was re=
sponsible<br>
&gt; &gt; for working around the issue. Skipping a long investigation, here=
 is the<br>
&gt; &gt; executive summary:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"http://git.lttng.org/?p=3Dlttng-modules.git;a=3Dblob;f=
=3Dlttng-ring-buffer-client.h;h=3D50c47b3bf49f6c2dd24e250cf1a9b97808cd8e27;=
hb=3DHEAD" target=3D"_blank">http://git.lttng.org/?p=3Dlttng-modules.git;a=
=3Dblob;f=3Dlttng-ring-buffer-client.h;h=3D50c47b3bf49f6c2dd24e250cf1a9b978=
08cd8e27;hb=3DHEAD</a><br>

&gt; &gt;<br>
&gt; &gt; Has the following function. We identified that adding a barrier()=
 as shown<br>
&gt; &gt; below<br>
&gt; &gt; works around the issue:<br>
&gt; &gt;<br>
&gt; &gt; static<br>
&gt; &gt; int lttng_event_reserve(struct lib_ring_buffer_ctx *ctx,<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; uint32_t event_id)<br>
&gt; &gt; {<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; struct lttng_channel *lttng_chan =3D =
channel_get_private(ctx-&gt;chan);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; int ret, cpu;<br>
&gt; &gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; cpu =3D lib_ring_buffer_get_cpu(&amp;=
client_config);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; if (cpu &lt; 0)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -E=
PERM;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; ctx-&gt;cpu =3D cpu;<br>
&gt; &gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; switch (lttng_chan-&gt;header_type) {=
<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; case 1: /* compact */<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (event=
_id &gt; 30)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; ctx-&gt;rflags |=3D LTTNG_RFLAG_EXTENDED;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br=
>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; case 2: /* large */<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (event=
_id &gt; 65534)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; ctx-&gt;rflags |=3D LTTNG_RFLAG_EXTENDED;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br=
>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; default:<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WARN_ON_O=
NCE(1);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; ret =3D lib_ring_buffer_reserve(&amp;=
client_config, ctx);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; if (ret)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto put;=
<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; lttng_write_event_header(&amp;client_=
config, ctx, event_id);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
&gt; &gt; put:<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; lib_ring_buffer_put_cpu(&amp;client_c=
onfig);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; ---------------&gt; barrier() added h=
ere;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &lt;----------------------------<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; Where barrier() is the usual asm volatile with "memory" clobber, =
nothing<br>
&gt; &gt; else.<br>
&gt; &gt;<br>
&gt; &gt; Nathan gave me the binary diff for the assembly generated for thi=
s function<br>
&gt; &gt; without<br>
&gt; &gt; the barrier and with the barrier:<br>
&gt; &gt;<br>
&gt; &gt; --- /tmp/lttng_event_reserve-4.8.2.dump 2013-11-21 11:14:14.53649=
5079 -0600<br>
&gt; &gt; +++ /tmp/lttng_event_reserve-with-barrier-4.8.2.dump &nbsp; &nbsp=
;2013-11-21<br>
&gt; &gt; 14:12:52.997355907 -0600<br>
&gt; &gt; @@ -7,11 +7,11 @@<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; f10: &nbsp; &nbsp; &nbsp;ebfffffe &nbsp; &nb=
sp; &nbsp; &nbsp;bl &nbsp; &nbsp; &nbsp;0 &lt;__gnu_mcount_nc&gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; f14: &nbsp; &nbsp; &nbsp;e5903000 &nbsp; &nb=
sp; &nbsp; &nbsp;ldr &nbsp; &nbsp; r3, [r0]<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; f18: &nbsp; &nbsp; &nbsp;e1a04000 &nbsp; &nb=
sp; &nbsp; &nbsp;mov &nbsp; &nbsp; r4, r0<br>
&gt; &gt; - &nbsp; &nbsp; f1c: &nbsp; &nbsp; &nbsp;e50b1048 &nbsp; &nbsp; &=
nbsp; &nbsp;str &nbsp; &nbsp; r1, [fp, #-72] &nbsp;; 0xffffffb8<br>
&gt; &gt; + &nbsp; &nbsp; f1c: &nbsp; &nbsp; &nbsp;e1a0000d &nbsp; &nbsp; &=
nbsp; &nbsp;mov &nbsp; &nbsp; r0, sp<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; f20: &nbsp; &nbsp; &nbsp;e5936030 &nbsp; &nb=
sp; &nbsp; &nbsp;ldr &nbsp; &nbsp; r6, [r3, #48] &nbsp; ; 0x30<br>
&gt; &gt; - &nbsp; &nbsp; f24: &nbsp; &nbsp; &nbsp;e1a0000d &nbsp; &nbsp; &=
nbsp; &nbsp;mov &nbsp; &nbsp; r0, sp<br>
&gt; &gt; - &nbsp; &nbsp; f28: &nbsp; &nbsp; &nbsp;e3c03d7f &nbsp; &nbsp; &=
nbsp; &nbsp;bic &nbsp; &nbsp; r3, r0, #8128 &nbsp; ; 0x1fc0<br>
&gt; &gt; - &nbsp; &nbsp; f2c: &nbsp; &nbsp; &nbsp;e3c3303f &nbsp; &nbsp; &=
nbsp; &nbsp;bic &nbsp; &nbsp; r3, r3, #63 &nbsp; &nbsp; ; 0x3f<br>
&gt; &gt; + &nbsp; &nbsp; f24: &nbsp; &nbsp; &nbsp;e3c03d7f &nbsp; &nbsp; &=
nbsp; &nbsp;bic &nbsp; &nbsp; r3, r0, #8128 &nbsp; ; 0x1fc0<br>
&gt; &gt; + &nbsp; &nbsp; f28: &nbsp; &nbsp; &nbsp;e3c3303f &nbsp; &nbsp; &=
nbsp; &nbsp;bic &nbsp; &nbsp; r3, r3, #63 &nbsp; &nbsp; ; 0x3f<br>
&gt; &gt; + &nbsp; &nbsp; f2c: &nbsp; &nbsp; &nbsp;e50b1048 &nbsp; &nbsp; &=
nbsp; &nbsp;str &nbsp; &nbsp; r1, [fp, #-72] &nbsp;; 0xffffffb8<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; f30: &nbsp; &nbsp; &nbsp;e5932004 &nbsp; &nb=
sp; &nbsp; &nbsp;ldr &nbsp; &nbsp; r2, [r3, #4]<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; f34: &nbsp; &nbsp; &nbsp;e2822001 &nbsp; &nb=
sp; &nbsp; &nbsp;add &nbsp; &nbsp; r2, r2, #1<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; f38: &nbsp; &nbsp; &nbsp;e5832004 &nbsp; &nb=
sp; &nbsp; &nbsp;str &nbsp; &nbsp; r2, [r3, #4]<br>
&gt; &gt; @@ -53,7 +53,7 @@<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; fc8: &nbsp; &nbsp; &nbsp;e3c3303f &nbsp; &nb=
sp; &nbsp; &nbsp;bic &nbsp; &nbsp; r3, r3, #63 &nbsp; &nbsp; ; 0x3f<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; fcc: &nbsp; &nbsp; &nbsp;e5933000 &nbsp; &nb=
sp; &nbsp; &nbsp;ldr &nbsp; &nbsp; r3, [r3]<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; fd0: &nbsp; &nbsp; &nbsp;e3130002 &nbsp; &nb=
sp; &nbsp; &nbsp;tst &nbsp; &nbsp; r3, #2<br>
&gt; &gt; - &nbsp; &nbsp; fd4: &nbsp; &nbsp; &nbsp;0a000000 &nbsp; &nbsp; &=
nbsp; &nbsp;beq &nbsp; &nbsp; fdc &lt;lttng_event_reserve+0xe0&gt;<br>
&gt; &gt; + &nbsp; &nbsp; fd4: &nbsp; &nbsp; &nbsp;0a0002be &nbsp; &nbsp; &=
nbsp; &nbsp;beq &nbsp; &nbsp; 1ad4 &lt;lttng_event_reserve+0xbd8&gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; fd8: &nbsp; &nbsp; &nbsp;ebfffffe &nbsp; &nb=
sp; &nbsp; &nbsp;bl &nbsp; &nbsp; &nbsp;0 &lt;preempt_schedule&gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; fdc: &nbsp; &nbsp; &nbsp;ea0002bc &nbsp; &nb=
sp; &nbsp; &nbsp;b &nbsp; &nbsp; &nbsp; 1ad4 &lt;lttng_event_reserve+0xbd8&=
gt;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; fe0: &nbsp; &nbsp; &nbsp;e3500000 &nbsp; &nb=
sp; &nbsp; &nbsp;cmp &nbsp; &nbsp; r0, #0<br>
&gt; &gt;<br>
&gt; &gt; We tried disabling the ftrace function tracing to get mcount out =
of the<br>
&gt; &gt; way,<br>
&gt; &gt; and the problem still reproduces.<br>
&gt; &gt;<br>
&gt; &gt; I'm stopping here in terms of details about the disassembly, beca=
use I<br>
&gt; &gt; need to double check with Nathan that I get the right disassembly=
 for the<br>
&gt; &gt; right<br>
&gt; &gt; cases. I also terribly need to setup a 4.8.2 ARM cross-compiler o=
n my<br>
&gt; &gt; machine.<br>
&gt; &gt;<br>
&gt; &gt; I'm attaching Nathan's ARM configuration.<br>
&gt; &gt;<br>
&gt; &gt; It does look behave a bit like this bug pointed out by Luis:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58854" t=
arget=3D"_blank">http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58854</a><br=
>
&gt; &gt;<br>
&gt; &gt; AFAIU (please correct me if I am wrong), ARM's interrupt handler =
run<br>
&gt; &gt; on top of the thread stack (?). If it's the case, then anything s=
tored<br>
&gt; &gt; on the stack below "sp" could be overwritten by an interrupt hand=
ler.<br>
&gt; &gt; This would fit well the reproduction scenario for this bug: Natha=
n runs<br>
&gt; &gt; LTTng tracing of kmem_cache_free tracepoint with hackbench runnin=
g.<br>
&gt; &gt; A race between a short window of stack use below sp and interrupt=
 handlers<br>
&gt; &gt; would trigger with this kind of stress-test.<br>
&gt; &gt;<br>
&gt; &gt; Thoughts ?<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Mathieu<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Mathieu Desnoyers<br>
&gt; &gt; EfficiOS Inc.<br>
&gt; &gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.=
efficios.com</a><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Luis A. Lozano | Software Engineer | <a href=3D"mailto:llozano@google.=
com" target=3D"_blank">llozano@google.com</a> | <a href=3D"tel:%2B1%20%2840=
8%29431-5164" target=3D"_blank">+1 (408)431-5164</a><br>
&gt;<br><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http=
://www.efficios.com</a><br></div></div></blockquote></div><br></div></div><=
/blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span =
name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios=
.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_73115_195880197.1385125346035--




--===============0319126766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0319126766==--
