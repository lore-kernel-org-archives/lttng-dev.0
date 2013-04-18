From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Limitations on subbuf_size / num_subbuf?
Date: Thu, 18 Apr 2013 13:23:39 -0400
Message-ID: <20130418172339.GA3151__40732.0746024654$1366305846$gmane$org@Krystal>
References: <OFC51F8E88.28285A69-ONC2257B4D.003B3B3E-C2257B4D.003B6399@il.ibm.com>
	<516C0D60.1050503@ericsson.com>
	<OFC6774750.9138DA2C-ONC2257B51.002189D3-C2257B51.0021DDB3@il.ibm.com>
	<51702491.1000007@voxpopuli.im> <20130418170748.GA32330@Krystal>
	<51702A9F.2010803@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1USsYe-0005ND-MN
	for lttng-dev@lists.lttng.org; Thu, 18 Apr 2013 13:23:40 -0400
Content-Disposition: inline
In-Reply-To: <51702A9F.2010803@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> On 13-04-18 01:07 PM, Mathieu Desnoyers wrote:
> > * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> >> On 13-04-18 02:11 AM, Amit Margalit wrote:
> >>> Hi,
> >>>
> >>> Thank for the quick response. Here is the missing data:
> >>>
> >>> UST
> >>> 2.6.32.12-205 (I had to make a tiny patch to make it compile)
> >>> MemTotal:       24628852 kB
> >>> lttng-ust-2.1.2
> >>> lttng-tools-2.1.1
> >>> lttng-modules-2.1.1
> >>> babeltrace-1.1.0
> >>> userspace-rcu-0.7.6
> >>>
> >>> Which patch for 4MB?
> >> Hi,
> >>
> >> Not sure if it's specifically this one that Matthew was talking about,
> >> but we have such a patch in the PPA packages. See:
> >> http://bazaar.launchpad.net/~lttng/lttng-tools/packaging-daily/view/head:/patches/0002-Increase-default-subbuffer-size-to-4MB.patch
> > First, it should be noted that lttng enable-channel allow overriding the
> > subbuffer size.
> 
> True that. But the value needs to be a power of two (which is not
> immediately obvious to new users). And if it's not exactly a power of
> two, it gets rejected, instead of simply rounding to the closest one. We
> have a patch for that too. ;)

I've never seen it on lttng-dev. Please share it, don't be shy :)

> 
> > It should be noted that lttng-modules 2.2 is going to output even _more_
> > events, so I don't think just making the buffers larger by default is
> > the right approach.
> 
> If it's gonna output more events, don't we want larger sizes?

No, because at some point, you want the default to take into account
typical HW configuration limitations. Usually, systems should not be
expected to be dedicated to tracing: whatever memory the tracer reserves
is less memory available for page cache and application, and therefore
more impact on the system.
> 
> >
> > I think we need to port the "loglevel" from UST to lttng-modules ASAP,
> > and assign a "debug" loglevel to events we don't care about by default.
> 
> This sounds like a good idea.
> 
> My main concern was that most users don't read the man pages, don't
> fiddle with custom flags, etc. They just run enable-event -a, then start
> tracing. In this setup, they should not expect dropped events.

Yep. Having loglevels should take care of that: debug-level events would
not be enabled unless a specific loglevel is specified.

Thanks,

Mathieu

> 
> Cheers,
> Alex
> 
> >
> > Thoughts ?
> >
> > Thanks,
> >
> > Mathieu
> >
> >>> Thanks,
> >>>
> >>> Amit Margalit
> >>> IBM XIV - Storage Reinvented
> >>> XIV-NAS Development Team
> >>> Tel. 03-689-7774
> >>> Fax. 03-689-7230
> >>>
> >>>
> >>>
> >>> From:   Matthew Khouzam <matthew.khouzam@ericsson.com>
> >>> To:     <lttng-dev@lists.lttng.org>
> >>> Date:   04/15/2013 05:24 PM
> >>> Subject:        Re: [lttng-dev] Limitations on subbuf_size / num_subbuf?
> >>>
> >>>
> >>>
> >>> Not at all a n00b question, but could you give some more info? what is 
> >>> your version of LTTng tools, are you using UST or kernel tracing? How much 
> >>> ram is on your system? Kernel version? 
> >>>
> >>> I actually have the patched lttng that has standard subbuffer sizes of 4 
> >>> mb, so I have not personnaly seen that problem. But the first thing I 
> >>> would do is upgrade to the latest stable.
> >>>
> >>> On 13-04-14 06:49 AM, Amit Margalit wrote:
> >>> Hello, 
> >>>
> >>> Sorry for the noob question. I seem to be unable to define the total of 
> >>> subbuf_size * num_subbuf higher than 4MB. I am getting ~30% discarded 
> >>> tracepoint data. 
> >>>
> >>> Any assistance would be greatly appreciated. 
> >>>
> >>> Amit Margalit 
> >>> IBM XIV - Storage Reinvented 
> >>> XIV-NAS Development Team 
> >>> Tel. 03-689-7774 
> >>> Fax. 03-689-7230 
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
