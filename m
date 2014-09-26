From: nitin.a.kamble@intel.com
Subject: [Patch v2 0/1] fix lttng-modules build with kernel v3.17
Date: Thu, 25 Sep 2014 18:19:39 -0700
Message-ID: <cover.1411693988.git.nitin.a.kamble__26931.0923330069$1411694394$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga14.intel.com ([192.55.52.115])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nitin.a.kamble@intel.com>) id 1XXKBi-0001O9-IX
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 21:19:11 -0400
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

The commit I sent earlier is further modified here, to avoid build
breakage with the older kernel version. Now the change to asoc.h is
conditional on the kernel version, and depending on the kernel
version used it chooses right fields for the sound codec.

Thanks,
Nitin


The following changes since commit 91c2dd86ac5ef716c039f30668f4126d019a3a4b:

  Fix: OOT lttng_logger tracepoint not visible with signed kernels (2014-09-16 12:10:37 -0400)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib nitin/lttng-modules
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=nitin/lttng-modules

Nitin A Kamble (1):
  asoc.h: fix build with v3.17 kernel

 instrumentation/events/lttng-module/asoc.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

-- 
1.8.1.4
