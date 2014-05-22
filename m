From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Support for Linux 3.15 in lttng-modules 2.4 ?
Date: Thu, 22 May 2014 08:49:32 -0400
Message-ID: <537DF25C.40500__33824.8945110992$1400763024$gmane$org@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1WnSRE-0001Ud-SR
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 08:49:37 -0400
Received: from [10.11.0.34] (unknown [10.11.0.34])
 by mail.voxpopuli.im (Postfix) with ESMTPSA id 1CC9C8A010B
 for <lttng-dev@lists.lttng.org>; Thu, 22 May 2014 08:49:33 -0400 (EDT)
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

Hi,

I noticed that lttng-modules 2.4 fails to compile on kernel 3.15. 
However, there are some commits in the master branch to support 3.15. 
Indeed, building git master on kernel 3.15 works fine.

Ubuntu 14.10 is currently tracking kernel 3.15, which causes the 
lttng-module package (based on 2.4) to fail building.
See https://bugs.launchpad.net/ubuntu/+source/lttng-modules/+bug/1321543

Is it planned to backport the 3.15 support to the stable-2.4 branch?


Thanks,
Alex
