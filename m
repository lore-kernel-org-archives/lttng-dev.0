From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: lttng-tracer missing
Date: Tue, 17 Feb 2015 13:00:15 -0600
Message-ID: <54E38FBF.2000900__27100.2754140229$1424199701$gmane$org@mentor.com>
References: <8369DAE2C5B8814998E89CE414A915381F6B7AF4@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1YNnNf-0006yb-Io
 for lttng-dev@lists.lttng.org; Tue, 17 Feb 2015 14:00:28 -0500
In-Reply-To: <8369DAE2C5B8814998E89CE414A915381F6B7AF4@IT-Mailbox3.TTPGroup.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Neil Bryan <Neil.Bryan@ttp.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 02/17/2015 11:02 AM, Neil Bryan wrote:
> Following the bitbake build I see these kernel modules in the build
> output directory:
> 
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/lib/lib-ring-buffer.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-ring-buffer-client-overwrite.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-irq.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-lttng.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-block.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-sched.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-types.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-ring-buffer-metadata-mmap-client.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-relay.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/ltt-ring-buffer-metadata-client.ko

I'm guessing you have a rather old version of lttng-modules?  The "ltt-"
prefix was replaced with "lttng-" about three years ago:

commit a90917c3f8c4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sun Jan 22 16:13:41 2012 -0500

    Mass rename: ltt_*/ltt-* to LTTNG_*/LTTNG-*

$ git describe --all  a90917c3f8c4
tags/v2.0-pre11-5-ga90917c3f8c4

Make sure you're not inadvertently using an old unsupported 0.x version
of the modules.
