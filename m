From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Thu, 22 Aug 2013 10:27:29 +0200
Message-ID: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski__34905.2471145571$1377160123$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f179.google.com ([74.125.82.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VCQFF-0001e1-CI
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 04:27:58 -0400
Received: by mail-we0-f179.google.com with SMTP id t58so1324443wes.38
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 01:27:47 -0700 (PDT)
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

Hi,


Here are some patches to allow installing LTTng-ust out of the system
directories, ie building with "./configure --prefix", without having to set
C/CPP/LDFLAGS at both the configure and the make building steps.

The "--with-urcu-prefix" is introduced to allow passing the userspace-rcu
build output directory, and CFLAGS are given to the lttng-gen-tp tool
when building '.c', '.h' and '.o' files, which requires URCU and tracepoint
headers.

Jimmy Durand Wesolowski (2):
  Introduce configure --with-urcu-prefix
  Add the CFLAGS for an "out of system" building of the gen-tp example
    files.

 configure.ac                 |   42 ++++++++++++++++++++++++++++++++++++------
 doc/examples/Makefile.am     |    2 +-
 doc/examples/gen-tp/Makefile |    9 ++++++---
 3 files changed, 43 insertions(+), 10 deletions(-)

-- 
1.7.10.4
