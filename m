From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: LTTng request to revert patch
 e78de861055e6288d11348866681d1373ed81aec (Improve channel listing output
 format)
Date: Tue, 4 Jun 2013 10:14:44 -0400
Message-ID: <51ADF654.80406__32045.3373752118$1370355390$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1Ujs1Z-0001Nc-Rl
	for lttng-dev@lists.lttng.org; Tue, 04 Jun 2013 10:15:45 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "David.goulet@polymtl.ca" <David.goulet@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Hello tracing kensais,

The patch "Improve channel listing output format" SHA1:
e78de861055e6288d11348866681d1373ed81aec breaks the output api and and
adds a new feature in the RC.

I would request that the patch be reverted, and also it should not
replace the standard text output from before. The LTTng Control in TMF
is dependant on the text output, therefore this patch breaks the support
for LTTng control.

Keep up the great work!

Matthew
