From: Suchakra Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Re: [RFC] Dynamic instrumentation support in UST
Date: Fri, 26 Jul 2013 14:14:56 -0400
Message-ID: <1374862496.14606.54.camel__7535.22694944895$1374862557$gmane$org@station15.dorsal.polymtl.ca>
References: <CAJ7wx-FipDw6XVvYsugMhOrSEJVz5vASaJQnjX9HM5-ahu24bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1V2mXZ-0000Hf-Tb
	for lttng-dev@lists.lttng.org; Fri, 26 Jul 2013 14:15:03 -0400
Received: from [132.207.72.20] ([132.207.72.20])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id r6QIEvc5017698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2013 14:14:57 -0400
In-Reply-To: <CAJ7wx-FipDw6XVvYsugMhOrSEJVz5vASaJQnjX9HM5-ahu24bA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

First of all, I think its very well written :)

On Fri, 2013-07-26 at 23:40 +0800, Zifei Tong wrote:

>     lttng add-context -u -e NAME --pid PID
>         -t, --type TYPE     Context type.
>                             TYPE can be one of the strings below:
>                                 regs
>                                     all registers
>                                 reg:reg_name
>                                     register with name reg_name
>                                 var_type:var_name:addr
>                                     variable at addr with field name var_name
>                                 backtrace
>                                     stack backtrace
> 
> Examples:
> 
>     # lttng add-context -u --pid PID -e aname -t reg:rax
>     # lttng add-context -u --pid PID -e aname -t int:varname:0xdeadbeef
>     # lttng add-context -u --pid PID -e aname -t string:varname:0xdeadbeef
>     # lttng add-context -u --pid PID -e aname -t backtrace

I had an idea about having these 'preset' (or some other fancy name)
types of events rather than different contexts. For eg.

	#lttng enable-event -u --pid PID --preset reg:rax

Thats how I had this is my mind. But I don't know a lot yet so I don't
know which is better.

> These context types appear in other tracers [4],[5],[6], however
> implement all of
> them may be not possible within the GSoC schedule.
> 
> The above proposed command line interface require defining tracepoint event at
> runtime thus free user form compiling tracepoint probes themselves. But I have
> a concern such runtime defined tracepoint event mechanism may eventually evolve
> to a tiny compiler/interpreter like Systemtap [7] or gdb [8].

Of course, to provide more flexibility it has to be evolved to a
mechanism by which through a meta language or some scripts, the
tracepoints can be compiled. Its going to be complex, but thats what
this should evolve into slowly. I don't think it should be of concern.

> 
> Implementation
> --------------
> 
> After comparing dyninst with gdb's tracepoint code, I think using dyninst as
> current choice of implementing dynamic instrumentation is more appropriate.
> gdb's tracepoint function relies on a lot of support code they already have,
> such as disassembler, elf/DWARF parser. We'll need to a lot of work to port all
> the support code.

Of course, dyninst will definitely provide a fast and clean
implementation (unless we have a library written from scratch to do
instrumentation) 

Not being overambitious but, eventually we may need to have options to
dynamically instrument binaries based on performances of gdb's strategy
as well as dyninst's strategy in different use cases. Systemtap already
has --runtime=dyninst switch to use dyninst or uprobe based (default)
instrumentation.


--
Suchakra
