From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix trace-collection.h: No such file
	or	directory that build code with libbabeltrace
Date: Thu, 23 Aug 2012 08:08:38 -0400
Message-ID: <20120823120838.GA23356__26898.3394875706$1345723750$gmane$org@Krystal>
References: <CANFwon3m1K3KRobkOk-4FSAaoFk8u1ixqVmtB284k-hVRGUXtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T4WDH-0001FF-Tv
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 08:08:39 -0400
Content-Disposition: inline
In-Reply-To: <CANFwon3m1K3KRobkOk-4FSAaoFk8u1ixqVmtB284k-hVRGUXtQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hui Zhu <teawater@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

Mathieu

* Hui Zhu (teawater@gmail.com) wrote:
> Hi,
> 
> After I install the babeltrace and try to build a code, I got this:
> gcc -Wall  -g 1.c -lbabeltrace -lbabeltrace-ctf
> In file included from 1.c:11:0:
> /usr/local/include/babeltrace/babeltrace.h:23:41: fatal error:
> babeltrace/trace-collection.h: No such file or directory
> compilation terminated.
> 
> I check the code,looks most of function of trace-collection.h is
> covered by context.h.
> 
> So I post a patch for it.  Wish you like it.
> 
> Thanks,
> Hui
> 
> --- a/include/babeltrace/babeltrace.h
> +++ b/include/babeltrace/babeltrace.h
> @@ -20,7 +20,6 @@
>  #include <babeltrace/context.h>
>  #include <babeltrace/format.h>
>  #include <babeltrace/iterator.h>
> -#include <babeltrace/trace-collection.h>
>  #include <babeltrace/trace-handle.h>
> 
>  #endif /* _BABELTRACE_H */
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
