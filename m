From: Suchakra Sharma <suchakrapani.sharma@polymtl.ca>
Subject: Issue with dynamic load and UST
Date: Wed, 22 May 2013 14:46:22 -0400
Message-ID: <1369248382.1847.41.camel__40095.0576564812$1369248419$gmane$org@station15.dorsal.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <suchakrapani.sharma@polymtl.ca>) id 1UfE3M-0003VI-3F
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 14:46:24 -0400
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

Zifei recently did a demo of dynamic tracing using ust with dyninst [1] The traces are being generated 
and I did some experiments by adding some more 'tracepoint types' too [2]. This seemed to be a promising 
approach but then there's an error as follows when I start tracing on a fresh rebooted machine (if a 
normal session of static userspace tracing is done once, the problem doesn't occur):

libust[3429/3429]: Error: Timed out waiting for lttng-sessiond (in lttng_ust_init() at lttng-ust-comm.c:1072)

This occurred even after separating the tracepoints [3] Backtrace is at [4]. I was able to reproduce it on my 
two machines with UST 2.1.2 and dyninst 8.1 (Fedora 18) 

Is it possible to circumvent this problem somehow? (it seems to be an inherent issue with dlopen w/ sessiond 
but I may be wrong) 


[1] https://gist.github.com/anonymous/5599765 
[2] https://gist.github.com/tuxology/5602019
[3] https://gist.github.com/anonymous/5605050
[4] https://gist.github.com/5kg/5604931


--
Suchakra
