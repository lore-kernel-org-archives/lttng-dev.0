From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [RELEASE] Userspace RCU 0.7.6
Date: Thu, 10 Jan 2013 08:32:47 -0800
Message-ID: <20130110083247.591ad0ba@nehalam.linuxnetplumber.net>
References: <20130109184616.GA14968@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130109184616.GA14968@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

On Wed, 9 Jan 2013 13:46:17 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
> data synchronization library provides read-side access which scales
> linearly with the number of cores. It does so by allowing multiples
> copies of a given data structure to live at the same time, and by
> monitoring the data structure accesses to detect grace periods after
> which memory reclamation is possible.
> 
> liburcu-cds provides efficient data structures based on RCU and
> lock-free algorithms. Those structures include hash tables, queues,
> stacks, and doubly-linked lists.
> 
> This is a bugfix release, mainly fixing handling of processes using
> call_rcu, then fork() without following exec(), and then continuing use
> of synchronize_rcu() or call_rcu() in the child process. A hang in
> synchronize_rcu() in the child could occur, which is fixed by this
> release.
> 
> Changelog:
> 2013-01-09 Userspace RCU 0.7.6
>         * Discourage use of pthread_atfork() for call_rcu handlers
>         * Fix call_rcu fork handling
>         * test: fork handling
>         * Fix TLS detection: test with linker, add --disable-compiler-tls
>         * Cleanup: cast pthread_self() return value to unsigned long
>         * Fallback mechanism not working on platform where TLS is unsupported
> 
> Project website: http://lttng.org/urcu
> Download link: http://lttng.org/files/urcu/
> 

Why is the git repository still at 0.7.4 and there is no tag for 0.7.6?
Am I looking at the right place?
  $ git remote -v
origin	git://git.lttng.org/userspace-rcu.git (fetch)
