From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.13, 2.10.10,
 2.11.0-rc5 (Linux kernel tracer)
Date: Tue, 11 Jun 2019 18:58:08 -0400 (EDT)
Message-ID: <1011523982.42412.1560293888405.JavaMail.zimbra__21063.1183975906$1560293907$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45Nllj50Hwz10RP
 for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2019 18:58:09 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 27D83248C18
 for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2019 18:58:09 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>, diamon-discuss@lists.linuxfoundation.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

These releases to the LTTng 2.9 and 2.10 stable branches, as well
as the release candidate for the LTTng 2.11 branch, contain a
series of bugfixes, and adds support for the 5.1 and 5.2-rc Linux
kernels.

One user-impacting fix is the following:

"Fix: don't access packet header for stream_id and stream_instance_id getters"

which can cause the consumer daemon to get an erroneous value of
stream ID and stream instance ID (0) when a live timer is fired at
the beginning of the buffer lifetime. This affects users of the live
streaming mode.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2019-06-12 (National Peanut Butter Cookie Day) LTTng modules 2.11.0-rc5
        * Fix: Don't print ring-buffer's records count when it is not used
        * Fix: do not set quiescent state on channel destroy
        * Fix: ring_buffer_frontend.c: init read timer with uninitialized flags
        * Introduce callstack stackwalk implementation header
        * Prepare callstack common code for stackwalk
        * Introduce callstack legacy implementation header
        * fix: random: only read from /dev/random after its pool has received 128 bits (v5.2)
        * fix: mm: move recent_rotated pages calculation to shrink_inactive_list() (v5.2)
        * fix: mm/vmscan: simplify trace_reclaim_flags and trace_shrink_flags (v5.2)
        * fix: mm/vmscan: drop may_writepage and classzone_idx from direct reclaim begin template (v5.2)
        * fix: timer/trace: Improve timer tracing (v5.2)
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Fix: timestamp_end field should include all events within sub-buffer
        * Fix: Remove start and number from syscall_get_arguments() args (v5.1)
        * lttng abi documentation: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * Fix: atomic_long_add_unless() returns a boolean
        * Fix: Revert "KVM: MMU: show mmu_valid_gen..." (v5.1)
        * Fix: pipe: stop using ->can_merge (v5.1)
        * Fix: rcu: Remove wrapper definitions for obsolete RCU... (v5.1)
        * Fix: mm: create the new vm_fault_t type (v5.1)
        * Fix: extra-version-git.sh redirect stderr to /dev/null

2019-06-12 (National Peanut Butter Cookie Day) LTTng modules 2.10.10
        * Fix: Don't print ring-buffer's records count when it is not used
        * Fix: do not set quiescent state on channel destroy
        * Fix: ring_buffer_frontend.c: init read timer with uninitialized flags
        * fix: random: only read from /dev/random after its pool has received 128 bits (v5.2)
        * fix: mm: move recent_rotated pages calculation to shrink_inactive_list() (v5.2)
        * fix: mm/vmscan: simplify trace_reclaim_flags and trace_shrink_flags (v5.2)
        * fix: mm/vmscan: drop may_writepage and classzone_idx from direct reclaim begin template (v5.2)
        * fix: timer/trace: Improve timer tracing (v5.2)
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Cleanup: bitfield.h: move to kernel style SPDX license identifiers
        * Fix: timestamp_end field should include all events within sub-buffer
        * Fix: Remove start and number from syscall_get_arguments() args (v5.1)
        * lttng abi documentation: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * Fix: atomic_long_add_unless() returns a boolean
        * Fix: Revert "KVM: MMU: show mmu_valid_gen..." (v5.1)
        * Fix: pipe: stop using ->can_merge (v5.1)
        * Fix: rcu: Remove wrapper definitions for obsolete RCU... (v5.1)
        * Fix: mm: create the new vm_fault_t type (v5.1)
        * Fix: extra-version-git.sh redirect stderr to /dev/null

2019-06-12 (National Peanut Butter Cookie Day) LTTng modules 2.9.13
        * Fix: Don't print ring-buffer's records count when it is not used
        * Fix: do not set quiescent state on channel destroy
        * Fix: ring_buffer_frontend.c: init read timer with uninitialized flags
        * fix: random: only read from /dev/random after its pool has received 128 bits (v5.2)
        * fix: mm: move recent_rotated pages calculation to shrink_inactive_list() (v5.2)
        * fix: mm/vmscan: simplify trace_reclaim_flags and trace_shrink_flags (v5.2)
        * fix: mm/vmscan: drop may_writepage and classzone_idx from direct reclaim begin template (v5.2)
        * fix: timer/trace: Improve timer tracing (v5.2)
        * Cleanup: bitfields: streamline use of underscores
        * Silence compiler "always false comparison" warning
        * Fix: bitfield: shift undefined/implementation defined behaviors
        * Cleanup: bitfield.h: move to kernel style SPDX license identifiers
        * Fix: timestamp_end field should include all events within sub-buffer
        * Fix: Remove start and number from syscall_get_arguments() args (v5.1)
        * lttng abi documentation: clarify getter usage requirements
        * Fix: don't access packet header for stream_id and stream_instance_id getters
        * Fix: atomic_long_add_unless() returns a boolean
        * Fix: Revert "KVM: MMU: show mmu_valid_gen..." (v5.1)
        * Fix: pipe: stop using ->can_merge (v5.1)
        * Fix: rcu: Remove wrapper definitions for obsolete RCU... (v5.1)
        * Fix: mm: create the new vm_fault_t type (v5.1)
        * Fix: extra-version-git.sh redirect stderr to /dev/null

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
