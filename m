From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: baddr feature triggers deadlock in lttng-ust
Date: Fri, 28 Feb 2014 13:38:55 +0100
Message-ID: <5310835F.10909__12695.6255677671$1393591313$gmane$org@mentor.com>
References: <561294755.31915.1393536606539.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WJMkF-0003d4-E0
	for lttng-dev@lists.lttng.org; Fri, 28 Feb 2014 07:41:00 -0500
In-Reply-To: <561294755.31915.1393536606539.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org, CS ESD-Analyzer <esd-analyzer@mentor.com>
List-Id: lttng-dev@lists.lttng.org

I have looked a bit into the issue...

The ust_locking inside the dl_iterate_phdr triggers the deadlock.

If I just collect the base address info inside dl_iterate_phdr and dump
the collected data with trace_baddr afterwards (outside the
dl_iterate_phdr iteration) the deadlock will be prevented.

I'm now going to create a patch that implements this approach.

Thanks,
Paul

On 02/27/2014 10:30 PM, Mathieu Desnoyers wrote:
> Hi Paul,
>
> Please see http://bugs.lttng.org/issues/745, which explains a deadlock
> we just found out.
>
> We might have to disable the baddr dump feature, since our release is
> tomorrow. We'll have to re-think our locking to protect operations
> using the dynamic loader lock against fork, clone, and daemon.
>
> Thanks,
>
> Mathieu
>


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
