From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [RELEASE] LTTng-modules 2.12.1 and 2.11.4 (Linux kernel
 tracer)
Date: Wed, 3 Jun 2020 08:02:29 -0400 (EDT)
Message-ID: <683437825.51033.1591185749972.JavaMail.zimbra@efficios.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49cSFz3RQFz1M61
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jun 2020 08:02:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8A1972BAFE6
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jun 2020 08:02:30 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org, lwn@lwn.net, linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi,

This is a release announcement of the LTTng kernel tracer for both
maintained LTTng stable branches. The main change integrated within
the new versions 2.12.1 and 2.11.4 is support for the newly released
5.7 Linux kernel.

If you followed the news lately [1], you will notice that LTTng had to
work-around a change which un-exports kallsyms symbols, making those
inaccessible to GPL modules, which was integrated within Linux 5.7. As a
matter of fact, LTTng happens to use kallsyms in some cases to access
symbols otherwise not visible to GPL kernel modules.

Just to underline the amount of effort that was put into trying to do
the right thing, here is an explanation of the alternative approaches
that were attempted before going for a work-around using kprobes
(taken from commit message of lttng-modules
commit a65765406b0 "Unbreak LTTng for kernel 5.7"):

    Linux commit 0bd476e6c67190b5eb7b6e105c8db8ff61103281 ("kallsyms:
    unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()") breaks
    LTTng-modules by removing symbols used by the LTTng-modules out-of-tree
    tracer.
    
    I pointed this out when the change was originally considered before the
    5.7 merge window. This generated some discussion but it did not lead to
    any concrete proposal to fix the issue. [2]
    
    The commit has been merged in the 5.7 merge window. At that point, as
    maintainer of LTTng, I immediately raised a flag about this issue,
    proposing an alternative approach to solve this: expose the few symbols
    needed by LTTng to GPL modules. This was NACKed on the ground that the
    Linux kernel cannot export GPL symbols when there are no in-tree
    users. [3]
    
    Steven Rostedt has shown interest in merging LTTng-modules upstream.
    LTTng-modules being LGPL, this is very much doable. I have prepared a
    tree of LTTng-modules "for upstreaming" and sent it to him privately so
    he can review it. Even if in an ideal scenario LTTng-modules is merged
    for the following merge window, it leaves LTTng-modules broken on the
    5.7 kernel.
    
    In order to ensure that the LTTng-modules kernel tracer continues working
    for my end users on kernels 5.7 onwards, as a very last resort, this is
    with great reluctance that I created this fix for LTTng modules. It
    basically uses kprobes to lookup the kallsyms_lookup_name symbol, and
    continues using kallsyms_lookup_name as before.

Steven Rostedt has started looking into lttng-modules, but currently lacks time
to look into it further. Understandably, this 15 years old project is larger than
he initially expected. Let's hope we receive concrete feedback on how we can
improve LTTng to make it acceptable for integration into Linux.

Thanks,

Mathieu

[1] https://lwn.net/Articles/817988/
[2] https://lore.kernel.org/r/20200302192811.n6o5645rsib44vco@localhost
[3] https://lore.kernel.org/r/20200409193543.18115-1-mathieu.desnoyers@efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
