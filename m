From: Neil Bryan <Neil.Bryan@ttp.com>
Subject: Re: lttng-tracer missing
Date: Thu, 19 Feb 2015 09:02:53 +0000
Message-ID: <8369DAE2C5B8814998E89CE414A915381F6B7DC2__31068.831208586$1424336669$gmane$org@IT-Mailbox3.TTPGroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Neil.Bryan@ttp.com>) id 1YON0z-0001HO-J1
 for lttng-dev@lists.lttng.org; Thu, 19 Feb 2015 04:03:24 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Nathan,

Thank you for the prompt response. I have fixed the kernel tracing problem and indeed your diagnosis was accurate.
I shall post the changes I made to solve the problem so that there is a searchable record for people in a similar position using the Poky component of the Yocto project for the Altera SoCFPGA.

Step 1) Find the recipe responsible for building lttng-modules.

On my installation the recipe can be found here:

~/yocto/meta/recipes-kernel/lttng-2.0

Step 2) Go to the LTTng git repository and look for the tag described by Nathan (v2.0-pre11):

http://git.lttng.org/?p=lttng-modules.git;a=tags

I diff'ed the next tagged commit (v2.0_pre12) and the changes looked minimal so I took a chance that it would work with my kernel/RFS.

Step 3) Examine the changelog (click on tag link) and obtain the commit MD5 checksum, which in this instance is:

497051bdaa2b09c77860eb3be4f93fc4975e388e

Step 4) Within the recipe ~/yocto/meta/recipes-kernel/lttng-2.0/lttng-modules_2.0.5.bb

Change the following lines:

SRCREV = "4d3e89e379fc66480d729abe8daa5c86eb585400"
PV = "2.0.pre11+git${SRCREV}"

To:

SRCREV = "497051bdaa2b09c77860eb3be4f93fc4975e388e"
PV = "2.0.pre12+git${SRCREV}"

The SRCREV is now pointing at the commit checksum and the package revision is now 2.0.pre12.

Step 5) Rebuild the project:

~/yocto/build$ bitbake altera-image

Now I can see the kernel-=tracer.ko module:

~/yocto/build/tmp/work/socfpga_cyclone5-poky-linux-gnueabi/lttng-modules-2.0.pre12+git497051bdaa2b09c77860eb3be4f93fc4975e388e-r0$ find -name *.ko <SNIP> ./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lib/lttng-lib-ring-buffer.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lttng-ring-buffer-metadata-client.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lttng-ring-buffer-client-discard.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lttng-ring-buffer-client-mmap-overwrite.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-irq.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-lttng.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-block.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-probe-sched.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/probes/lttng-types.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lttng-tracer.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lttng-ring-buffer-client-mmap-discard.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lttng-ring-buffer-metadata-mmap-client.ko
./sysroot-destdir/lib/modules/3.7.0/kernel/lttng-modules/lttng-ring-buffer-client-overwrite.ko

Also the names are all lttng-* rather than a couple of ltt-*

Step 6) Recreate the SD card or update the touched components on the SD card (RFS and kernel).

Step 7) Cross fingers, boot and test.

Thanks again and regards,

Neil.

-----Original Message-----
From: Nathan Lynch [mailto:Nathan_Lynch@mentor.com]
Sent: Tuesday, February 17, 2015 7:00 PM
To: Neil Bryan
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] lttng-tracer missing

On 02/17/2015 11:02 AM, Neil Bryan wrote:
> Following the bitbake build I see these kernel modules in the build 
> output directory:
> 
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/li
> b/lib-ring-buffer.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/lt
> t-ring-buffer-client-overwrite.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/pr
> obes/lttng-probe-irq.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/pr
> obes/lttng-probe-lttng.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/pr
> obes/lttng-probe-block.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/pr
> obes/lttng-probe-sched.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/pr
> obes/lttng-types.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/lt
> t-ring-buffer-metadata-mmap-client.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/lt
> t-relay.ko
> ./altera-image-1.0-r0/rootfs/lib/modules/3.7.0/kernel/lttng-modules/lt
> t-ring-buffer-metadata-client.ko

I'm guessing you have a rather old version of lttng-modules?  The "ltt-"
prefix was replaced with "lttng-" about three years ago:

commit a90917c3f8c4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sun Jan 22 16:13:41 2012 -0500

    Mass rename: ltt_*/ltt-* to LTTNG_*/LTTNG-*

$ git describe --all  a90917c3f8c4
tags/v2.0-pre11-5-ga90917c3f8c4

Make sure you're not inadvertently using an old unsupported 0.x version of the modules.
