From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Sat, 8 Feb 2014 16:06:32 +0000 (UTC)
Message-ID: <1380151240.21051.1391875592403.JavaMail.zimbra__10112.7063193873$1391875635$gmane$org@efficios.com>
References: <52F55511.2080309@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WCAQO-000360-Fy
	for lttng-dev@lists.lttng.org; Sat, 08 Feb 2014 11:06:37 -0500
In-Reply-To: <52F55511.2080309@mentor.com>
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



----- Original Message -----
> From: "Stefan Seefeld" <stefan_seefeld@mentor.com>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, February 7, 2014 4:50:09 PM
> Subject: [lttng-dev] RFC: Fix crash in dlerror()
> 
> I have been looking into an issue with the malloc wrapper, where an
> unsuccessful call to dlopen(), followed by a call to dlerror(), would
> result in a segmentation fault when the malloc wrapper is being used.
> 
> The problem is the following:
> 
> The functions dlopen() and dlsym() make use of a global (though
> thread-local) "result" structure to hold the error state, to allow a
> subsequent call to dlerror() to report it.
> 
> As it turns out, dlerror() itself may implicitly call realloc(), which,
> if it hasn't been used before, triggers our wrapper to call dlsym(). So,
> while dlerror() inspects said result structure, dlsym() re-initializes
> it, causing the crash...
> 
> This is arguably a bug in the dlfcn functions. The attached patch
> attempts to fix this by moving the initialization of the realloc()
> wrapper (i.e., the loading of the symbol) into the constructor. This
> fixes the crash that I'm observing, but since none of these dependencies
> are specified or documented, this change may cause other issues elsewhere.
> 
> Are there any objections to this approach ? If not, I'll submit a formal
> patch for this.

The issue I see with the approach you propose is if dlsym() is used
within another constructor (from anoter lib for instance). Given that
the order of constructor execution should be assumed to be random, we can
run into the same error scenario you describe here.

Thoughts ?

Thanks,

Mathieu

> 
> Thanks,
>         Stefan
> 
> --
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
> 
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
