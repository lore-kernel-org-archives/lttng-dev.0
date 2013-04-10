From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: LTTng system call tracing on ARM
Date: Wed, 10 Apr 2013 12:09:12 -0400
Message-ID: <CAGDH53mpsZ-gsA4VViqFTLkWYsJmigWb7KquJ-+Dvn4-BfBHuA__28531.5951485702$1365610195$gmane$org@mail.gmail.com>
References: <20130410084053.GB25958@hal>
	<CA+umk=pX-4t74XQqsP+vLsDGF1atWzUi75gmSyoVGsDkqQcB7g@mail.gmail.com>
	<20130410130246.GA12801@hal>
	<CA+umk=pPAvGqkC2pPfr6sA3sPtZroKoPegJ6gET2eBYSPp4Fhw@mail.gmail.com>
	<20130410160233.GA17568@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UPxaI-0005ki-Hg
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 12:09:18 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz10so574605veb.31
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 09:09:13 -0700 (PDT)
In-Reply-To: <20130410160233.GA17568@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi Jan,

This seems related to bug #472 [1]. CCing Mathieu.

Christian

[1] - http://bugs.lttng.org/issues/472

On Wed, Apr 10, 2013 at 12:02 PM, Jan Glauber <jan.glauber@gmail.com> wrote:
> On Wed, Apr 10, 2013 at 09:38:33AM -0400, Pierre-Luc St-Charles wrote:
>> Here are the links I stashed a while back about previous patching attempts
>> to add syscall tracepoints to the ARM kernel :
>>
>> Most promising:
>> http://www.spinics.net/lists/arm-kernel/msg166419.html
>>
>> Earlier draft(s):
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086974.html
>> https://lkml.org/lkml/2011/12/1/131
>> http://comments.gmane.org/gmane.linux.ports.arm.kernel/141933
>>
>> I believe the first link shows the most refined patch there is out there,
>> but it might take some minor tinkering to apply it to a different kernel
>> version. I briefly tried to apply it to the 3.0.31 kernel, but it's a bit
>> out of my 'tinkering' range, and I never finished it.
>>
>>
>> Good luck!
>
> Thanks, fortunately I'm targeting 3.4. It wasn't too hard, got the kernel running
> and ftrace already works.
>
> Now I'm facing something hilarious, on loading the lttng-tracer module I get:
>
> Error: could not insert module lttng-tracer.ko: Cannot allocate memory
>
> [15912.259399] alloc_vmap_area: 2 callbacks suppressed
> [15912.264953] vmap allocation for size 15998976 failed: use vmalloc=<size> to increase size.
> [15912.273895] vmalloc: allocation failure: 15991653 bytes
> [15912.279602] insmod: page allocation failure: order:0, mode:0xd0
>
> Never saw vmalloc fail on loading a kernel module before. Hmmm.
> Looking at the module reveals:
> -rw-rw-r-- 1 jang jang 16036281 Apr 10 17:48 lttng-tracer.ko
>
> Wow. 16 megs for a kernel module ?!? readelf says its all in .rodata.
>
> Doing an objdump on that
> Disassembly of section .rodata:
>
> 00000000 <sc_table>:
> ...
>     1714:       00f0a788        rscseq  sl, r0, r8, lsl #15
>     1718:       00f0a7a0        rscseq  sl, r0, r0, lsr #15
>     171c:       00000004        andeq   r0, r0, r4
>         ...
>   f00054:       00f0a860        rscseq  sl, r0, r0, ror #16
>   f00058:       00f0a878        rscseq  sl, r0, r8, ror r8
>   f0005c:       00000002        andeq   r0, r0, r2
>
> Now whats that? A big hole in the system call table?
>
> Digging through the various defines and headers of lttng-modules I've found:
>
> instrumentation/syscalls/headers/arm-32-syscalls-2.6.38_integers_override.h:
> ...
> #define OVERRIDE_TABLE_32_sys_set_tls
> TRACE_SYSCALL_TABLE(sys_set_tls, sys_set_tls, 0xf0005, 2)
>
> Weird ARM apparently expanded the system call area above 0xf0000. I don't
> understand why this override logic is needed but removing that define results
> in a kernel module with a much more sane size.
>
> LTTng system call tracing works with that change for me.
>
> Any idea on how the override problem can be solved with the magic system calls?
>
> --Jan
>
>> -PL
>>
>>
>>
>> On Wed, Apr 10, 2013 at 9:02 AM, Jan Glauber <jan.glauber@gmail.com> wrote:
>>
>> > On Wed, Apr 10, 2013 at 08:37:18AM -0400, PLSTC wrote:
>> > > Hey Jan,
>> > >
>> > > I cannot speak on behalf of everyone here, but during our attempt to port
>> > > LTTng to Android, we also noticed that the kernels we were using (3.0.x)
>> > > were nowhere near the requirements for syscall tracepoints support. I
>> > > believe such support was added on x86/64 way earlier (early 3.x) than on
>> > > ARM, which is why it was included in LTTng's modules a while ago. Simply
>> > > put, the ARM kernel is late.
>> >
>> > OK, so for ARM kernel version 3.6 is the minimum unless the syscall
>> > tracepoint
>> > support is backported.
>> >
>> > > There are a few actuals ways to 'enable' syscall tracepoints support on
>> > > early ARM kernels, but they all including a bit of kernel
>> > hacking/patching.
>> > > I could send you some links if you're interested in that.
>> >
>> > Yes, sure!
>> >
>> > --Jan
>> >
>> > > -PL
>> > > On Apr 10, 2013 4:40 AM, "Jan Glauber" <jan.glauber@gmail.com> wrote:
>> > >
>> > > > Hi,
>> > > >
>> > > > I want to use LTTng for system call tracing on ARM. Now lttng-modules
>> > seems
>> > > > to support system call tracing on ARM already since
>> > > > "8f4f80e LTTng Modules ARM syscall instrumentation".
>> > > >
>> > > > But I wonder how that worked since lttng-syscalls.c is only build under
>> > > > CONFIG_HAVE_SYSCALL_TRACEPOINTS and that was added to ARM only with
>> > kernel
>> > > > 3.6
>> > > > (much after than the lttng-modules commit).
>> > > >
>> > > > Am I missing something? Is system call tracing working on ARM with the
>> > > > upstream
>> > > > LTTng version?
>> > > >
>> > > > thanks,
>> > > > Jan
>> > > >
>> > > > _______________________________________________
>> > > > lttng-dev mailing list
>> > > > lttng-dev@lists.lttng.org
>> > > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> > > >
>> >
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
