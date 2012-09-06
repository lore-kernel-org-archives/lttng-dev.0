From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-ust] Fix: Filter ABI changes to support
	FILTER_BYTECODE_MAX_LEN (65536)
Date: Thu,  6 Sep 2012 13:51:38 -0400
Message-ID: <1346953899-15422-1-git-send-email-christian.babeux__29251.83886332$1346953938$gmane$org@efficios.com>
References: <1346799744-23032-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T9gF7-0006sL-BO
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 13:51:53 -0400
Received: by vbme21 with SMTP id e21so2215789vbm.35
	for <lttng-dev@lists.lttng.org>; Thu, 06 Sep 2012 10:51:47 -0700 (PDT)
In-Reply-To: <1346799744-23032-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

v2 Changelog:
- Add a check when receiving data on the reloc_offset to
  ensure it lies within the data.

Christian Babeux (1):
  Fix: Accept bytecode of length 65536 bytes

 include/lttng/ust-abi.h       | 4 ++--
 include/ust-comm.h            | 4 ++--
 liblttng-ust/lttng-ust-comm.c | 8 ++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.7.11.4
