From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng: global_dirty_limit symbol lookup failed
Date: Tue, 2 Apr 2013 09:28:18 -0400
Message-ID: <20130402132818.GB12063__5131.08413802019$1364909350$gmane$org@Krystal>
References: <6C5EA58090A5ED459815C4D04C2B466F8C56DAF3@EU-MBX-01.mgc.mentorg.com>
	<6C5EA58090A5ED459815C4D04C2B466FD931DEDB@EU-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UN1G7-0005MT-8R
	for lttng-dev@lists.lttng.org; Tue, 02 Apr 2013 09:28:19 -0400
Content-Disposition: inline
In-Reply-To: <6C5EA58090A5ED459815C4D04C2B466FD931DEDB@EU-MBX-03.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Gabbasov, Andrew (Andrew_Gabbasov@mentor.com) wrote:
> > From: Gabbasov, Andrew
> > Sent: Monday, February 18, 2013 14:14
> > To: Mathieu Desnoyers
> > Cc: lttng-dev@lists.lttng.org
> > Subject: RE: LTTng: global_dirty_limit symbol lookup failed
> > 
> > > Hi Andrew,
> > >
> > > Commit:
> > >
> > > commit b87700e318c27267890cbd6fb5e50b687279131b
> > > Author: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> > > Date:   Mon Dec 10 11:14:52 2012 -0500
> > >
> > >     Add new kernel probes instrumentation
> > >
> > >     Add kernel probes for btrfs, compaction, ext4, printk, random, rcu,
> > >     regmap, rpm, sunrpc, workqueue, writeback.
> > >
> > >     Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> > >     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > >
> > > has 2 issues:
> > >
> > > 1) it implements a wrapper around global_dirty_limit() in probes/. All
> > >    wrappers should be in /wrapper/, without exception, otherwise the
> > >    code will quickly become unmaintainable (we need to know what
> > >    wrappers we can eventually remove if we remove support for older
> > >    kernels in the future, and we need to be aware of those wrappers for
> > >    complete testing coverage). I have no problem with having a
> > >    probes/Makefile using a relative path (e.g. ../wrapper/somefile.o) as
> > >    input if needed.
> > >
> > > 2) It fills my dmesg log output with:
> > >    "LTTng: global_dirty_limit symbol lookup failed."
> > >    messages. .config follows.
> > >
> > > Can you look into those issues ?
> > >
> > > Thanks,
> > >
> > > Mathieu
> > 
> > Hi Mathieu,
> > 
> > Sorry for a late response.
> > 
> > I'm sending a separate e-mail with the patch to fix these issues. Here are some details:
> > 
> > 1) I moved the wrapper to a separate file wrapper/writeback.h. Since it is supposed to be used
> > in writeback probe only, I think, using static variable will be harmless.
> > 
> > 2) Since global_dirty_limit is not a function, but a global variable, its address is available
> > to kallsyms lookup only if CONFIG_KALLSYMS_ALL is set. In order not to introduce wrapper
> > related checks of this config into tracepoint definition include file, I decided not to exclude
> > separate tracepoints in case of this config absence, but to omit the whole probe from
> > building. So, writeback probe will be available only if CONFIG_KALLSYMS_ALL is set.
> > 
> > 3) Additional issue that I noticed: in case of CONFIG_THUMB2_KERNEL setting for ARM,
> > kallsyms_lookup_funcptr modifies the address found for the symbol. In order to avoid
> > it for data addresses, I introduced a new kallsyms_lookup_dataptr function, that does not
> > do any address modifications. And this new function is used for global_dirty_limit wrapper.
> > 
> > Thanks.
> > 
> > Best regards,
> > Andrew
> 
> Hi Mathieu,
> 
> Any thoughts on these changes?
> Do you need anything else regarding it (the patch itself was sent
> separately on Feb 18, 2013, with a subject "[PATCH lttng-modules]
> Clean up using global_dirty_limit wrapper for writeback probe").

All good! Sorry for the delay, the last months have been hectic :)

Thanks,

Mathieu

> 
> Thanks.
> 
> Best regards,
> Andrew

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
