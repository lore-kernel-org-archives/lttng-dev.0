From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng Tools 2.2.2
Date: Wed, 17 Jul 2013 19:12:39 -0400
Message-ID: <20130717231239.GA1556__49761.4202010029$1374102954$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uzatl-0001RC-Nx
	for lttng-dev@lists.lttng.org; Wed, 17 Jul 2013 19:12:45 -0400
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

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

Since David Goulet is currently on vacation, I'm acting as backup
maintainer for lttng-tools.

Changelog:
2013-07-17 lttng-tools 2.2.2
        * Fix: set tracefile size test with PID buffers
        * Fix: Babelstats fail to parse output with no process name or pid
        * Fix: kernel data unit test
        * Fix: don't send error to sessiond on orderly shutdown
        * Fix: consumer: incorrect size zmalloc
        * Fix: RCU read side lock unbalanced
        * Fix deadlock: don't take channel lock in timer
        * Introduce channel timer lock
        * document lttng_ustconsumer_request_metadata locking constraints
        * document metadata_switch_timer() deadlock
        * document metadata_switch_timer() locking constraints
        * consumer: replace DBG2() instances by DBG()
        * ust consumer: data_pending check is endpoint active
        * Fix: kernel consumer: data_pending check if endpoint active
        * consumer: explicitly set endpoint status to active at init
        * document consumer_metadata_cache_flushed use of consumer_data.lock
        * consumer: introduce channel lock
        * Missing NULL pointer init in tap.c
        * Fix: Unchecked asprintf/vasprintf return values

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
