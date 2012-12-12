From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: 'call_rcu' unstable?
Date: Tue, 11 Dec 2012 21:41:20 -0500
Message-ID: <20121212024120.GA19284__22002.0824847326$1355280425$gmane$org@Krystal>
References: <tencent_29113C2C186D9DCF3BDBA809@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TicGA-0004r9-5n
	for lttng-dev@lists.lttng.org; Tue, 11 Dec 2012 21:41:22 -0500
Content-Disposition: inline
In-Reply-To: <tencent_29113C2C186D9DCF3BDBA809@qq.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: zs <84500316@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* zs (84500316@qq.com) wrote:
> Thanks , BUT ...
> I really check my code:
> 
> zs# find .|xargs grep rcu_read 
> 
> ./sslvpn_ctx.c: rcu_read_lock();
> ./sslvpn_ctx.c:                 rcu_read_unlock();
> ./sslvpn_ctx.c: rcu_read_unlock();

OK, in that case, continuing on the debugging checklist:

- Did you ensure that you issue rcu_register_thread() at thread start of
  each of your threads ? And rcu_register_thread before returning from
  each thread ?
- How is the list g_sslvpnctxlist[h] initialized ? Are there concurrent
  modifications of this list ? If yes, are they synchronized with a
  mutex ?
- When your application is a state where the call_rcu worker thread
  busy-waits on RCU read-side critical sections, it would be interesting
  to know on what read-side critical section it is waiting. In order to
  do so, from gdb attached to your process when it is hung:
  - we'd need to look at the urcu.c "registry" list. We'd need to figure
    out which list entries are keeping the busy-loop waiting.
  - then, we should look at each thread's "rcu_reader" TLS variable, to
    see its address and content.
  By comparing the content of the list and each active thread's
  rcu_reader TLS variable, we should be able to figure out what is
  keeping grace period to complete. If you can provide these dumps, it
  would let me help you digging further into your issue.

Thanks,

Mathieu


> 
> AND in sslvpn_ctx.c:
> void *sslvpn_lookup_ssl(unsigned long iip)
> {
>         struct sslvpn_ctx *ctx;
>         int h;
> 
>         h = get_hash(iip, 0);
> 
>         rcu_read_lock();
>         cds_list_for_each_entry_rcu(ctx, &g_sslvpnctxlist[h], cdlist) {
>                 if ((ctx->flags & SSL_CTX_ESTABLISHED) && ctx->iip && ctx->iip == iip) {
> 
>                         uatomic_add(&ctx->ssl_use, 1);
>                         rcu_read_unlock();
>                         return ctx;
>                 }
>         }
> 
>         rcu_read_unlock();
>         return NULL;
> }
> 
> By the way, *sslvpn_lookup_ssl* called by 6 threads for TX.
> the 7th thread only will call *call_rcu*:
> 
> int sslvpn_del_ctx(struct sslvpn_ctx *pctx)
> {
>         ...
>         cds_list_del_rcu(&ctx->cdlist);
>         ctx->flags |= SSL_CTX_DYING;
>         call_rcu(&ctx->rcu, func);
>         ...
> }
> 
> 
> 
> 
> 
> ------------------ Original ------------------
> From:  "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>;
> Date:  Wed, Dec 12, 2012 01:55 AM
> To:  "zs"<84500316@qq.com>; 
> Cc:  "lttng-dev"<lttng-dev@lists.lttng.org>; 
> Subject:  Re: [lttng-dev] 'call_rcu' unstable?
> 
> 
> 
> * zs (84500316@qq.com) wrote:
> > Hi list,
> > 
> > I found a big problem in my product, that use urcu 0.7.5. My program cost too mutch CPU in the funtion 'update_counter_and_wait:uruc.c:247', and I use gdb to see to *wait_loops*, it says -167777734. The CPU usage grows up from 1% to 100% in one day!
> > 
> > 
> > Here is the sample code to show how I use urcu library:
> > 
> > #include <urcu.h>
> > 
> > thread ()
> > {
> > rcu_register_thread();
> > 
> > for (;;) {
> > rcu_read_lock();
> > xxx
> > rcu_read_unlock();
> 
> Please triple-check that all your rcu_read_lock() and rcu_read_unlock()
> are balanced (no double-unlock, nor missing unlock for each lock taken).
> 
> The type of problem you get would happen in such a case.
> 
> Thanks,
> 
> Mathieu
> 
> > }
> > }
> > 
> > main()
> > {
> > rcu_init();
> >   pthread_create(, , , , thread);
> > 
> > rcu_register_thread();
> > for (;;)
> > {
> >  if (xxx)
> >    call_rcu();
> > }
> > 
> > }
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
-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
