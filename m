From: Jon Bernard <jbernard@debian.org>
Subject: babeltrace test failures on some architectures
Date: Wed, 4 Jun 2014 14:41:26 -0400
Message-ID: <20140604184126.GA26877__10159.9510213875$1401907365$gmane$org@helmut>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WsG7w-0001Ew-Ho
 for lttng-dev@lists.lttng.org; Wed, 04 Jun 2014 14:41:38 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2A7A0229E5
 for <lttng-dev@lists.lttng.org>; Wed,  4 Jun 2014 14:41:27 -0400 (EDT)
Received: from localhost (unknown [216.252.204.85])
 by mail.messagingengine.com (Postfix) with ESMTPA id EE76C6800FE
 for <lttng-dev@lists.lttng.org>; Wed,  4 Jun 2014 14:41:26 -0400 (EDT)
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

I noticed babeltrace is having test failures on armel, hurd-i386,
kfreebsd-{amd64,i386}, and sparc.  These were passing in version 1.1 and
the failures appeared in 1.2.  Here are links to the build logs:

    armel:          https://buildd.debian.org/status/fetch.php?pkg=babeltrace&arch=armel&ver=1.2.1-2&stamp=1395846913
    hurd-i386:      https://buildd.debian.org/status/fetch.php?pkg=babeltrace&arch=hurd-i386&ver=1.2.1-2&stamp=1398158394
    kfreebsd-amd64: https://buildd.debian.org/status/architecture.php?a=kfreebsd-amd64&suite=sid
    kfreebsd-i386:  https://buildd.debian.org/status/fetch.php?pkg=babeltrace&arch=kfreebsd-i386&ver=1.2.1-2&stamp=1395842518
    sparc:          https://buildd.debian.org/status/fetch.php?pkg=babeltrace&arch=sparc&ver=1.2.1-2&stamp=1395859546

    buildd page:    https://buildd.debian.org/status/package.php?p=babeltrace

Cheers,

-- 
Jon
