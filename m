From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [RFC PATCH lttng-modules v2 01/30] Bump minimum
 kernel version to 3.0
Date: Thu, 8 Nov 2018 17:09:19 -0500
Message-ID: <533559e3-ebe3-2535-c0aa-8bb18029c779__25334.2486372732$1541714846$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
 <9f28b4a4-2561-c158-198d-c25bd30c4335@efficios.com>
 <105083008.2757.1541714752908.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcrc3QV4zqdG
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 17:09:20 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 317B824BC4F
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 17:09:20 -0500 (EST)
In-Reply-To: <105083008.2757.1541714752908.JavaMail.zimbra@efficios.com>
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

On 2018-11-08 5:05 p.m., Mathieu Desnoyers wrote:
> 
> ----- On Nov 8, 2018, at 4:59 PM, Michael Jeanson mjeanson@efficios.com wrote:
> 
>> On 2018-11-08 4:45 p.m., Michael Jeanson wrote:
>>> Upstream Linux 3.0 was released 7 years ago, the oldest longterm release
>>> still supported is 3.16. On the distro kernels side, we still cover :
>>>
>>>  RHEL / CentOS 7 and up
>>>  SLES11 SP2 and up
>>>  SLES12 and up
>>>  Ubuntu 12.04 (Precise) and up
>>>  Debian 7 (Wheezy) and up
>>>  Fedora 16 and up
>>>
>>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> 
> Great patchset! Can I get a pointer to a git branch containing
> this series I could pull from ?
> 
> Thanks,
> 
> Mathieu

Here you go : https://github.com/mjeanson/lttng-modules/tree/kernel3.0
