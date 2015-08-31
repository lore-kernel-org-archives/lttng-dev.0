From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [GIT PULL v2] Regenerate the metadata file after a
 major NTP correction
Date: Sun, 30 Aug 2015 23:05:26 -0400
Message-ID: <55E3C476.4090409__44545.5015440986$1440990406$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZWFPZ-000454-JB
 for lttng-dev@lists.lttng.org; Sun, 30 Aug 2015 23:05:37 -0400
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
b12c6ba Tests for metadata regenerate
b0eb2fd Command metadata regenerate
5983098 Store the relay protocol version in the consumer_output
ce3ea6b Store the version of the tracer in the UID registry

https://github.com/jdesfossez/lttng-modules-dev/tree/regenmeta
a728303 Command to regenerate the metadata of a session

Changes from v1:
- Addressed Mathieu's comments
- Added documentation in the manpage for the new command
- Send the metadata version to the relay now
- Implemented the check on the relay protocol version before allowing
the command
- Still missing the MI but I can't seem to find the willpower to want to
do it, it will come as a separate commit if this gets merged next week.

These commits are on top of my seqnum branch which is now located on top
of Mathieu's staging-test-fixes-v2 branch.
When these branches will be merged in master, I will rebase on master as
well, but in the meantime it is now ready for review.

Julien
