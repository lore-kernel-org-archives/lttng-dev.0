From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Wed, 12 Feb 2014 21:59:09 +0000 (UTC)
Message-ID: <1009657763.24078.1392242349218.JavaMail.zimbra__35589.4191227437$1392242410$gmane$org@efficios.com>
References: <52F55511.2080309@mentor.com> <52F66118.5010003@mentor.com>
	<905376946.21151.1391898148330.JavaMail.zimbra@efficios.com>
	<52F9746F.5070302@mentor.com>
	<1494953964.23233.1392151900002.JavaMail.zimbra@efficios.com>
	<52FA8E5C.40203@mentor.com>
	<975853026.23546.1392176395828.JavaMail.zimbra@efficios.com>
	<2141704629.23782.1392215703555.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WDhpp-0000kh-0t
	for lttng-dev@lists.lttng.org; Wed, 12 Feb 2014 16:59:18 -0500
In-Reply-To: <2141704629.23782.1392215703555.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Patch merged into master as commit:

commit 2594a5b4f2b60642973b4941ee506be41786c4d3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sat Feb 8 17:12:16 2014 -0500

    Fix: malloc libc instrumentation wrapper
    
    calloc and realloc wrt dlsym and dlerror can trigger segmentation
    faults. Ensure that we fully populate the allocator symbols all at once,
    and also ensure that we use the static allocator while doing the dlsym
    lookups.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Stefan Seefeld" <stefan_seefeld@mentor.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, February 12, 2014 9:35:03 AM
> Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
> 
> Updated patch, now ensuring that the wrapper is initialized before
> UST starts other threads. It now has a constructor function that will
> take care of initializing the wrapper before other program threads are
> started anyhow.
> 
> I also added a missing lookup check (calloc pointer) within realloc
> (branch handling realloc of a statically allocated pointer).
> 
> Thanks,
> 
> Mathieu
> 
> ----- Original Message -----
> > From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > To: "Stefan Seefeld" <stefan_seefeld@mentor.com>
> > Cc: lttng-dev@lists.lttng.org
> > Sent: Tuesday, February 11, 2014 10:39:55 PM
> > Subject: Re: [lttng-dev] RFC: Fix crash in dlerror()
> > 
> > Updated patch, now with tracepoints in the static allocator.
> > 
> > Review welcome,
> > 
> > Thanks,
> > 
> > Mathieu
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
