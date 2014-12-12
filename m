From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: lttng-tools 2.6-rc vs. lttng-ust master
Date: Fri, 12 Dec 2014 12:36:54 -0600
Message-ID: <548B35C6.30604__25643.8310527757$1418409465$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1XzV5O-0001o1-Ar
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 13:37:08 -0500
Received: from svr-orw-fem-04.mgc.mentorg.com ([147.34.97.41])
 by relay1.mentorg.com with esmtp
 id 1XzV5D-0003ve-Do from Nathan_Lynch@mentor.com
 for lttng-dev@lists.lttng.org; Fri, 12 Dec 2014 10:36:55 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

By accident I attempted to build lttng-tools stable-2.6 branch
against current lttng-ust master, and got:

trace-ust.c: In function 'trace_ust_create_event':
trace-ust.c:430:11: error: 'struct lttng_ust_event' has no member named 'disabled'
  lue->attr.disabled = 1;
           ^
I found the commit below, which seems to indicate that this may be
anticipated/intentional, but I figured I'd raise the issue in case
it's not.  Breaking source compatibility with lttng-tools doesn't
seem like a big deal, but does the removal of the 'disabled' field in
lttng-ust/master present a problem for other users of the library?


commit 3a4009667b330f62fc4d6100ead0bcfd5f5526d6
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Wed Nov 12 18:18:32 2014 -0500

    Fix: filter attach vs event enable race
    
    In order to correctly handle the use-case where events are enabled
    _after_ trace is started, and _after_ applications are already being
    traced, the event should be created in a "disabled" state, so that it
    does not trace events until its filter is attached.
    
    This fix needs to be done both in lttng-tools and lttng-ust. In order to
    keep ABI compatibility between tools and ust within a stable release
    cycle, we introduce a new "disabled" within struct lttng_ust_event
    padding (previously zeroed). Newer LTTng-UST checks this flag, and
    fallback on the old racy behavior (enabling the event on creation) if it
    is unset.
    
    Therefore, old session daemon works with newer lttng-ust of the same
    stable release, and vice-versa. However, building lttng-tools requires
    an upgraded lttng-ust, which contains the communication protocol with
    the new "disabled" field.
    
    This patch should be backported to stable-2.4, stable-2.5, stable-2.6
    branches.
