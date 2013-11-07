From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-ust 0/7] UST Event exclusions
Date: Thu,  7 Nov 2013 12:22:28 +0200
Message-ID: <1383819755-6891-1-git-send-email-jp_ikaheimonen__10795.6485976048$1383820210$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjl-0007mI-CD
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:54 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjf-0006Hn-Tf from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:47 -0800
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

This patch set works in conjunction with the similarly named patch
set for lttng-tools, where an option -x is implemented for the
lttng enable-event command.

In lttng-ust, enablers are enhanced with a list of exclusions - event
names that are not to be matched when matching an enabler with an event
description.

JP Ikaheimonen (7):
  Define a new command LTTNG_UST_EXCLUSION
  Define exclusion structure for UST ABI
  Send exclusion data through ustcomm
  Add excluders to enabler structure
  Store exclusions to enablers
  Add handler for LTTNG_UST_EXCLUSION in UST ABI
  Add a check against excluders

 include/lttng/ust-abi.h       |  8 ++++++
 include/lttng/ust-ctl.h       |  2 ++
 include/lttng/ust-events.h    | 13 +++++++++
 include/ust-comm.h            |  3 +++
 liblttng-ust-ctl/ustctl.c     | 34 +++++++++++++++++++++++
 liblttng-ust/lttng-events.c   | 40 +++++++++++++++++++++++++++
 liblttng-ust/lttng-ust-abi.c  |  7 +++++
 liblttng-ust/lttng-ust-comm.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 170 insertions(+)

-- 
1.8.1.2
