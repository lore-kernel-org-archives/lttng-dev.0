From: Jan Glauber <jan.glauber@gmail.com>
Subject: [RFC Patch Tools 0/4] Configurable lttng-probe modules
Date: Thu,  3 Apr 2014 12:57:43 +0200
Message-ID: <cover.1396521858.git.jan.glauber__43548.305243212$1396528543$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f178.google.com ([74.125.82.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WVfMS-0007tw-FD
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 06:59:09 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so1594939wes.23
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 03:59:02 -0700 (PDT)
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

Hi LTTng'ers,

I've asked briefly for the configurable probes feature at the Tracing summit,
here is an RFC how we could implement it.

Why I want to have this feature:
Currently the LTTng probes that are loaded when a session is created are defined
in a static list. If the user wants to change the loaded probes (for instance
disable the very noisy rcu) then lttng-tools must be recompiled or the modules must
be blacklisted or deleted. I also found that in our embedded environment the default
busybox configuration is to disable the blacklist feature, so blacklisting is not an
option.

Therefore I want to have a more flexible way of defining which probes to load
on session start. We could use an environment variable that (if present)
overrides the default and only loads the probes named in the variable.

Patch 1 is a cleanup and patch 2 & 3 are preparation for the feature in patch 4.
Please review and give feedback if this approach is feasible.

thanks,
Jan
---
Harman Becker Automotive GmbH
System Profiling & Optimizing Team


Jan Glauber (4):
  Use common functions for module loading and unloading
  Seperate probe modules from control modules
  Remove required parameter from module parameters
  Dynamic probe list support

 src/bin/lttng-sessiond/kern-modules.h |    3 +-
 src/bin/lttng-sessiond/modprobe.c     |  292 ++++++++++++++++++---------------
 src/common/defaults.h                 |    3 +
 src/common/utils.c                    |   10 ++
 src/common/utils.h                    |    1 +
 5 files changed, 172 insertions(+), 137 deletions(-)

-- 
1.7.9.5
