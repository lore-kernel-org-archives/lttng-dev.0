From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu 2/4] Fix: pthread_rwlock initialization
 on Cygwin
Date: Fri, 23 Nov 2018 15:58:35 -0500 (EST)
Message-ID: <1984962878.12013.1543006715115.JavaMail.zimbra__6668.4576835998$1543006601$gmane$org@efficios.com>
References: <20181123202707.19851-1-mjeanson@efficios.com>
 <20181123202707.19851-2-mjeanson@efficios.com>
 <173534666.11983.1543005974050.JavaMail.zimbra@efficios.com>
 <35e75d5a-bf20-4fc4-4ca7-ed63e3dc0931@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 431pZ42h7WzyKq
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:58:36 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A0C739A9EF
 for <lttng-dev@lists.lttng.org>; Fri, 23 Nov 2018 15:58:35 -0500 (EST)
In-Reply-To: <35e75d5a-bf20-4fc4-4ca7-ed63e3dc0931@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 23, 2018, at 3:54 PM, Michael Jeanson mjeanson@efficios.com wrote:

> On 2018-11-23 3:46 p.m., Mathieu Desnoyers wrote:
[...]
>> I typically use "abort()" instead.
> 
> exit() is used everywhere in this file to abort, I went with the "local"
> style.

Works for me!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
