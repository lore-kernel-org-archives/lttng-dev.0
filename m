From: "Shelton, Ben" <benjamin.h.shelton@intel.com>
Subject: Instrumenting code that's common between user and
	kernel space
Date: Mon, 31 Aug 2015 14:13:10 -0500
Message-ID: <20150831191309.GA13818__3189.31878214261$1441048493$gmane$org@bhshelto-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mga01.intel.com ([192.55.52.88])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <benjamin.h.shelton@intel.com>) id 1ZWUWC-0000f2-7G
 for lttng-dev@lists.lttng.org; Mon, 31 Aug 2015 15:13:29 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: timothy.mcdaniel@intel.com
List-Id: lttng-dev@lists.lttng.org

Hi all,

I'm working on using LTTng to instrument a driver that has both a kernel
space portion and a user space portion.  There is quite a bit of code
that's common between the two.  Is there a recommended way to handle
generating both the user space template files and the kernel space
tracepoints / probes for the same code, or is this something we would
need to build ourselves?

Thanks,
Ben
