Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C80C001DB
	for <lttng-dev@archiver.kernel.org>; Thu, 10 Aug 2023 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1691668364;
	bh=4PHSsU8A84IUUZwVFi4dL3Zeyo6o8vDKY/zNDpUa9Ys=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZhdEknrtVfvPpcx27JPqVfkgPD7QEbGhqgqcpmQj0JnZeyYPz7tzDEkZTNMMfWhOT
	 eEvZ2+ASUeyaDwpJ/8tM12DgBy9uzg0Xd+pVJD8waNya7kZ00fW+asIfSjFSclNLVr
	 DXAwYA9qAcuM/KBYD76vk4Nl2R3jggHVZ5gWyRLwU2UUiyiU3EwW1L/EkViRb7yFBZ
	 8S4YUax38kYTuZIp+XJyaDt9qS63f/Kg9BMD5lKbYyznIcmedbpmcmJFT4+zNzSw+8
	 Z+W+PbaoGSwB5o1wR+fRXABMxQmUAaatHcT1TS2G4ScuKsDrSWq5B9SXUmcDaBR42W
	 JDaVXmrU495fA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RM4zw08wcz2Kb1;
	Thu, 10 Aug 2023 07:52:44 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4RM4zr4wSwz2Kpc
 for <lttng-dev@lists.lttng.org>; Thu, 10 Aug 2023 07:52:40 -0400 (EDT)
Received: from [192.168.18.28] (unknown [107.159.1.132])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4RM4zr0ZPzz1KsH;
 Thu, 10 Aug 2023 07:52:40 -0400 (EDT)
Message-ID: <c7705847-7373-47ba-884e-fe5f3e8df785@efficios.com>
Date: Thu, 10 Aug 2023 07:53:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Richa Bharti <Richa_Bharti@mentor.com>,
 Michael Jeanson <mjeanson@efficios.com>
Cc: Richa Bharti <Richa.Bharti@siemens.com>,
 lttng-dev <lttng-dev@lists.lttng.org>
References: <20230810100555.17568-1-Richa_Bharti@mentor.com>
In-Reply-To: <20230810100555.17568-1-Richa_Bharti@mentor.com>
Subject: Re: [lttng-dev] [PATCH] Fix: list lttng sub-directory in Kbuild
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

On 8/10/23 06:05, Richa Bharti wrote:
> From: Richa Bharti <Richa.Bharti@siemens.com>

Hi!

Thanks for your patch. I'm adding Michael Jeanson and the lttng-dev 
mailing list in CC.

Thanks,

Mathieu

> 
> * Linux kernel>=6.1 reads sub-directory from Kbuild
> * Kernel < 6.1 reads sub-directory from Makefile
> 
> Signed-off-by: Richa Bharti <Richa.Bharti@siemens.com>
> ---
>   scripts/built-in.sh | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/built-in.sh b/scripts/built-in.sh
> index f0594ec..2451230 100755
> --- a/scripts/built-in.sh
> +++ b/scripts/built-in.sh
> @@ -14,9 +14,19 @@ KERNEL_DIR="$(readlink --canonicalize-existing "$1")"
>   # Symlink the lttng-modules directory in the kernel source
>   ln -sf "$(pwd)" "${KERNEL_DIR}/lttng"
>   
> +# Get kernel version from Makefile
> +version=$(grep -m 1 VERSION ${KERNEL_DIR}/Makefile | sed 's/^.*= //g')
> +patchlevel=$(grep -m 1 PATCHLEVEL ${KERNEL_DIR}/Makefile | sed 's/^.*= //g')
> +kernel_version=${version}.${patchlevel}
> +
>   # Graft ourself to the kernel build system
>   echo 'source "lttng/src/Kconfig"' >> "${KERNEL_DIR}/Kconfig"
> -sed -i 's#+= kernel/#+= kernel/ lttng/#' "${KERNEL_DIR}/Makefile"
> +
> +if awk "BEGIN {exit !(${kernel_version} >= 6.1)}"; then
> +	echo 'obj-y += lttng/' >> "${KERNEL_DIR}/Kbuild"
> +else
> +	sed -i 's#+= kernel/#+= kernel/ lttng/#' "${KERNEL_DIR}/Makefile"
> +fi
>   
>   echo >&2
>   echo "    $0: done." >&2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
