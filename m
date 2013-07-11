From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Subject: Re: View for virtual machine monitoring
Date: Thu, 11 Jul 2013 14:08:34 -0400
Message-ID: <1373566114.51def4a22ff9b__20544.9773384773$1373566154$gmane$org@www.imp.polymtl.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD13423326@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mohamad.gebai@polymtl.ca>) id 1UxLIB-0000a2-GD
	for lttng-dev@lists.lttng.org; Thu, 11 Jul 2013 14:08:35 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD13423326@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> > For the sake of our experience, we pinned vCPU0 of VM1 and vCPU0 of VM2 on
> > the same physical CPU, and ran a CPU-intensive workload for one second one
> > each one of them.
> > We generated our traces using the low-overhead LTTng tracer. We can clearly
> > see that during that second, both of the virtual CPUs are fighting over the
> > same physical CPU.
>
>    You should have said "and ran a CPU-intensive workload for one second on
> both of them simultaneously".  Otherwise you may be misconstrued as meaning
> you ran the workloads consecutively.  (The third sentence dispels this
> incorrect reading, but it's better to get the meaning across unambiguously
> the first time)

I agree! Thank you for the feedback,
Mohamad.
