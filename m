From: Jim Reid <jim@rfc1035.com>
Subject: userspace-rcu-0.8.6 problems on MacOSX
Date: Wed, 11 Mar 2015 15:50:43 +0000
Message-ID: <18312E03-EE49-4807-8227-7DE555AFFD28__1679.04118211499$1426091456$gmane$org@rfc1035.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from shaun.rfc1035.com ([93.186.33.42])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jim@rfc1035.com>) id 1YViuN-000533-Sx
 for lttng-dev@lists.lttng.org; Wed, 11 Mar 2015 11:50:56 -0400
Received: from [172.24.66.75] (static-213-115-66-155.sme.bredbandsbolaget.se
 [213.115.66.155])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by shaun.rfc1035.com (Postfix) with ESMTPSA id 0F2E52420FB6
 for <lttng-dev@lists.lttng.org>; Wed, 11 Mar 2015 15:50:44 +0000 (UTC)
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

Hi. There are some problems getting this to compile on MacOSX (10.9.5):

1) Many of the make regtest tests fail because the time command use command line arguments. eg:

...
./test_urcu_lgc 4 4 10 -d 2 -b 32768
/usr/bin/time: illegal option -- a
usage: time [-lp] command.
...

2) The generated Makefiles feed Linuxy linker arguments (-Wl,-rpath==) to the compiler.
I kludged that by manually editing the Makefile(s) to just use -L././libs instead. Which would seem to be a better solution in general. YMMV.

Could you please fix these for a future release? Thanks.
