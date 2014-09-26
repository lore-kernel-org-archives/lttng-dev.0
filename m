From: nitin.a.kamble@intel.com
Subject: [PATCH 0/1] Fix lttng-modules build with v3.17 kernel
Date: Thu, 25 Sep 2014 17:12:37 -0700
Message-ID: <cover.1411690005.git.nitin.a.kamble__36084.3434035361$1411690394$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga01.intel.com ([192.55.52.88])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nitin.a.kamble@intel.com>) id 1XXJ98-00011K-QX
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 20:12:28 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
Cc: Nitin A Kamble <nitin.a.kamble@intel.com>
List-Id: lttng-dev@lists.lttng.org

From: Nitin A Kamble <nitin.a.kamble@intel.com>

Hi Mathieu,

The lttng-modules build was failing with th v3.17 kernel. The accompanied commit fixes the issue.

Thanks,
Nitin

The following changes since commit 91c2dd86ac5ef716c039f30668f4126d019a3a4b:

  Fix: OOT lttng_logger tracepoint not visible with signed kernels (2014-09-16 12:10:37 -0400)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib nitin/lttng-modules
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=nitin/lttng-modules

Nitin A Kamble (1):
  asoc.h: fix build with v3.17 kernel

 instrumentation/events/lttng-module/asoc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
1.8.1.4
