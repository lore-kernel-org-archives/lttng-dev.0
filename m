From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: 'call_rcu' unstable?
Date: Tue, 11 Dec 2012 12:55:25 -0500
Message-ID: <20121211175524.GB6393__29273.7291929827$1355248629$gmane$org@Krystal>
References: <tencent_3FFFB50C2209B0C914907B07@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TiU3C-0000qL-9Z
	for lttng-dev@lists.lttng.org; Tue, 11 Dec 2012 12:55:26 -0500
Content-Disposition: inline
In-Reply-To: <tencent_3FFFB50C2209B0C914907B07@qq.com>
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
