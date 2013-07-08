From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Issue with dynamic load and UST
Date: Mon, 8 Jul 2013 10:45:35 -0400
Message-ID: <20130708144535.GB29362__37225.0949185856$1373294769$gmane$org@Krystal>
References: <1369248382.1847.41.camel@station15.dorsal.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCh6-0005e4-M8
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:45:36 -0400
Content-Disposition: inline
In-Reply-To: <1369248382.1847.41.camel@station15.dorsal.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Suchakra Sharma <suchakrapani.sharma@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Suchakra Sharma (suchakrapani.sharma@polymtl.ca) wrote:
> Hi,
> 
> Zifei recently did a demo of dynamic tracing using ust with dyninst [1] The traces are being generated 
> and I did some experiments by adding some more 'tracepoint types' too [2]. This seemed to be a promising 
> approach but then there's an error as follows when I start tracing on a fresh rebooted machine (if a 
> normal session of static userspace tracing is done once, the problem doesn't occur):
> 
> libust[3429/3429]: Error: Timed out waiting for lttng-sessiond (in lttng_ust_init() at lttng-ust-comm.c:1072)
> 
> This occurred even after separating the tracepoints [3] Backtrace is at [4]. I was able to reproduce it on my 
> two machines with UST 2.1.2 and dyninst 8.1 (Fedora 18) 
> 
> Is it possible to circumvent this problem somehow? (it seems to be an inherent issue with dlopen w/ sessiond 
> but I may be wrong) 
> 
> 
> [1] https://gist.github.com/anonymous/5599765 
> [2] https://gist.github.com/tuxology/5602019
> [3] https://gist.github.com/anonymous/5605050
> [4] https://gist.github.com/5kg/5604931

This appears to be a deadlock between the ust_lock and an internal lock
in glibc's dynamic linker.

See this commit:

commit eddd8d5d1a04887d1979417f1aca6c2f109bfe50
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Mar 1 12:00:04 2012 -0500

    Fix: fix deadlock with dlopen() lttng-ust
    
    Pre-"fault" the libuuid TLS outside of the ust lock to ensure that we
    never deadlock with the linker mutex in libc. This mutex is held both
    for TLS fixup of dlopen'd libs, and across execution of all
    constructors. We therefore have a reverse use of this mutex wrt ust
    lock, that we fix by forcing the TLS fixup to happen very early in the
    lttng-ust constructor.
    
    [fixed merge from dev branch]
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Good luck!

Mathieu


> 
> 
> --
> Suchakra
> 
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
