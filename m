From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 0/3] Filter allocation and large
	bytecode fixes
Date: Mon, 27 Aug 2012 14:48:18 -0400
Message-ID: <1346093301-25274-1-git-send-email-christian.babeux__27193.3844582692$1346093345$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-iy0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T64MZ-0004kh-2f
	for lttng-dev@lists.lttng.org; Mon, 27 Aug 2012 14:48:39 -0400
Received: by iagt4 with SMTP id t4so10155357iag.35
	for <lttng-dev@lists.lttng.org>; Mon, 27 Aug 2012 11:48:33 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi all,

While testing the new filtering feature, some issues were discovered
when generating large bytecode (more than 32768 bytes).

The first patch fix an issue with the buffer size not being a power of 2,
thus leading to odd-looking alloc buffer size.

The second patch is a typo fix.

The third patch fix an issue when generating a bytecode longer than 32768
bytes. The alloc_len of the underlying bytecode buffer was artificially
limiting the bytecode size to 32768 because its length was overflowing
the range of 16-bits values.

Thanks,

Christian Babeux (3):
  Fix: Filter bytecode alloc buffer size must be a power of 2
  Fix: Typo in LTTNG_FILTER_MAX_LEN
  Fix: Generation of bytecode longer than 32768 bytes fails

 src/bin/lttng-sessiond/main.c                      |  2 +-
 src/common/sessiond-comm/sessiond-comm.h           |  2 +-
 src/lib/lttng-ctl/filter/filter-bytecode.h         |  2 +-
 .../filter/filter-visitor-generate-bytecode.c      | 46 ++++++++++++++++++++--
 4 files changed, 46 insertions(+), 6 deletions(-)

-- 
1.7.11.4
