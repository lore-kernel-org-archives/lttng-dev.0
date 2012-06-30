From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [babeltrace] FTS does not support large files on 32-bit
Date: Sat, 30 Jun 2012 14:53:35 -0400
Message-ID: <20120630185335.GA31235__39893.9561368481$1341082441$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sl2nY-0004iJ-Ob
	for lttng-dev@lists.lttng.org; Sat, 30 Jun 2012 14:53:36 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>, jdesfossez@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Yannick,

The babeltrace commit:

commit 6cba487f031260536d6a77acde888c8b1a876fcf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Feb 10 12:01:01 2012 -0500

    babeltrace lib cleanup, folded with open/remove trace functions
    
    Folded patch from Yannick Brosseau <yannick.brosseau@gmail.com>, along
    with various updates and cleanups, related to babeltrace lib.
    
    Original changelog from Yannick Brosseau:
        Move the trace_collection into its own file.
        Port the converter to uses the new functions
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Introduces fts(3) as a replacement for ftw(3). However, it seems that
FTS does not support large files (LFS), which I need to turn on in
babeltrace. fts.h shows why:

/* The fts interface is incompatible with the LFS interface which
   transparently uses the 64-bit file access functions.  */
#ifdef __USE_FILE_OFFSET64
# error "<fts.h> cannot be used with -D_FILE_OFFSET_BITS==64"
#endif

We should therefore go back to FTW to support large files on 32-bit. Is
there any reason why we moved from ftw to fts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
