From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: might_sleep warnings in overwrite mode
Date: Mon, 11 Nov 2013 09:47:21 -0600
Message-ID: <5280FC09.7030208__22966.3294660442$1384184911$gmane$org@mentor.com>
References: <52803E5D.3050109@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Nathan_Lynch@mentor.com>) id 1Vfti4-0005rp-S8
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 10:47:34 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1Vfthz-0000Ui-EN from Nathan_Lynch@mentor.com
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 07:47:23 -0800
In-Reply-To: <52803E5D.3050109@mentor.com>
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

On 11/10/2013 08:18 PM, Nathan Lynch wrote:
> At this point I cannot trigger the issue without overwrite mode on
> 3.11.6, but on a 3.8-based vendor kernel I can recreate it regardless of
> the mode.
> 
> Is it possible that the lttng module code is messing up the current
> task's preempt count somehow?

Here's another manifestation of the issue -- when flood-pinging the
board during tracing, I get this warning from __do_softirq:

huh, entered softirq 3 NET_RX 804ae528 preempt_count 00000101, exited
with 00000102?
