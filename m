From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH lttng-modules] RFC: Drop support for kernels
 < 3.0
Date: Thu, 8 Nov 2018 15:19:24 -0500
Message-ID: <c5ca5230-45cb-6711-556a-1f2bd188c34e__35480.2013178871$1541708250$gmane$org@efficios.com>
References: <20181108200351.17511-1-mjeanson@efficios.com>
 <714803963.2305.1541708156763.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rZPp2MPlzq4W
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 15:19:26 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C78FD240894
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 15:19:25 -0500 (EST)
In-Reply-To: <714803963.2305.1541708156763.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2018-11-08 3:15 p.m., Mathieu Desnoyers wrote:
> ----- On Nov 8, 2018, at 3:03 PM, Michael Jeanson mjeanson@efficios.com wrote:
> 
> Hi Michael,
> 
> Can you split this patch as follows ?
> 
> - One patch updating README.md.
> 
> - Individual patches removing older kernel ifdefs for instrumentation, per subsystem.
> 
> - Individual patches removing each old wrapper and along with its associated use,
> 
> - One patch removing all backport patches,
> 
> - One patch removing old stuff from Makefile and Kbuild (I think it's missing from
>   your patch currently),
> 
> Also, please justify in the README.md patch commit message why the 3.0 Linux kernel
> version is chosen as backward compatibility cutoff point for now.
> 
> Thanks,
> 
> Mathieu

Will do, this was more about getting the discussion started.

Cheers,

Michael
