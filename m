From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools] Filter allocation and large
	bytecode fixes
Date: Tue,  4 Sep 2012 18:57:29 -0400
Message-ID: <1346799450-22888-1-git-send-email-christian.babeux__40984.6537317664$1346799496$gmane$org@efficios.com>
References: <1346093301-25274-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T9240-0003nB-RS
	for lttng-dev@lists.lttng.org; Tue, 04 Sep 2012 18:57:44 -0400
Received: by qady1 with SMTP id y1so4523829qad.14
	for <lttng-dev@lists.lttng.org>; Tue, 04 Sep 2012 15:57:39 -0700 (PDT)
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

Hi all,

After some discussion with Mathieu, it was decided that we should
accept filter bytecode with a length of 65536 bytes. In order to fully support
this length, the len field of lttng_ust_filter_bytecode must be able to hold
that value, so we must change the len type from a uint16_t to a uint32_t.

Also, the relocation table offset field must be able to hold a value
larger than 65535 since the table is located at the end of the generated
bytecode. The field type must be changed from a uint16_t to a uint32_t.

Theses changes _will_ break the filter ABI. Since we are in RC and the
lttng_ust_filter_bytecode struct has only been introduced with the
new filtering feature this seems to be a reasonable approach. This
change must also be reflected on the lttng-ust side. A subsequent patch
for lttng-ust will address this particular concern.

Changelog v2:

1/3 - Already merged.
2/3 - Respin. Support 65536 bytes bytecode len + filter ABI changes.
3/3 - Already merged.

Thanks,

Christian Babeux (1):
  Fix: Accept bytecode of length 65536 bytes

 src/bin/lttng-sessiond/lttng-ust-abi.h                      | 6 +++---
 src/common/sessiond-comm/sessiond-comm.h                    | 6 +++---
 src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.7.11.4
