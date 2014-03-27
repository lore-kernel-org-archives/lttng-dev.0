From: loody <miloody@gmail.com>
Subject: arm gcc compile lttng-tool fail
Date: Thu, 27 Mar 2014 20:26:41 +0800
Message-ID: <CANudz+vJ94402GcgVbFonObcWY7HuxcPR_R6eTat54W9JmeYTQ__49257.660265039$1395923252$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <miloody@gmail.com>) id 1WT9OR-0002dO-Ip
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 08:26:48 -0400
Received: by mail-ie0-f175.google.com with SMTP id to1so3340239ieb.20
	for <lttng-dev@lists.lttng.org>; Thu, 27 Mar 2014 05:26:42 -0700 (PDT)
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

hi all:
I try to compile lttng-tool for arm platform but get below message

  CC     kernel-consumer.lo
kernel-consumer.c: In function 'lttng_kconsumer_snapshot_
channel':
kernel-consumer.c:324:1: internal compiler error: in gen_movsi, at
config/arm/arm.md:5680

after ask gcc for help, they said this will be fixed in gcc 4.9.0
http://gcc.gnu.org/ml/gcc-help/2014-03/msg00107.html

the stable release version of gcc is 4.8.2.
Could I get the conclusion that no one can compile it for arm platform before?


thanks for your help,
