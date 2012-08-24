From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools] Filter: Notify the user when a
	filter is already enabled on event(s)
Date: Thu, 23 Aug 2012 22:05:11 -0400
Message-ID: <1345773912-30858-1-git-send-email-christian.babeux__25186.272376641$1345773987$gmane$org@efficios.com>
References: <1345760474-29248-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-iy0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1T4jHS-0007P4-Qp
	for lttng-dev@lists.lttng.org; Thu, 23 Aug 2012 22:05:50 -0400
Received: by iagt4 with SMTP id t4so2828139iag.35
	for <lttng-dev@lists.lttng.org>; Thu, 23 Aug 2012 19:05:45 -0700 (PDT)
In-Reply-To: <1345760474-29248-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

Changelog from v1:

- Style fixes.
- Add missing changelog.

Thanks,

Christian Babeux (1):
  Filter: Notify the user when a filter is already enabled on event(s)

 src/bin/lttng/commands/enable_events.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
1.7.11.4
