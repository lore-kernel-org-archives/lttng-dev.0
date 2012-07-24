From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: health check and time
Date: Tue, 24 Jul 2012 14:16:29 -0400
Message-ID: <20120724181629.GA2285__25163.9346512549$1343153819$gmane$org@Krystal>
References: <20120723191204.GA12711@Krystal> <500EDC1C.1030803@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Stjeo-0000oY-Uh
	for lttng-dev@lists.lttng.org; Tue, 24 Jul 2012 14:16:30 -0400
Content-Disposition: inline
In-Reply-To: <500EDC1C.1030803@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> I've just notice something here during testing.
> 
> Refer to the comment below.
> 
[...]
> I think this should "goto end" and NOT followed by an update to the
> last counter and time since this makes two health_check return
> respectively BAD and OK.
> 
> Considering two health check made by let say two applications or/and
> users, the second one will indicate a good health which is not true.
> 
> Cheers!
> David

How about the following fix ?

Fix: set health to bad state for good when error state detected

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/health.c b/src/bin/lttng-sessiond/health.c
index 7bf41c8..3637225 100644
--- a/src/bin/lttng-sessiond/health.c
+++ b/src/bin/lttng-sessiond/health.c
@@ -114,6 +114,7 @@ int health_check_state(struct health_state *state)
 		if (time_diff_gt(&current_time, &state->last_time, &time_delta)) {
 			if (current == last && !HEALTH_IS_IN_POLL(current)) {
 				/* error */
+				uatomic_or(&state->flags, HEALTH_ERROR);
 				retval = 0;
 			}
 			/* update last counter and last sample time */

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
