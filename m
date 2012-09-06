From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v3 lttng-tools] Filter allocation and large
	bytecode fixes
Date: Thu,  6 Sep 2012 13:40:18 -0400
Message-ID: <1346953219-9001-1-git-send-email-christian.babeux__43576.5590671965$1346953274$gmane$org@efficios.com>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T9g4G-0006lG-JL
	for lttng-dev@lists.lttng.org; Thu, 06 Sep 2012 13:40:40 -0400
Received: by vcbfl11 with SMTP id fl11so3331267vcb.35
	for <lttng-dev@lists.lttng.org>; Thu, 06 Sep 2012 10:40:35 -0700 (PDT)
In-Reply-To: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
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

Previous iteration of patch 2/3 was missing a typo fix in the
LTTNG_FILTER_MAX_LEN define. 

Also, Mathieu suggested that we put a check on the reloc_table_offset
in the sessiond to check its bounds when receiving the LTTNG_SET_FILTER
command. This is not necessary because the reloc_table_offset does not
exist in the filter struct of the lttcomm_session_msg union.

Changelog v3:

1/3 - Already merged.
2/3 - Add missing typo fix in LTTNG_FILTER_MAX_LEN define.
3/3 - Already merged.

Changelog v2:

1/3 - Already merged.
2/3 - Respin. Support 65536 bytes bytecode len + filter ABI changes.
3/3 - Already merged.

Thanks,

Christian Babeux (1):
  Fix: Accept bytecode of length 65536 bytes

 src/bin/lttng-sessiond/lttng-ust-abi.h                      | 6 +++---
 src/bin/lttng-sessiond/main.c                               | 2 +-
 src/common/sessiond-comm/sessiond-comm.h                    | 6 +++---
 src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.7.11.4
