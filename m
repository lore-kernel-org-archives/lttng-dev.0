From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttng-ust 0/2] Shared object base address
 tracing
Date: Wed, 13 Nov 2013 13:09:13 -0500
Message-ID: <5283C049.1060204__47686.4891978495$1384366222$gmane$org@voxpopuli.im>
References: <1384183688-19038-1-git-send-email-paul_woegerer@mentor.com>
	<52828889.6030403@voxpopuli.im> <52834DB8.5030004@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1VgesW-0005pd-9I
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 13:09:30 -0500
In-Reply-To: <52834DB8.5030004@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>, mathieu.desnoyers@efficios.com, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 13-11-13 05:00 AM, Woegerer, Paul wrote:
>> - Why does the "statedump" event seem to give many more libs than the
>> "push" events? Could we be missing some dlopen's? For example, I traced
>> glxgears by preloading liblttng-ust-dl.so: http://pastebin.com/HKVa9a4T
> Since ust_baddr:push/pop is based on LD_PRELOAD'ing dlopen/dlclose it
> can only tell you what shared libraries were opened/closed during the
> time you are actually tracing the application. Whatever is
> dlopen'ed/dlclose'ed before the tracing infrastructure that is part of
> the userspace application (lttng-ust) is becoming fully functional
> therefore cannot be captured as ust_baddr:push/pop events.

Ah true, it's possible for the application to dlopen libraries before
it's even registered to UST. In my glxgears example I was expecting to
see the dlopen of libGL, but I would only get it in the statedump.
Although you do see it in your log, I wonder why too. I'll try to run
some more tests to see how repeatable the behavior is.

>> - As Matthew suggested, we could also hijack dlsym(), and with its
>> parameters we could match a symbol name to an address. This becomes
>> immensely useful when coupled with the ust-cyg-profile instrumentation,
>> so we can get information about about function names directly in the
>> trace! (but ironically, only for the dlopened libraries, and not the
>> main binary). What do you think of this approach?
> IMHO, hijacking dlsym() is not helping. The only thing you would know is
> that somewhere in your code for some reason the address for some symbol
> was requested via dlsym(). This will not help you to get symbol
> resolution for ust-cyg-profile instrumentation.

I was thinking of the case where you cyg-profile the dynamic libraries
also. But yeah, I didn't realize it would only give us the function
names for one call "deep". If the library calls others of its own
functions (which it does most of the time), then we would still need
standard symbol resolution to get the function names for those calls.
And since standard symbol resolution gives us all the information,
dlsym() doesn't bring anything new in that case.

But I think we all agree that it would be much easier for us (and for
the users) if the function name information was directly in the trace ;)


Thanks for your explanations!
Alexandre
