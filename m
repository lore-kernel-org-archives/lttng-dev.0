From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [lttng-tools stable-2.0 merge req] Fix: close all file
	descriptors	when executed as daemon
Date: Mon, 4 Jun 2012 18:32:36 -0400
Message-ID: <20120604223236.GA30869__18650.6837643266$1338849183$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SbfpF-0001iO-Jj
	for lttng-dev@lists.lttng.org; Mon, 04 Jun 2012 18:32:37 -0400
Content-Disposition: inline
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

This commit from lttng-tools master should be merged into stable-2.0:

commit ceed52b545103258e84f1c7040700be9dbbbaec6
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Jun 4 18:08:24 2012 -0400

    Fix: close all file descriptors when executed as daemon
    
    Both sessiond and consumerd support the option "-d" to run as daemon. In
    some specific cases, e.g. when launched from dpkg installation scripts,
    file descriptors 3, 4, 5 are left open and don't seem to have O_CLOEXEC
    flag set, so the install script hangs because the sessiond still holds a
    reference to them. daemon(3) only closes standard FD 0, 1, 2.
    
    Fix this issue by closing all file descriptors after calling daemon(3).
    Note: we make sure no file descriptor is opened before calling daemon(3)
    by moving the init_thread_quit_pipe() call after the FD close.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
