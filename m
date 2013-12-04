From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Ctf-testsuite bug
Date: Wed, 4 Dec 2013 10:20:42 -0500
Message-ID: <529F484A.50200__1849.28818275711$1386170611$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VoEH2-00053J-4e
	for lttng-dev@lists.lttng.org; Wed, 04 Dec 2013 10:22:11 -0500
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

Hi all,
According to the example at line 580 of the ctf spec, a variant missing
a selector should still be valid. According to the test suite, it is not
and is at the same time as
tests/1.8/regression/metadata/pass/variant-missing-selector
<https://github.com/TheMatthew/ctf-testsuite/blob/master/tests/1.8/regression/metadata/pass/variant-missing-selector/metadata>
and /tests/1.8/regression/metadata/fail/variant-missing-selector
<https://github.com/TheMatthew/ctf-testsuite/blob/master/tests/1.8/regression/metadata/fail/variant-missing-selector/metadata>
both exist. I believe that variant-missing-selector should only be in
the pass or the ctf spec should be updated.

A small thing that could help avoid this is to have unique uuids for
each test. Then there will be less duplication bugs.
