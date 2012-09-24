From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH v2 lttng-tools 0/4] Tests cleanup
Date: Mon, 24 Sep 2012 16:44:01 -0400
Message-ID: <5060C611.3050507__38513.9778293253$1348519474$gmane$org@efficios.com>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
	<1348503107-3830-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TGFVe-00056K-AB
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 16:44:06 -0400
In-Reply-To: <1348503107-3830-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hoy!

I fixed a SMALL issue in two "echo" statements that were missing a "-n".

Everything is working good and merged!

Thanks!
David

Christian Babeux:
> Hi all,
> 
> Here a brief changelog for the tests cleanup patches.
> 
> v2 Changelog:
> 
> 1/4: Use STDOUT_FILENO define instead of fileno(stdout). 2/4:
> print_test_banner now accept a string parameter instead of relying
> on the global TEST_DESC. 3/4: print_test_banner now requires a
> string argument. Pass TEST_DESC string. 4/4: No changes
> 
> Thanks,
> 
> Christian Babeux (4): Tests: Add a check for color support when
> printing status Tests: Add helper functions for printing status and
> test banner Tests: Cleanup redundant code and use printing helper
> functions Tests: Rename helper functions to have consistent names
> 
> tests/kernel/run-kernel-tests.sh    |  13 ++--- 
> tests/tools/streaming/run-kernel    |  29 +++++----- 
> tests/tools/streaming/run-ust       |  21 ++++---- 
> tests/tools/streaming/uri_switch    |  30 +++++------ 
> tests/ust/before-after/run          |  30 +++++------ 
> tests/ust/high-throughput/run       |  17 +++--- 
> tests/ust/low-throughput/run        |  17 +++--- 
> tests/ust/multi-session/run         |  23 ++++---- 
> tests/ust/nprocesses/run            |  11 ++-- 
> tests/ust/nprocesses/ust-nprocesses |  11 ++-- 
> tests/ust/run-ust-global-tests.sh   |  12 ++--- tests/utils.h
> |  22 +++++++- tests/utils.sh                      | 104
> ++++++++++++++++++++++++------------ 13 files changed, 193
> insertions(+), 147 deletions(-)
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQYMYOAAoJEELoaioR9I02qRYH/3L1ATAiQQUamHUsgp4hJr0K
f2qWrdQmRMvUg1qs2jsflj2S08isCyhdRnjBvYCisRxoJDhrMSCffFWVg9bdpXxj
/5cuzhXYgQB/nImugUF3VzOIraxkLTLbK7SQlUBFvvlNdYI/ytn0WFyVC6/wWlsr
kkWkeR/Ja1hiWNEOrT+Q8JL2ogUQfiamnBmqNl05P3SXRKB9WOPdO/mmbjbrJnTf
oa+9lZAtPMDh33My5d4USecm/HgQWtFVlNi1sGWPmRmP+Ym+ziHs/wEiGWhBhg9u
ZEFmVQPULjgdZwmjFbfLIVk8M9D/N3hY2RLlXg4F8wlOq5iqn4496DNDOtjNlRI=
=uXpJ
-----END PGP SIGNATURE-----
