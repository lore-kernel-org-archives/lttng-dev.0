From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Sync instrumentation to today's linux 3.8
Date: Mon, 28 Jan 2013 11:19:53 -0500
Message-ID: <20130128161953.GB23427__12257.2373169989$1359390042$gmane$org@Krystal>
References: <CAC6yHM5Vd8zZc-1nmFuVfuxiH3yUwA+mNUd6cejZFfvFb4kURw@mail.gmail.com>
	<20130128161555.GA23427@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TzrR4-0000mt-QF
	for lttng-dev@lists.lttng.org; Mon, 28 Jan 2013 11:19:54 -0500
Content-Disposition: inline
In-Reply-To: <20130128161555.GA23427@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> > To prepare instrumentation for the next linux release, here is the ticket I
> > was working on. It's mostly straight forward.
> > 
> > http://redmine.dorsal.polymtl.ca/issues/431
> > 
> > There is one issue with ext4 includes. I had to copy fs/ext4/ext4.h and
> > ext4_extent.h for the function ext4_ext_get_actual_len(). I added them to
> > instrumentation/mainline/fs/ext4 directory. I'm not sure if it's the best
> > solution.
> > 
> > Still testing to do, thought. BTW, is there a test setup for regression? I
> > would like to verify that it doesn't break any supported kernel and I don't
> > have the required setup.
> > 
> > With this, maybe lttng-modules 2.1 can target linux 3.8?

And FYI, ext4 tracepoints are only in lttng-modules master branch. They
were excluded from 2.1.x because they arrived too late in the 2.1 cycle.

Thanks,

Mathieu

> 
> Please send the patch by email.
> 
> 3.8 is still in rc stage. Removing ext4_ext_get_actual_len() seems like
> a bad move from upstream Linux if it is needed in the instrumentation
> headers. This should be fixed upstream rather than duplicated within our
> own code.
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Cheers,
> > 
> > Francis
> 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
