From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: CTF specificity question
Date: Wed, 30 Apr 2014 15:31:48 -0400
Message-ID: <53614FA4.7010706__42915.0748336271$1398886485$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <matthew.khouzam@ericsson.com>) id 1WfaFy-00065F-H8
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 15:33:32 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello tracing tracers,

I was wondering about the CTF readers, right now both babeltrace and the
java reader will look in the event header for "id" and "timestamp" and
they will also look for a variant "v". This works very well for LTTng
traces, but it provides an LTTng specific code path in theoretically
non-LTTng products. maybe it would be good to have in the spec that
timestamp and id are hard-coded in certain places. It would allow (not
garantied) minor performance improvements too since we know what to look
for all the time.

Just a random though

Matthew
