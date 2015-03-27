From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: introduction  & usage of LTTNG in machinekit
Date: Fri, 27 Mar 2015 14:35:42 -0400 (EDT)
Message-ID: <711173584.2718642.1427481342189.JavaMail.zimbra__5449.55678419701$1427481453$gmane$org@polymtl.ca>
References: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1YbZ6d-0004dT-IY
 for lttng-dev@lists.lttng.org; Fri, 27 Mar 2015 14:35:51 -0400
In-Reply-To: <887B7027-5FE6-4D13-B35A-7DCBD785DC57@mah.priv.at>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Haberler <mail17@mah.priv.at>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


> I am involved in machinekit.io, a portable realtime application for motion control
> machinekit runs on several kernels - starting from vanilla (no time
> guarantees), RT-PREEMPT, Xenomai, and RTAI; on x86, amd64 and ARM platforms.

I am actually using LinuxCNC on a small CNC mill and would love to get that running directly on PREEMPT-RT instead of Xenomai (modified Sieg SX3 mill, cncfusion conversion kit, servo motors on X, Y and Z axis, mesa FPGA and H bridge boards for control).

> As some of the processing is highly time sensitive, I'm looking into
> integrating LTTNG into the machinekit build so we have options beyond
> logging and timestamping manually. For instance, currently some
> transcendental math functions on ARM overrun the time budget.
> 
> I've started integrating the build support and am running into my first
> problems. So, that's the context of my following questions - thanks in
> advance for guiding me through any blunders.

This is an excellent application for LTTng. My group has been looking for good use cases of real-time applications. We have a significant expertise with Linux for real-time and PREEMPT-RT. We could easily help you with the machinekit tracing: kernel and user-space instrumentation, specific views and analysis for this application... 
