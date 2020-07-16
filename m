From: Michel Dagenais via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Capturing User-Level Function Calls/Returns
Date: Wed, 15 Jul 2020 21:06:01 -0400 (EDT)
Message-ID: <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
Reply-To: Michel Dagenais <michel.dagenais@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6bgM6Fbhz1Xxh
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 21:06:39 -0400 (EDT)
In-Reply-To: <20200715174858.4698803c@oasis.local.home>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>, linux-trace-users-owner@vger.kernel.org, linux-trace-users <linux-trace-users@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: lttng-dev@lists.lttng.org


> Without recompiling, how would that be implemented?

As you mentioned, this is possible when "jump patching" 5 bytes instructions. Fast tracepoints in GDB and in kprobe do it. Kprobe goes further and patches sequences of instructions (because the target instruction is less than 5 bytes) if there is no incoming branch into the middle of the sequence. You can go even further, for instance using 3 bytes jumps to a trampoline installed in alignment nops. If you combine different strategies like this, you can eventually reach almost 100% success rate for "jump patching" tracepoints. This gets quite hairy though. However, the short story is that there is currently no tool as far as I know that does that easily and reliably in user space.

https://onlinelibrary.wiley.com/doi/abs/10.1002/spe.2746
https://dl.acm.org/doi/pdf/10.1145/3062341.3062344

If you can afford a more invasive tool, that requires a lot of memory and stops your application for quite some time, you can look at approaches like dyninst that decompile the binary, insert instrumentation code and reassemble the code.

https://dyninst.org/

> You would need to insert a jump on top of code, and still be able to
> preserve that code. What a trap does, is to insert a int3, that will
> trap into the kernel, it would then emulate the code that the int3 was
> on, and also call some code that can trace the current state.
> 
> To do it in user land, you would need to find way to replace the code
> at the location you want to trace, with a jump to the tracing
> infrastructure, that will also be able to emulate the code that the
> jump was inserted on top of. As on x86, that jump will need to be 5
> bytes long (covering 5 bytes of text to emulate), where as a int3 is a
> single byte.
> 
> Thus, you either recompile and insert nops where you want to place your
> jumps, or you trap using int3 that can do the work from within the
> kernel.
> 
> -- Steve
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
