From: <Paul_Woegerer@mentor.com>
Subject: [RFC PATCH lttng-ust] Make lttng-ust aware of shared
	object base addresses (issue #474)
Date: Mon, 26 Aug 2013 17:31:30 +0200
Message-ID: <5877897.ECNuB8OFpD__24395.6998609521$1377585261$gmane$org@atv-pwoegere-l3.atv.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VECqI-0006iD-OC
	for lttng-dev@lists.lttng.org; Tue, 27 Aug 2013 02:33:34 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hello,

To allow graphical trace viewers to provide features like address-to-symbol resolution or source lookup (address-to-lineinfo), information about the shared object base address mappings are required. These mappings are inherently time based and potentially change during the application runtime (dlopen, dlcose, dlopen, ...). It's even possible that at a later point in the program the same shared object gets mapped to a different base address (I saw that once on ARM or PPC)

The patch set below provides an initial (prof of concept) implementation (based on the previous discussion on https://bugs.lttng.org/issues/474). It's a starting point for further discussions that will hopefully help me to provide an implementation that is good enough for upstream inclusion.

Applying the patch provides the following additional events for userspace tracing:

*) ust_baddr:push with TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime)
*) ust_baddr:pop with TP_ARGS(void *, baddr)

Tracepoints 'ust_baddr:push' and 'ust_baddr:pop' are emitted for every runtime object that makes use of tracing (i.e emits tracepoints/includes tracepoint.h). This is also true for shared objects that get loaded during application run time. Loading a shared object via dlopen will, for example, result in emitting:
[14:22:07.841547445] ust_baddr:push: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000, sopath = "/path/to/plugin1.so", size = 21968, mtime = 1377519722 }
..likewise sometime later a corresponding dlclose in the program will result in emitting:
[14:22:07.841867307] ust_baddr:pop: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000 }

*) ust_baddr:init with TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime)

In contrast, ust_baddr:init tracepoints are only emitted when a userspace application gets a "session enabled" sent by the sessiond (necessary if tracing starts in the middle of an already running application). In this case all the currently loaded shared objects are iterated and the base address mappings are recored as ust_baddr:init events with the same payload structure as ust_baddr:push. E.g.

[15:20:32.763114409]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAC083000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 1359709982 }
[15:20:32.763118346]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAEAF0000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1359709980 }
[15:20:32.763125921]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAAE7C000, sopath = "/other/currently/loaded/shared-object.so.0.0.0", size = 58359, mtime = 1377516019 }
... and so on for all other currently loaded shared objects

The known deficiencies of the current implementation are:

Non-optional 'ust_baddr:push' and 'ust_baddr:pop' events 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
