Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A08AEB64D9
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Jul 2023 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1688498185;
	bh=txoHX0p+5RCEyO6UPByHi9iMAYiTD+ZjCmJU6oWSgAQ=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=corCHB0yFZc7IwPKzIJlrMd9sEmERuzExTyjgSTa2Hm0coTy43cqmyrvk1SNgqxg3
	 Cv/d1bh+w+j1emYxkYfz9iyeSDo+Sb3OVbernh3L16vmHOc9J6mHaOXKlm2GJoIcw9
	 ylxBcPk/cMqYhCnmHKmWtbAkW7tzYBB0+6pFltRmIrAeweoPnUQ3iH2XVc9xRWsbV0
	 rDtSOOUzl856tkhUY8NuJt9FCsyNXZLKDd+A+FwxJYS8qpJ4PFW/gdA3UkZxr34mix
	 VAsFJosRVf/su/7EuZ5HBtYHQbRkDYX0/G0O1TNYsMRtBD0aRW+qSSJ90B2D5sUEsU
	 S9/zNBfh/MVXg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QwXZx0W7qz23wm;
	Tue,  4 Jul 2023 15:16:25 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QwXZv4cL4z23Tr
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jul 2023 15:16:18 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QwXZn6bf6z1Frw;
 Tue,  4 Jul 2023 15:16:17 -0400 (EDT)
Message-ID: <2c6e0b29-0e88-4dc7-6691-7a89a5428932@efficios.com>
Date: Tue, 4 Jul 2023 15:16:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Roxana Nicolescu <roxana.nicolescu@canonical.com>,
 Michael Jeanson <mjeanson@efficios.com>, lttng-dev@lists.lttng.org
References: <20230703182859.49731-1-roxana.nicolescu@canonical.com>
 <01b221fc-05f8-ac1f-0c88-9875fd945e9c@efficios.com>
 <4a1b6647-3870-41c7-7335-862983e60346@efficios.com>
 <ecbb3bbf-b61c-a777-2ee5-c81231a2b8c1@canonical.com>
Cc: =?UTF-8?Q?St=c3=a9phane_Graber?= <stgraber@stgraber.org>
In-Reply-To: <ecbb3bbf-b61c-a777-2ee5-c81231a2b8c1@canonical.com>
Subject: Re: [lttng-dev] [PATCH lttng-modules 0/1] Introduce configure
 script to describe changes in linux kernel interface
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 7/4/23 14:39, Roxana Nicolescu wrote:
> Hi,
> 
> Thanks a lot for your feedback.
> 
> I realize I did not say the reason why I did not go for 
> LTTNG_UBUNTU_KERNEL_RANGE. We deliver a bunch of different
> derivatives (inherited from the main kernel), each with its own
> version and it's impossible to use LTTNG_UBUNTU_KERNEL_RANGE alone. 
> Derivatives in the same cycle don't have the same version number, so
> I cannot rely on the version alone to determine when a change has
> happened. For example these are some kernels we released last cycle: 
> - linux (main kernel): 5.19.0-46 - linux-kvm: 5.19.0-1026 -
> linux-lowlatency: 5.19.0-1028 As you can see, linux-kvm and
> linux-lowlatency versions are not the same, and linux-lowlatency from
> 2 months ago version version number coincides with linux-kvm from
> now, but they don't match the same base. I hope that explains it.
> 
> Initially I thought about exposing the version of the main kernel in
> the kernel headers that can be later used in the module, but then I
> came across openvswitch and that's how I came up with the idea of an
> initial configure step.
> 
> But I totally understand if you think this is not worth it.

LTTng modules use the UTS_UBUNTU_RELEASE_ABI from the Ubuntu 
generated/utsrelease.h kernel headers to detect tracepoint 
instrumentation changes. I don't understand why many kernel flavors 
would have the same ABI number with different ABI semantics, but I guess 
that's just how things are now.

One way to solve this would be to detect the "-lowlatency" and "-kvm" 
suffixes in the string within generated/utsrelease.h UTS_RELEASE, e.g.:

#define UTS_RELEASE "5.15.0-76-lowlatency"

This could be done by LTTng modules by implementing a script similar to 
what we do for debian, fedora, rhel, and sle (see scripts/ in 
lttng-modules).

Then we could have:

* LTTNG_UBUNTU_KERNEL_RANGE for kernels where all flavors have the same
   kernel ABI.

* LTTNG_UBUNTU_GENERIC_KERNEL_RANGE for generic kernels only, for
   situations where the kernel ABI differ between flavors,

