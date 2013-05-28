From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
Subject: using a custom channel
Date: Tue, 28 May 2013 14:31:53 +0200
Message-ID: <51A4A3B9.7010303__21477.2115731195$1369744355$gmane$org@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp1-g21.free.fr ([212.27.42.1])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sancelot@free.fr>) id 1UhJ4M-0000aI-T4
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 08:32:03 -0400
Received: from [192.168.1.242] (num-trut.pck.nerim.net [62.212.97.179])
	(Authenticated sender: sancelot)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 094AC940299
	for <lttng-dev@lists.lttng.org>; Tue, 28 May 2013 14:31:57 +0200 (CEST)
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

I finally managed to create my trace events probes...
I copied my .h header in instrumentation/event/lttng-module and create a 
lttng probe module

but now, I would like to use other channels than channel0 , how to do this,
I tried using xn_nucleus_blahblah as event name, but it has not helped , 
it is seen in channel0

Regards,
Steph
