From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Compiliing LTTng-modules 2.1 with a 3.9.4 kernel
Date: Fri, 07 Jun 2013 14:22:16 -0400
Message-ID: <51B224D8.6070102__49894.4250787192$1370629379$gmane$org@gmail.com>
References: <51B220F3.70901@gmail.com> <20130607181235.GA32244@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Ul1Iv-0004Mv-5k
	for lttng-dev@lists.lttng.org; Fri, 07 Jun 2013 14:22:25 -0400
Received: by mail-ie0-f182.google.com with SMTP id 9so11566561iec.27
	for <lttng-dev@lists.lttng.org>; Fri, 07 Jun 2013 11:22:19 -0700 (PDT)
In-Reply-To: <20130607181235.GA32244@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2013-06-07 14:12, Mathieu Desnoyers wrote:
> Please let me know if anything is missing,
The biggest issues about the commits on block.h is this one:

7c68b363332170e4db100327ecc9e09b8a79cf29    Update kernel probes to more
detailed match to kernel versions

it modifies a lot of other files, but all the next commit on block.h
depends on it.
we could get it in full into the stable branch, or just extract the
change on block.h
