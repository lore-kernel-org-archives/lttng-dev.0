From: Michael Haberler <mail17@mah.priv.at>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Fri, 27 Mar 2015 19:41:56 +0100
Message-ID: <69E17552-7BEB-4DDF-9060-72717D06676B__10138.9291733087$1427481793$gmane$org@mah.priv.at>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
 <711173584.2718642.1427481342189.JavaMail.zimbra@polymtl.ca>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mah2.mah.priv.at ([86.59.12.251] helo=mah.priv.at)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mail17@mah.priv.at>) id 1YbZCh-0004hH-7d
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 14:42:04 -0400
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
> 
> 
>> I am involved in machinekit.io, a portable realtime application for motion control
>> machinekit runs on several kernels - starting from vanilla (no time
>> guarantees), RT-PREEMPT, Xenomai, and RTAI; on x86, amd64 and ARM platforms.
> 
> I am actually using LinuxCNC on a small CNC mill and would love to get that running directly on PREEMPT-RT instead of Xenomai (modified Sieg SX3 mill, cncfusion conversion kit, servo motors on X, Y and Z axis, mesa FPGA and H bridge boards for control).

machinekit is a fork of LinuxCNC and does all that stock, we've moved well beyond the original project's capabilities. Runs on x86, amd64 and arm7+; the beaglebones are quite popular around here, especially with the 3d printer users.

See http://www.machinekit.io/docs/packages-debian/ for packages, maybe join the mailing list.

> 
>> As some of the processing is highly time sensitive, I'm looking into
>> integrating LTTNG into the machinekit build so we have options beyond
>> logging and timestamping manually. For instance, currently some
>> transcendental math functions on ARM overrun the time budget.
>> 
>> I've started integrating the build support and am running into my first
>> problems. So, that's the context of my following questions - thanks in
>> advance for guiding me through any blunders.
> 
> This is an excellent application for LTTng. My group has been looking for good use cases of real-time applications. We have a significant expertise with Linux for real-time and PREEMPT-RT. We could easily help you with the machinekit tracing: kernel and user-space instrumentation, specific views and analysis for this application... 

Yes, I have the impression this could be a very good match. Thanks! right now I'm climbing the learning curve and integrating basic examples into the machinekit repo so others can follow and explore. No showstoppers so far.

well, my first round of questions is about to hit the list..


thanks! drop me a line if you need help using machinekit.

- Michael
