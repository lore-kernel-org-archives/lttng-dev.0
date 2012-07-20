From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng-UST alternative to LD_PRELOAD
Date: Fri, 20 Jul 2012 14:13:21 -0400
Message-ID: <20120720181321.GB20073__4759.97812250188$1342808033$gmane$org@Krystal>
References: <1339945703.2599.21.camel@DellE5500>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SsHhb-00005V-35
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 14:13:23 -0400
Content-Disposition: inline
In-Reply-To: <1339945703.2599.21.camel@DellE5500>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lars <lars@grandepotatis.se>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Lars (lars@grandepotatis.se) wrote:
> 
> Hello,
> 
> I have recently started to use LTTng-UST and am using LD_PRELOAD
> to make it possilbe to execute instrumented code on systems without
> LTTng-UST installed.
> 
> To define LD_PRELOAD however affects too much. For instance all
> forked processes also get the library loaded. This can be fixed by
> removing the library from the LD_PRELOAD variable early in the main
> function. This looks odd and required some explaining in comments.

good point. LD_PRELOAD was originally the only way we allowed lttng-ust
to be loaded, because during the rc phase of the lttng-ust 2.0
development, we had issues with dlopening liblttng-ust. This has been
fixed within the rc stages though, so we could go for a dlopen approach
now.

> 
> Also, in my case, the instrumented program is started with a "wrapper"
> program which I can not alter. This wrapper also gets the library
> loaded.
> 
> As an alternative to using LD_PRELOAD I would like to use an explicit
> function, like;
> 
>   int traceload(char const* library_path);

or maybe:

int lttng_ust_dlopen(const char *library_path);

?

> that is called early in main (instead of the LD_PRELOAD environment
> manipulation) and loads the library with dlopen if it exists.

yep, makes sense.

> 
> I have already tried this (of course) and it almost works already.
> The tracepoints becomes visible but I get no trace data written.
> So I think a really small modification is needed.
> 
> Is anything like this planned?

if you can provide a patch, I'd be glad to review & merge it.

> 
> Or can anybody give me a hint on what is missing?

Try running your app with the env. var LTTNG_UST_DEBUG=1  set. It might
provide helpful info. If you still have problems, please post your patch
as RFC along with specific test programs so we can look at the behavior.

Thanks,

Mathieu

> 
> I checked the mailing list a couple of months back but did not
> find anything.
> 
> Best Regards,
> Lars Ekman
> 
> 
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
