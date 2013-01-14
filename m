From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-modules PATCH] Add uprobes support
Date: Mon, 14 Jan 2013 14:51:04 -0500
Message-ID: <20130114195104.GA11211__38647.7375207052$1358193107$gmane$org@Krystal>
References: <1358131230-3446-1-git-send-email-yannick.brosseau@gmail.com>
	<50F448D6.7050600@redhat.com> <50F44BFB.3070206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tuq3k-0001Rz-62
	for lttng-dev@lists.lttng.org; Mon, 14 Jan 2013 14:51:04 -0500
Content-Disposition: inline
In-Reply-To: <50F44BFB.3070206@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> On 2013-01-14 13:05, Josh Stone wrote:
> > On 01/13/2013 06:40 PM, Yannick Brosseau wrote:
> >> +	ret = uprobe_register(event->u.uprobe.inode,
> >> +			event->u.uprobe.offset,
> >> +			&event->u.uprobe.up_consumer);
> >> +	uprobe_unregister(event->u.uprobe.inode,
> >> +			event->u.uprobe.offset,
> >> +			&event->u.uprobe.up_consumer);
> > I'm guessing that you're using a Fedora kernel? :)
> Oh, you're right... I did not realize that the vanilla kernel did not
> contains those export.
> >
> > These functions are not yet exported upstream, but coincidentally I just
> > posted a patch for that a few days ago:
> >
> >   https://patchwork.kernel.org/patch/1962891/
> >   https://lkml.org/lkml/2013/1/13/118
> >
> > If there's any more complaint about this, maybe you can chime in to
> > advocate for lttng's needs too.
> >
> Ok, I'll weight in if necessary.

Yes, we should be able to help out if needed.

Meanwhile, we could use kallsyms to lookup these symbols and use them,
as we already do in a couple of header under wrappers/ in lttng-modules.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
