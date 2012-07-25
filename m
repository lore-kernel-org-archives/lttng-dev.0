From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Question about the performance of LTTng-UST
Date: Wed, 25 Jul 2012 09:29:37 -0400
Message-ID: <20120725132937.GA14530__15832.7325516895$1343223082$gmane$org@Krystal>
References: <500FBEB3.8070106@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Su1ek-00019v-SU
	for lttng-dev@lists.lttng.org; Wed, 25 Jul 2012 09:29:38 -0400
Content-Disposition: inline
In-Reply-To: <500FBEB3.8070106@emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: changz <zheng.chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* changz (zheng.chang@emc.com) wrote:
> Hi All,
>
> I wrote a very simple test code like this:
>
>         for (i = 0; i < 0xffffff; i++) {
>                 tracepoint(sample_component, message, "This is a  
> performance test:","main",i);
>         }
>
> And then I started lttng and ran the test code:
> time  ./test
> real0m16.120s

This is indeed very high (96 microsecond per event). There is something
wrong with your system (what architecture, kernel version do you use ?
Getting you dmesg log would be useful too, especially to find out which
clock source your kernel uses. Also, are you in a virtualized
environment ? If yes, which ?)

> user0m8.280s
> sys0m7.789s
>
> From the result of time output, you can see sys time is about half of  
> the whole run-time. I wondered where the cost was from.
> So I used strace to track it and found amount of system calls (get_cpu  
> and clock_gettime) during the run-time.
> I know these system calls are used for ring-buffer. But I just think the  
> cost is a little heavy.
>
> What do you think?

On x86, these calls are done through a kernel vDSO. Having those showing
up in strace tells me that you kernel might be quite old, or use use an
architecture that implements those as standard system calls rather than
vDSO.

Thanks,

Mathieu

>
> BR
> Zheng

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
