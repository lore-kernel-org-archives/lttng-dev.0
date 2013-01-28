From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: bug?
Date: Mon, 28 Jan 2013 11:37:12 -0500
Message-ID: <20130128163712.GA23710__23549.0044382916$1359391095$gmane$org@Krystal>
References: <8E0A14A4C9B95B459AE214584119C1EB3BC909B3@Hal.ad.unb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tzrhy-0000vs-C5
	for lttng-dev@lists.lttng.org; Mon, 28 Jan 2013 11:37:22 -0500
Content-Disposition: inline
In-Reply-To: <8E0A14A4C9B95B459AE214584119C1EB3BC909B3@Hal.ad.unb.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yang Wang <yangw.wang5@unb.ca>
Cc: Kenneth Kent <ken@unb.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, ",
	" <Grame_johson@ca.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Yang Wang (yangw.wang5@unb.ca) wrote:
> Hello,
> 
> I am Yang Wang, I am currently using lttng to trace my JVM.
> 
> During my using lttng in tracing JVM, I found three problems,
> 
>  1) in lttng-ust-2.1.0/include/lttng/ust-tracepoint-event.h
> 
>      why using an assertion "assert(!ret);"  (Line676)?
>      not allowing double registering and init?
>      if double registering or initialization (provider), why not allowed just returning silently instead
>       of aborting"? How about comments assert(!ret); ==>//assert(!ret); what is the side-effects
>       of doing this?

This would be caused by having two different versions of .so with
conflicting provider name. This is usually a linking issue, and/or due
to the fact that your system has old/deprecated provider .so still
reachable.

If your system has only one version of the provider available, you would
not trigger double registering.

So I don't see how silently allowing multiple non-matching providers
(and using just the first one that happened to be loaded) would help
diagnosing bogus setups.

> 
>  2) The other problem is in ./userspace-rcu-0.7.5/urcu/list.h Line85
> 
>   I have to add a guard "if" statement as the assertion in my program fails otherwise
> 
>   static inline void
>   __cds_list_del (struct cds_list_head *prev, struct cds_list_head *next)
>   {
>    if (prev != NULL && next != NULL) {
>       //assert(prev != NULL && next != NULL);
>       next->prev = prev;
>       prev->next = next;
>   }

It might be caused by e.g. double registration issues I'm talking about,
now that you removed the assert in __lttng_events_init__.

You should verify which provider .so are reachable, and make sure you
don't try to load two different providers with the same name.

> 
>  3) Now my instrumented prog is ready to run. Here is my commands:
>      lttng create
>      lttng enable-event -u -a
>      lttng start
>      ./prog
> 
>     The (lttng) instrumented prog is stuck there without any outputs
>     related to lttng tracing, how can I know what happen inside.
>     In other words, does lttng have any mechanism to trace itself?

Start with LTTNG_UST_DEBUG=1 env. var. set (see man 3 lttng-ust)

gdb is usually pretty good at letting us know the culprit of such a
hang. Recommendation: compile your program with CFLAGS="-O0 -g", and use
"thread apply all bt full" to see the stack of each thread.

Best regards,

Mathieu


> 
>    Thanks
> 
>    Yang

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
