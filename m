From: David Bryant <david.bryant@quantum.com>
Subject: static versus dynamic linking
	(TRACEPOINT_PROBE_DYNAMIC_LINKAGE)
Date: Mon, 04 Mar 2013 10:21:45 +1030
Message-ID: <5133E211.8070909__44246.2219311439$1362354766$gmane$org@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [202.189.79.91] (helo=mail.rocksoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.bryant@quantum.com>) id 1UCIh4-00038v-12
	for lttng-dev@lists.lttng.org; Sun, 03 Mar 2013 18:51:50 -0500
Received: from [192.168.1.107] (unknown [150.101.103.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.rocksoft.com (Postfix) with ESMTPSA id 5C8B9FFC032
	for <lttng-dev@lists.lttng.org>; Mon,  4 Mar 2013 10:21:47 +1030 (CST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

I'm trying to decide whether to use static or dynamic tracepoint probe 
linkage. What are the factors that I should consider?

Are there any licensing related issues? For example, is closed-source 
software allowed to use static linking?

Is it purely an organisational feature, i.e., allowing a program to be 
cleanly severed from its probes when they are not in use?

(This is a bit of a re-post, but I didn't get any response last time...)

Thanks,
Dave
