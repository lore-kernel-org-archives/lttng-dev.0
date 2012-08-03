From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 0/2] Configure fixes for
	cross-compilation
Date: Fri,  3 Aug 2012 16:31:26 -0400
Message-ID: <cover.1344025572.git.christian.babeux__38954.6117665761$1344025962$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SxOXg-0007oS-VS
	for lttng-dev@lists.lttng.org; Fri, 03 Aug 2012 16:32:17 -0400
Received: by ggcs6 with SMTP id s6so1586555ggc.35
	for <lttng-dev@lists.lttng.org>; Fri, 03 Aug 2012 13:32:11 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

Here are a few fixes to the configure.ac script to accomodate
cross-compilation of lttng-tools.

Patch 1: 

Same fix that was merged in lttng-ust to fix libtool.m4 on target 
where link_all_deplibs = no.

Patch 2:

Fix an issue encountered when cross-compiling. The configure script
simply fails saying it cannot find the lttng-ust-ctl library even
thought the proper "-L/path/to/ust" is specified in $LDFLAGS.
The AC_CHECK_LIB test fails because it can't find the libraries that
liblttng-ust-ctl depends on. The fix is to specify the dependents
libraries (liburcu-{common,bp,cds}) in the other-lib-case of AC_CHECK_LIB.

Thanks,

Christian

Christian Babeux (2):
  Fix: Libtool fails to find dependent libraries when cross-compiling
    lttng-tools
  Fix: Missing libs dependencies in configure check for lttng-ust-ctl

 configure.ac | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
1.7.11.3
