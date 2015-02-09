From: Lars Persson <lars.persson@axis.com>
Subject: [PATCH lttng-modules 0/3] MIPS32 syscall
	instrumentation update.
Date: Mon,  9 Feb 2015 11:49:15 +0100
Message-ID: <1423478958-10776-1-git-send-email-larper__30096.3817317554$1423479020$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <lars.persson@axis.com>) id 1YKluG-0006HZ-Gy
 for lttng-dev@lists.lttng.org; Mon, 09 Feb 2015 05:49:33 -0500
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id 98CEC180BD
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:26 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id jwkd5hau-jvF for <lttng-dev@lists.lttng.org>;
 Mon,  9 Feb 2015 11:49:26 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id C507018097
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:25 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id A1A40F66
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:25 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
 by boulder.se.axis.com (Postfix) with ESMTP id 93125F57
 for <lttng-dev@lists.lttng.org>; Mon,  9 Feb 2015 11:49:25 +0100 (CET)
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

A refresh of the syscalls for the MIPS32 kernel.

Lars Persson (3):
  Do not override the pipe syscall on MIPS.
  Update the MIPS32 syscall instrumentation to 3.18.
  Use 3.18 syscall instrumentation for MIPS32.

 .../syscalls/3.18.0/mips-32-syscalls-3.18.0        |  287 +++
 .../headers/mips-32-syscalls-3.18.0_integers.h     | 1307 +++++++++++
 .../mips-32-syscalls-3.18.0_integers_override.h    |    3 +
 .../headers/mips-32-syscalls-3.18.0_pointers.h     | 2268 ++++++++++++++++++++
 .../mips-32-syscalls-3.18.0_pointers_override.h    |   32 +
 .../syscalls/headers/syscalls_integers.h           |    2 +-
 .../syscalls/headers/syscalls_pointers.h           |    2 +-
 .../syscalls/headers/syscalls_pointers_override.h  |    2 +
 8 files changed, 3901 insertions(+), 2 deletions(-)
 create mode 100644 instrumentation/syscalls/3.18.0/mips-32-syscalls-3.18.0
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_integers.h
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_integers_override.h
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_pointers.h
 create mode 100644 instrumentation/syscalls/headers/mips-32-syscalls-3.18.0_pointers_override.h

-- 
1.7.10.4
