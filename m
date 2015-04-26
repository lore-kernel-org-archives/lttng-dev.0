From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Sun, 26 Apr 2015 09:31:51 -0400 (EDT)
Message-ID: <381678352.13569741.1430055111345.JavaMail.zimbra__27436.4167279147$1430055170$gmane$org@polymtl.ca>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
 <8187A8CE-F16D-4CDE-B969-380DE308A8D5@mah.priv.at>
 <826926538.3126946.1427639461728.JavaMail.zimbra@polymtl.ca>
 <76BAB974-2B32-469C-82AD-4D5630AFA28E@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1YmMf4-000490-3i
 for lttng-dev@lists.lttng.org; Sun, 26 Apr 2015 09:31:56 -0400
In-Reply-To: <76BAB974-2B32-469C-82AD-4D5630AFA28E@mah.priv.at>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Haberler <mail17@mah.priv.at>
Cc: =?utf-8?Q?Rafa=C3=ABl?= Blanchet-Lecomte <rafael.blanchet-lecomte@polymtl.ca>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

How are you progressing to add LTTng instrumentation to the various layers of MachineKit? 

I will have a student this Summer in our lab looking at the use of LTTng on embedded platforms for real-time applications such as MachineKit. He will insure that LTTng is easy to use and deploy on these popular platforms (Raspberry Pi, BeagleBone Black, Parallela), and well documented. He will also look at specific analysis and views that would be useful for such platforms and applications and look at the possibility of tracing the peripheral processors such as the BBB PRU as well. He is in CC and could help you by getting your feedback and proposing adjustments and improvements to the LTTng toolchain as a result.

----- Mail original -----
> Michel,
> 
> > Am 29.03.2015 um 16:31 schrieb Michel Dagenais
> > <michel.dagenais@polymtl.ca>:
> > 
> > 
> >> - is there a complete example out-of-tree kernel module instrumented for
> >> LTTng? I worked through Steve Rostedt's sillymod
> >> (http://lwn.net/Articles/379903 ff) but am fuzzy on "Adding the LTTng
> >> adaptation layer" - is the example from the manual available in toto
> >> somewhere?
> > 
> > A few people in my group have done so. I will check on Monday to get sample
> > code for you.
> 
> on re-reading, I am almost there, but I'd appreciate an example anyway
> 
> > 
> >> - much of the machinekit RT code (HAL library and components) can be
> >> compiled
> >> as userland shared objects (Posix, RT-PREEMPP, Xenomai threads) or kernel
> >> modules (RTAI, and the deprecated Xenomai kernel API), sitting ontop of an
> >> abstracted realtime API ("RTAPI"). Ideally the tracepoints would work
> >> unchanged except for the different context. The manual naturally assumes
> >> an
> >> either-or context. Am I out on a limb here ;-? How would I bring in the
> >> tracepoint definitions in a kernel context - as a separate module maybe or
> >> linked into each using module?
> > 
> > I dont believe that we have examples of code that compile in both kernel
> > and UST contexts. This can certainly be handled with conditional
> > compilation.
> 
> right, I need to wrap my head around the maze of #defines and #includes ;)
> but it looks possible
> 
> > 
> >> - we cannot assume that lttng is available when building machinekit
> >> packages
> >> at least for now, meaning we likely need shim macro definitions and
> >> possibly
> >> fake header files to adjust for the lacking lttng files. Any examples I
> >> can
> >> follow?
> > 
> > MariaDB and others can target different tracers (LTTng, DTrace, none)...
> > Again, I will try to get you good sample code early next week.
> 
> I thought I might not be the first one to do this
> 
> 
> semi-related because I was bitten by it: the Xenomai configs referenced here:
> http://www.xenomai.org/pipermail/xenomai/2013-January/027272.html turn
> CONFIG_FTRACE off, citing performance reasons. I think we'll turn it back on
> in our kernels, cant be that much extra overhead.
> 
> 
> thanks in advance!
> 
> - Michael
> 
> 
> 
> 
