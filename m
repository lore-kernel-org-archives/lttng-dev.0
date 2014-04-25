From: Chaitannya Mahatme <chaitannya@gmail.com>
Subject: Getting started with lttng
Date: Sat, 26 Apr 2014 01:08:20 +0530
Message-ID: <CAGwPLsbDhAyyVGD-3euyHT0tahjJ9saNM_XprO34SrjOWsbMcQ__23152.3789618679$1398455091$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chaitannya@gmail.com>) id 1Wdlx4-0008Ib-NN
 for lttng-dev@lists.lttng.org; Fri, 25 Apr 2014 15:38:31 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so440021lbd.2
 for <lttng-dev@lists.lttng.org>; Fri, 25 Apr 2014 12:38:20 -0700 (PDT)
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

Hello Everyone,

I have recently  installed lttng on my machine .. (Ubuntu 12.04)
It's a fresh instalation on vmware. Every thing runs fine expect that
no trace information is captured. What can be the issue?

lttng enable-event sched_switch,sched_process_fork -k
lttng start
lttng stop
babeltrace lttng-traces/mysession-20140425-235804/

There is no output here.

du -h lttng-traces/mysession-20140425-235804/

8.0K	lttng-traces/mysession-20140425-235804/kernel/index
20K	lttng-traces/mysession-20140425-235804/kernel
24K	lttng-traces/mysession-20140425-235804/

o/p of uname -a
Linux ubuntu 3.2.0-23-generic-pae #36-Ubuntu SMP Tue Apr 10 22:19:09
UTC 2012 i686 athlon i386 GNU/Linux

What can be the issue ?
-- 
Cheers !!!
Chaitannya

follow me on twitter http://twitter.com/chaitannya
-- 
I believe there's a hero in all of us who keeps us honest, gives us
strength, makes us noble, and finally allows us to die with pride,
even though sometimes we have to be steady, and give up the thing we
want the most... even our dreams.
- Spider Man 2
