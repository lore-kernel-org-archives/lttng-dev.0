From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: LTTng Minor Release Policy
Date: Wed, 14 Aug 2013 16:38:22 -0400
Message-ID: <20130814203822.GA9866__30058.8760212579$1376512763$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V9hpn-00068s-G5
	for lttng-dev@lists.lttng.org; Wed, 14 Aug 2013 16:38:29 -0400
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

Hi,

Following the thread about LTTng release strategy, here are the policy
we've come up with. Those are detailed here to ensure our project
policies are in sync with what project maintainers can realistically
accomplish:

- At any given time, we maintain at most two stable versions of LTTng:
  - For the latest stable all fixes are backported from master branch.
  - For one version below the latest stable, only security fixes are
    backported from master.
- During release candidate cycle, the master branch is in "feature
  freeze" state.
- New features can be merged into master after a final release, and
  before the start of the following release candidate cycle.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
