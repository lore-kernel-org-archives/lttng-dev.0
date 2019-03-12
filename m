From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.9.12, 2.10.9, 2.11.0-rc4 (Linux kernel
 tracer)
Date: Tue, 12 Mar 2019 12:35:56 -0400 (EDT)
Message-ID: <804725660.4775.1552408556592.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
Cc: lwn <lwn@lwn.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

LTTng-modules tracer 2.9.12, 2.10.9, 2.11.0-rc4 releases add support for Linux
kernel v4.20 and v5.0, as well as support for the RHEL 7.6 Linux kernel.

I realized that 2.11.0-rc3 was missing a RHEL 7.6 build fix, so I released
a 2.11.0-rc4 immediately after this "Doh!" moment, appropriately celebrating
Homer Simpson's birthday.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:
2019-03-12 (Homer Simpson Birthday) LTTng modules 2.9.12
        * Blacklist: kprobe for arm
        * Cleanup: tp mempool: Remove logically dead code
        * Fix: btrfs: Remove fsid/metadata_fsid fields from btrfs_info
        * Fix: SUNRPC: Simplify defining common RPC trace events (v5.0)
        * Fix: Replace pointer values with task->tk_pid and rpc_clnt->cl_clid
        * Fix: Remove 'type' argument from access_ok() function (v5.0)
        * Fix: timer instrumentation for RHEL 7.6
        * Fix: ext4: adjust reserved cluster count when removing extents (v4.20)
        * Fix: signal: Remove SEND_SIG_FORCED (v4.20)
        * Fix: signal: Distinguish between kernel_siginfo and siginfo (v4.20)

2019-03-12 (Homer Simpson Birthday) LTTng modules 2.10.9
        * Blacklist: kprobe for arm
        * Cleanup: tp mempool: Remove logically dead code
        * Fix: btrfs: Remove fsid/metadata_fsid fields from btrfs_info
        * Fix: SUNRPC: Simplify defining common RPC trace events (v5.0)
        * Fix: Replace pointer values with task->tk_pid and rpc_clnt->cl_clid
        * Fix: Remove 'type' argument from access_ok() function (v5.0)
        * Fix: timer instrumentation for RHEL 7.6
        * Fix: ext4: adjust reserved cluster count when removing extents (v4.20)
        * Fix: signal: Remove SEND_SIG_FORCED (v4.20)
        * Fix: signal: Distinguish between kernel_siginfo and siginfo (v4.20)

2019-03-12 (Homer Simpson Birthday) LTTng modules 2.11.0-rc4
        * Fix: timer instrumentation for RHEL 7.6

2019-03-12 (Homer Simpson Birthday) LTTng modules 2.11.0-rc3
        * Move timekeeping blacklisting to a header file
        * Blacklist: kprobe for arm
        * Cleanup: tp mempool: Remove logically dead code
        * Fix: btrfs: Remove fsid/metadata_fsid fields from btrfs_info
        * Fix: SUNRPC: Simplify defining common RPC trace events (v5.0)
        * Fix: Replace pointer values with task->tk_pid and rpc_clnt->cl_clid
        * Fix: Remove 'type' argument from access_ok() function (v5.0)
        * Add missing SPDX license identifiers to uprobes
        * Fix: ext4: adjust reserved cluster count when removing extents (v4.20)
        * Fix: signal: Remove SEND_SIG_FORCED (v4.20)
        * Fix: signal: Distinguish between kernel_siginfo and siginfo (v4.20)


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
