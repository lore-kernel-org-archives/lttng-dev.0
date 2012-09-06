From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] fix timestamps on architectures
	without	CONFIG_KTIME_SCALAR
Date: Thu, 6 Sep 2012 17:07:08 -0400
Message-ID: <20120906210708.GB10606__36256.704995367$1346965653$gmane$org@Krystal>
References: <1346340992-27307-1-git-send-email-gerlando.falauto@keymile.com>
	<20120906142726.GJ3630@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T9jI5-0008Mw-Ae
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 17:07:09 -0400
Content-Disposition: inline
In-Reply-To: <20120906142726.GJ3630@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Gerlando Falauto (gerlando.falauto@keymile.com) wrote:
> > trace_clock_monotonic_wrapper() should return a u64 representing the
> > number of nanoseconds since system startup.
> > ktime_get() provides that value directly within its .tv64 field only
> > on those architectures defining CONFIG_KTIME_SCALAR, whereas in all
> > other cases (e.g. PowerPC) a ktime_to_ns() conversion (which
> > translates back to .tv64 when CONFIG_KTIME_SCALAR is defined)
> > becomes necessary.
> 
> merged!
> 
> Will make its way into stable-2.0 too.

I did manage to mess the "From" of the patch in my merge though. I
forgot to attribute the commit to you as the author. Sorry about that !

You still appear in the signed-off-by lines though.

Thanks,

Mathieu

> 
> Thanks!
> 
> Mathieu
> 
> > 
> > Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
> > ---
> >  wrapper/trace-clock.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/wrapper/trace-clock.h b/wrapper/trace-clock.h
> > index 6ea9e81..bced61c 100644
> > --- a/wrapper/trace-clock.h
> > +++ b/wrapper/trace-clock.h
> > @@ -46,7 +46,7 @@ static inline u64 trace_clock_monotonic_wrapper(void)
> >  		return (u64) -EIO;
> >  
> >  	ktime = ktime_get();
> > -	return (u64) ktime.tv64;
> > +	return ktime_to_ns(ktime);
> >  }
> >  
> >  static inline u32 trace_clock_read32(void)
> > -- 
> > 1.7.10.1
> > 
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
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