* LTTNG_UBUNTU_LOWLATENCY_KERNEL_RANGE for lowlatency kernels only, for
   situations where the kernel ABI differ between flavors,

* LTTNG_UBUNTU_KVM_KERNEL_RANGE for kvm kernels only, for situations
   where the kernel ABI differ between flavors.

It would all have been simpler if the UTS_UBUNTU_RELEASE_ABI would 
actually have been a versioned kernel ABI without different semantics 
across kernel flavors, but considering the current situation we will 
need to deal with this with scripts as we have done for other distributions.

Thanks,

Mathieu

> 
> All the best, Roxana
> 
> On 04/07/2023 20:07, Mathieu Desnoyers wrote:
>> On 7/4/23 11:35, Michael Jeanson via lttng-dev wrote:
>>> On 2023-07-03 14:28, Roxana Nicolescu via lttng-dev wrote:
>>>> This script described the changes in the linux kernel interface
>>>> that affect compatibility with lttng-modules.
>>>> 
>>>> It is introduced for a specific usecase where commit 
>>>> d87a7b4c77a9: "jbd2: use the correct print format" broke the
>>>> interface between the kernel and lttng-module. 3 variables 
>>>> changed their type to tid_t (transaction, head and tid) in
>>>> multiple function declarations. The lttng module was updated
>>>> properly to ensure backwards compatibility by using the version
>>>> of the kernel. But this change took into account only long term
>>>> supported versions. As an example, ubuntu 5.19 kernels picked
>>>> the linux kernel change from 5.15 without actually changing the
>>>> linux kernel upstream version. This means the current tooling
>>>> does not allow to fix the module for newer ubuntu 5.19
>>>> kernels.
>>>> 
>>>> This script is supposed to solve the problem mentioned above,
>>>> but to also make this change easier to integrate. We check the
>>>> linux kernel header (include/trace/events/jbd2.h) if the types
>>>> of tid, transaction and head variable have changed to tid_t
>>>> and define these 3 variables in 'include/generated/config.h': 
>>>> TID_IS_TID_T 1 TRANSACTION_IS_TID_T 1 HEAD_IS_TID_T 1
>>>> 
>>>> In 'include/instrumentation/events/jbd2.h' we then check these
>>>> to define the proper type of transaction, head and tid
>>>> variables that will be later used in the function declarations
>>>> that need them.
>>>> 
>>>> This change is meant to remove the dependency on linux kernel
>>>> version and the outcome is a bit cleaner that before. As with
>>>> the previous implementation, this may need changes in the 
>>>> future if the kernel interface changes again.
>>>> 
>>>> Note: This is a proposal for a simpler way of integrating linux
>>>> kernel changes in lttng-modules. The implementation is very
>>>> simple due to the fact that tid_t was introduced everywhere in
>>>> one commit in include/trace/events/jbd2.h. I would like to get
>>>> your opinion on this approach. If needed, it can be improved.
>>>> 
>>>> Roxana Nicolescu (1): Introduce configure script to describe
>>>> changes in linux kernel interface
>>>> 
>>>> README.md                             |   3 +- configure
>>>> |  36 +++++++++ include/instrumentation/events/jbd2.h | 110 
>>>> ++++++-------------------- 3 files changed, 61 insertions(+),
>>>> 88 deletions(-) create mode 100755 configure
>>>> 
>>> 
>>> Hi Roxana,
>>> 
>>> While I can see advantages to a configure script approach to
>>> detect kernel source changes I don't think it's worth the added
>>> complexity on top of our current kernel version range system.
>>> 
>>> We already have an Ubuntu specific kernel range macro that 
>>> supplements the upstream version with Ubuntu's kernel ABI
>>> number:
>>> 
>>> LTTNG_UBUNTU_KERNEL_RANGE(5,19,17,X, 6,0,0,0)
>>> 
>>> I'll let Mathieu make the final call but I think that would be
>>> the preferred approach.
>> 
>> Indeed, many of the kernel tracepoint code changes we had to deal
>> with in the past 10 years would not be easy to track with configure
>>  scripts, so we would end up with not just one, but with a
>> combination of two different mechanisms to adapt to kernel code
>> changes.
>> 
>> In order to keep things maintainable long-term, I prefer that we
>> stay with the version-based approach as recommended by Michael.
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>>> Regards,
>>> 
>>> Michael _______________________________________________ lttng-dev
>>> mailing list lttng-dev@lists.lttng.org 
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

a
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
