From: "=?utf-8?B?enM=?=" <84500316@qq.com>
Subject: Re: 'call_rcu' unstable?
Date: Wed, 12 Dec 2012 09:47:15 +0800
Message-ID: <tencent_69E24282190096EF5FC461EC__27161.9629733779$1355276950$gmane$org@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpbg238.qq.com ([183.62.127.194])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <84500316@qq.com>) id 1TibQv-0004S5-0s
	for lttng-dev@lists.lttng.org; Tue, 11 Dec 2012 20:48:27 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?utf-8?B?TWF0aGlldSBEZXNub3llcnM=?= <mathieu.desnoyers@efficios.com>
Cc: =?utf-8?B?bHR0bmctZGV2?= <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks , BUT ...
I really check my code:

zs# find .|xargs grep rcu_read 

./sslvpn_ctx.c: rcu_read_lock();
./sslvpn_ctx.c:                 rcu_read_unlock();
./sslvpn_ctx.c: rcu_read_unlock();

AND in sslvpn_ctx.c:
void *sslvpn_lookup_ssl(unsigned long iip)
{
        struct sslvpn_ctx *ctx;
        int h;

        h = get_hash(iip, 0);

        rcu_read_lock();
        cds_list_for_each_entry_rcu(ctx, &g_sslvpnctxlist[h], cdlist) {
                if ((ctx->flags & SSL_CTX_ESTABLISHED) && ctx->iip && ctx->iip == iip) {

                        uatomic_add(&ctx->ssl_use, 1);
                        rcu_read_unlock();
                        return ctx;
                }
        }

        rcu_read_unlock();
        return NULL;
}

By the way, *sslvpn_lookup_ssl* called by 6 threads for TX.
the 7th thread only will call *call_rcu*:

int sslvpn_del_ctx(struct sslvpn_ctx *pctx)
{
        ...
        cds_list_del_rcu(&ctx->cdlist);
        ctx->flags |= SSL_CTX_DYING;
        call_rcu(&ctx->rcu, func);
        ...
}





------------------ Original ------------------
From:  "Mathieu Desnoyers"<mathieu.desnoyers@efficios.com>;
Date:  Wed, Dec 12, 2012 01:55 AM
To:  "zs"<84500316@qq.com>; 
Cc:  "lttng-dev"<lttng-dev@lists.lttng.org>; 
Subject:  Re: [lttng-dev] 'call_rcu' unstable?



* zs (84500316@qq.com) wrote:
> Hi list,
> 
> I found a big problem in my product, that use urcu 0.7.5. My program cost too mutch CPU in the funtion 'update_counter_and_wait:uruc.c:247', and I use gdb to see to *wait_loops*, it says -167777734. The CPU usage grows up from 1% to 100% in one day!
> 
> 
> Here is the sample code to show how I use urcu library:
> 
> #include <urcu.h>
> 
> thread ()
> {
> rcu_register_thread();
> 
> for (;;) {
> rcu_read_lock();
> xxx
> rcu_read_unlock();

Please triple-check that all your rcu_read_lock() and rcu_read_unlock()
are balanced (no double-unlock, nor missing unlock for each lock taken).

The type of problem you get would happen in such a case.

Thanks,

Mathieu

> }
> }
> 
> main()
> {
> rcu_init();
>   pthread_create(, , , , thread);
> 
> rcu_register_thread();
> for (;;)
> {
>  if (xxx)
>    call_rcu();
> }
> 
> }
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
