From: Zvi Vered <veredz72@gmail.com>
Subject: compile error in lttng-ust-2.4.4
Date: Fri, 27 Nov 2015 06:20:49 +0200
Message-ID: <CABRndgwATfY9cPKb2JSzg_aO=8Q6_qZxRsf-YxnahhoMU6QH1A__29825.03162134$1448598095$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f180.google.com ([209.85.223.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <veredz72@gmail.com>) id 1a2AWk-0006yw-V2
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 23:20:55 -0500
Received: by ioir85 with SMTP id r85so103738652ioi.1
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 20:20:49 -0800 (PST)
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

Hello,

I downloaded lttng-ust-2.4.4 extracted it and ran ./configure
Then I ran make.

I got the following error:

....
  CC       lttng-filter-specialize.lo
  CC       lttng-filter-interpreter.lo
  CC       lttng-ust-baddr.lo
In file included from ../include/lttng/ust-tracepoint-event.h:724,
                 from ../include/lttng/tracepoint-event.h:58,
                 from ust_baddr_statedump.h:56,
                 from lttng-ust-baddr.c:40:
././ust_baddr_statedump.h:40: error: weak declaration of
'__ref_loglevel___ust_baddr_statedump___soinfo' must be public
././ust_baddr_statedump.h:40: error:
'__ref_loglevel___ust_baddr_statedump___soinfo' defined both normally
and as an alias
././ust_baddr_statedump.h:40: error: weak declaration of
'__ref_model_emf_uri___ust_baddr_statedump___soinfo' must be public
././ust_baddr_statedump.h:40: error:
'__ref_model_emf_uri___ust_baddr_statedump___soinfo' defined both
normally and as an alias
make[2]: *** [lttng-ust-baddr.lo] Error 1
make[2]: Leaving directory
`/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4/liblttng-ust'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/zvivered/GNU/lttng-ust/lttng-ust-2.4.4'
make: *** [all] Error 2

I'm running under Centos 5.5 (32),
gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)

Best regards,
Z.V
