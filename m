From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules v4 0/2] MIPS syscall
	instrumentation updates
Date: Tue,  8 Sep 2015 15:31:44 +0200
Message-ID: <1441719106-30228-1-git-send-email-larper__2210.05657590485$1441719189$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bes.se.axis.com ([195.60.68.10])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lars.persson@axis.com>) id 1ZZJ0R-0006yg-Dg
 for lttng-dev@lists.lttng.org; Tue, 08 Sep 2015 09:32:21 -0400
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 8C3442E70B
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:32:09 +0200 (CEST)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id OuEGrkY0FFWU for <lttng-dev@lists.lttng.org>;
 Tue,  8 Sep 2015 15:32:09 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id 03ADE2E407
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:32:08 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id D769112B2
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:32:08 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id CBA1C1293
 for <lttng-dev@lists.lttng.org>; Tue,  8 Sep 2015 15:32:08 +0200 (CEST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

v2:
 * Updated to use TP_FIELDS.

v3:
 * Added missing Signed-off-by.

v4:
 * The handling of the pipe override is not part of the series any more.

Lars Persson (2):
  Update the MIPS32 syscall instrumentation to 3.18.
  Use 3.18 syscall instrumentation for MIPS32.

 .../syscalls/3.18.0/mips-32-syscalls-3.18.0        |  287 +++
 .../headers/mips-32-syscalls-3.18.0_integers.h     | 1109 ++++++++++++
 .../mips-32-syscalls-3.18.0_integers_override.h    |    3 +
 .../headers/mips-32-syscalls-3.18.0_pointers.h     | 1894 ++++++++++++++++++++
 .../mips-32-syscalls-3.18.0_pointers_override.h    |   28 +
 .../syscalls/headers/syscalls_integers.h           |    2 +-
 .../syscalls/headers/syscalls_pointers.h           |    2 +-
 7 files changed, 3323 insertions(+), 2 deletions(-)
 create mode 100644 instrumentation/syscalls/3.18.0/mips-32-syscalls-3.18.0
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_integers.h
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_integers_override.h
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_pointers.h
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_pointers_override.h

-- 
2.1.4
