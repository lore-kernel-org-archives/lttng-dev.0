From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [RFC PATCH lttng-ust] Make lttng-ust aware of
 shared object base addresses (issue #474)
Date: Tue, 27 Aug 2013 14:27:12 +0200
Message-ID: <521C9B20.2040509__20670.9333266646$1377606496$gmane$org@mentor.com>
References: <5877897.ECNuB8OFpD@atv-pwoegere-l3.atv.mentorg.com>
	<OF2E0D4AE6.BB12158A-ONC2257BD4.003113D1-C2257BD4.003649EE@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VEIMk-00084I-Tx
	for lttng-dev@lists.lttng.org; Tue, 27 Aug 2013 08:27:29 -0400
In-Reply-To: <OF2E0D4AE6.BB12158A-ONC2257BD4.003113D1-C2257BD4.003649EE@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 08/27/2013 11:53 AM, Amit Margalit wrote:
> Absolutely wonderful idea, IMHO.

Thanks!

The solution I suggest is based a previous solution (that was never
designed to get upstreamed). Semantic and payload structure of the
events haven't changed as they have proven sound. I agree that seeking
to an arbitrary position without also processing the sequence of
ust_baddr events up to that point in time is problematic. In practice
this was never a problem. We have a simple analysis that iterates all
ust_baddr events upfront and creates a time-aware
virtual-memory-to-shared-object mapping ((timestamp, vmaddr) -->
(so_path, so_base_addr). With that map we are able to resolve all addresses.

> I encountered the same problem, and partially solved it, differently. I 
> think your idea complements my solution, so perhaps together we can come 
> up with something even better.
>
> There are a couple of requirements that are still hard to meet with your 
> solution:
> If I seek to an arbitrary position in the trace, I have no easy way to 
> find which shared object the address belongs to.
> If I read the trace on a different system than where it was generated, I 
> may not have access to the same shared objects, so "/lib64/libc-2.17.so" 
> may not be valid, or worse - may be valid but different architecture and 
> therefore the symbol addresses would be different.

In our previous solution for each ust_baddr:push/init I additionally
created a symlink to the shared object in a dedicated per-process-id
directory (only one symlink for each referred object, even if referred
multiple times). After tracing completes we simply do a "cp
--dereference" to get the involved executables/shared objects to the host.

For the suggested upstream solution I instead recommend doing this as a
postproccessing step (we know the target where we traced, so we know how
to interpret the absolute path in the ust_baddr:push/init events). With
caching of already downloaded debuginfo this can be made sufficiently fast.

> The problems with my approach are:
> 1. I wasn't handling dlopen/dlclose calls
> 2. Relying on external tools and post-processing

IMHO, this feature will always rely on external tools, unless we extend
babeltrace (which is questionable). People also want to have tracepoint
source lookup (see:
http://lists.lttng.org/pipermail/lttng-dev/2013-July/020852.html)). I
doubt babeltrace would be the right tool for that.

> Combining the 2 sugestions gives a good solution - i.e. track 
> dlopen/dlclose to generate the shared object maps during runtime so that 
> we can emit signature+function-pointer(relative to its shared object).
>
> Moreover, I suggest further improvement - a TP_FIELDS macro "ctf_symbol" 
> that will automatically do exactly this, and store the 
> signature+address-to-name mapping in the metadata...
>
> What do you think?

IMHO, the proposed solution already works pretty well. Let's see what
Mathieu has to say.

Thanks,
Paul

>
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
>
>
>
> From:   <Paul_Woegerer@mentor.com>
> To:     <lttng-dev@lists.lttng.org>, Mathieu Desnoyers 
> <mathieu.desnoyers@efficios.com>
> Date:   08/27/2013 09:33 AM
> Subject:        [lttng-dev] [RFC PATCH lttng-ust] Make lttng-ust aware of 
> shared  object base addresses (issue #474)
>
>
>
> Hello,
>
> To allow graphical trace viewers to provide features like 
> address-to-symbol resolution or source lookup (address-to-lineinfo), 
> information about the shared object base address mappings are required. 
> These mappings are inherently time based and potentially change during the 
> application runtime (dlopen, dlcose, dlopen, ...). It's even possible that 
> at a later point in the program the same shared object gets mapped to a 
> different base address (I saw that once on ARM or PPC)
>
> The patch set below provides an initial (prof of concept) implementation 
> (based on the previous discussion on https://bugs.lttng.org/issues/474). 
> It's a starting point for further discussions that will hopefully help me 
> to provide an implementation that is good enough for upstream inclusion.
>
> Applying the patch provides the following additional events for userspace 
> tracing:
>
> *) ust_baddr:push with TP_ARGS(void *, baddr, const char*, sopath, 
> int64_t, size, int64_t, mtime)
> *) ust_baddr:pop with TP_ARGS(void *, baddr)
>
> Tracepoints 'ust_baddr:push' and 'ust_baddr:pop' are emitted for every 
> runtime object that makes use of tracing (i.e emits tracepoints/includes 
> tracepoint.h). This is also true for shared objects that get loaded during 
> application run time. Loading a shared object via dlopen will, for 
> example, result in emitting:
> [14:22:07.841547445] ust_baddr:push: { cpu_id = 4 }, { baddr = 
> 0x7F8D13DFD000, sopath = "/path/to/plugin1.so", size = 21968, mtime = 
> 1377519722 }
> ..likewise sometime later a corresponding dlclose in the program will 
> result in emitting:
> [14:22:07.841867307] ust_baddr:pop: { cpu_id = 4 }, { baddr = 
> 0x7F8D13DFD000 }
>
> *) ust_baddr:init with TP_ARGS(void *, baddr, const char*, sopath, 
> int64_t, size, int64_t, mtime)
>
> In contrast, ust_baddr:init tracepoints are only emitted when a userspace 
> application gets a "session enabled" sent by the sessiond (necessary if 
> tracing starts in the middle of an already running application). In this 
> case all the currently loaded shared objects are iterated and the base 
> address mappings are recored as ust_baddr:init events with the same 
> payload structure as ust_baddr:push. E.g.
>
> [15:20:32.763114409]  ust_baddr:init: { cpu_id = 1 }, { baddr = 
> 0x7F5BAC083000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 
> 1359709982 }
> [15:20:32.763118346]  ust_baddr:init: { cpu_id = 1 }, { baddr = 
> 0x7F5BAEAF0000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 
> 1359709980 }
> [15:20:32.763125921]  ust_baddr:init: { cpu_id = 1 }, { baddr = 
> 0x7F5BAAE7C000, sopath = "/other/currently/loaded/shared-object.so.0.0.0", 
> size = 58359, mtime = 1377516019 }
> ... and so on for all other currently loaded shared objects
>
> The known deficiencies of the current implementation are:
>
> Non-optional 'ust_baddr:push' and 'ust_baddr:pop' events 
>
>


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
