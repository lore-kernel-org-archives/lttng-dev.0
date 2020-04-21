From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Have live session and rotation together
Date: Tue, 21 Apr 2020 10:23:03 -0400 (EDT)
Message-ID: <211031090.61650.1587478983634.JavaMail.zimbra@efficios.com>
References: <CAAeL1MEpwm_HgfJOXfZuoe=f9SbG+uTdcLSUeJAEFe9+hNyc-g@mail.gmail.com>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4965Q660F0z1hHB
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2020 10:23:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 054F3292946
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2020 10:23:04 -0400 (EDT)
In-Reply-To: <CAAeL1MEpwm_HgfJOXfZuoe=f9SbG+uTdcLSUeJAEFe9+hNyc-g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sergei Dyshel <qyron.private@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Apr 20, 2020, at 4:17 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hi all,
> 
> When creating live session (lttng create --live) I can not enable rotation:
> 
> # lttng enable-rotation --size=10M
> Error: Failed to enable size-based rotation schedule on session BX

This is indeed the expected behavior.

> 
> In LTTNG 2.12 rotation is supported for network streaming mode  but it
> was not yet supported in 2.11.

I do not think this statement is factually correct. I recall that session
rotation was available for sessions being streamed over the network. What
makes you think otherwise ?

> 
> Is there architectural reasons why we can't have live session with rotation?
> Or is it just not implemented yet? In that case in what version is it
> expected to appear?

It is not impossible design-wise, but would make the implementation much more
complex and require a very significant testing effort.

Considering that there are few compelling use-cases for using both
features together, and no customer have expressed interest in this,
it is not part of our roadmap.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
