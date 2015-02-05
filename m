From: "Emilio G. Cota" <cota@braap.org>
Subject: [urcu] Google Summer of Code for userspace RCU
Date: Thu, 5 Feb 2015 11:48:44 -0500
Message-ID: <20150205164844.GA28184__18386.4709608772$1423154910$gmane$org@flamenco>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cota@braap.org>) id 1YJPai-0004wi-GQ
 for lttng-dev@lists.lttng.org; Thu, 05 Feb 2015 11:47:47 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 0050A206EB
 for <lttng-dev@lists.lttng.org>; Thu,  5 Feb 2015 11:47:41 -0500 (EST)
Received: from localhost (unknown [128.59.20.216])
 by mail.messagingengine.com (Postfix) with ESMTPA id B6292680118
 for <lttng-dev@lists.lttng.org>; Thu,  5 Feb 2015 11:47:41 -0500 (EST)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

As you might know--I see LTTng participated in it in previous
years--the Google Summer of Code (GSoC) application deadline
for organisations is in 4 days.

I wonder if there would be interest in proposing urcu-related
projects for GSoC. So far I've got one project idea:

* Port liburcu to Windows, plus extensive testing on the BSD's
  and Darwin so that support for those can be officially
  claimed.  The motivation for this is that at least one
  multi-platform open-source project (QEMU) is already using
  RCU, and its lack of Windows support has forced them to
  effectively fork RCU.[1]
  I have no experience doing Windows development but I volunteer
  to mentor if needed. Of course somebody with experience
  developing for Windows would be more appropriate.

I don't know under what open-source organisation this could
be done, but since LLTng has a good track record with GSoC
maybe that's the best option we have. Thoughts?

Thanks,

		Emilio

[1] http://thread.gmane.org/gmane.comp.emulators.qemu/317087
    for pull request. Final pull request here:
    http://thread.gmane.org/gmane.comp.emulators.qemu/317371

    I brought up the issue of (among other options) adding Windows
    support in urcu to avoid the fork here:
    http://thread.gmane.org/gmane.comp.emulators.qemu/317656/
