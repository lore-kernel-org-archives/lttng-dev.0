From: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Subject: getting a notification from 'lttng start|stop'
Date: Thu, 25 Oct 2012 11:49:41 +0000
Message-ID: <7F632A9222059A42AF70FCB7965774AA208660DB__42952.8945395306$1351165823$gmane$org@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.windriver.com ([147.11.146.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew.McDermott@windriver.com>) id 1TRLwZ-0002UH-Sg
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 07:49:48 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q9PBnh9F014024
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Thu, 25 Oct 2012 04:49:43 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Is it possible to see when tracing has actually started (i.e., when
`lttng start' is invoked)?

I can observe that the tracepoint is enabled/disabled by looking at the
'state' field in a 'struct tracepoint'.  Is there an equivalent variable
to monitor for `lttng start|stop'?  I was trying to dump some additional
process state (via calls to tracepoint) whenever an external
start/stop/start/stop/start sequence occurs.

Also, when I run 'lttng enable-event -u -a' I see that the 'state' value
changes from '0' to '1', but if I run 'lttng disable-event -u -a' it
stays at '1'.  Is this expected?  If I subsequently run 'lttng destroy'
then it does go to '0'.  Shouldn't the disable set it to '0' too?

-- 
andy
