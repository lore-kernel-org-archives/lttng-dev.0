From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust 0/2] Bugfix for
	http://bugs.lttng.org/issues/745 (now using mutex)
Date: Mon, 14 Jul 2014 10:38:23 +0200
Message-ID: <1405327105-20507-1-git-send-email-paul_woegerer__10120.7611653537$1405327183$gmane$org@mentor.com>
References: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1X6bmg-0003Lx-FX
 for lttng-dev@lists.lttng.org; Mon, 14 Jul 2014 04:38:57 -0400
In-Reply-To: <1879691854.11749.1404998687774.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

As discussed previously I replaced the semaphore with a mutex and retested on
all three platforms (x86_x64, ARM and PPC). Turns out using a mutex is as good
as the original implementation with the semaphore.

Paul Woegerer (2):
  Bugfix for #745 deadlock with baddr statedump+fork
  Revert "Turn base address dump into experimental feature"

 doc/man/lttng-ust.3            | 10 +++-------
 liblttng-ust/lttng-ust-baddr.c |  2 +-
 liblttng-ust/lttng-ust-comm.c  | 16 ++++++++++++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.0.1
