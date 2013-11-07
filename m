From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 00/28] UST Event exclusions
Date: Thu,  7 Nov 2013 12:16:43 +0200
Message-ID: <1383819403-6386-1-git-send-email-jp_ikaheimonen__10607.0915506736$1383819473$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMe4-0006I5-Rk
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:17:03 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMdy-0004tz-Jb from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:16:54 -0800
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

This patch set, along with a patch set for lttng-ust, implements
a new option for lttng enable-event command.

The new option makes it possible to exclude events from a wildcarded
event definition.

That is, running command

lttng enable-event -u -c c1 'myevents*' -x 'myevents:dbg*'

would enable all UST tracepoint events whose names start with 'myevents'
except those that start with 'myevents:dbg'.

The lttng list command is also updated, so that it points out the
fact that an event has some exclusions.

JP Ikaheimonen (28):
  Add exclusion data to enable-command
  Define a structure for event exclusion data
  Add exclusion data to cmd_enable_event
  Add exclusions to event_ust_enable_tracepoint
  Add event exclusion data to ltt_ust_event structure
  Add exclusion matching logic to trace_ust_ht_match_event
  Add exclusion data to trace_ust_create_event
  Add exclusion data to trace_ust_find_event
  Copy exclusion data in add_unique_ust_event.
  Add new error codes for exclusion processing
  Add handling of LTTNG_ENABLE_EVENT_WITH_EXCLUSION
  Collate handling of LTTNG_ENABLE_EVENT_WITH_FILTER
  Add exclusion data to ust_app_event structure
  Compare also exclusions in ht_match_ust_app_event
  Copy event exclusion data in add_unique_ust_app_event
  Free exclusion data when ust_app_event is deleted
  Add exclusion data to find_ust_app_event
  Copy exclusion data in shadow_copy_event
  Set event exclusions in the target when event is created
  Send enable-event commands with exclusion data
  Collate lttng_enable_event* code
  Add -exclude option to enable-event command
  Add usage for --exclude option
  Add a function to check for legal exclusions
  Parse exclusions and forward them to the control handler
  Detect and report exclusion option errors
  Add exclusion names to diagnostic printouts
  When listing events, show exclusions if they exist

 include/lttng/lttng-error.h              |   2 +
 include/lttng/lttng.h                    |  20 ++-
 src/bin/lttng-sessiond/cmd.c             |  13 +-
 src/bin/lttng-sessiond/cmd.h             |   4 +-
 src/bin/lttng-sessiond/event.c           |  12 +-
 src/bin/lttng-sessiond/event.h           |   3 +-
 src/bin/lttng-sessiond/main.c            | 110 +++++++-----
 src/bin/lttng-sessiond/trace-ust.c       |  23 ++-
 src/bin/lttng-sessiond/trace-ust.h       |  14 +-
 src/bin/lttng-sessiond/ust-app.c         |  95 +++++++++-
 src/bin/lttng-sessiond/ust-app.h         |   2 +
 src/bin/lttng/commands/enable_events.c   | 242 +++++++++++++++++++++++--
 src/bin/lttng/commands/list.c            |  15 +-
 src/common/sessiond-comm/sessiond-comm.h |  22 ++-
 src/lib/lttng-ctl/lttng-ctl.c            | 291 ++++++++++++++++++-------------
 tests/unit/test_ust_data.c               |   2 +-
 16 files changed, 657 insertions(+), 213 deletions(-)

-- 
1.8.1.2
