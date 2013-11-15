From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: a few files without copyright in UST
Date: Fri, 15 Nov 2013 15:47:26 +0000 (UTC)
Message-ID: <110492599.68270.1384530446598.JavaMail.zimbra__32129.0020402104$1384530514$gmane$org@efficios.com>
References: <20131115123531.GA25371@shaniqua> <20131115124113.GA27366@shaniqua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VhLcF-0006fZ-SR
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 10:47:33 -0500
In-Reply-To: <20131115124113.GA27366@shaniqua>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Jon Bernard" <jbernard@debian.org>
> To: lttng-dev@lists.lttng.org
> Sent: Friday, November 15, 2013 7:41:13 AM
> Subject: Re: [lttng-dev] a few files without copyright in UST
> 
> * Jon Bernard <jbernard@debian.org> wrote:
> > Since we a tool for this (licensecheck), I see that the following files
> > are missing copyright information:
> > 
> >     ./tests/benchmark/tp.c
> >     ./tests/benchmark/ust_tests_benchmark.h
> 
> That was in 2.3.0, these are the files in current master:
> 
>     ./tests/benchmark/tp.c
>     ./tests/benchmark/ust_tests_benchmark.h
>     ./tests/tracepoint/benchmark/runtest.sh
>     ./tests/tracepoint/benchmark/runstap.sh

Should be all fixed now, thanks!

Mathieu

> 
> --
> Jon
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
