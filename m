From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [lttng-tools 0/2] Fix various polling loops when using
	poll()
Date: Wed, 26 Nov 2014 16:29:17 -0500
Message-ID: <1417037359-20877-1-git-send-email-eeppeliteloop__3430.80993411622$1417037371$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1Xtk8q-0003Kg-EJ
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 16:28:53 -0500
Received: by mail-qg0-f41.google.com with SMTP id j5so2721015qga.14
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 13:28:47 -0800 (PST)
Received: from archeepp.internal.efficios.com ([173.246.22.116])
 by mx.google.com with ESMTPSA id b17sm4927018qah.35.2014.11.26.13.28.45
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 26 Nov 2014 13:28:46 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

When disabling epoll (--disable-epoll), poll() is used instead of
epoll_wait() thanks to the compat layer. While epoll_wait() only returns
the file descriptors that are ready, with poll() you need to check all
file descriptors and process only those which have revents flags.

This patchset fixes a few of those polling loops in LTTng-tools where
it is assumed that revents is not 0 (epoll_wait() behaviour).

Philippe Proulx (2):
  Fix: sessiond: revents may be 0 when using poll()
  Fix: relayd: revents may be 0 when using poll()

 src/bin/lttng-relayd/main.c         |  5 +++++
 src/bin/lttng-sessiond/ht-cleanup.c |  5 +++++
 src/bin/lttng-sessiond/main.c       | 10 ++++++++++
 src/bin/lttng-sessiond/ust-thread.c |  5 +++++
 4 files changed, 25 insertions(+)

--
2.1.3
