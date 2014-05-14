From: Jan Glauber <jan.glauber@gmail.com>
Subject: [PATCH lttng-tools v3 0/4] Dynamic probe list support
Date: Wed, 14 May 2014 16:26:28 +0200
Message-ID: <cover.1400077421.git.jan.glauber__18213.5816933171$1400077708$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1Wka9c-0001bx-8K
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 10:27:37 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so1435992eek.17
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2014 07:27:26 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

here are the rebased patches (onto 88564da). There are no functional
changes to the previous version.

Jan Glauber (4):
  Use common functions for module loading and unloading
  Seperate probe modules from control modules
  Remove required parameter from module parameters
  Configurable kernel module probes support

 doc/man/lttng-sessiond.8              |    7 +
 src/bin/lttng-sessiond/kern-modules.h |    3 +-
 src/bin/lttng-sessiond/main.c         |    5 +
 src/bin/lttng-sessiond/modprobe.c     |  307 ++++++++++++++++++---------------
 src/bin/lttng-sessiond/modprobe.h     |    2 +
 src/common/defaults.h                 |    3 +
 src/common/utils.c                    |   10 ++
 src/common/utils.h                    |    1 +
 8 files changed, 200 insertions(+), 138 deletions(-)

-- 
1.7.9.5
