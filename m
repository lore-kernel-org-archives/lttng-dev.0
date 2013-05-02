From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Can I use function to retrieve socket information
	in the	SC_TRACE_EVENT macro?
Date: Thu, 2 May 2013 16:57:21 -0400
Message-ID: <20130502205721.GC16536__5111.78855454109$1367528279$gmane$org@Krystal>
References: <CABy43G-h0eN9L5hmHhWYrQM1D1Mcwzr3So5b7_qZbFEYoPzx-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY0ZA-0006gx-JC
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:57:24 -0400
Content-Disposition: inline
In-Reply-To: <CABy43G-h0eN9L5hmHhWYrQM1D1Mcwzr3So5b7_qZbFEYoPzx-w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rui Han <r.han@umiami.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Rui Han (r.han@umiami.edu) wrote:
> Dear all,
> 
> I am working on retrieving socket information for socket related syscalls
> by the kernel trace, such as sys_connect() and sys_bind(). What I did is in
> the .h file
> "instrumentation/syscalls/headers/x86-64-syscalls-3.0.4_pointers.h", I
> modify the sys_connect SC_TRACE_EVENT. I add _field(size_t, port) and
> tp_assign(port, getport() ) to the TP_STRUCT_entry() and TP_fast_assign(),
> respectively. The getport() function is a function I wrote to retrieve the
> port number and ip address by the function getpeername(). The lttng module
> got installed correctly after the modification, (with some #ifndef
> manipulations), However, when I reboot the machine and try to do the kernel
> trace. It gives me error messages:
> 
> Spawning a session daemon
> FATAL: Error inserting lttng_tracer
> (/lib/modules/3.2.0-29-generic/extra/lttng-tracer.ko): Unknown symbol in
> module, or unknown parameter (see dmesg)
> Error: Unable to load module lttng-tracer
> Warning: No kernel tracer available
> Warning: No tracing group detected
> Session rui-session created.
> Traces will be written in /root/lttng-traces/rui-session-20120813-133953
> FATAL: Error inserting lttng_tracer
> (/lib/modules/3.2.0-29-generic/extra/lttng-tracer.ko): Unknown symbol in
> module, or unknown parameter (see dmesg)
> Error: Unable to load module lttng-tracer
> Warning: No kernel tracer available
> 
> and in the syslog file: I got the following error:
> [   82.001603] lttng_tracer: Unknown symbol getport (err 0)
> [   82.377213] lttng_tracer: Unknown symbol getport (err 0)
> 
> I am new to the kernel module programming. My question is: should I do some
> kinds of symbol register before define a function in the kernel space? Any
> suggestion for solving the problem?

I think your tracepoint probe cannot find the getport() symbol you
created. Sounds like an issue with the way you declared/defined
getport() within lttng-modules.

Sorry for the late reply,

Thanks,

Mathieu

> 
> Thanks,
> Rui

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
