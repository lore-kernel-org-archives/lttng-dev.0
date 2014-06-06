From: Eduardo Silva <edsiper@gmail.com>
Subject: Centos 6.5 support ?
Date: Fri, 6 Jun 2014 15:06:26 -0600
Message-ID: <CAMAQheN4oJYEGMML4CsQ6jBZ=VnHZQjEuiDg5uXadDNqRrMsSw__7153.34451892904$1402089205$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <edsiper@gmail.com>) id 1Wt1Lg-0003zR-4i
 for lttng-dev@lists.lttng.org; Fri, 06 Jun 2014 17:06:54 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so4002422veb.12
 for <lttng-dev@lists.lttng.org>; Fri, 06 Jun 2014 14:06:46 -0700 (PDT)
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

Hi Folks,

we just got a report from one user of Monkey Project where the
software have some missing dependencies in the system, e.g:

[root@centos65 monkey-1.5.0]# make
  CC    jemalloc [all]
  CC    src/monkey.o
In file included from ./include/mk_linuxtrace.h:67,
                 from monkey.c:29:
/usr/include/lttng/tracepoint-event.h:39:28: error:
TRACEPOINT_INCLUDE_FILE: No such file or directory
make[1]: *** [monkey.o] Error 1
make: *** [all] Error 2
[root@centos65 monkey-1.5.0]# rpm -qa |grep lttng
lttng-ust-devel-2.0.8-1.el6.x86_64
lttng-tools-devel-2.0.4-2.el6.x86_64
lttng-ust-2.0.8-1.el6.x86_64
lttng-tools-2.0.4-2.el6.x86_64

after test this in a VM i found all packages are installed, is there
anything extra required or are we missing something from the caller
(monkey server) ?

thanks for your help

-- 
Eduardo Silva
http://edsiper.linuxchile.cl
http://monkey-project.com
