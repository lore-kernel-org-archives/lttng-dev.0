From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: baddr feature triggers deadlock in lttng-ust
Date: Thu, 27 Feb 2014 18:37:23 -0500
Message-ID: <530FCC33.4050200__10569.3138707013$1393544343$gmane$org@voxpopuli.im>
References: <561294755.31915.1393536606539.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1WJAWg-0002qX-9K
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 18:38:07 -0500
In-Reply-To: <561294755.31915.1393536606539.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Could it be hidden behind a non-default configure option, instead of
completely removed?

Alex


On 14-02-27 04:30 PM, Mathieu Desnoyers wrote:
> Hi Paul,
>
> Please see http://bugs.lttng.org/issues/745, which explains a deadlock
> we just found out.
>
> We might have to disable the baddr dump feature, since our release is
> tomorrow. We'll have to re-think our locking to protect operations
> using the dynamic loader lock against fork, clone, and daemon.
>
> Thanks,
>
> Mathieu
>
