From: Jon Bernard <jbernard@debian.org>
Subject: Re: a few files without copyright in UST
Date: Fri, 15 Nov 2013 07:41:13 -0500
Message-ID: <20131115124113.GA27366__43086.9565265768$1384519322$gmane$org@shaniqua>
References: <20131115123531.GA25371@shaniqua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jbernard@debian.org>) id 1VhIi8-0008MT-7O
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 07:41:21 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0A47E20BBE
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 07:41:15 -0500 (EST)
Received: from localhost (unknown [108.15.195.199])
	by mail.messagingengine.com (Postfix) with ESMTPA id B39366800F8
	for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2013 07:41:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20131115123531.GA25371@shaniqua>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Jon Bernard <jbernard@debian.org> wrote:
> Since we a tool for this (licensecheck), I see that the following files
> are missing copyright information:
> 
>     ./tests/benchmark/tp.c
>     ./tests/benchmark/ust_tests_benchmark.h

That was in 2.3.0, these are the files in current master:

    ./tests/benchmark/tp.c
    ./tests/benchmark/ust_tests_benchmark.h
    ./tests/tracepoint/benchmark/runtest.sh
    ./tests/tracepoint/benchmark/runstap.sh

-- 
Jon
