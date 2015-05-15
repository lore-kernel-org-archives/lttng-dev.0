From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Using tracepoint call inside a macro
Date: Fri, 15 May 2015 16:03:51 +0000 (UTC)
Message-ID: <1492353728.2098.1431705831953.JavaMail.zimbra__3327.71377075023$1431705894$gmane$org@efficios.com>
References: <553616B4.4060706@oneaccess-net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YtI5b-0006da-Q2
 for lttng-dev@lists.lttng.org; Fri, 15 May 2015 12:03:58 -0400
In-Reply-To: <553616B4.4060706@oneaccess-net.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Franck Balazot <franck.balazot@oneaccess-net.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> Hi all,
> 
> I wonder if it is possible to define a macro containing a tracepoint
> (which is also a macro) call.
> 
> As a very simple example, using :
> 
> #define TRACE(subsystem, tracepoint, params...) tracepoint(subsystem,
> tracepoint, params)
> 
> TRACE(provider, tp1, arg);
> 
> is not compiling (tracepoint macro seems not to be expanded), whereas
> direct call
> 
> tracepoint(provider, tp1, arg);
> 
> is compiling.
> 
> Any idea ?

Try renaming your TRACE() argument "tracepoint" to something else,
e.g. "_tracepoint", so it does not clash with the "tracepoint" macro
name.

Thanks,

Mathieu

> 
> BR
> Franck
> 
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
