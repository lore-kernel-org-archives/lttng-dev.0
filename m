From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools 0/4] Tests cleanup
Date: Mon, 24 Sep 2012 12:11:43 -0400
Message-ID: <1348503107-3830-1-git-send-email-christian.babeux__33380.2896821455$1348503156$gmane$org@efficios.com>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TGBGL-00031I-Oy
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 12:12:01 -0400
Received: by vcbgb22 with SMTP id gb22so8030492vcb.35
	for <lttng-dev@lists.lttng.org>; Mon, 24 Sep 2012 09:11:56 -0700 (PDT)
In-Reply-To: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

Here a brief changelog for the tests cleanup patches.

v2 Changelog:

1/4: Use STDOUT_FILENO define instead of fileno(stdout).
2/4: print_test_banner now accept a string parameter instead
     of relying on the global TEST_DESC.
3/4: print_test_banner now requires a string argument. Pass TEST_DESC string.
4/4: No changes

Thanks,

Christian Babeux (4):
  Tests: Add a check for color support when printing status
  Tests: Add helper functions for printing status and test banner
  Tests: Cleanup redundant code and use printing helper functions
  Tests: Rename helper functions to have consistent names

 tests/kernel/run-kernel-tests.sh    |  13 ++---
 tests/tools/streaming/run-kernel    |  29 +++++-----
 tests/tools/streaming/run-ust       |  21 ++++----
 tests/tools/streaming/uri_switch    |  30 +++++------
 tests/ust/before-after/run          |  30 +++++------
 tests/ust/high-throughput/run       |  17 +++---
 tests/ust/low-throughput/run        |  17 +++---
 tests/ust/multi-session/run         |  23 ++++----
 tests/ust/nprocesses/run            |  11 ++--
 tests/ust/nprocesses/ust-nprocesses |  11 ++--
 tests/ust/run-ust-global-tests.sh   |  12 ++---
 tests/utils.h                       |  22 +++++++-
 tests/utils.sh                      | 104 ++++++++++++++++++++++++------------
 13 files changed, 193 insertions(+), 147 deletions(-)

-- 
1.7.12
