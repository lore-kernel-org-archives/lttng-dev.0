From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Getting function names with	lttng-ust-cyg-profile.so
Date: Mon, 9 Sep 2013 19:44:09 -0400
Message-ID: <20130909234409.GA11082__26871.5019374669$1378770307$gmane$org@Krystal>
References: <522E4FCE.7070000@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VJB7r-0004MX-5I
	for lttng-dev@lists.lttng.org; Mon, 09 Sep 2013 19:44:16 -0400
Content-Disposition: inline
In-Reply-To: <522E4FCE.7070000@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

We might want to investigate doing a side-program that gathers the
executables on the system, and lookup the symbols from the ELF. We could
save those in a bin/ subdirectory of a CTF trace. All we need is
instrumentation of the dynamic linker, and to know the executable names
associated with PIDs. There is a UST feature request for dynamic linker
instrumentation.

Thanks,

Mathieu

* Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> Hi all,
> 
> I've recently started playing with liblttng-ust-cyg-profile.so (aka,
> getting UST events from -finstrument-functions), and I have to say it's
> pretty nifty! I haven't done any benchmarks, but it's certainly faster
> than the typical printf() that people use with it...
> 
> However, in the resulting trace, one only gets the addresses of the
> functions. I understand how it's relatively "easy" for the seasoned user
> to use nm or addr2line to get the actual function names, but would it
> possible - and how hard would it be - to have this information (function
> names) directly in the trace?
> 
> 
> I'm trying to leverage this feature in Eclipse TMF to display a call
> stack for such UST traces. And to be honest, displaying a call stack
> with only the function addresses is completely useless, we need the
> function names.
> 
> We could have the user import a text file (which he can generate with
> "nm appname > file.txt" for example). But then he needs the original
> binary, which he might not have. And that binary needs to be compiled
> with debugging symbols. If the function name information was already in
> the trace, it would make the user experience much better, and our job
> much easier! ;)
> 
> 
> Thoughts?
> 
> Thanks,
> Alex
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
