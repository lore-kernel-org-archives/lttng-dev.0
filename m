From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-UST 2.1.0-rc2
Date: Thu, 22 Nov 2012 14:13:08 -0500
Message-ID: <20121122191308.GA18632__17056.9990216338$1353611653$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TbcCz-00076e-Tg
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 14:13:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id A65FD1404BA
	for <lttng-dev@lists.lttng.org>; Thu, 22 Nov 2012 14:13:09 -0500 (EST)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id vwZQm7gwfrV7 for <lttng-dev@lists.lttng.org>;
	Thu, 22 Nov 2012 14:13:08 -0500 (EST)
Content-Disposition: inline
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

LTTng-UST, the Linux Trace Toolkit Next Generation Userspace Tracer, is
port of the low-overhead tracing capabilities of the LTTng kernel tracer
to user-space. The library "liblttng-ust" enables tracing of
applications and libraries.

You will need to upgrade lttng-tools to 2.1.0-rc8 to use this release.

Noteworthy changes: we had to change the ABI for filters, so we send
along a sequence number used to order their execution. This will enable
us to handle future bytecode side-effects in a pre-defined order. This
ABI has been introduced in 2.1.0-rc1, so we did not break any stable
release ABI.

Other noteworthy change: UST now supports having the same event enabled
multiple times, and overlapping wildcards, overlapping wildcards&event,
without unexpected behaviors (e.g. before these changes, UST would be
logging the same event twice into the trace if enabled by two
wildcards).

Many lines of code were touched by this RC, mainly due to a cleanup
patch: "Cleanup: add lttng_/lttng-/LTTNG_ prefixes". It does not modify
any behavior, and is a cleanup-only patch.

Changelog:

2012-11-22 lttng-ust 2.1.0-rc2
        * filter interpreter cleanup: use uint64_t for retval
        * Fix: filter linking can dereference NULL pointer on alloc failure
        * Cleanup: remove whitespaces and EOL in tests
        * Filter: use only single lower bit of filter return value
        * Fix: filter: var len array at end of external structure
        * Fix: filter link fail handling
        * Fix: add missing seqnum field to filter
        * filters: perform union rather than intersection
        * Implement support for overlapping wildcard/events
        * Cleanup: add lttng_/lttng-/LTTNG_ prefixes
        * filter: add seqnum field to filter command
        * Filter iteration: iterate on list of filters
        * document that tracepoint names should ideally not be re-used
        * Remove LIBFORMAT config declaration, unused
        * Add libc errno translation layer to UST error code
        * Fix: add const qualifier for filter local void *
        * Fix: re-allow non-lvalue string, sequence, array parameters
        * Tear down handles associated with a closed sessiond socket
        * Distinguish UST return codes from transport return codes
        * Fix: Conditionally disable tests requiring shared libs support
        * Cleanup: don't spawn per-user thread if HOME is not set
        * Manpage: document supported UST contexts
        * Fix: procname context semantic
        * Fix: Fix self-assign warning on struct ustfork_clone_info init
        * Fix: memcpy of string is larger than source
        * Implement liblttng-ust-fork daemon() override test
        * liblttng-ust-fork: override daemon() call
        * ustfork: set errno to ENOSYS if symbol lookup fails
        * Fix: be quiet on filter linker error
        * Build out of src tree
        * Fix: filter bytecode specializer stack leak
        * Fix: reloc offset validation error out on filters with no reloc table
        * Perform calculation on bit size in 64-bit
        * Use uint64_t for packet header content size and packet size
        * Fix: manpage typo "-lllttng-ust" -> "-llttng-ust"
        * Fix: BSD getprogname null pointer dereference
        * Add support for model.emf.uri event info
        * Filter error message cleanup
        * Manpage update: document use in daemons
        * Fix: get_wait_shm() ust mutex deadlock (add 2 missing exit calls)
        * Fix: get_wait_shm() ust mutex deadlock
        * Fix: add events with 0 field to field list

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
