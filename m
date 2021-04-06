Return-Path: <SRS0=PeGe=JD=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2AC433B4
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 13:11:53 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA10613B7
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Apr 2021 13:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA10613B7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FF7GG52RVz137g;
	Tue,  6 Apr 2021 09:11:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617714711;
	bh=cAfvF9Aaj0awjyqE6ApzE4sYRyAMEZJXPnMj3wEg6Lk=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vOKXLlM9C6Ald/Uv2UzWUDOZuE2gXJGGf1Vy/sTAEL2LCSXH8zUjrx/73HovX2XrE
	 lBjR9sIh/x2QPZJtjIG3bfc3uIALbEjZ8f5PtMWfMeCUZGB8/U9U3NHgbbc6sdm9WZ
	 ebqbOD8pzy3QmJcre/FXl0BOB5TdckK0Bq2G6pujkHgUloXTQyFtqukn3QQ22FPC5g
	 CLOqzXikFeMB6bg3p0kCaptxHtXo8KQYsn2yc7T2UnmIurn0s58TqXNAQsPBmSy1Mc
	 LDAuw9v7RVbASpCzuATqYaVa9ht6VpSm6qXrB6YD/d02KJFDGAHnasYLUSg96o3RRq
	 SwecIAwfAe2Jg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FF7GF4124z135J
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 09:11:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0027431AAAA
 for <lttng-dev@lists.lttng.org>; Tue,  6 Apr 2021 09:11:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 71K8jCMNik0Q; Tue,  6 Apr 2021 09:11:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7CB7C31AAA8;
 Tue,  6 Apr 2021 09:11:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7CB7C31AAA8
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 2EDVCX2oHmbc; Tue,  6 Apr 2021 09:11:40 -0400 (EDT)
Received: from joraj-alpa (unknown [107.159.43.215])
 by mail.efficios.com (Postfix) with ESMTPSA id 2679131AB2E;
 Tue,  6 Apr 2021 09:11:40 -0400 (EDT)
Date: Tue, 6 Apr 2021 09:11:39 -0400
To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <20210406131139.GC79283@joraj-alpa>
References: <mailman.1.1617379201.29396.lttng-dev@lists.lttng.org>
 <CAFGSPryoOne68L4APnOvEgmw=q3WcgVujY1RYbEiO0FwqJnDyw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFGSPryoOne68L4APnOvEgmw=q3WcgVujY1RYbEiO0FwqJnDyw@mail.gmail.com>
Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 3
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jonathan Rajotte-Julien via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

I think you need to take a step back and figure out how lttng is deployed and more
importantly the overall architecture of lttng and its principal moving pieces.

First, you need a functioning and running lttng-sessiond process.

From lttng-console-log.txt:

   root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#  lttng list -u
   Error: Unable to list UST events: No session daemon is available

The error is clear here, no lttng-sessiond is running or at least, the lttng CLI
cannot communicate with it.

Here the sessiond was killed before performing this operation based on
CmdSequence.txt. You seem to have forgot to start a lttng-sessiond before
performing the call to your application and `lttng` commands.

My previous email stated the following:
  With the app running and having the LD_PRELOAD correctly set, and a sessiond
  (sessiond should have read lttng-sessiond) running.

Then, if we look at kernel modules loading.

From lttng-sessiond.txt:

DEBUG1 - 19:50:34.293777619 [27093/27093]: libkmod: could not find module by name='lttng_ring_buffer_client_discard'
 (in log_kmod() at modprobe.c:108)
Error: Unable to load required module lttng-ring-buffer-client-discard
Warning: No kernel tracer available

libkmod expect the presence of lttng-modules kernel modules in: /lib/modules/$(uname -r)/

From lttng-system-env.txt:

  root@RocrLnx23:~# find /lib/modules/$(uname -r)/ | grep lttng

Yield nothing. I suspect that your modules are installed under:

  ~/git/compute/out/ubuntu-18.04/18.04/lib/modules/$(uname -r)/

Now, currently, lttng-sessiond when built with kmod support does not support
defining the modules locations (as far as I know) since we pass (NULL, NULL)
to the creation context (kmod_new). The default behaviour is to look into
/lib/modules/.... .

Albeit it would be nice to support such scenarios, this will not help you in the
short term. I would recommend the usage of symbolic link here to provide "/lib/modules/$(uname -r)/".

Note that this is overly complicated by the deployment scenario you are
currently using, which does not represent a typical deployment for most of our
users.

In any cases, again, this is only useful if you plan on doing kernel tracing. 

I would suggest that you might want to put effort in making sure Userspace
Tracing works.

Here I think the only thing missing is to have a running lttng-sessiond process
while you launch  ./rocminfo

Concretely:
    $ sudo -s
    # systemctl stop lttng-sessiond.service
    # pkill lttng-sessiond
    # cd ~/git/compute/out/ubuntu-18.04/18.04/lib
    # export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH
    # lttng-sessiond -vvv --verbose-consumer -b > /tmp/lttng-sessiond.log 2>&1
    # lttng create my_userspace_tracing_session
    # lttng enable-event -u -a
    # lttng start
    # LD_PRELOAD=liblttng-ust-cyg-profile-fast.so  LTTNG_UST_DEBUG=1     ./rocminfo
    # lttng destroy
    # babeltrace <the path trace as displayed after lttng create>
    # pkill lttng-sessiond


Note: here the manual starting and termination of lttng-sessiond is only for the
purpose of testing. In a normal deployment lttng-sessiond is a daemon.

Note that the sequence of `lttng` commands is important here since I expect
./rocminfo to not have a long lifetime. In other word, the `rocminfo` will have
finished and unregistered from lttng-sessiond perspective before you are able to
manually either list its tracepoints or setup a tracing session after you started
the application.

Please read the following and try to perform it under your deployment scenario:

https://lttng.org/docs/v2.12/#doc-tracing-your-own-user-application


Hope this helps.

Cheers


On Mon, Apr 05, 2021 at 08:32:00PM -0500, Ramesh Errabolu via lttng-dev wrote:
> Jonathan, et al
> 
> Attaching here with logs of the run.
> 
> 1. Command sequence I ran
> 2. Console log of commands as I ran them
> 3. Log of lttng-service daemon *lttng-sessiond.txt*
> 4. Info about the system, things such as kernel, lttng kernel modules, etc
> 5. Lastly I tried to build lttng-modules for my kernel 5.9.x. This failed
> as lacking support for it.
> 
> Any help info is appreciated.
> 
> Regards,
> Ramesh
> 
> 
> On Fri, Apr 2, 2021 at 11:00 AM <lttng-dev-request@lists.lttng.org> wrote:
> 
> > Send lttng-dev mailing list submissions to
> >         lttng-dev@lists.lttng.org
> >
> > To subscribe or unsubscribe via the World Wide Web, visit
> >         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > or, via email, send a message with subject or body 'help' to
> >         lttng-dev-request@lists.lttng.org
> >
> > You can reach the person managing the list at
> >         lttng-dev-owner@lists.lttng.org
> >
> > When replying, please edit your Subject line so it is more specific
> > than "Re: Contents of lttng-dev digest..."
> >
> >
> > Today's Topics:
> >
> >    1. Re: Can't trace function calls (Jonathan Rajotte-Julien)
> >
> >
> > ----------------------------------------------------------------------
> >
> > Message: 1
> > Date: Fri, 2 Apr 2021 11:07:19 -0400
> > From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> > To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
> > Cc: lttng-dev@lists.lttng.org
> > Subject: Re: [lttng-dev] Can't trace function calls
> > Message-ID: <20210402150719.GB79283@joraj-alpa>
> > Content-Type: text/plain; charset=us-ascii
> >
> > On Wed, Mar 31, 2021 at 12:55:53PM -0500, Ramesh Errabolu wrote:
> > > root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ls ~/ | grep
> > -i ltt
> > > root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# lttng create
> > > my-kernel-session --output=~/my-kernel-trace
> > > Session my-kernel-session created.
> > > Traces will be output to
> > > /home/user1/git/compute/out/ubuntu-18.04/18.04/bin/~/my-kernel-trace
> > > root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# *lttng list
> > > --kerne*l
> > > *Error: Unable to list kernel events: Kernel tracer not available*
> >
> > Well this would be the first thing to look at.
> >
> > First let's deactivate the lttng-sessiond.service installed by the
> > packages.
> >
> >    systemctl stop lttng-sessiond.service
> >
> > You might want to reanable it later.
> >
> > >
> > > root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ps -ef | grep
> > ltt
> > > root      1002     1  0 12:16 ?        00:00:00 /usr/bin/lttng-sessiond
> > > root      1054  1002  0 12:16 ?        00:00:00 */usr/bin/lttng-sessiond*
> > > root      3145  2861  0 12:51 pts/0    00:00:00 grep --color=auto ltt
> > > root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> >
> > Make sure after the systemctl call that no lttng-sessiond process is
> > running.
> >
> > Now let's launch a lttng-sessiond by hand with a bit more verbosity. For
> > now
> > let's stick to the root user.
> >
> >   # lttng-sessiond -vvv --verbose-consumer -b > /tmp/lttng-sessiond.log
> > 2>&1
> >   # pkill lttng-sessiond
> >
> > Please share the content of /tmp/lttng-sessiond.log using a pasting service
> > (paste.ubuntu.com).
> >
> > Also please provide the output of:
> >
> >  # uname -a
> >  # find /lib/modules/$(uname -r)/ | grep lttng
> >  # dmesg | grep lttng
> >
> >
> > But again, the cyg-profile helper library is meant for Userspace tracing.
> >
> > With the app running and having the LD_PRELOAD correctly set, and a
> > sessiond
> > running.
> >
> >  # lttng list -u
> >
> > If there is nothing, well you can start the application with the following
> > and
> > share the output of it (make sure to remove any output from your
> > application if
> > sensitive data is present)
> >
> >  # LD_PRELOAD=.... LTTNG_UST_DEBUG=1 your_application_here
> >
> > Note that debug log will be outputted on stderr.
> >
> > Cheers
> >
> > --
> > Jonathan Rajotte-Julien
> > EfficiOS
> >
> >
> > ------------------------------
> >
> > Subject: Digest Footer
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> > ------------------------------
> >
> > End of lttng-dev Digest, Vol 156, Issue 3
> > *****************************************
> >

