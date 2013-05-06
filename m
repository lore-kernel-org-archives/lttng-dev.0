From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Add architecture specific tracepoints
Date: Mon, 6 May 2013 08:56:59 -0400
Message-ID: <20130506125659.GE12699__1397.099675569$1367845050$gmane$org@Krystal>
References: <1358526136.50f976b837ad0@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZKyS-0005lP-Bh
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 08:57:00 -0400
Content-Disposition: inline
In-Reply-To: <1358526136.50f976b837ad0@www.imp.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mohamad Gebai (mohamad.gebai@polymtl.ca) wrote:
> Hi,
> I would like to add some of kvm's tracepoints to lttng as only few of them are
> already included. The problem is that those tracepoints are architecture
> specific (in the kernel source: arch/x86/kvm/trace.h). The readme file in
> lttng-modules/instrumentation/events/lttng-module doesn't explain the procedure
> to do this for arch specific folders. Should I add an arch folder in
> lttng-modules/instrumentation/events/mainline and /lttng-module?

I'd go for:

lttng-modules/instrumentation/events/mainline/arch/${ARCH}
lttng-modules/instrumentation/events/lttng-module/arch/${ARCH}

Sorry for the late reply,

Thanks,

Mathieu

> 
> Thanks.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
