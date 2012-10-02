From: Paul Chavent <paul.chavent@fnac.net>
Subject: Viewing userspace apps traces
Date: Tue, 02 Oct 2012 22:10:09 +0200
Message-ID: <506B4A21.6080309__18117.7336643033$1349208645$gmane$org@fnac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp5-g21.free.fr ([212.27.42.5])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paul.chavent@fnac.net>) id 1TJ8n4-0005BZ-Q1
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 16:10:03 -0400
Received: from [192.168.3.81] (unknown [82.235.130.199])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 64D35D48147
	for <lttng-dev@lists.lttng.org>; Tue,  2 Oct 2012 22:09:58 +0200 (CEST)
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

Hi.

Today, I've tested the tracing of a user space app.

I wonder what is the best solution for viewing it ?

I have tried babeltrace that produce a good comprehensive text outpout.
I have tried eclipse that isn't able to use the vtid and vpid context. It's unfortunate as i would like to see a timeline representation...
Is it a good solution to use the custom text parser of the eclipse tool ?
Do you suggest an other way ?

Thanks for your help.

Paul.
