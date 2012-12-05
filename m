From: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Subject: Re: [PATCH lttng-modules] Update kernel probes to
	more	detailed match to kernel versions
Date: Wed, 5 Dec 2012 11:39:52 +0000
Message-ID: <6C5EA58090A5ED459815C4D04C2B466F8C567BBB__2573.81626074693$1354707636$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <20121128155032.GA9266@Krystal>
	<6C5EA58090A5ED459815C4D04C2B466F8C566A47@EU-MBX-01.mgc.mentorg.com>,
	<20121203135513.GA3426@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1TgDKb-0003ij-Qo
	for lttng-dev@lists.lttng.org; Wed, 05 Dec 2012 06:40:02 -0500
In-Reply-To: <20121203135513.GA3426@Krystal>
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

OK, then I'm inserting the checks to Makefile, that build such probes if the full
kernel source is available and to skip them if not.

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

Understood, updated probes (as well as some additional ones) will be
sent soon.

> By the way, we're planning to go for a 2.1 release in a matter of days.
> At that point, I'll have to decide if we keep the recent instrumentation
> commits introduced after the start of the -rc cycle in this release (if
> mature enough), or if we should branch before those for the 2.1 release
> if they need more testing (and keep these instrumentation extensions for
> 2.2). Any thoughts on this ?

I believe, it would be desirable to make more thorough testing of new
instrumentations. On our side the testing was not too extensive, and was
done for ARM platform only. Although the probes are mostly replicating
the kernel's tracepoints, it would be reasonable to keep the commits
in a branch for some time so that more people in the community could
make some testing.

Also, a side note: the "lock" probe seems to be not working. It causes
kernel hang when trying to perform 'lttng start' at least on arm platform).
We suspect that it may be caused by some kind of locks recursion or
deadlocks (since tracing engine use locks too and they may be tried
to trace again). There is no solution or even more detailed analysis
so far, so I'll disable building of "lock" probe in the next update.

Thanks.

Best regards,
Andrew