> 
> $ sudo -s
> #
> # systemctl stop lttng-sessiond.service
> # ps -ef | grep -i lttng
> # lttng-sessiond -vvv --verbose-consumer -b > /tmp/lttng-sessiond.log 2>&1
> # pkill lttng-sessiond
> # uname -a
> # find /lib/modules/$(uname -r)/ | grep lttng
> # dmesg | grep lttng
> #
> # cd ~/git/compute/out/ubuntu-18.04/18.04/lib
> # export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH
> # echo $LD_LIBRARY_PATH
> #
> # cd ../bin
> # LD_PRELOAD=liblttng-ust-cyg-profile-fast.so  ./rocminfo
> # lttng list -u
> #
> #  LD_PRELOAD=liblttng-ust-cyg-profile-fast.so  LTTNG_UST_DEBUG=1     ./rocminfo
> #
> #
> #
> #
> 
> 
> 
> 

> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/lib#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/lib# export LD_LIBRARY_PATH=`pwd`:$LD_LIBRARY_PATH
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/lib#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/lib# echo $LD_LIBRARY_PATH
> /home/user1/git/compute/out/ubuntu-18.04/18.04/lib:
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/lib#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/lib# cd ../bin
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# LD_PRELOAD=liblttng-ust-cyg-profile-fast.so  ./rocminfo
> ROCk module is loaded
> =====================
> HSA System Attributes
> =====================
> Runtime Version:         1.1
> System Timestamp Freq.:  1000.000000MHz
> Sig. Max Wait Duration:  18446744073709551615 (0xFFFFFFFFFFFFFFFF) (timestamp count)
> Machine Model:           LARGE
> System Endianness:       LITTLE
> 
> ==========
> HSA Agents
> ==========
> *******
> Agent 1
> *******
>   Name:                    Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
>   Uuid:                    CPU-XX
>   Marketing Name:          Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
>   Vendor Name:             CPU
>   Feature:                 None specified
>   Profile:                 FULL_PROFILE
>   Float Round Mode:        NEAR
>   Max Queue Number:        0(0x0)
>   Queue Min Size:          0(0x0)
>   Queue Max Size:          0(0x0)
>   Queue Type:              MULTI
>   Node:                    0
>   Device Type:             CPU
>   Cache Info:
>     L1:                      32768(0x8000) KB
>   Chip ID:                 0(0x0)
>   Cacheline Size:          64(0x40)
>   Max Clock Freq. (MHz):   4000
>   BDFID:                   0
>   Internal Node ID:        0
>   Compute Unit:            8
>   SIMDs per CU:            0
>   Shader Engines:          0
>   Shader Arrs. per Eng.:   0
>   WatchPts on Addr. Ranges:1
>   Features:                None
>   Pool Info:
>     Pool 1
>       Segment:                 GLOBAL; FLAGS: KERNARG, FINE GRAINED
>       Size:                    32551856(0x1f0b3b0) KB
>       Allocatable:             TRUE
>       Alloc Granule:           4KB
>       Alloc Alignment:         4KB
>       Accessible by all:       TRUE
>     Pool 2
>       Segment:                 GLOBAL; FLAGS: COARSE GRAINED
>       Size:                    32551856(0x1f0b3b0) KB
>       Allocatable:             TRUE
>       Alloc Granule:           4KB
>       Alloc Alignment:         4KB
>       Accessible by all:       TRUE
>   ISA Info:
>     N/A
> *******
> Agent 2
> *******
>   Name:                    gfx900
>   Uuid:                    GPU-0213f0fe991a3144
>   Marketing Name:          Vega 10 XL/XT [Radeon RX Vega 56/64]
>   Vendor Name:             AMD
>   Feature:                 KERNEL_DISPATCH
>   Profile:                 BASE_PROFILE
>   Float Round Mode:        NEAR
>   Max Queue Number:        128(0x80)
>   Queue Min Size:          4096(0x1000)
>   Queue Max Size:          131072(0x20000)
>   Queue Type:              MULTI
>   Node:                    1
>   Device Type:             GPU
>   Cache Info:
>     L1:                      16(0x10) KB
>   Chip ID:                 26751(0x687f)
>   Cacheline Size:          64(0x40)
>   Max Clock Freq. (MHz):   1630
>   BDFID:                   768
>   Internal Node ID:        1
>   Compute Unit:            64
>   SIMDs per CU:            4
>   Shader Engines:          4
>   Shader Arrs. per Eng.:   1
>   WatchPts on Addr. Ranges:4
>   Features:                KERNEL_DISPATCH
>   Fast F16 Operation:      FALSE
>   Wavefront Size:          64(0x40)
>   Workgroup Max Size:      1024(0x400)
>   Workgroup Max Size per Dimension:
>     x                        1024(0x400)
>     y                        1024(0x400)
>     z                        1024(0x400)
>   Max Waves Per CU:        40(0x28)
>   Max Work-item Per CU:    2560(0xa00)
>   Grid Max Size:           4294967295(0xffffffff)
>   Grid Max Size per Dimension:
>     x                        4294967295(0xffffffff)
>     y                        4294967295(0xffffffff)
>     z                        4294967295(0xffffffff)
>   Max fbarriers/Workgrp:   32
>   Pool Info:
>     Pool 1
>       Segment:                 GLOBAL; FLAGS: COARSE GRAINED
>       Size:                    8372224(0x7fc000) KB
>       Allocatable:             TRUE
>       Alloc Granule:           4KB
>       Alloc Alignment:         4KB
>       Accessible by all:       FALSE
>     Pool 2
>       Segment:                 GROUP
>       Size:                    64(0x40) KB
>       Allocatable:             FALSE
>       Alloc Granule:           0KB
>       Alloc Alignment:         0KB
>       Accessible by all:       FALSE
>   ISA Info:
>     ISA 1
>       Name:                    amdgcn-amd-amdhsa--gfx900:xnack-
>       Machine Models:          HSA_MACHINE_MODEL_LARGE
>       Profiles:                HSA_PROFILE_BASE
>       Default Rounding Mode:   NEAR
>       Default Rounding Mode:   NEAR
>       Fast f16:                TRUE
>       Workgroup Max Size:      1024(0x400)
>       Workgroup Max Size per Dimension:
>         x                        1024(0x400)
>         y                        1024(0x400)
>         z                        1024(0x400)
>       Grid Max Size:           4294967295(0xffffffff)
>       Grid Max Size per Dimension:
>         x                        4294967295(0xffffffff)
>         y                        4294967295(0xffffffff)
>         z                        4294967295(0xffffffff)
>       FBarrier Max Size:       32
> *** Done ***
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ldd ./rocminfo
>   linux-vdso.so.1 (0x00007ffec4ba4000)
>   libhsa-runtime64.so.1 => /home/user1/git/compute/out/ubuntu-18.04/18.04/lib/libhsa-runtime64.so.1 (0x00007f996e6df000)
>   libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f996e356000)
>   libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f996e13e000)
>   libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f996dd4d000)
>   libhsakmt.so.1 => /home/user1/git/compute/out/ubuntu-18.04/18.04/lib/libhsakmt.so.1 (0x00007f996db16000)
>   libelf.so.1 => /usr/lib/x86_64-linux-gnu/libelf.so.1 (0x00007f996d8fc000)
>   libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f996d6f8000)
>   libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f996d4d9000)
>   librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f996d2d1000)
>   libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f996cf33000)
>   /lib64/ld-linux-x86-64.so.2 (0x00007f996eef0000)
>   libnuma.so.1 => /usr/lib/x86_64-linux-gnu/libnuma.so.1 (0x00007f996cd28000)
>   libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f996cb0b000)
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#  lttng list -u
> Error: Unable to list UST events: No session daemon is available
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# ldd ./rocminfo
>   linux-vdso.so.1 (0x00007ffec4ba4000)
>   libhsa-runtime64.so.1 => /home/user1/git/compute/out/ubuntu-18.04/18.04/lib/libhsa-runtime64.so.1 (0x00007f996e6df000)
>   libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f996e356000)
>   libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f996e13e000)
>   libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f996dd4d000)
>   libhsakmt.so.1 => /home/user1/git/compute/out/ubuntu-18.04/18.04/lib/libhsakmt.so.1 (0x00007f996db16000)
>   libelf.so.1 => /usr/lib/x86_64-linux-gnu/libelf.so.1 (0x00007f996d8fc000)
>   libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f996d6f8000)
>   libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f996d4d9000)
>   librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f996d2d1000)
>   libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f996cf33000)
>   /lib64/ld-linux-x86-64.so.2 (0x00007f996eef0000)
>   libnuma.so.1 => /usr/lib/x86_64-linux-gnu/libnuma.so.1 (0x00007f996cd28000)
>   libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f996cb0b000)
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#  lttng list -u
> Error: Unable to list UST events: No session daemon is available
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin# LD_PRELOAD=liblttng-ust-cyg-profile-fast.so  LTTNG_UST_DEBUG=1     ./rocminfo
> liblttng_ust_tracepoint[27270/27270]: Your compiler treats weak symbols with hidden visibility for integer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:957)
> liblttng_ust_tracepoint[27270/27270]: Your compiler treats weak symbols with hidden visibility for pointer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:961)
> liblttng_ust_tracepoint[27270/27270]: Your compiler treats weak symbols with hidden visibility for 24-byte structure objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:965)
> liblttng_ust_tracepoint[27270/27270]: just registered a tracepoints section from 0x7fd9399e98a0 and having 26 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_statedump:end (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_statedump:procname (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_statedump:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_statedump:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_statedump:bin_info (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_statedump:start (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_lib:unload (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_lib:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_lib:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_lib:load (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_LINE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_UNIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_MODULE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROCESS (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_INFO (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_NOTICE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_WARNING (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_ERR (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_CRIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_ALERT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_tracelog:TRACE_EMERG (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27270/27270]: Provider "lttng_ust_statedump" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27270/27270]: adding probe lttng_ust_statedump containing 6 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>  (in lttng_ring_buffer_metadata_client_init() at lttng-ring-buffer-metadata-client.h:351)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
>  (in lttng_ring_buffer_client_overwrite_init() at lttng-ring-buffer-client.h:867)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap" init
>  (in lttng_ring_buffer_client_overwrite_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-discard-mmap" init
>  (in lttng_ring_buffer_client_discard_init() at lttng-ring-buffer-client.h:867)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
>  (in lttng_ring_buffer_client_discard_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27270/27271]: Info: sessiond not accepting connections to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27270/27271]: Waiting for global apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27270/27272]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27270/27272]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27270/27270]: Provider "lttng_ust_lib" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27270/27270]: adding probe lttng_ust_lib containing 4 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27270/27270]: Provider "lttng_ust_tracef" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27270/27270]: adding probe lttng_ust_tracef containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27270/27270]: Provider "lttng_ust_tracelog" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27270/27270]: adding probe lttng_ust_tracelog containing 15 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> liblttng_ust_tracepoint[27270/27270]: just registered a tracepoints section from 0x7fd93ab89098 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_cyg_profile_fast:func_exit (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27270/27270]: registered tracepoint: lttng_ust_cyg_profile_fast:func_entry (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27270/27270]: Provider "lttng_ust_cyg_profile_fast" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27270/27270]: adding probe lttng_ust_cyg_profile_fast containing 2 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> liblttng_ust_tracepoint[27273/27273]: Your compiler treats weak symbols with hidden visibility for integer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:957)
> liblttng_ust_tracepoint[27273/27273]: Your compiler treats weak symbols with hidden visibility for pointer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:961)
> liblttng_ust_tracepoint[27273/27273]: Your compiler treats weak symbols with hidden visibility for 24-byte structure objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:965)
> liblttng_ust_tracepoint[27273/27273]: just registered a tracepoints section from 0x7f298724b8a0 and having 26 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_statedump:end (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_statedump:procname (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_statedump:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_statedump:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_statedump:bin_info (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_statedump:start (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_lib:unload (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_lib:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_lib:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_lib:load (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_LINE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_UNIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_MODULE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROCESS (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_INFO (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_NOTICE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_WARNING (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_ERR (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_CRIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_ALERT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_tracelog:TRACE_EMERG (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27273/27273]: Provider "lttng_ust_statedump" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27273/27273]: adding probe lttng_ust_statedump containing 6 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27273/27273]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>  (in lttng_ring_buffer_metadata_client_init() at lttng-ring-buffer-metadata-client.h:351)
> libust[27273/27273]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
>  (in lttng_ring_buffer_client_overwrite_init() at lttng-ring-buffer-client.h:867)
> libust[27273/27273]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap" init
>  (in lttng_ring_buffer_client_overwrite_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27273/27273]: LTT : ltt ring buffer client "relay-discard-mmap" init
>  (in lttng_ring_buffer_client_discard_init() at lttng-ring-buffer-client.h:867)
> libust[27273/27273]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
>  (in lttng_ring_buffer_client_discard_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27273/27274]: Info: sessiond not accepting connections to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27273/27274]: Waiting for global apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27273/27275]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27273/27275]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27273/27273]: Provider "lttng_ust_lib" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27273/27273]: adding probe lttng_ust_lib containing 4 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27273/27273]: Provider "lttng_ust_tracef" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27273/27273]: adding probe lttng_ust_tracef containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27273/27273]: Provider "lttng_ust_tracelog" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27273/27273]: adding probe lttng_ust_tracelog containing 15 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> liblttng_ust_tracepoint[27273/27273]: just registered a tracepoints section from 0x7f2987849098 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_cyg_profile_fast:func_exit (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27273/27273]: registered tracepoint: lttng_ust_cyg_profile_fast:func_entry (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27273/27273]: Provider "lttng_ust_cyg_profile_fast" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27273/27273]: adding probe lttng_ust_cyg_profile_fast containing 2 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> liblttng_ust_tracepoint[27276/27276]: Your compiler treats weak symbols with hidden visibility for integer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:957)
> liblttng_ust_tracepoint[27276/27276]: Your compiler treats weak symbols with hidden visibility for pointer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:961)
> liblttng_ust_tracepoint[27276/27276]: Your compiler treats weak symbols with hidden visibility for 24-byte structure objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:965)
> liblttng_ust_tracepoint[27276/27276]: just registered a tracepoints section from 0x7f5b0154b8a0 and having 26 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_statedump:end (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_statedump:procname (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_statedump:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_statedump:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_statedump:bin_info (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_statedump:start (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_lib:unload (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_lib:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_lib:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_lib:load (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_LINE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_UNIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_MODULE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROCESS (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_INFO (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_NOTICE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_WARNING (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_ERR (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_CRIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_ALERT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_tracelog:TRACE_EMERG (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27276/27276]: Provider "lttng_ust_statedump" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27276/27276]: adding probe lttng_ust_statedump containing 6 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>  (in lttng_ring_buffer_metadata_client_init() at lttng-ring-buffer-metadata-client.h:351)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
>  (in lttng_ring_buffer_client_overwrite_init() at lttng-ring-buffer-client.h:867)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap" init
>  (in lttng_ring_buffer_client_overwrite_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-discard-mmap" init
>  (in lttng_ring_buffer_client_discard_init() at lttng-ring-buffer-client.h:867)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
>  (in lttng_ring_buffer_client_discard_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27276/27278]: Info: sessiond not accepting connections to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27276/27278]: Waiting for global apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27276/27279]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27276/27279]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27276/27276]: Provider "lttng_ust_lib" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27276/27276]: adding probe lttng_ust_lib containing 4 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27276/27276]: Provider "lttng_ust_tracef" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27276/27276]: adding probe lttng_ust_tracef containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27276/27276]: Provider "lttng_ust_tracelog" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27276/27276]: adding probe lttng_ust_tracelog containing 15 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> liblttng_ust_tracepoint[27276/27276]: just registered a tracepoints section from 0x7f5b01b49098 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_cyg_profile_fast:func_exit (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27276/27276]: registered tracepoint: lttng_ust_cyg_profile_fast:func_entry (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27276/27276]: Provider "lttng_ust_cyg_profile_fast" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27276/27276]: adding probe lttng_ust_cyg_profile_fast containing 2 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27276/27276]: Provider "lttng_ust_cyg_profile_fast" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27276/27276]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27276/27276]: just unregistered probes of provider lttng_ust_cyg_profile_fast (in lttng_probe_unregister() at lttng-probes.c:231)
> liblttng_ust_tracepoint[27276/27276]: just unregistered a tracepoints section from 0x7f5b01b49098 (in tracepoint_unregister_lib() at tracepoint.c:938)
> libust[27276/27276]: Provider "lttng_ust_tracelog" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27276/27276]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27276/27276]: just unregistered probes of provider lttng_ust_tracelog (in lttng_probe_unregister() at lttng-probes.c:231)
> libust[27276/27276]: Provider "lttng_ust_tracef" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27276/27276]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27276/27276]: just unregistered probes of provider lttng_ust_tracef (in lttng_probe_unregister() at lttng-probes.c:231)
> libust[27276/27276]: Provider "lttng_ust_lib" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27276/27276]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27276/27276]: just unregistered probes of provider lttng_ust_lib (in lttng_probe_unregister() at lttng-probes.c:231)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-discard-rt-mmap" exit
>  (in lttng_ring_buffer_client_discard_rt_exit() at lttng-ring-buffer-client.h:874)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-discard-mmap" exit
>  (in lttng_ring_buffer_client_discard_exit() at lttng-ring-buffer-client.h:874)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap" exit
>  (in lttng_ring_buffer_client_overwrite_rt_exit() at lttng-ring-buffer-client.h:874)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-overwrite-mmap" exit
>  (in lttng_ring_buffer_client_overwrite_exit() at lttng-ring-buffer-client.h:874)
> libust[27276/27276]: LTT : ltt ring buffer client "relay-metadata-mmap" exit
>  (in lttng_ring_buffer_metadata_client_exit() at lttng-ring-buffer-metadata-client.h:358)
> libust[27276/27276]: Provider "lttng_ust_statedump" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27276/27276]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27276/27276]: just unregistered probes of provider lttng_ust_statedump (in lttng_probe_unregister() at lttng-probes.c:231)
> liblttng_ust_tracepoint[27276/27276]: just unregistered a tracepoints section from 0x7f5b0154b8a0 (in tracepoint_unregister_lib() at tracepoint.c:938)
> liblttng_ust_tracepoint[27277/27277]: Your compiler treats weak symbols with hidden visibility for integer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:957)
> liblttng_ust_tracepoint[27277/27277]: Your compiler treats weak symbols with hidden visibility for pointer objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:961)
> liblttng_ust_tracepoint[27277/27277]: Your compiler treats weak symbols with hidden visibility for 24-byte structure objects as SAME address between compile units part of the same module. (in check_weak_hidden() at tracepoint.c:965)
> liblttng_ust_tracepoint[27277/27277]: just registered a tracepoints section from 0x7f3e7e2fb8a0 and having 26 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_statedump:end (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_statedump:procname (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_statedump:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_statedump:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_statedump:bin_info (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_statedump:start (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_lib:unload (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_lib:debug_link (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_lib:build_id (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_lib:load (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_LINE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_FUNCTION (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_UNIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_MODULE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROCESS (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_PROGRAM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_DEBUG_SYSTEM (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_INFO (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_NOTICE (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_WARNING (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_ERR (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_CRIT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_ALERT (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_tracelog:TRACE_EMERG (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27277/27277]: Provider "lttng_ust_statedump" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27277/27277]: adding probe lttng_ust_statedump containing 6 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27277/27277]: LTT : ltt ring buffer client "relay-metadata-mmap" init
>  (in lttng_ring_buffer_metadata_client_init() at lttng-ring-buffer-metadata-client.h:351)
> libust[27277/27277]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
>  (in lttng_ring_buffer_client_overwrite_init() at lttng-ring-buffer-client.h:867)
> libust[27277/27277]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap" init
>  (in lttng_ring_buffer_client_overwrite_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27277/27277]: LTT : ltt ring buffer client "relay-discard-mmap" init
>  (in lttng_ring_buffer_client_discard_init() at lttng-ring-buffer-client.h:867)
> libust[27277/27277]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
>  (in lttng_ring_buffer_client_discard_rt_init() at lttng-ring-buffer-client.h:867)
> libust[27277/27280]: Info: sessiond not accepting connections to global apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27277/27280]: Waiting for global apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27277/27281]: Info: sessiond not accepting connections to local apps socket (in ust_listener_thread() at lttng-ust-comm.c:1546)
> libust[27277/27281]: Waiting for local apps sessiond (in wait_for_sessiond() at lttng-ust-comm.c:1427)
> libust[27277/27277]: Provider "lttng_ust_lib" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27277/27277]: adding probe lttng_ust_lib containing 4 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27277/27277]: Provider "lttng_ust_tracef" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27277/27277]: adding probe lttng_ust_tracef containing 1 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> libust[27277/27277]: Provider "lttng_ust_tracelog" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27277/27277]: adding probe lttng_ust_tracelog containing 15 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> liblttng_ust_tracepoint[27277/27277]: just registered a tracepoints section from 0x7f3e7ed6f098 and having 2 tracepoints (in tracepoint_register_lib() at tracepoint.c:908)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_cyg_profile_fast:func_exit (in tracepoint_register_lib() at tracepoint.c:913)
> liblttng_ust_tracepoint[27277/27277]: registered tracepoint: lttng_ust_cyg_profile_fast:func_entry (in tracepoint_register_lib() at tracepoint.c:913)
> libust[27277/27277]: Provider "lttng_ust_cyg_profile_fast" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> libust[27277/27277]: adding probe lttng_ust_cyg_profile_fast containing 2 events to lazy registration list (in lttng_probe_register() at lttng-probes.c:198)
> ROCk module is loaded
> =====================
> HSA System Attributes
> =====================
> Runtime Version:         1.1
> System Timestamp Freq.:  1000.000000MHz
> Sig. Max Wait Duration:  18446744073709551615 (0xFFFFFFFFFFFFFFFF) (timestamp count)
> Machine Model:           LARGE
> System Endianness:       LITTLE
> 
> ==========
> HSA Agents
> ==========
> *******
> Agent 1
> *******
>   Name:                    Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
>   Uuid:                    CPU-XX
>   Marketing Name:          Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
>   Vendor Name:             CPU
>   Feature:                 None specified
>   Profile:                 FULL_PROFILE
>   Float Round Mode:        NEAR
>   Max Queue Number:        0(0x0)
>   Queue Min Size:          0(0x0)
>   Queue Max Size:          0(0x0)
>   Queue Type:              MULTI
>   Node:                    0
>   Device Type:             CPU
>   Cache Info:
>     L1:                      32768(0x8000) KB
>   Chip ID:                 0(0x0)
>   Cacheline Size:          64(0x40)
>   Max Clock Freq. (MHz):   4000
>   BDFID:                   0
>   Internal Node ID:        0
>   Compute Unit:            8
>   SIMDs per CU:            0
>   Shader Engines:          0
>   Shader Arrs. per Eng.:   0
>   WatchPts on Addr. Ranges:1
>   Features:                None
>   Pool Info:
>     Pool 1
>       Segment:                 GLOBAL; FLAGS: KERNARG, FINE GRAINED
>       Size:                    32551856(0x1f0b3b0) KB
>       Allocatable:             TRUE
>       Alloc Granule:           4KB
>       Alloc Alignment:         4KB
>       Accessible by all:       TRUE
>     Pool 2
>       Segment:                 GLOBAL; FLAGS: COARSE GRAINED
>       Size:                    32551856(0x1f0b3b0) KB
>       Allocatable:             TRUE
>       Alloc Granule:           4KB
>       Alloc Alignment:         4KB
>       Accessible by all:       TRUE
>   ISA Info:
>     N/A
> *******
> Agent 2
> *******
>   Name:                    gfx900
>   Uuid:                    GPU-0213f0fe991a3144
>   Marketing Name:          Vega 10 XL/XT [Radeon RX Vega 56/64]
>   Vendor Name:             AMD
>   Feature:                 KERNEL_DISPATCH
>   Profile:                 BASE_PROFILE
>   Float Round Mode:        NEAR
>   Max Queue Number:        128(0x80)
>   Queue Min Size:          4096(0x1000)
>   Queue Max Size:          131072(0x20000)
>   Queue Type:              MULTI
>   Node:                    1
>   Device Type:             GPU
>   Cache Info:
>     L1:                      16(0x10) KB
>   Chip ID:                 26751(0x687f)
>   Cacheline Size:          64(0x40)
>   Max Clock Freq. (MHz):   1630
>   BDFID:                   768
>   Internal Node ID:        1
>   Compute Unit:            64
>   SIMDs per CU:            4
>   Shader Engines:          4
>   Shader Arrs. per Eng.:   1
>   WatchPts on Addr. Ranges:4
>   Features:                KERNEL_DISPATCH
>   Fast F16 Operation:      FALSE
>   Wavefront Size:          64(0x40)
>   Workgroup Max Size:      1024(0x400)
>   Workgroup Max Size per Dimension:
>     x                        1024(0x400)
>     y                        1024(0x400)
>     z                        1024(0x400)
>   Max Waves Per CU:        40(0x28)
>   Max Work-item Per CU:    2560(0xa00)
>   Grid Max Size:           4294967295(0xffffffff)
>   Grid Max Size per Dimension:
>     x                        4294967295(0xffffffff)
>     y                        4294967295(0xffffffff)
>     z                        4294967295(0xffffffff)
>   Max fbarriers/Workgrp:   32
>   Pool Info:
>     Pool 1
>       Segment:                 GLOBAL; FLAGS: COARSE GRAINED
>       Size:                    8372224(0x7fc000) KB
>       Allocatable:             TRUE
>       Alloc Granule:           4KB
>       Alloc Alignment:         4KB
>       Accessible by all:       FALSE
>     Pool 2
>       Segment:                 GROUP
>       Size:                    64(0x40) KB
>       Allocatable:             FALSE
>       Alloc Granule:           0KB
>       Alloc Alignment:         0KB
>       Accessible by all:       FALSE
>   ISA Info:
>     ISA 1
>       Name:                    amdgcn-amd-amdhsa--gfx900:xnack-
>       Machine Models:          HSA_MACHINE_MODEL_LARGE
>       Profiles:                HSA_PROFILE_BASE
>       Default Rounding Mode:   NEAR
>       Default Rounding Mode:   NEAR
>       Fast f16:                TRUE
>       Workgroup Max Size:      1024(0x400)
>       Workgroup Max Size per Dimension:
>         x                        1024(0x400)
>         y                        1024(0x400)
>         z                        1024(0x400)
>       Grid Max Size:           4294967295(0xffffffff)
>       Grid Max Size per Dimension:
>         x                        4294967295(0xffffffff)
>         y                        4294967295(0xffffffff)
>         z                        4294967295(0xffffffff)
>       FBarrier Max Size:       32
> *** Done ***
> libust[27270/27270]: Provider "lttng_ust_cyg_profile_fast" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27270/27270]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27270/27270]: just unregistered probes of provider lttng_ust_cyg_profile_fast (in lttng_probe_unregister() at lttng-probes.c:231)
> liblttng_ust_tracepoint[27270/27270]: just unregistered a tracepoints section from 0x7fd93ab89098 (in tracepoint_unregister_lib() at tracepoint.c:938)
> libust[27270/27270]: Provider "lttng_ust_tracelog" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27270/27270]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27270/27270]: just unregistered probes of provider lttng_ust_tracelog (in lttng_probe_unregister() at lttng-probes.c:231)
> libust[27270/27270]: Provider "lttng_ust_tracef" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27270/27270]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27270/27270]: just unregistered probes of provider lttng_ust_tracef (in lttng_probe_unregister() at lttng-probes.c:231)
> libust[27270/27270]: Provider "lttng_ust_lib" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27270/27270]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27270/27270]: just unregistered probes of provider lttng_ust_lib (in lttng_probe_unregister() at lttng-probes.c:231)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-discard-rt-mmap" exit
>  (in lttng_ring_buffer_client_discard_rt_exit() at lttng-ring-buffer-client.h:874)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-discard-mmap" exit
>  (in lttng_ring_buffer_client_discard_exit() at lttng-ring-buffer-client.h:874)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap" exit
>  (in lttng_ring_buffer_client_overwrite_rt_exit() at lttng-ring-buffer-client.h:874)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-overwrite-mmap" exit
>  (in lttng_ring_buffer_client_overwrite_exit() at lttng-ring-buffer-client.h:874)
> libust[27270/27270]: LTT : ltt ring buffer client "relay-metadata-mmap" exit
>  (in lttng_ring_buffer_metadata_client_exit() at lttng-ring-buffer-metadata-client.h:358)
> libust[27270/27270]: Provider "lttng_ust_statedump" accepted, version 1.0 is compatible with LTTng UST provider version 1.0. (in check_provider_version() at lttng-probes.c:161)
> liblttng_ust_tracepoint[27270/27270]: Release queue of unregistered tracepoint probes. (in __tracepoint_probe_prune_release_queue() at tracepoint.c:743)
> libust[27270/27270]: just unregistered probes of provider lttng_ust_statedump (in lttng_probe_unregister() at lttng-probes.c:231)
> liblttng_ust_tracepoint[27270/27270]: just unregistered a tracepoints section from 0x7fd9399e98a0 (in tracepoint_unregister_lib() at tracepoint.c:938)
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#
> root@RocrLnx23:~/git/compute/out/ubuntu-18.04/18.04/bin#

