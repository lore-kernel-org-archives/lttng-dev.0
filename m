From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [GIT PULL] Regenerate the metadata file after a major
 NTP correction
Date: Sat, 29 Aug 2015 20:38:42 -0400
Message-ID: <55E25092.2020000__22111.6225854077$1440895211$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZVqe2-0004jV-50
 for lttng-dev@lists.lttng.org; Sat, 29 Aug 2015 20:38:58 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeremie Galarneau <jgalar@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This patchset for LTTng 2.8 is composed of commits in lttng-tools and
lttng-modules it allows the user to regenerate the metadata file of a
running session. This allows to fix the NTP offset located in the
metadata after a major NTP correction. Works for kernel and per-uid UST
sessions, local or remote but not live.

Please pull from:
https://github.com/jdesfossez/lttng-tools-dev/tree/regenmeta
d060d4c Tests for metadata regenerate
e646827 Command metadata regenerate
ce3ea6b Store the version of the tracer in the UID registry

https://github.com/jdesfossez/lttng-modules-dev/tree/regenmeta
6b87bf9 Command to regenerate the metadata of a session

These commits are on top of my seqnum branch which is now located on top
of Mathieu's staging-test-fixes-v2 branch.
When these branches will be merged in master, I will rebase on master as
well, but in the meantime it is now ready for review.

Julien
