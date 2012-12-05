From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Update kernel probes to
	more	detailed match to kernel versions
Date: Wed, 5 Dec 2012 06:33:06 -0500
Message-ID: <20121205113306.GA31411__682.095500133251$1354707231$gmane$org@Krystal>
References: <20121128155032.GA9266@Krystal>
	<6C5EA58090A5ED459815C4D04C2B466F8C566A47@EU-MBX-01.mgc.mentorg.com>
	<20121203135513.GA3426@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TgDDw-0003ed-8F
	for lttng-dev@lists.lttng.org; Wed, 05 Dec 2012 06:33:08 -0500
Content-Disposition: inline
In-Reply-To: <20121203135513.GA3426@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>, Paul Woegerer <paul_woegerer@mentor.com>, Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Gabbasov, Andrew (Andrew_Gabbasov@mentor.com) wrote:
> > Hi Mathieu,
> > 
> > > * Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
> > > > We have added some more ifdef's to kernel probes to more closely match
> > > > the kernel tracepoints for different kernel versions. The changes cover
> > > > kernel versions from 2.6.38 up to 3.7. We did not track the earlier
> > > > versions, and they are filtered out in probes Makefile.
> > > >
> > > > ext3 probe was modified to use #include <../fs/ext3/ext3.h> instead of
> > > > copying this include from kernel source to lttng-modules source.
> > > > Using such includes (there will be more similar in other probes)
> > > > imposes a restriction to use the full kernel source for building
> > > > lttng-modules rather than having just kernel "include" directory,
> > > > but it looks like full source is required anyway, at least with respect
> > > > to Makefiles structure. May be it is worth mentioning somewhere
> > > > in the documentation.
> > > >
> > > > The code was verified to compile with latest versions in all stable
> > > > branches from 2.6.38.x to 3.6.x and 3.7-rc7.
> > > 
> > > I get this build failure on 3.5 with this patch:
> > > 
> > >   CC [M]  /home/compudj/work/lttng-modules/probes/lttng-probe-ext3.o
> > > /home/compudj/work/lttng-modules/probes/lttng-probe-ext3.c:30:29: fatal
> > > error: ../fs/ext3/ext3.h: No such file or directory
> > > compilation terminated.
> > > 
> > > can you look into it and submit a revised patch ?
> > 
> > You must be using kernel headers for building lttng-modules
> > (linux-headers package or something like that), right? This is what I
> > was writing about: since ext3.h is not available in kernel's "include"
> > directory, and in order to avoid duplicating this file in
> > lttng-modules sources, we have to use that <../> based reference, and
> > this requires having full kernel source for building. The same issue
> > will later be with btrfs and ext4 probes: their necessary include
> > files are also not available in kernel headers. 
> > 
> > Trying to duplicate these header files to lttng-modules source seems
> > to be not a good idea, especially if we need to add many ifdef's to
> > them to track different kernel versions. We can try to insert some
> > checks to the Makefile and skip building those probes if we do not
> > have full kernel sources (actually if we do not have necessary include
> > files). Or to declare having full kernel source as a requirement for
> > building lttng-modules. What do you think?
> 
> The user experience should be that if lttng-modules is built against
> linux-headers packages, the build should work fine, even if it means
> some extra features are disabled.
> 
> And we don't want local copies of kernel headers, because then we could
> trigger runtime bugs if the headers don't match between the kernel
> version and local version.
> 
> > 
> > > Also, although the README file states that we support only 3.6.38+, we
> > > happen to also have support for kernels down to 2.6.32 with the patches
> > > in the linux-patches/ directory applied to the appropriate kernel
> > > versions. So it would be good that the instrumentation compiles for
> > > those older kernels too. I promise we won't go further back than 2.6.32
> > > though.
> > 
> > We'll try to add the ifdef's for earlier version down to 2.6.32 to the
> > probes, although the additional amount of conditions makes the code
> > overcomplicated ;-)
> 
> Indeed, but I never said supporting various kernels was easy ;)
> 
> I don't care immensely if older kernels have less features: in some
> cases, it can be just OK to disable an entire tracepoint probe for older
> kernels. I just want the build to work fine for those.
> 
> By the way, we're planning to go for a 2.1 release in a matter of days.
> At that point, I'll have to decide if we keep the recent instrumentation
> commits introduced after the start of the -rc cycle in this release (if
> mature enough), or if we should branch before those for the 2.1 release
> if they need more testing (and keep these instrumentation extensions for
> 2.2). Any thoughts on this ?

I assume no answer means you're OK with it. I'm branching the
lttng-modules master branch at commit
cc4f887d47f83de6cdfd4fc0f93fffc81427cb36, thus creating a stable-2.1
branch, which will be used for the 2.1 release. This will not include
the extra tracepoint instrumentation that entered too late in the rc
cycle. I see these new features are still in a stabilisation phase, and
we need to get 2.1 out the door this week. Therefore, the new
instrumentation will be 2.2 material. Here is the list of commits that
won't make it into 2.1:

e5177f1 Update sites using kernel version checking macro to new range
144bbfd Make upper bound of kernel version checking macro exclusive
180f0df sock instrumentation: fix fields to get referenced values
630bed3 ext3 instrumentation: fix of assignment code conversion
e7b0901 sched instrumentation: rename "pid" fields in sched_process_exec
253be6e Remove remaining semicolons in TP_fast_assign blocks
f95480c Fix compilation for 3.0 kernels that are named 2.6.40
49bafb1 Fix compilation for 3.0 branch (>= 3.0.39)
5fa3880 Add kernel version checking macro
d3ac4d6 Remove semicolons in TP_fast_assign blocks
4a7363f Add ifdefs to net probe to support Linux 2.6.39
b283666 Add kernel probes for supplementary subsystems

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > 
> > Thanks.
> > 
> > Best regards,
> > Andrew Gabbasov
> > 
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
