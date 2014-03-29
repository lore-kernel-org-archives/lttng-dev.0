From: Helge Deller <deller@gmx.de>
Subject: Bug#742979: liburcu FTBFS on hppa architecture -
	patches attached
Date: Sat, 29 Mar 2014 18:27:33 +0100
Message-ID: <53370285.5060101__9860.45159302211$1396190182$gmane$org@gmx.de>
Reply-To: Helge Deller <deller@gmx.de>, 742979@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060107020807050509070506"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@tuxion.com>) id 1WUGG6-0008Sq-6z
 for lttng-dev@lists.lttng.org; Sun, 30 Mar 2014 09:58:50 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BC064210F7
 for <lttng-dev@lists.lttng.org>; Sun, 30 Mar 2014 09:58:40 -0400 (EDT)
Received: from localhost (unknown [108.15.209.36])
 by mail.messagingengine.com (Postfix) with ESMTPA id A59C9C00005
 for <lttng-dev@lists.lttng.org>; Sun, 30 Mar 2014 09:58:39 -0400 (EDT)
Resent-Message-ID: <20140330135838.GA4032@helmut>
Resent-To: lttng-dev@lists.lttng.org
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.742979.B.13961140632418@bugs.debian.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Debian Bug Tracking System <submit@bugs.debian.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------060107020807050509070506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

package: liburcu
version: 0.7.7-1
tags: patch

liburcu doesn't build yet on the hppa architecture, because the support for this architecture hasn't been developed yet.

Attached patches adds this support now.
It would be nice if you could apply it to the next version of liburcu.

In the attached TGZ file you will find:
- configure.ac_hppa.patch -> patch to apply to existing ./configure.ac file (adds just hppa arch detection)
- urcu/arch/hppa.h  - new file, adds clock functions for hppa
- urcu/uatomic/hppa.h - new file, adds atomic functions for hppa arch via gcc's built-in atomic ops.

I did tested the build with those patches on the hppa arch and ran the testsuite successfully.

Thanks!
Helge

--------------060107020807050509070506
Content-Type: application/x-compressed-tar;
 name="liburcu_hppa_patches.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="liburcu_hppa_patches.tgz"

H4sIAHIAN1MAA+2W2WrbQBSGfWs9xUFpwY6tfbHjNiXGBNyLkpDlopgg1NFIHiqNhJakIfTd
O5LtLGrcEEhdCucDWfLZNKM5/0gk5SGLqpyqPvGWWearmV+SZect0QWubddnY+QY67PT2Gsc
0+4YpmU4bh0o7IZjiXDQ33QUW6iK0s8BOsuAxjHNt8YVVZDSvNjFkHZJwMIQlCoDVSOPWkFN
86hlkhRFeSaqa+qGreiWYh6AYUx0c2K56oE51g/GYjVB0cWiSoPBoJX6kDYGfTyx3Yk1VjcN
sUk7OgJlNB66MBC/IxB/p+febHp+3Fu8W6ZF6ZGsuhpK0F0w37WvhrCYns3mF19Pjw/liBB5
5fPzZP+pT1jWvoRlRctZm2rvoLuo9dDy1qZ17oOx4t95esPlKwn6Ekj/ek1fg6pVOam0yi/T
hBGt2QHeVv0v69+ynZX+LddwTFfo33Yt1P9O2GMhD2gI3uXZ7NKrW9q7nF6cfPk88+anp1Nv
Lu0JN+P0DxHSHuMkrgIKH5tmImmSMfEs1eWntqu4LUqa1I77uvfFhLbXl+fzk7OLduqmRSPK
ac7IqgblYgMDbX/76GBf+68EuWPW+vdzsvw74u+8rP+Rbq71r7umY9f6N4QJ9b8DntH/dt2/
Xu+rV/5KqyxsbiRe2nFV1IdEf5Q05yDPZLjbaPlx9aIMYvbtaVmxg2glS2hTs7zNaF204gWL
OA0gTnkE5JbEtPDKD5IkFrdkBBiP66lsHEB834uo+H5oDNC7TlnQl+6k7kNEcyEqdP0iges0
FnVi2gM5CUkZg+EO4b0uwwTkw1yG3iq8368TclpWYlabCj+fmzoI82rCvz3NRoovbnK4uSEI
giAIgiAIgiAIgiAIgiAIgiAI0uYXCL8r2QAoAAA=
--------------060107020807050509070506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------060107020807050509070506--
