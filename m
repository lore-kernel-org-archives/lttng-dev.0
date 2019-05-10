From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust v2] Fix: allocate ts_end in
 ringbuffer shared memory
Date: Fri, 10 May 2019 15:34:22 -0400 (EDT)
Message-ID: <1120045260.787.1557516862762.JavaMail.zimbra__44746.0416167573$1557516881$gmane$org@efficios.com>
References: <20190510152632.8730-1-gabriel.pollo-guilbert@efficios.com>
 <c9f0e5ee-14ed-a2e7-1113-49a77bc7312a@gydle.com>
 <1897690228.618.1557511236306.JavaMail.zimbra@efficios.com>
 <84225c7a-c13e-ff39-9891-5ddab703e8b9@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4510lM5shkz1KGJ
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 15:34:23 -0400 (EDT)
In-Reply-To: <84225c7a-c13e-ff39-9891-5ddab703e8b9@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 10, 2019, at 3:16 PM, Sebastien Boisvert sboisvert@gydle.com wrote:

> On 2019-05-10 2:00 p.m., Mathieu Desnoyers wrote:
[...]
>>> [sboisvert@GT480:lttng-ust]$ ./configure
>>> --prefix=/home/sboisvert/open-source/lttng.org/Build/lttng-ust/v2.9.4
>>> LDFLAGS=-L/home/sboisvert/open-source/lttng.org/Build/userspace-rcu/v0.11.0/lib
>> 
>> I think you need a lttng-ust which is more recent than 2.9.4.
> 
> Got it.
> 
> I used the most recent git tag for lttng-ust: v2.9.4

The most recent git tag stable version for lttng-ust is actually 2.10.3.

The patch in this thread addresses an issue recently introduced only in the
master branch and the stable-2.11 branch (no release tags yet).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
