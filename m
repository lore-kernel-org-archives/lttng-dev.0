From: Michael Haberler <mail17@mah.priv.at>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Mon, 27 Apr 2015 13:41:41 +0200
Message-ID: <A0DF7795-1940-45E4-A12B-ED0D340883D4__12913.0336143591$1430134982$gmane$org@mah.priv.at>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
 <8187A8CE-F16D-4CDE-B969-380DE308A8D5@mah.priv.at>
 <826926538.3126946.1427639461728.JavaMail.zimbra@polymtl.ca>
 <76BAB974-2B32-469C-82AD-4D5630AFA28E@mah.priv.at>
 <381678352.13569741.1430055111345.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1YmhQ1-0002Ga-CB
 for lttng-dev@lists.lttng.org; Mon, 27 Apr 2015 07:41:46 -0400
In-Reply-To: <381678352.13569741.1430055111345.JavaMail.zimbra@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: =?utf-8?Q?Rafa=C3=ABl_Blanchet-Lecomte?= <rafael.blanchet-lecomte@polymtl.ca>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello Michel, Rafael,

> Am 26.04.2015 um 15:31 schrieb Michel Dagenais <michel.dagenais@polymtl.ca>:
> 
> How are you progressing to add LTTng instrumentation to the various layers of MachineKit? 

I've worked my way through examples to get traces, and I have added autoconf and build support to the machinekit repo so it can be used.

That said, the folks which have timing problems have not caught on yet.. it looks some more guidance, examples and a bit of a machinekit-specific writeup is needed, competing with the other 247 priority projects on my desk ;)

So in principle it's a go as far as the (more important) userland threads flavors (xenomai, rt-preempt) are concerned; RTAI/in-kernel instrumentation would be nice to have to round it out but given the prospects for RTAI's future this might be a bit academic an exercise.
 
> I will have a student this Summer in our lab looking at the use of LTTng on embedded platforms for real-time applications such as MachineKit. He will insure that LTTng is easy to use and deploy on these popular platforms (Raspberry Pi, BeagleBone Black, Parallela), and well documented. He will also look at specific analysis and views that would be useful for such platforms and applications and look at the possibility of tracing the peripheral processors such as the BBB PRU as well. He is in CC and could help you by getting your feedback and proposing adjustments and improvements to the LTTng toolchain as a result.

Well, I would be glad to get Rafael interested in instrumenting machinekit and I am certain we'd be able to coach him through the learning curve so any work actually makes a difference; I would love to see some critical components be instrumented and actually measured on several platforms, and embedded ARM's are becoming more important all the time.

As far as machinekit as a proving ground for LTTNG goes, it is certainly a nontrivial 'customer' - meaning I dont exclude some problems and roadblocks downstream. But the upside for LTTNG I see - if it works here, it should work just about anywhere.


Let me add a question out of the blue: I've read the literature on observing time and distributed systems and am aware of the theoretical issues, as well as clock synchronisation. Still - has any thought been given to merge traces of several systems based on synchronisation points (known causality), well-synchronized  clocks, or other forms of hardware synchronisation?

thanks for caring!

best regards

Michael Haberler

> 
> ----- Mail original -----
>> Michel,
>> 
>>> Am 29.03.2015 um 16:31 schrieb Michel Dagenais
>>> <michel.dagenais@polymtl.ca>:
>>> 
>>> 
>>>> - is there a complete example out-of-tree kernel module instrumented for
>>>> LTTng? I worked through Steve Rostedt's sillymod
>>>> (http://lwn.net/Articles/379903 ff) but am fuzzy on "Adding the LTTng
>>>> adaptation layer" - is the example from the manual available in toto
>>>> somewhere?
>>> 
>>> A few people in my group have done so. I will check on Monday to get sample
>>> code for you.
>> 
>> on re-reading, I am almost there, but I'd appreciate an example anyway
>> 
>>> 
>>>> - much of the machinekit RT code (HAL library and components) can be
>>>> compiled
>>>> as userland shared objects (Posix, RT-PREEMPP, Xenomai threads) or kernel
>>>> modules (RTAI, and the deprecated Xenomai kernel API), sitting ontop of an
>>>> abstracted realtime API ("RTAPI"). Ideally the tracepoints would work
>>>> unchanged except for the different context. The manual naturally assumes
>>>> an
>>>> either-or context. Am I out on a limb here ;-? How would I bring in the
>>>> tracepoint definitions in a kernel context - as a separate module maybe or
>>>> linked into each using module?
>>> 
>>> I dont believe that we have examples of code that compile in both kernel
>>> and UST contexts. This can certainly be handled with conditional
>>> compilation.
>> 
>> right, I need to wrap my head around the maze of #defines and #includes ;)
>> but it looks possible
>> 
>>> 
>>>> - we cannot assume that lttng is available when building machinekit
>>>> packages
>>>> at least for now, meaning we likely need shim macro definitions and
>>>> possibly
>>>> fake header files to adjust for the lacking lttng files. Any examples I
>>>> can
>>>> follow?
>>> 
>>> MariaDB and others can target different tracers (LTTng, DTrace, none)...
>>> Again, I will try to get you good sample code early next week.
>> 
>> I thought I might not be the first one to do this
>> 
>> 
>> semi-related because I was bitten by it: the Xenomai configs referenced here:
>> http://www.xenomai.org/pipermail/xenomai/2013-January/027272.html turn
>> CONFIG_FTRACE off, citing performance reasons. I think we'll turn it back on
>> in our kernels, cant be that much extra overhead.
>> 
>> 
>> thanks in advance!
>> 
>> - Michael
>> 
>> 
>> 
>> 
