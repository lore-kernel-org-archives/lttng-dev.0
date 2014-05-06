From: Jon Bernard <jbernard@debian.org>
Subject: [lttng-tools] build failure on armel (debian)
Date: Tue, 6 May 2014 11:14:03 -0400
Message-ID: <20140506151403.GD11105__17132.9287499704$1399393886$gmane$org@helmut>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1Whh4P-0001zy-Um
 for lttng-dev@lists.lttng.org; Tue, 06 May 2014 11:14:19 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 180102102E
 for <lttng-dev@lists.lttng.org>; Tue,  6 May 2014 11:14:03 -0400 (EDT)
Received: from localhost (unknown [216.252.204.85])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6AA42680532
 for <lttng-dev@lists.lttng.org>; Tue,  6 May 2014 11:14:03 -0400 (EDT)
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

Hey guys,

This bug=B9 was filed recently:

    your package no longer builds on the armel buildds:
    https://buildd.debian.org/status/fetch.php?pkg=3Dltt-control&arch=3Darm=
el&ver=3D2.4.1-1&stamp=3D1397064419

    >   CC       rculfhash.lo
    > /tmp/ccBG89vh.s: Assembler messages:
    > /tmp/ccBG89vh.s:1105: Error: selected processor does not support ARM =
mode `dmb'
    > /tmp/ccBG89vh.s:1286: Error: selected processor does not support ARM =
mode `dmb'
    > /tmp/ccBG89vh.s:3175: Error: selected processor does not support ARM =
mode `dmb'
    > /tmp/ccBG89vh.s:3725: Error: selected processor does not support ARM =
mode `dmb'
    > /tmp/ccBG89vh.s:3833: Error: selected processor does not support ARM =
mode `dmb'
    > /tmp/ccBG89vh.s:3994: Error: selected processor does not support ARM =
mode `dmb'
    > /tmp/ccBG89vh.s:4331: Error: selected processor does not support ARM =
mode `dmb'
    > /tmp/ccBG89vh.s:5292: Error: selected processor does not support ARM =
mode `dmb'
    > make[4]: *** [rculfhash.lo] Error 1

The public buildd that I can use to test this is unreachable at the
moment, but maybe a solution can be reached without further debug info?

The build machine is ARMv7, which supports dmb IIUC, so I'm a bit
puzzled on this one.

Any thoughts?

=B9 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D745891

-- =

Jon
