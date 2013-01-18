From: Mohamad Gebai <mohamad.gebai@polymtl.ca>
Subject: Add architecture specific tracepoints
Date: Fri, 18 Jan 2013 11:22:16 -0500
Message-ID: <1358526136.50f976b837ad0__9987.17842526293$1358526186$gmane$org@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mohamad.gebai@polymtl.ca>) id 1TwEhs-0003dQ-2a
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 11:22:16 -0500
Received: from localhost (imp-4-3.polymtl.ca [132.207.4.78])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id r0IGMGix015489
	for <lttng-dev@lists.lttng.org>; Fri, 18 Jan 2013 11:22:16 -0500
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
I would like to add some of kvm's tracepoints to lttng as only few of them are
already included. The problem is that those tracepoints are architecture
specific (in the kernel source: arch/x86/kvm/trace.h). The readme file in
lttng-modules/instrumentation/events/lttng-module doesn't explain the procedure
to do this for arch specific folders. Should I add an arch folder in
lttng-modules/instrumentation/events/mainline and /lttng-module?

Thanks.
