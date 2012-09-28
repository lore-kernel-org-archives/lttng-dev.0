From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL lttng-tools] Please pull from compudj-pull
Date: Fri, 28 Sep 2012 16:45:57 -0400
Message-ID: <20120928204557.GA22248__13075.5410915755$1348865191$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1THhRf-0008EO-20
	for lttng-dev@lists.lttng.org; Fri, 28 Sep 2012 16:45:59 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

Please pull from compudj-pull at commit:

commit 3870fc0dddd945410af05ac9e65f041acf84731a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Sep 28 16:41:25 2012 -0400

    Fix: consumer_allocate_stream error handling
    
    Fix a memory leak and "be nice" when handling stream alloc errors. Upon
    CPU hotplug, it is possible that we receive a stream only after all
    other streams are finalized, which means it could happen that we discard
    that channel, in the unlikely event that we have cpu hotplug
    concurrently with destroy.
    
    Moreover, this fix the return path of channel lookup failure: we were
    returning an zeroed stream rather than returning an error, which was
    certainly not the intended behavior.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
