From: Michael Haberler <mail17@mah.priv.at>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Sun, 29 Mar 2015 17:17:27 +0200
Message-ID: <76BAB974-2B32-469C-82AD-4D5630AFA28E__2884.30422447181$1427642323$gmane$org@mah.priv.at>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
 <8187A8CE-F16D-4CDE-B969-380DE308A8D5@mah.priv.at>
 <826926538.3126946.1427639461728.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1YcExw-0001OE-2p
 for lttng-dev@lists.lttng.org; Sun, 29 Mar 2015 11:17:34 -0400
In-Reply-To: <826926538.3126946.1427639461728.JavaMail.zimbra@polymtl.ca>
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

> Am 29.03.2015 um 16:31 schrieb Michel Dagenais <michel.dagenais@polymtl.ca>:
> 
> 
>> - is there a complete example out-of-tree kernel module instrumented for
>> LTTng? I worked through Steve Rostedt's sillymod
>> (http://lwn.net/Articles/379903 ff) but am fuzzy on "Adding the LTTng
>> adaptation layer" - is the example from the manual available in toto
>> somewhere?
> 
> A few people in my group have done so. I will check on Monday to get sample code for you.

on re-reading, I am almost there, but I'd appreciate an example anyway

> 
>> - much of the machinekit RT code (HAL library and components) can be compiled
>> as userland shared objects (Posix, RT-PREEMPP, Xenomai threads) or kernel
>> modules (RTAI, and the deprecated Xenomai kernel API), sitting ontop of an
>> abstracted realtime API ("RTAPI"). Ideally the tracepoints would work
>> unchanged except for the different context. The manual naturally assumes an
>> either-or context. Am I out on a limb here ;-? How would I bring in the
>> tracepoint definitions in a kernel context - as a separate module maybe or
>> linked into each using module?
> 
> I dont believe that we have examples of code that compile in both kernel and UST contexts. This can certainly be handled with conditional compilation. 

right, I need to wrap my head around the maze of #defines and #includes ;) but it looks possible

> 
>> - we cannot assume that lttng is available when building machinekit packages
>> at least for now, meaning we likely need shim macro definitions and possibly
>> fake header files to adjust for the lacking lttng files. Any examples I can
>> follow?
> 
> MariaDB and others can target different tracers (LTTng, DTrace, none)... Again, I will try to get you good sample code early next week.

I thought I might not be the first one to do this


semi-related because I was bitten by it: the Xenomai configs referenced here: http://www.xenomai.org/pipermail/xenomai/2013-January/027272.html turn CONFIG_FTRACE off, citing performance reasons. I think we'll turn it back on in our kernels, cant be that much extra overhead.


thanks in advance!

- Michael
