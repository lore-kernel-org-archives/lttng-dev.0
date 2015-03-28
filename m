From: Michael Haberler <mail17@mah.priv.at>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Sat, 28 Mar 2015 09:33:17 +0100
Message-ID: <8187A8CE-F16D-4CDE-B969-380DE308A8D5__3418.00972023538$1427531671$gmane$org@mah.priv.at>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1YbmBD-0000Mn-On
 for lttng-dev@lists.lttng.org; Sat, 28 Mar 2015 04:33:25 -0400
In-Reply-To: <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Michel,

> Am 27.03.2015 um 19:35 schrieb Michel Dagenais <michel.dagenais@polymtl.ca>:
>> 
>> I've started integrating the build support and am running into my first
>> problems. So, that's the context of my following questions - thanks in
>> advance for guiding me through any blunders.
> 
> This is an excellent application for LTTng. My group has been looking for good use cases of real-time applications. We have a significant expertise with Linux for real-time and PREEMPT-RT. We could easily help you with the machinekit tracing: kernel and user-space instrumentation, specific views and analysis for this application... 

wrote the first UST tracepoints, got them to work just fine - no surprises (congratulations on the manual and general usability!). I'm building them into a shared library for now.

this I'm unsure how to deal with:

- is there a complete example out-of-tree kernel module instrumented for LTTng? I worked through Steve Rostedt's sillymod (http://lwn.net/Articles/379903 ff) but am fuzzy on "Adding the LTTng adaptation layer" - is the example from the manual available in toto somewhere?

- much of the machinekit RT code (HAL library and components) can be compiled as userland shared objects (Posix, RT-PREEMPP, Xenomai threads) or kernel modules (RTAI, and the deprecated Xenomai kernel API), sitting ontop of an abstracted realtime API ("RTAPI"). Ideally the tracepoints would work unchanged except for the different context. The manual naturally assumes an either-or context. Am I out on a limb here ;-? How would I bring in the tracepoint definitions in a kernel context - as a separate module maybe or linked into each using module?

- we cannot assume that lttng is available when building machinekit packages at least for now, meaning we likely need shim macro definitions and possibly fake header files to adjust for the lacking lttng files. Any examples I can follow?

thanks!

- Michael
