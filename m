From: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Subject: Re: [PATCH lttng-modules] Update kernel probes to
	more	detailed match to kernel versions
Date: Wed, 28 Nov 2012 17:16:02 +0000
Message-ID: <6C5EA58090A5ED459815C4D04C2B466F8C566A47__49555.0708532848$1354123018$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <1354096526-22098-1-git-send-email-andrew_gabbasov@mentor.com>,
	<20121128155032.GA9266@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1TdlF5-0003xb-D5
	for lttng-dev@lists.lttng.org; Wed, 28 Nov 2012 12:16:11 -0500
In-Reply-To: <20121128155032.GA9266@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

> * Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
> > We have added some more ifdef's to kernel probes to more closely match
> > the kernel tracepoints for different kernel versions. The changes cover
> > kernel versions from 2.6.38 up to 3.7. We did not track the earlier
> > versions, and they are filtered out in probes Makefile.
> >
> > ext3 probe was modified to use #include <../fs/ext3/ext3.h> instead of
> > copying this include from kernel source to lttng-modules source.
> > Using such includes (there will be more similar in other probes)
> > imposes a restriction to use the full kernel source for building
> > lttng-modules rather than having just kernel "include" directory,
> > but it looks like full source is required anyway, at least with respect
> > to Makefiles structure. May be it is worth mentioning somewhere
> > in the documentation.
> >
> > The code was verified to compile with latest versions in all stable
> > branches from 2.6.38.x to 3.6.x and 3.7-rc7.
> 
> I get this build failure on 3.5 with this patch:
> 
>   CC [M]  /home/compudj/work/lttng-modules/probes/lttng-probe-ext3.o
> /home/compudj/work/lttng-modules/probes/lttng-probe-ext3.c:30:29: fatal
> error: ../fs/ext3/ext3.h: No such file or directory
> compilation terminated.
> 
> can you look into it and submit a revised patch ?

You must be using kernel headers for building lttng-modules (linux-headers package
or something like that), right? This is what I was writing about: since ext3.h is not available
in kernel's "include" directory, and in order to avoid duplicating this file in lttng-modules
sources, we have to use that <../> based reference, and this requires having full kernel
source for building. The same issue will later be with btrfs and ext4 probes: their necessary
include files are also not available in kernel headers. 

Trying to duplicate these header files to lttng-modules source seems to be not a good
idea, especially if we need to add many ifdef's to them to track different kernel
versions. We can try to insert some checks to the Makefile and skip building those
probes if we do not have full kernel sources (actually if we do not have necessary
include files). Or to declare having full kernel source as a requirement for building
lttng-modules. What do you think?

> Also, although the README file states that we support only 3.6.38+, we
> happen to also have support for kernels down to 2.6.32 with the patches
> in the linux-patches/ directory applied to the appropriate kernel
> versions. So it would be good that the instrumentation compiles for
> those older kernels too. I promise we won't go further back than 2.6.32
> though.

We'll try to add the ifdef's for earlier version down to 2.6.32 to the probes, although
the additional amount of conditions makes the code overcomplicated ;-)

> Thanks,
> 
> Mathieu

Thanks.

Best regards,
Andrew Gabbasov
