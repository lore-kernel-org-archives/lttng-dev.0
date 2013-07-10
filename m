From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: How much shared memory is used by LTTng (UST) ?
Date: Wed, 10 Jul 2013 16:05:35 -0400
Message-ID: <20130710200535.GA11096__46813.8697710403$1373486770$gmane$org@Krystal>
References: <OFCCB7B255.8E21590D-ONC2257BA4.004A6CD2-C2257BA4.004B3116@il.ibm.com>
	<20130710135939.GA2331@Krystal>
	<OF915EC9C3.D105E64F-ONC2257BA4.004D98BF-C2257BA4.004E8DA6@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ux0ds-0006cF-Q5
	for lttng-dev@lists.lttng.org; Wed, 10 Jul 2013 16:05:36 -0400
Content-Disposition: inline
In-Reply-To: <OF915EC9C3.D105E64F-ONC2257BA4.004D98BF-C2257BA4.004E8DA6@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Amit Margalit (AMITM@il.ibm.com) wrote:
> That explains a lot. Our SHM space is hard coded to 64MB, which limits me 
> big-time.
> 
> It still doesn't explain why I was able to add procname to the context but 
> adding also vpid and vtid failed when the number of cores was 24 rather 
> than 12.

No idea. These are unrelated.

Thanks,

Mathieu

> 
> I mean - the formula you give (and we use per-UID buffers) doesn't seem to 
> be related to what's in context and what's not...
> 
> Now, on the 12 core (6+HT) system, I would need - 
> 
> nb_traced_users(=1) * subbuf_size(=256KB) * nr_subbuf(=16) * nb_cpus(=12) 
> = 1*256KB*16*16 = 48MB
> 
> But the same arguments worked just fine on the 24-core system, including 
> adding procname to context. Adding vtid + vpid worked on the 12-core, but 
> failed on the 24-core system.
> 
> Any ideas why?
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> 
> 
> 
> From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To:     Amit Margalit/Israel/IBM@IBMIL
> Cc:     lttng-dev@lists.lttng.org
> Date:   07/10/2013 04:59 PM
> Subject:        Re: [lttng-dev] How much shared memory is used by LTTng 
> (UST) ?
> 
> 
> 
> * Amit Margalit (AMITM@il.ibm.com) wrote:
> > Hi,
> > 
> > Chasing down an issue with adding some context (see 
> > https://bugs.lttng.org/issues/579), I've encountered something that 
> makes 
> > me think the failures I am seeing are related to amount of shared memory 
> 
> > that LTTng uses...
> > 
> > In short - when the subbuffers have a large enough size and number, 
> adding 
> > things to context on a multi-core system can cause libringbuffer/shm.c 
> in 
> > lttng-ust to complain about "No space left on device", leading to 
> > everything looking OK, except that the trace directory stays empty.
> > 
> > I am working on a 6-core (12 with HT) system that has 24GB of RAM. This 
> is 
> > one configuration, but we also have dual-CPU systems (i.e. 12 cores / 24 
> 
> > with HT) with 96GB.
> > 
> > I am using 16 subbuffers of 256KB. In this setup, I have no problem 
> adding 
> > procname, vpid and vtid to the context.
> > 
> > When I tried the same on the 12-core dual-CPU system, it failed as 
> > explained above. I tried reducing the subbuffer sizes to 64KB, and the 
> > problem disappeared.
> > 
> > So - how can I tell how much shared memory LTTng wants, and - if you 
> know 
> > - how can I configure my system to allow more than the default?
> 
> First thing, try using per-uid buffers rather than the 2.2 default
> (per-pid buffers).
> 
> If you do that, then you will need:
>   nb_traced_users * subbuf_size * nr_subbuf * nb_cpus   as shm space.
> 
> If you stay with per-pid buffers, then you need
>   nb_processes * subbuf_size * nr_subbuf * nb_cpus   as shm space.
> 
> On my system here, I notice that each shm creates files within /run/shm
> (this location may differ on your system). It is a tmpfs filesystem. You
> might want to increase its size. For instance, here, it is 1.6GB.
> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Thanks,
> > 
> > Amit Margalit
> > IBM XIV - Storage Reinvented
> > XIV-NAS Development Team
> > Tel. 03-689-7774
> > Fax. 03-689-7230
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
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
