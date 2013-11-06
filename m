From: Paul Thomas <paul.thomas@ise.bc.ca>
Subject: Unable to configure babeltrace, lttv
Date: Wed, 6 Nov 2013 18:09:18 +0000
Message-ID: <F98AC8DFC04DC741915F3DFB00515DBEE8972716__49306.6041650765$1383762918$gmane$org@Thetis.ISE-DOM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]
	helo=ch1outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paul.thomas@ise.bc.ca>) id 1Ve7Xo-0005kx-1c
	for lttng-dev@lists.lttng.org; Wed, 06 Nov 2013 13:09:37 -0500
Received: from mail35-ch1 (localhost [127.0.0.1])	by mail35-ch1-R.bigfish.com
	(Postfix) with ESMTP id E484840031D	for <lttng-dev@lists.lttng.org>;
	Wed,  6 Nov 2013 18:09:22 +0000 (UTC)
Received: from CH1EHSMHS013.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.242])	by mail35-ch1.bigfish.com (Postfix) with ESMTP id
	22FFC1C00C2
	for <lttng-dev@lists.lttng.org>; Wed,  6 Nov 2013 18:09:21 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Running ./bootstrap for babeltrace or lttv produces
a fatal message, namely, 

configure.ac:48: warning: macro `AM_PATH_GTK_2_0' not found in library

I am running Debian:
Linux debian-rt 2.6.31.51 #1 SMP PREEMPT i686 GNU/Linux

Can you advise me about this problem, or what steps I should
take to find an answer to this problem?

Thanks,

Paul
