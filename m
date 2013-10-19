From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: LTTng packages in Debian sid out of sync
Date: Sat, 19 Oct 2013 19:46:34 +0000 (UTC)
Message-ID: <856849325.45462.1382211994767.JavaMail.zimbra__48073.8663966351$1382212069$gmane$org@efficios.com>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VXcTy-0007Wf-DR
	for lttng-dev@lists.lttng.org; Sat, 19 Oct 2013 15:46:48 -0400
In-Reply-To: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jon Bernard <jbernard@debian.org>
Cc: lttng-dev@lists.lttng.org, =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@ubuntu.com>
List-Id: lttng-dev@lists.lttng.org

Hi Jon,

We've had a couple of user reports about lttng versions not working in Debian.

I'm looking at the current Debian sid, and here is the situation:

http://packages.debian.org/sid/lttng-tools : version 2.1.1-2
http://packages.debian.org/sid/utils/ltt-bin : version 2.1.1-2
http://packages.debian.org/sid/lttng-modules-dkms : version 2.3.0-1

Although it's possible that lttng-modules 2.3.x will work with lttng-tools 2.1.x, this combination of versions is unsupported. We require that ust/tools/modules be updated in locked step between minor versions (2.1 with 2.1, 2.2 with 2.2, and so on). Also, 2.1 is starting to be quite old: we're currently working on an upcoming 2.4, and the last version (2.3) provides lots of cool features including flight recorder tracing and snapshot support.

Is there any chance that we could get the set of lttng packages upgraded to 2.3.x for lttng ust, modules, and tools ? If you need help, please let us know. I'm concerned about a couple of our users reporting they had issues and have not been able to use LTTng from Debian packages due to issues we've fixed years ago. It would be good to have slightly more up to date packages, because it starts to reflect badly on our project.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
