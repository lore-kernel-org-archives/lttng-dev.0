From: Jan Glauber <jan.glauber@gmail.com>
Subject: lttng-ust cross compile broken for demo-tracef
Date: Mon, 7 Apr 2014 13:43:21 +0200
Message-ID: <20140407114320.GA25948__46213.5685761043$1396871123$gmane$org@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WX7yc-0007Ef-AG
 for lttng-dev@lists.lttng.org; Mon, 07 Apr 2014 07:44:36 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so553782eek.1
 for <lttng-dev@lists.lttng.org>; Mon, 07 Apr 2014 04:44:28 -0700 (PDT)
Received: from hal ([194.121.90.173])
 by mx.google.com with ESMTPSA id a4sm41297625eep.12.2014.04.07.04.44.26
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Mon, 07 Apr 2014 04:44:27 -0700 (PDT)
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

Hi list,

I get a compile error with current git head of lttng-ust if I cross-compile (bitbake):

| make[4]: Entering directory `/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/work/armv7ahf-vfp-neon-elina-linux-gnueabi/lttng-ust-2.4-r0/git/doc/examples/demo-tracef'
| arm-linux-gnueabihf-gcc  -march=armv7-a     -mthumb-interwork -mfloat-abi=hard -mfpu=neon -mtune=cortex-a15 --sysroot=/home/jang/temp/p4/JGlauber_hal_share/poky/build/tmp/sysroots/omap5 -L/home/jang/te
|               -o demo-tracef demo-tracef.o -ldl -llttng-ust
| demo-tracef.o: file not recognized: File format not recognized
| collect2: error: ld returned 1 exit status
| make[4]: *** [demo-tracef] Error 1

Looks like the demo-tracef Makefile sets CC hard to gcc. But if I fix this I get more
errors which I don't undertand. Am I the only one running into this?

thx, Jan
---
Harman Becker Automotive GmbH
System Profiling & Optimizing Team
