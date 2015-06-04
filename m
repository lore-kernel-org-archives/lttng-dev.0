From: Eugene Ivanov <Eugene.Ivanov@orc-group.com>
Subject: Runtime issue with mismatched arg name in
 TRACEPOINT_EVENT_INSTANCE and TRACEPOINT_EVENT_CLASS
Date: Thu, 4 Jun 2015 10:39:12 +0300
Message-ID: <557000A0.2010206__8113.87945800579$1433403669$gmane$org@orc-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx02.orcsoftware.com ([89.202.167.90]
 helo=ungol.ad.orcsoftware.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Eugene.Ivanov@orc-group.com>) id 1Z0PkV-0002bO-RO
 for lttng-dev@lists.lttng.org; Thu, 04 Jun 2015 03:39:41 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Recently I've used different names for the argument in
TRACEPOINT_EVENT_INSTANCE and TRACEPOINT_EVENT_CLASS. Everything
compiles, the probe is registered, but can't be activated.
__tracepoint_provider___probe.state is always 0 despite whatever is
shown in 'lttng list session_name'. In this case I would expect
compilation failure.

Probes example, note some_id and MISMATCHED_id:

TRACEPOINT_EVENT_CLASS(hello, myclass,
         TP_ARGS(const unsigned long *, some_id),
         TP_FIELDS(ctf_array(unsigned long, some_identifier, some_id, 2)))

TRACEPOINT_EVENT_INSTANCE(hello, myclass, probe_name, TP_ARGS(const
unsigned long *, MISMATCHED_id))


--
Eugene Ivanov


________________________________

This e-mail is confidential and may contain legally privileged information. It is intended only for the addressees. If you have received this e-mail in error, kindly notify us immediately by telephone or e-mail and delete the message from your system.
