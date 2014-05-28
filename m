From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Support for Linux 3.15 in lttng-modules 2.4 ?
Date: Wed, 28 May 2014 15:51:57 +0000 (UTC)
Message-ID: <2064406121.24244.1401292317212.JavaMail.zimbra__39507.8512527563$1401292387$gmane$org@efficios.com>
References: <537DF25C.40500@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Wpg93-0002eA-AM
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 11:52:06 -0400
In-Reply-To: <537DF25C.40500@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, May 22, 2014 8:49:32 AM
> Subject: [lttng-dev] Support for Linux 3.15 in lttng-modules 2.4 ?
> 
> Hi,
> 
> I noticed that lttng-modules 2.4 fails to compile on kernel 3.15.
> However, there are some commits in the master branch to support 3.15.
> Indeed, building git master on kernel 3.15 works fine.
> 
> Ubuntu 14.10 is currently tracking kernel 3.15, which causes the
> lttng-module package (based on 2.4) to fail building.
> See https://bugs.launchpad.net/ubuntu/+source/lttng-modules/+bug/1321543
> 
> Is it planned to backport the 3.15 support to the stable-2.4 branch?

Hi Alexandre,

Since there has been an important tracepoint module API change between 3.14
and 3.15 in the Linux kernel, supporting 3.15 falls into the "new feature"
category, so we don't plan to backport it to stable 2.4.

lttng-modules 2.5.0 (currently at RC1) is what you need there.

Thanks!

Mathieu

> 
> 
> Thanks,
> Alex
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
