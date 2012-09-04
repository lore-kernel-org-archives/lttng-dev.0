From: Wade Farnsworth <wade_farnsworth@mentor.com>
Subject: babeltrace assertion "`pos->offset <=
	pos->content_size' failed"
Date: Tue, 4 Sep 2012 08:33:43 -0700
Message-ID: <50461F57.5010401__7059.75493551723$1346772893$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <wade_farnsworth@mentor.com>) id 1T8v8m-0000Tg-7L
	for lttng-dev@lists.lttng.org; Tue, 04 Sep 2012 11:34:12 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1T8v8g-0004p7-6D from wade_farnsworth@mentor.com
	for lttng-dev@lists.lttng.org; Tue, 04 Sep 2012 08:34:06 -0700
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

Hi,

I'm occasionally seeing the following error when I pass a trace through 
babeltrace:

babeltrace: ../../include/babeltrace/ctf/types.h:203: ctf_pos_get_event: 
Assertion `pos->offset <= pos->content_size' failed.
Aborted

Here are my platform details:

Board: ARM Pandaboard
Kernel: v3.1.0 from 
git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.git
lttng-modules: v2.0.5
lttng-tools: v2.0.3
babeltrace: 1.0.0-rc5

Now, I'm not very familiar with the internal workings of, but it seems 
like this situation should be prevented by the call to v_cmpxchg in 
lib_ring_buffer_check_deliver() which claims to have exclusive subbuffer 
access when the content_size field is written.  Is this understanding 
correct?

Does anyone have any suggestions on where the problem might be?  Any 
help you might be able to give me would be appreciated.

Thanks,

Wade Farnsworth
