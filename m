From: Stefan Seefeld <stefan@seefeld.name>
Subject: [PATCH lttng-tools 0/2] Improve testing.
Date: Mon, 16 Sep 2013 19:50:38 -0400
Message-ID: <1379375440-24087-1-git-send-email-stefan_seefeld__6641.09100257537$1379375516$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1VLiZ8-0002tq-OL
	for lttng-dev@lists.lttng.org; Mon, 16 Sep 2013 19:50:56 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so5975849pab.21
	for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2013 16:50:45 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The first of these two patches is a minor improvement I had meant to send out 
much earlier. It allows to configure / build against an lttng-ust in a non-default
location.

The second patch follows up on our previous discussion about support for 'make check'
vs. 'make installcheck'. It sets the PATH variable appropriately from within the
Makefile, and then removes the hard-coding from the various tests and support scripts.

Stefan Seefeld (2):
  Add --with-lttng-ust-prefix config option.
  Robustify tests.

 configure.ac                                       |  9 +++
 tests/Makefile.am                                  |  5 ++
 .../regression/tools/filtering/test_invalid_filter |  3 +-
 .../regression/tools/filtering/test_unsupported_op |  3 +-
 tests/regression/tools/filtering/test_valid_filter |  3 +-
 tests/regression/tools/health/test_thread_exit     |  1 -
 tests/regression/tools/health/test_thread_stall    |  1 -
 .../tools/snapshots/test_kernel_streaming          |  2 +-
 tests/regression/tools/snapshots/test_ust          |  2 +-
 .../regression/tools/snapshots/test_ust_streaming  |  2 +-
 .../tools/streaming/test_high_throughput_limits    |  2 +-
 tests/regression/tools/streaming/test_kernel       |  2 +-
 tests/regression/tools/streaming/test_ust          |  2 +-
 .../tools/tracefile-limits/test_tracefile_count    |  4 +-
 .../tools/tracefile-limits/test_tracefile_size     |  4 +-
 tests/regression/ust/buffers-pid/test_buffers_pid  | 12 ++--
 tests/regression/ust/daemon/test_daemon            |  4 +-
 tests/regression/ust/exit-fast/test_exit-fast      |  4 +-
 tests/regression/ust/fork/test_fork                |  4 +-
 .../regression/ust/libc-wrapper/test_libc-wrapper  |  4 +-
 tests/regression/ust/linking/test_linking          |  4 +-
 tests/regression/ust/nprocesses/test_nprocesses    |  2 +-
 tests/regression/ust/overlap/test_overlap          |  2 +-
 .../test_periodical_metadata_flush                 |  8 +--
 tests/regression/ust/test_event_basic              |  7 +--
 tests/regression/ust/test_event_wildcard           |  1 -
 tests/run.sh                                       |  2 +-
 tests/utils/utils.sh                               | 72 ++++++++++------------
 28 files changed, 82 insertions(+), 89 deletions(-)

-- 
1.8.3.1
