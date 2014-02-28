From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: baddr feature triggers deadlock in lttng-ust
Date: Fri, 28 Feb 2014 14:05:10 +0000 (UTC)
Message-ID: <373036003.32115.1393596310716.JavaMail.zimbra__34089.4032422968$1393596384$gmane$org@efficios.com>
References: <561294755.31915.1393536606539.JavaMail.zimbra@efficios.com>
	<5310835F.10909@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WJO3u-0004QN-4k
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 09:05:20 -0500
In-Reply-To: <5310835F.10909@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <Paul_Woegerer@mentor.com>
Cc: CS ESD-Analyzer <esd-analyzer@mentor.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org, "CS ESD-Analyzer"
> <esd-analyzer@mentor.com>
> Sent: Friday, February 28, 2014 7:38:55 AM
> Subject: Re: baddr feature triggers deadlock in lttng-ust
> 
> I have looked a bit into the issue...
> 
> The ust_locking inside the dl_iterate_phdr triggers the deadlock.
> 
> If I just collect the base address info inside dl_iterate_phdr and dump
> the collected data with trace_baddr afterwards (outside the
> dl_iterate_phdr iteration) the deadlock will be prevented.
> 
> I'm now going to create a patch that implements this approach.

I suspect that having the UST lock nested inside the dynamic loader lock
only makes the problem happen more consistently, but that the basic issue
is that the dynamic loader lock should not be held while another thread
concurrently calls fork/clone/daemon. It seems to leave the child process
in a state where the lock state is stale (taken).

Thanks,

Mathieu

> 
> Thanks,
> Paul
> 
> On 02/27/2014 10:30 PM, Mathieu Desnoyers wrote:
> > Hi Paul,
> >
> > Please see http://bugs.lttng.org/issues/745, which explains a deadlock
> > we just found out.
> >
> > We might have to disable the baddr dump feature, since our release is
> > tomorrow. We'll have to re-think our locking to protect operations
> > using the dynamic loader lock against fork, clone, and daemon.
> >
> > Thanks,
> >
> > Mathieu
> >
> 
> 
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
