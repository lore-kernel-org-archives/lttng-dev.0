From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-modules 2.6.1 compilation error on Ubuntu
 14.04
Date: Thu, 14 May 2015 13:18:47 +0000 (UTC)
Message-ID: <499393386.662.1431609527328.JavaMail.zimbra__40521.0987934426$1431609607$gmane$org@efficios.com>
References: <CABx-oYzx7CRvzMF52sSMJy1DQMvc-GXC+rPhgERe3TZmMZ8JtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Yst2L-0006q5-PA
 for lttng-dev@lists.lttng.org; Thu, 14 May 2015 09:18:59 -0400
In-Reply-To: <CABx-oYzx7CRvzMF52sSMJy1DQMvc-GXC+rPhgERe3TZmMZ8JtQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Engel Sanchez <engel@basho.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message ----- 

> Hello there. I was wondering if anybody knew what is causing this compilation
> error I'm getting on a new Ubuntu 14.04 VM with a 3.13.0 kernel. It does not
> find the DEBIAN_API_VERSION symbol. The use of that was introduced in 2.6.1
> apparently:

> http://fossies.org/diffs/lttng-modules/2.6.0_vs_2.6.1/lttng-kernel-version.h-diff.html

> I'm following the instructions in the Download page to install from the PPA :
> http://lttng.org/download/#ubuntu

> This the error I'm getting. Thanks in advance for any help!

> In file included from
> /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/wrapper/page_alloc.h:28:0,
> 	from
> /var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/lttng-events.c:27:
> 	/var/lib/dkms/lttng-modules/2.6.x+stable+bzr727+pack22+201504291801~ubuntu14.04.1/build/wrapper/../lttng-kernel-version.h:60:57:
> error: operator '+' has no right operand 	((LINUX_VERSION_CODE * 1000000ULL)
> + DEBIAN_API_VERSION)

I pushed the following fix into master and stable-2.6 branches
of lttng-modules. Can you give it a try ?

commit a748963b76f353d459a3faf85eecc96f52811eee
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu May 14 09:13:49 2015 -0400

    Fix: build against Ubuntu kernels
    
    Recent Ubuntu kernels appear to define DEBIAN_API_VERSION, but they are
    not really a Debian kernel per-se: the abi-debian-version.sh cannot find
    the expected Debian kernel version string layout.
    
    Therefore, change the conditional check to use directly the
    LTTNG_DEBIAN_VERSION_CODE define, which is defined only when the
    abi-debian-version.sh script figures out it builds against a Debian
    kernel.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
