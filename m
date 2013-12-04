From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Ctf-testsuite bug
Date: Wed, 4 Dec 2013 19:31:32 +0000 (UTC)
Message-ID: <1224034384.79875.1386185492812.JavaMail.zimbra__35230.351080145$1386185565$gmane$org@efficios.com>
References: <529F484A.50200@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VoIAd-0006z6-Mt
	for lttng-dev@lists.lttng.org; Wed, 04 Dec 2013 14:31:49 -0500
In-Reply-To: <529F484A.50200@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

All fixed in CTF spec, ctf-testsuite, and babeltrace.

Thanks for reporting!

Mathieu

----- Original Message -----
> From: "Matthew Khouzam" <matthew.khouzam@ericsson.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, December 4, 2013 4:20:42 PM
> Subject: [lttng-dev] Ctf-testsuite bug
> 
> Hi all,
> According to the example at line 580 of the ctf spec, a variant missing
> a selector should still be valid. According to the test suite, it is not
> and is at the same time as
> tests/1.8/regression/metadata/pass/variant-missing-selector
> <https://github.com/TheMatthew/ctf-testsuite/blob/master/tests/1.8/regression/metadata/pass/variant-missing-selector/metadata>
> and /tests/1.8/regression/metadata/fail/variant-missing-selector
> <https://github.com/TheMatthew/ctf-testsuite/blob/master/tests/1.8/regression/metadata/fail/variant-missing-selector/metadata>
> both exist. I believe that variant-missing-selector should only be in
> the pass or the ctf spec should be updated.
> 
> A small thing that could help avoid this is to have unique uuids for
> each test. Then there will be less duplication bugs.
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
