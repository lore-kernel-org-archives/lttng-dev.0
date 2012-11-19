From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: TRACEPOINT_PROVIDER mismatch check
	in	ust-tracepoint-event.h needs -Wsystem-headers
Date: Mon, 19 Nov 2012 11:26:18 -0500
Message-ID: <20121119162618.GA17428__28238.0888741047$1353342477$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F87106@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TaUAu-0005f4-6G
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 11:26:20 -0500
Content-Disposition: inline
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB19F87106@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David OShea (David.OShea@quantum.com) wrote:
> Hi all,
> 
> I noticed that ust-tracepoint-event.h includes:
> 
> """
> /*
>  * Stage 0 of tracepoint event generation.
>  *
>  * Check that each TRACEPOINT_EVENT provider argument match the
>  * TRACEPOINT_PROVIDER by creating dummy callbacks.
>  */
> """
> 
> If I ask GCC to output the preprocessor's output, I can see that the
> checks are behaving as expected - creating calls to functions whose
> names include the TRACEPOINT_EVENTs' provider arguments, and defining
> a function whose name includes the TRACEPOINT_PROVIDER value.
> However, because I have installed the LTTng header files - they are in
> /usr/include/lttng - GCC (I'm using version 4.3.3) does not actually
> output any warnings regarding the calls to undefined functions because
> they are made in a "system header file".  If I pass -Wsystem-headers
> to GCC, then it does output warnings when I have a TRACEPOINT_PROVIDER
> mismatch, but I also get lots of warnings about unused parameters due
> to the way the tracepoint definitions work.
> 
> From some experimentation, it looks like enabling -Wsystem-headers,
> even if only for the trace provider .c file, would probably result in
> us getting lots of spurious warnings due to various Linux system
> header files too, so we don't really want to enable that.

We had to enable -Wsystem-headers in UST tests/hello and tests/demo
Makefile.am. Indeed, it should be documented. And yes, we see some
warnings in Linux system headers about missing prototypes. I think we
should report these to distro and/or Linux kernel upstream.

> I'm not sure if there is any way you could "fix" this so that
> -Wsystem-headers isn't required, but perhaps it would at least be
> worth documenting that this flag could be used - but perhaps not
> recommend it - to enable those checks to occur.

I have not found any way to show those warnings from UST system headers
without -Wsystem-headers. We have the following scenario:

probe C file
  -> includes ust probe description file
     -> includes tracepoint-event.h (system header)
        -> includes ust probe description file
        -> includes ust-tracepoint-event.h (system header) [1]
           For each stage:
             -> undef/define macros
             -> includes ust probe description file

Since the actual functions are created by the compiler in the scope of
ust-tracepoint-event.h [1] (a system header), the warnings are inhibited
unless we specify -Wsystem-headers.

When we build within the UST tree, since the build fetches the headers
locally from the tree, we see those warnings even without
-Wsystem-headers.

So I guess documenting this would be the right way to do it, unless
anyone has a better idea ?

Thanks,

Mathieu


> This was seen with lttng-ust-2.0.5 patched with commit 009745db "Cache
> the procname per-thread rather than per-process to take into account
> that prctl() can be used to set thread names." and commit e699eda
> "don't spawn per-user thread if HOME is not set".
> 
> Thanks,
> David
> 
[...]

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
