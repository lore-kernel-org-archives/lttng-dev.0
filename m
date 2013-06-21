From: Anand Buddhdev <anandb@ripe.net>
Subject: Compile failure on OSX 10.8
Date: Fri, 21 Jun 2013 17:23:40 +0200
Message-ID: <51C46FFC.7050407__49631.2007112012$1371828249$gmane$org@ripe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from postgirl.ripe.net ([193.0.19.66])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anandb@ripe.net>) id 1Uq3BV-0004xA-VZ
	for lttng-dev@lists.lttng.org; Fri, 21 Jun 2013 11:23:34 -0400
Received: from ayeaye.ripe.net ([193.0.23.5])
	by postgirl.ripe.net with esmtps (TLSv1:AES256-SHA:256) (Exim 4.72)
	(envelope-from <anandb@ripe.net>) id 1Uq3BT-0001iz-Tj
	for lttng-dev@lists.lttng.org; Fri, 21 Jun 2013 17:23:33 +0200
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

Hi people,

I'm trying to compile userspace-rcu 0.7.7 on OSX 10.8.4, and it's
failing. The configure phase completes, but make fails like this:

$ make
make  all-recursive
Making all in .
  CC     wfqueue.lo
  CC     wfstack.lo
  CC     compat_arch_x86.lo
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:44:suffix
or operands invalid for `pushf'
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:44:suffix
or operands invalid for `pop'
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:55:suffix
or operands invalid for `push'
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:55:suffix
or operands invalid for `popf'
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:60:suffix
or operands invalid for `pushf'
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:60:suffix
or operands invalid for `pop'
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:65:suffix
or operands invalid for `push'
/var/folders/9f/pv25pv1j7k54m9q11sz79w0h0000gn/T//cc2LG2nk.s:65:suffix
or operands invalid for `popf'
make[2]: *** [compat_arch_x86.lo] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2

CC is just gcc, which is:

$ gcc --version
i686-apple-darwin11-llvm-gcc-4.2 (GCC) 4.2.1 (Based on Apple Inc. build
5658) (LLVM build 2336.11.00)

Anyone know what the problem is, and how to fix it?

Regards,

Anand
