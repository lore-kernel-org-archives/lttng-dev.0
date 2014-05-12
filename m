From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: cross-compiling lttng-ust and python version
Date: Mon, 12 May 2014 16:24:14 +0200
Message-ID: <5370D98E.3010500__5291.54573237083$1399904725$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0209817850=gerlando.falauto@keymile.com>)
 id 1Wjr9S-0004Fd-Sr
 for lttng-dev@lists.lttng.org; Mon, 12 May 2014 10:24:28 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:64826
 helo=mailrelay.de.keymile.net)
 by mail-de.keymile.com with esmtp (Exim 4.76)
 (envelope-from <gerlando.falauto@keymile.com>) id 1Wjr9L-0000AV-0A
 for lttng-dev@lists.lttng.org; Mon, 12 May 2014 16:24:15 +0200
Received: from chber1-10555x.ch.keymile.net (chber1-10555x.ch.keymile.net
 [172.31.40.82])
 by mailrelay.de.keymile.net (8.12.2/8.12.2) with ESMTP id s4CEODLf023165
 for <lttng-dev@lists.lttng.org>; Mon, 12 May 2014 16:24:13 +0200 (MEST)
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

I am trying to cross-compile lttng-ust for a powerpc platform.

I get the following error during make:

../../../tools/lttng-gen-tp -o sample_tracepoint.h sample_tracepoint.tp
'import site' failed; use -v for traceback
Traceback (most recent call last):
   File "../../../tools/lttng-gen-tp", line 19, in <module>
     from __future__ import print_function
ImportError: No module named __future__

I believe the wrong python version is called ("python" instead of 
"python2.7"), as the first line of tools/gen-tp reads:

#!/usr/bin/env python

Notice how I explicitly set the python version in my configure script:

ac_cv_header_linux_perf_event_h=no PYTHON=python2.7 ./configure 
--target=powerpc-linux --host=powerpc-linux --build=i686-linux 
--with-libtool-sysroot=/opt/eldk/powerpc/sysroots/powerpc-linux 
--prefix=/usr

MAKEFLAGS= && DESTDIR=/opt/eldk/powerpc/sysroots/powerpc-linux make all 
install install-strip pkgconfigdir=/tmp pkgconfig_DATA=

Which doesn't seem to help in this case though.
Any idea how to fix this?

I temporarily tried patching
-#!/usr/bin/env python
+#!/usr/bin/env python2.7

which partially solves my problem; as a matter of fact, I get this new 
error:

   File "../../../tools/lttng-gen-tp", line 24, in <module>
     import subprocess
ImportError: No module named subprocess

which is a somwhat different issue, as I'm now running python2.7 from 
the sysroot of my cross-compiler environment (which doesn't apparently 
have subprocess.py).

$ which python2.7
/opt/eldk/powerpc/sysroots/i686-eldk-linux/usr/bin/python2.7

Any suggestions here?
Even though it might look like the easiest solution, I'd rather not 
install a native 2.7 (or higher) python version on my build machine.

Thank you!
Gerlando