> root@RocrLnx23:~#
> root@RocrLnx23:~# uname -a
> Linux RocrLnx23 5.9.0-050900-generic #202010112230 SMP Sun Oct 11 22:34:01 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> root@RocrLnx23:~#
> root@RocrLnx23:~# find /lib/modules/$(uname -r)/ | grep lttng
> root@RocrLnx23:~#
> root@RocrLnx23:~# dmesg | grep lttng
> root@RocrLnx23:~#

> DEBUG1 - 19:50:34.287825235 [27092/27092]: [sessiond configuration]
> DEBUG1 - 19:50:34.287914395 [27092/27092]: 	version                        2.12.3
> DEBUG1 - 19:50:34.287926947 [27092/27092]: 	verbose:                       3
> DEBUG1 - 19:50:34.287936527 [27092/27092]: 	verbose consumer:              1
> DEBUG1 - 19:50:34.287945611 [27092/27092]: 	quiet mode:                    False
> DEBUG1 - 19:50:34.287954818 [27092/27092]: 	agent_tcp_port:                [5345, 5354]
> DEBUG1 - 19:50:34.287964363 [27092/27092]: 	application socket timeout:    5
> DEBUG1 - 19:50:34.287973514 [27092/27092]: 	no-kernel:                     False
> DEBUG1 - 19:50:34.287982534 [27092/27092]: 	background:                    True
> DEBUG1 - 19:50:34.287991518 [27092/27092]: 	daemonize:                     False
> DEBUG1 - 19:50:34.288000510 [27092/27092]: 	signal parent on start:        False
> DEBUG1 - 19:50:34.288009358 [27092/27092]: 	tracing group name:            tracing
> DEBUG1 - 19:50:34.288018350 [27092/27092]: 	kmod_probe_list:               None
> DEBUG1 - 19:50:34.288027446 [27092/27092]: 	kmod_extra_probe_list:         None
> DEBUG1 - 19:50:34.288036354 [27092/27092]: 	rundir:                        /var/run/lttng
> DEBUG1 - 19:50:34.288045306 [27092/27092]: 	application socket path:       /var/run/lttng/lttng-ust-sock-8
> DEBUG1 - 19:50:34.288054274 [27092/27092]: 	client socket path:            /var/run/lttng/client-lttng-sessiond
> DEBUG1 - 19:50:34.288063306 [27092/27092]: 	wait shm path:                 /lttng-ust-wait-8
> DEBUG1 - 19:50:34.288072322 [27092/27092]: 	health socket path:            /var/run/lttng/sessiond-health
> DEBUG1 - 19:50:34.288081166 [27092/27092]: 	LTTNG_UST_CLOCK_PLUGIN:        None
> DEBUG1 - 19:50:34.288090102 [27092/27092]: 	pid file path:                 /var/run/lttng/lttng-sessiond.pid
> DEBUG1 - 19:50:34.288099078 [27092/27092]: 	lock file path:                /var/run/lttng/lttng-sessiond.lck
> DEBUG1 - 19:50:34.288107978 [27092/27092]: 	session load path:             None
> DEBUG1 - 19:50:34.288116894 [27092/27092]: 	agent port file path:          /var/run/lttng/agent.port
> DEBUG1 - 19:50:34.288125790 [27092/27092]: 	consumerd32 path:              /var/run/lttng/ustconsumerd32
> DEBUG1 - 19:50:34.288134734 [27092/27092]: 	consumerd32 bin path:          Unknown
> DEBUG1 - 19:50:34.288143774 [27092/27092]: 	consumerd32 lib dir:           Unknown
> DEBUG1 - 19:50:34.288152706 [27092/27092]: 	consumerd32 err unix sock path:/var/run/lttng/ustconsumerd32/error
> DEBUG1 - 19:50:34.288161702 [27092/27092]: 	consumerd32 cmd unix sock path:/var/run/lttng/ustconsumerd32/command
> DEBUG1 - 19:50:34.288170734 [27092/27092]: 	consumerd64 path:              /var/run/lttng/ustconsumerd64
> DEBUG1 - 19:50:34.288179678 [27092/27092]: 	consumerd64 bin path:          /usr/lib/x86_64-linux-gnu/lttng/libexec/lttng-consumerd
> DEBUG1 - 19:50:34.288188762 [27092/27092]: 	consumerd64 lib dir:           /usr/lib/x86_64-linux-gnu
> DEBUG1 - 19:50:34.288197697 [27092/27092]: 	consumerd64 err unix sock path:/var/run/lttng/ustconsumerd64/error
> DEBUG1 - 19:50:34.288206714 [27092/27092]: 	consumerd64 cmd unix sock path:/var/run/lttng/ustconsumerd64/command
> DEBUG1 - 19:50:34.288215650 [27092/27092]: 	kconsumerd path:               /var/run/lttng/kconsumerd
> DEBUG1 - 19:50:34.288224577 [27092/27092]: 	kconsumerd err unix sock path: /var/run/lttng/kconsumerd/error
> DEBUG1 - 19:50:34.288233502 [27092/27092]: 	kconsumerd cmd unix sock path: /var/run/lttng/kconsumerd/command
> DEBUG1 - 19:50:34.288247353 [27092/27092]: Starting lttng-sessiond {016dcf3f-566c-46ce-93bf-8d36b5c54b06} (in sessiond_uuid_log() at main.c:1282)
> DEBUG3 - 19:50:34.288257429 [27092/27092]: Creating LTTng run directory: /var/run/lttng (in create_lttng_rundir() at main.c:995)
> DEBUG1 - 19:50:34.291627947 [27094/27094]: Resetting run_as worker signal handlers to default (in reset_sighandler() at runas.c:1117)
> DEBUG1 - 19:50:34.291685132 [27094/27094]: run_as signal handler set for SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:1178)
> DEBUG1 - 19:50:34.292727391 [27093/27093]: Health check time delta in seconds set to 20 (in health_init() at health.c:63)
> DEBUG1 - 19:50:34.292869817 [27093/27095]: Launching "HT cleanup" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.292890654 [27093/27095]: [ht-thread] startup. (in thread_ht_cleanup() at ht-cleanup.c:98)
> DEBUG1 - 19:50:34.292914128 [27093/27095]: epoll set max size is 6649446 (in compat_epoll_set_max_size() at compat-epoll.c:346)
> DEBUG3 - 19:50:34.292918834 [27093/27093]: Created hashtable size 4 at 0x5604ecc7c8c0 of type 1 (in lttng_ht_new() at hashtable.c:135)
> DEBUG3 - 19:50:34.292933074 [27093/27093]: Created hashtable size 4 at 0x5604ecc7d9a0 of type 1 (in lttng_ht_new() at hashtable.c:135)
> DEBUG3 - 19:50:34.292937660 [27093/27093]: Created hashtable size 4 at 0x5604ecc7e050 of type 1 (in lttng_ht_new() at hashtable.c:135)
> DEBUG3 - 19:50:34.292941688 [27093/27093]: Created hashtable size 4 at 0x5604ecc7e790 of type 1 (in lttng_ht_new() at hashtable.c:135)
> DEBUG3 - 19:50:34.292943516 [27093/27095]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.c:122)
> DEBUG2 - 19:50:34.292945189 [27093/27093]: Creating consumer directory: /var/run/lttng/kconsumerd (in set_consumer_sockets() at main.c:1037)
> DEBUG1 - 19:50:34.293777619 [27093/27093]: libkmod: could not find module by name='lttng_ring_buffer_client_discard'
>  (in log_kmod() at modprobe.c:108)
> Error: Unable to load required module lttng-ring-buffer-client-discard
> Warning: No kernel tracer available
> DEBUG2 - 19:50:34.293795387 [27093/27093]: Creating consumer directory: /var/run/lttng/ustconsumerd64 (in set_consumer_sockets() at main.c:1037)
> DEBUG2 - 19:50:34.293842285 [27093/27093]: Creating consumer directory: /var/run/lttng/ustconsumerd32 (in set_consumer_sockets() at main.c:1037)
> DEBUG3 - 19:50:34.293894755 [27093/27093]: Created hashtable size 4 at 0x5604ecc81b60 of type 2 (in lttng_ht_new() at hashtable.c:135)
> DEBUG3 - 19:50:34.293900359 [27093/27093]: Global buffer per UID registry initialized (in buffer_reg_init_uid_registry() at buffer-registry.c:90)
> DEBUG3 - 19:50:34.293907430 [27093/27093]: Created hashtable size 4 at 0x5604ecc822a0 of type 2 (in lttng_ht_new() at hashtable.c:135)
> DEBUG3 - 19:50:34.293911032 [27093/27093]: Global buffer per PID registry initialized (in buffer_reg_init_pid_registry() at buffer-registry.c:219)
> DEBUG1 - 19:50:34.293914742 [27093/27093]: Command subsystem initialized (in cmd_init() at cmd.c:5511)
> DEBUG1 - 19:50:34.293934016 [27093/27093]: Pid 27093 written in file /var/run/lttng/lttng-sessiond.pid (in utils_create_pid_file() at utils.c:619)
> DEBUG1 - 19:50:34.293956094 [27093/27093]: TCP inet operation timeout set to 216 sec (in lttcomm_inet_init() at inet.c:545)
> DEBUG1 - 19:50:34.293991262 [27093/27093]: Waiting for health management thread to be ready (in wait_until_thread_is_ready() at health.c:35)
> DEBUG1 - 19:50:34.294010795 [27093/27097]: Launching "Health management" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294026085 [27093/27097]: [thread] Manage health check started (in thread_manage_health() at health.c:65)
> DEBUG1 - 19:50:34.294100006 [27093/27097]: Marking health management thread as ready (in mark_thread_as_ready() at health.c:28)
> DEBUG1 - 19:50:34.294110094 [27093/27097]: Health check ready (in thread_manage_health() at health.c:136)
> DEBUG1 - 19:50:34.294127735 [27093/27093]: Health management thread is ready (in wait_until_thread_is_ready() at health.c:37)
> DEBUG1 - 19:50:34.294172751 [27093/27093]: Waiting for notification thread to be ready (in wait_until_thread_is_ready() at notification-thread.c:387)
> DEBUG1 - 19:50:34.294191612 [27093/27098]: Launching "Notification" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294206256 [27093/27098]: [notification-thread] Started notification thread (in thread_notification() at notification-thread.c:521)
> DEBUG1 - 19:50:34.294221868 [27093/27098]: [notification-thread] Creating notification channel UNIX socket at /var/run/lttng/sessiond-notification (in notification_channel_socket_create() at notification-thread.c:215)
> DEBUG1 - 19:50:34.294274346 [27093/27098]: [notification-thread] Notification channel UNIX socket created (fd = 35) (in notification_channel_socket_create() at notification-thread.c:250)
> DEBUG1 - 19:50:34.294293232 [27093/27098]: [notification-thread] Listening on notification channel socket (in init_thread_state() at notification-thread.c:414)
> DEBUG1 - 19:50:34.294306233 [27093/27098]: Marking notification thread as ready (in mark_thread_as_ready() at notification-thread.c:380)
> DEBUG1 - 19:50:34.294313225 [27093/27098]: [notification-thread] Entering poll wait (in thread_notification() at notification-thread.c:543)
> DEBUG1 - 19:50:34.294330832 [27093/27093]: Notification thread is ready (in wait_until_thread_is_ready() at notification-thread.c:389)
> DEBUG1 - 19:50:34.294388353 [27093/27099]: Launching "Timer" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294411906 [27093/27100]: Launching "Rotation" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294430483 [27093/27100]: [rotation-thread] Started rotation thread (in thread_rotation() at rotation-thread.c:772)
> DEBUG1 - 19:50:34.294413199 [27093/27093]: Created client socket (fd = 41) (in create_client_sock() at client.c:2145)
> DEBUG1 - 19:50:34.294491978 [27093/27093]: Waiting for client thread to be ready (in wait_thread_status() at client.c:56)
> DEBUG1 - 19:50:34.294502467 [27093/27098]: [notification-thread] Poll wait returned (1) (in thread_notification() at notification-thread.c:545)
> DEBUG1 - 19:50:34.294512099 [27093/27098]: [notification-thread] Handling fd (35) activity (1) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:34.294517607 [27093/27098]: [notification-thread] Handling new notification channel client connection (in handle_notification_thread_client_connect() at notification-thread-events.c:2414)
> DEBUG1 - 19:50:34.294510683 [27093/27101]: Launching "Client management" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294539500 [27093/27101]: [thread] Manage client started (in thread_manage_clients() at client.c:2179)
> DEBUG1 - 19:50:34.294529671 [27093/27098]: Client socket (fd = 44) set as non-blocking (in socket_set_non_blocking() at notification-thread-events.c:2382)
> DEBUG1 - 19:50:34.294557464 [27093/27098]: [notification-thread] Added new notification channel client socket (44) to poll set (in handle_notification_thread_client_connect() at notification-thread-events.c:2464)
> DEBUG1 - 19:50:34.294562398 [27093/27101]: Marking client thread's state as running (in set_thread_status() at client.c:49)
> DEBUG1 - 19:50:34.294570221 [27093/27101]: Accepting client command ... (in thread_manage_clients() at client.c:2235)
> DEBUG1 - 19:50:34.294563060 [27093/27098]: [notification-thread] Entering poll wait (in thread_notification() at notification-thread.c:543)
> DEBUG1 - 19:50:34.294583088 [27093/27098]: [notification-thread] Poll wait returned (1) (in thread_notification() at notification-thread.c:545)
> DEBUG1 - 19:50:34.294586731 [27093/27098]: [notification-thread] Handling fd (44) activity (1) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:34.294587586 [27093/27093]: Client thread is ready (in wait_thread_status() at client.c:59)
> DEBUG1 - 19:50:34.294593184 [27093/27098]: [notification-thread] Entering poll wait (in thread_notification() at notification-thread.c:543)
> DEBUG1 - 19:50:34.294612829 [27093/27098]: [notification-thread] Poll wait returned (1) (in thread_notification() at notification-thread.c:545)
> DEBUG1 - 19:50:34.294616606 [27093/27098]: [notification-thread] Handling fd (44) activity (1) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:34.294625004 [27093/27098]: [notification-thread] Received handshake from client (uid = 0, gid = 0) with version 1.1 (in client_dispatch_message() at notification-thread-events.c:2764)
> DEBUG1 - 19:50:34.294631301 [27093/27098]: [notification-thread] Flushing client (socket fd = 44) outgoing queue (in client_flush_outgoing_queue() at notification-thread-events.c:2562)
> DEBUG1 - 19:50:34.294639404 [27093/27098]: [notification-thread] Send command reply (0) (in client_send_command_reply() at notification-thread-events.c:2645)
> DEBUG1 - 19:50:34.294646757 [27093/27093]: All permissions are set (in set_permissions() at main.c:983)
> DEBUG1 - 19:50:34.294647496 [27093/27098]: [notification-thread] Flushing client (socket fd = 44) outgoing queue (in client_flush_outgoing_queue() at notification-thread-events.c:2562)
> DEBUG1 - 19:50:34.294672224 [27093/27098]: [notification-thread] Entering poll wait (in thread_notification() at notification-thread.c:543)
> DEBUG1 - 19:50:34.294695416 [27093/27100]: [rotation-thread] Entering poll wait (in thread_rotation() at rotation-thread.c:796)
> DEBUG1 - 19:50:34.294704105 [27093/27102]: Launching "UST registration dispatch" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294717737 [27093/27102]: [thread] Dispatch UST command started (in thread_dispatch_ust_registration() at dispatch.c:244)
> DEBUG1 - 19:50:34.294721310 [27093/27102]: Futex n to 1 prepare done (in futex_nto1_prepare() at futex.c:67)
> DEBUG3 - 19:50:34.294707395 [27093/27093]: Session daemon application socket created (fd = 48)  (in create_application_socket() at register.c:69)
> DEBUG1 - 19:50:34.294725301 [27093/27102]: Woken up but nothing in the UST command queue (in thread_dispatch_ust_registration() at dispatch.c:273)
> DEBUG1 - 19:50:34.294757225 [27093/27093]: Waiting for application registration thread to be ready (in wait_thread_status() at register.c:129)
> DEBUG1 - 19:50:34.294769256 [27093/27103]: Launching "UST application registration" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294781168 [27093/27103]: [thread] Manage application registration started (in thread_application_registration() at register.c:166)
> DEBUG1 - 19:50:34.294806482 [27093/27103]: Marking application registration thread's state as running (in set_thread_status() at register.c:122)
> DEBUG1 - 19:50:34.294814191 [27093/27103]: Accepting application registration (in thread_application_registration() at register.c:205)
> DEBUG1 - 19:50:34.294825259 [27093/27093]: Application registration thread is ready (in wait_thread_status() at register.c:132)
> DEBUG1 - 19:50:34.294830430 [27093/27093]: Notifying applications of session daemon state: 1 (in notify_ust_apps() at register.c:90)
> DEBUG1 - 19:50:34.294858860 [27093/27093]: Got the wait shm fd 50 (in get_wait_shm() at shm.c:138)
> DEBUG1 - 19:50:34.294870529 [27093/27093]: Futex wait update active 1 (in futex_wait_update() at futex.c:55)
> DEBUG1 - 19:50:34.294905093 [27093/27104]: Launching "UST application management" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294913821 [27093/27104]: [thread] Manage application started (in thread_application_management() at manage-apps.c:52)
> DEBUG1 - 19:50:34.294931686 [27093/27104]: Apps thread polling (in thread_application_management() at manage-apps.c:88)
> DEBUG1 - 19:50:34.294936804 [27093/27105]: Launching "Application notification" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294943458 [27093/27093]: Waiting for agent management thread to be ready (in wait_until_thread_is_ready() at agent-thread.c:334)
> DEBUG1 - 19:50:34.294955501 [27093/27106]: Launching "Agent management" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.294966877 [27093/27106]: [agent-thread] Manage agent application registration. (in thread_agent_management() at agent-thread.c:352)
> DEBUG1 - 19:50:34.294946701 [27093/27105]: [ust-thread] Manage application notify command (in thread_application_notification() at notify-apps.c:39)
> DEBUG3 - 19:50:34.294986842 [27093/27106]: URI string: tcp://localhost (in uri_parse() at uri.c:298)
> DEBUG3 - 19:50:34.295004846 [27093/27105]: [ust-thread] Manage notify polling (in thread_application_notification() at notify-apps.c:74)
> DEBUG2 - 19:50:34.295090649 [27093/27106]: IP address resolved to 127.0.0.1 (in set_ip_address() at uri.c:155)
> DEBUG3 - 19:50:34.295096604 [27093/27106]: URI dtype: 1, proto: 1, host: localhost, subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:512)
> DEBUG3 - 19:50:34.295107916 [27093/27106]: [agent-thread] Trying to bind on port 5345 (in init_tcp_socket() at agent-thread.c:127)
> DEBUG1 - 19:50:34.295120995 [27093/27106]: [agent-thread] Listening on TCP port 5345 and socket 59 (in init_tcp_socket() at agent-thread.c:164)
> DEBUG1 - 19:50:34.295138488 [27093/27106]: Pid 5345 written in file /var/run/lttng/agent.port (in utils_create_pid_file() at utils.c:619)
> DEBUG1 - 19:50:34.295142962 [27093/27106]: Marking agent management thread as ready (in mark_thread_as_ready() at agent-thread.c:327)
> DEBUG3 - 19:50:34.295150688 [27093/27106]: [agent-thread] Manage agent polling (in thread_agent_management() at agent-thread.c:406)
> DEBUG1 - 19:50:34.295160580 [27093/27093]: Agent management thread is ready (in wait_until_thread_is_ready() at agent-thread.c:336)
> DEBUG1 - 19:50:34.295194644 [27093/27107]: Launching "Kernel management" thread (in launch_thread() at thread.c:64)
> DEBUG1 - 19:50:34.295202977 [27093/27107]: [thread] Thread manage kernel started (in thread_kernel_management() at manage-kernel.c:173)
> DEBUG1 - 19:50:34.295226521 [27093/27107]: Updating kernel poll set (in update_kernel_poll() at manage-kernel.c:37)
> DEBUG1 - 19:50:34.295230665 [27093/27107]: Thread kernel polling (in thread_kernel_management() at manage-kernel.c:227)
> DEBUG1 - 19:50:45.902214432 [27093/27093]: SIGTERM caught (in sighandler() at main.c:1109)
> DEBUG1 - 19:50:45.902235323 [27093/27093]: Terminating all threads (in stop_threads() at main.c:163)
> DEBUG1 - 19:50:45.902259051 [27093/27093]: Shutting down "Client management" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902307308 [27093/27101]: Clean command context structure (in clean_command_ctx() at client.c:656)
> DEBUG1 - 19:50:45.902339483 [27093/27101]: Client thread dying (in thread_manage_clients() at client.c:2434)
> DEBUG1 - 19:50:45.902347817 [27093/27101]: Thread "Client management" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902408592 [27093/27093]: Initiating destruction of all sessions (in destroy_all_sessions_and_wait() at main.c:1224)
> DEBUG1 - 19:50:45.902418973 [27093/27093]: Waiting for the destruction of all sessions to complete (in destroy_all_sessions_and_wait() at main.c:1252)
> DEBUG1 - 19:50:45.902423833 [27093/27093]: Destruction of all sessions completed (in destroy_all_sessions_and_wait() at main.c:1254)
> DEBUG1 - 19:50:45.902428147 [27093/27093]: Shutting down "UST application registration" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902459934 [27093/27103]: Notifying applications of session daemon state: 0 (in notify_ust_apps() at register.c:90)
> DEBUG1 - 19:50:45.902485386 [27093/27103]: Got the wait shm fd 39 (in get_wait_shm() at shm.c:138)
> DEBUG1 - 19:50:45.902496966 [27093/27103]: Futex wait update active 0 (in futex_wait_update() at futex.c:55)
> DEBUG1 - 19:50:45.902512917 [27093/27103]: UST Registration thread cleanup complete (in thread_application_registration() at register.c:362)
> DEBUG1 - 19:50:45.902516944 [27093/27103]: Thread "UST application registration" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902538043 [27093/27093]: Shutting down "Kernel management" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902571047 [27093/27107]: Thread kernel return from poll on 2 fds (in thread_kernel_management() at manage-kernel.c:234)
> DEBUG1 - 19:50:45.902586716 [27093/27107]: Kernel thread dying (in thread_kernel_management() at manage-kernel.c:309)
> DEBUG1 - 19:50:45.902590679 [27093/27107]: Thread "Kernel management" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902616869 [27093/27093]: Shutting down "Agent management" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG3 - 19:50:45.902632030 [27093/27106]: [agent-thread] Manage agent return from poll on 2 fds (in thread_agent_management() at agent-thread.c:412)
> DEBUG3 - 19:50:45.902640319 [27093/27106]: [agent-thread] 1 fd ready (in thread_agent_management() at agent-thread.c:423)
> DEBUG3 - 19:50:45.902645315 [27093/27106]: [agent-thread] Destroy TCP socket on port 5345 (in destroy_tcp_socket() at agent-thread.c:192)
> DEBUG1 - 19:50:45.902658101 [27093/27106]: [agent-thread] Cleaning up and stopping. (in thread_agent_management() at agent-thread.c:531)
> DEBUG1 - 19:50:45.902666445 [27093/27106]: Thread "Agent management" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902693470 [27093/27093]: Shutting down "Application notification" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG3 - 19:50:45.902708608 [27093/27105]: [ust-thread] Manage notify return from poll on 2 fds (in thread_application_notification() at notify-apps.c:81)
> DEBUG1 - 19:50:45.902721389 [27093/27105]: Application notify communication apps thread cleanup complete (in thread_application_notification() at notify-apps.c:183)
> DEBUG1 - 19:50:45.902725248 [27093/27105]: Thread "Application notification" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902760824 [27093/27093]: Shutting down "UST application management" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902780690 [27093/27104]: Apps thread return from poll on 2 fds (in thread_application_management() at manage-apps.c:95)
> DEBUG1 - 19:50:45.902789409 [27093/27104]: Application communication apps thread cleanup complete (in thread_application_management() at manage-apps.c:194)
> DEBUG1 - 19:50:45.902792683 [27093/27104]: Thread "UST application management" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902820751 [27093/27093]: Shutting down "UST registration dispatch" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902827741 [27093/27093]: Futex n to 1 wake done (in futex_nto1_wake() at futex.c:112)
> DEBUG1 - 19:50:45.902839348 [27093/27102]: Futex n to 1 wait done (in futex_nto1_wait() at futex.c:95)
> DEBUG1 - 19:50:45.902845362 [27093/27102]: Futex n to 1 prepare done (in futex_nto1_prepare() at futex.c:67)
> DEBUG1 - 19:50:45.902848778 [27093/27102]: Dispatch thread dying (in thread_dispatch_ust_registration() at dispatch.c:478)
> DEBUG1 - 19:50:45.902851875 [27093/27102]: Thread "UST registration dispatch" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902866282 [27093/27093]: Shutting down "Rotation" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902890606 [27093/27100]: [rotation-thread] Poll wait returned (1) (in thread_rotation() at rotation-thread.c:798)
> DEBUG1 - 19:50:45.902899665 [27093/27100]: [rotation-thread] Handling fd (37) activity (1) (in thread_rotation() at rotation-thread.c:817)
> DEBUG1 - 19:50:45.902903523 [27093/27100]: [rotation-thread] Quit pipe activity (in thread_rotation() at rotation-thread.c:856)
> DEBUG1 - 19:50:45.902906465 [27093/27100]: [rotation-thread] Exit (in thread_rotation() at rotation-thread.c:864)
> DEBUG1 - 19:50:45.902922897 [27093/27100]: Thread "Rotation" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902930771 [27093/27098]: [notification-thread] Poll wait returned (1) (in thread_notification() at notification-thread.c:545)
> DEBUG1 - 19:50:45.902936150 [27093/27098]: [notification-thread] Handling fd (44) activity (8209) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:45.902940543 [27093/27098]: [notification-thread] Closing client connection (socket fd = 44) (in handle_notification_thread_client_disconnect() at notification-thread-events.c:2487)
> DEBUG1 - 19:50:45.902941876 [27093/27093]: Shutting down "Timer" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902961103 [27093/27099]: [timer-thread] Exit (in thread_timer() at timer.c:402)
> DEBUG1 - 19:50:45.902967696 [27093/27099]: Thread "Timer" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.902974330 [27093/27098]: [notification-thread] Entering poll wait (in thread_notification() at notification-thread.c:543)
> DEBUG1 - 19:50:45.902977663 [27093/27093]: Shutting down "Health management" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.902992777 [27093/27097]: Health check thread dying (in thread_manage_health() at health.c:231)
> DEBUG1 - 19:50:45.903008660 [27093/27097]: Thread "Health management" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.913157227 [27093/27093]: Cleanup sessiond (in sessiond_cleanup() at main.c:268)
> DEBUG1 - 19:50:45.913205962 [27093/27093]: Removing sessiond and consumerd content of directory /var/run/lttng (in sessiond_cleanup() at main.c:285)
> DEBUG1 - 19:50:45.913212800 [27093/27093]: Removing /var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at main.c:288)
> DEBUG1 - 19:50:45.913221691 [27093/27093]: Removing /var/run/lttng/agent.port (in sessiond_cleanup() at main.c:291)
> DEBUG1 - 19:50:45.913231516 [27093/27093]: Removing /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at main.c:295)
> DEBUG1 - 19:50:45.913239682 [27093/27093]: Removing directory /var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:298)
> DEBUG1 - 19:50:45.913248303 [27093/27093]: Removing /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at main.c:302)
> DEBUG1 - 19:50:45.913256440 [27093/27093]: Removing directory /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:305)
> DEBUG1 - 19:50:45.913263733 [27093/27093]: Removing /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at main.c:309)
> DEBUG1 - 19:50:45.913271720 [27093/27093]: Removing directory /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:312)
> DEBUG1 - 19:50:45.913279537 [27093/27093]: Cleaning up all agent apps (in sessiond_cleanup() at main.c:317)
> DEBUG1 - 19:50:45.913346539 [27093/27093]: Closing all UST sockets (in sessiond_cleanup() at main.c:319)
> DEBUG2 - 19:50:45.913360710 [27093/27093]: UST app cleaning registered apps hash table (in ust_app_clean_list() at ust-app.c:3849)
> DEBUG3 - 19:50:45.913379235 [27093/27093]: Buffer registry destroy all registry (in buffer_reg_destroy_registries() at buffer-registry.c:743)
> DEBUG3 - 19:50:45.913401261 [27093/27095]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:126)
> DEBUG2 - 19:50:45.913418510 [27093/27093]: Closing kernel fd (in cleanup_kernel_tracer() at kernel.c:1879)
> DEBUG1 - 19:50:45.913425075 [27093/27093]: Unloading kernel modules (in cleanup_kernel_tracer() at kernel.c:1887)
> DEBUG1 - 19:50:45.913437742 [27093/27098]: [notification-thread] Poll wait returned (3) (in thread_notification() at notification-thread.c:545)
> DEBUG1 - 19:50:45.913452093 [27093/27098]: [notification-thread] Handling fd (11) activity (16) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:45.913460616 [27093/27098]: [notification-thread] Handling fd (13) activity (16) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:45.913467079 [27093/27098]: [notification-thread] Handling fd (17) activity (16) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:45.913473531 [27093/27098]: [notification-thread] Entering poll wait (in thread_notification() at notification-thread.c:543)
> DEBUG3 - 19:50:45.913477766 [27093/27095]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.c:122)
> DEBUG3 - 19:50:45.913493705 [27093/27095]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:126)
> DEBUG3 - 19:50:45.913560516 [27093/27095]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.c:122)
> DEBUG3 - 19:50:45.913576156 [27093/27095]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:126)
> DEBUG3 - 19:50:45.913642762 [27093/27095]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.c:122)
> DEBUG3 - 19:50:45.913658523 [27093/27095]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:126)
> DEBUG3 - 19:50:45.913725454 [27093/27095]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.c:122)
> DEBUG3 - 19:50:45.913741174 [27093/27095]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:126)
> DEBUG3 - 19:50:45.913808136 [27093/27095]: [ht-thread] Polling. (in thread_ht_cleanup() at ht-cleanup.c:122)
> DEBUG1 - 19:50:45.914216854 [27093/27093]: Shutting down "Notification" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG1 - 19:50:45.914234880 [27093/27093]: Beginning of waiter wait period (in lttng_waiter_wait() at waiter.c:46)
> DEBUG1 - 19:50:45.914257856 [27093/27098]: [notification-thread] Poll wait returned (1) (in thread_notification() at notification-thread.c:545)
> DEBUG1 - 19:50:45.914272661 [27093/27098]: [notification-thread] Handling fd (33) activity (1) (in thread_notification() at notification-thread.c:563)
> DEBUG1 - 19:50:45.914281930 [27093/27098]: [notification-thread] Received quit command (in handle_notification_thread_command() at notification-thread-events.c:2331)
> DEBUG1 - 19:50:45.914293095 [27093/27098]: [notification-thread] Closing all client connections (in handle_notification_thread_client_disconnect_all() at notification-thread-events.c:2517)
> DEBUG1 - 19:50:45.914315153 [27093/27093]: End of waiter wait period (in lttng_waiter_wait() at waiter.c:89)
> DEBUG1 - 19:50:45.914545275 [27093/27098]: [notification-thread] Destroying notification channel socket (in notification_channel_socket_destroy() at notification-thread.c:192)
> DEBUG1 - 19:50:45.914579516 [27093/27098]: Thread "Notification" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.924748745 [27093/27093]: Shutting down "HT cleanup" thread (in _lttng_thread_shutdown() at thread.c:152)
> DEBUG3 - 19:50:45.924794950 [27093/27095]: [ht-thread] Returning from poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:126)
> DEBUG1 - 19:50:45.924809066 [27093/27095]: [ht-cleanup] quit. (in thread_ht_cleanup() at ht-cleanup.c:206)
> DEBUG1 - 19:50:45.924820729 [27093/27095]: [ht-cleanup] Thread terminates. (in thread_ht_cleanup() at ht-cleanup.c:217)
> DEBUG1 - 19:50:45.924827321 [27093/27095]: Thread "HT cleanup" has returned (in launch_thread() at thread.c:66)
> DEBUG1 - 19:50:45.924928877 [27093/27093]: Cleaning up options (in sessiond_cleanup_options() at main.c:345)
> DEBUG1 - 19:50:45.924943491 [27093/27093]: Destroying run_as worker (in run_as_destroy_worker_no_lock() at runas.c:1313)
> DEBUG1 - 19:50:45.924949502 [27093/27093]: Closing run_as worker socket (in run_as_destroy_worker_no_lock() at runas.c:1318)
> DEBUG1 - 19:50:45.924997667 [27094/27094]: run_as worker exiting (ret = 0) (in run_as_create_worker_no_lock() at runas.c:1263)
> DEBUG1 - 19:50:45.925615056 [27093/27093]: lttng-runas terminated with status code 0 (in run_as_destroy_worker_no_lock() at runas.c:1340)

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS


_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
