Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6DCC00140
	for <lttng-dev@archiver.kernel.org>; Mon, 15 Aug 2022 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660571629;
	bh=N81pzfD5Gvb7dcjIZtzNniK2IGr+aG1C+CE3dznB2TU=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=SyfCSFKJxkEIyVhmrrJzowaw3HHz2W4BlQMPTaujThK74Cn7EVRT0FLfqmDAZUzLV
	 S439iaBZO5Wqg0EYV0dV1ANywVW1JmJOJLwP6mGhS/WJvvj0y0B3O4Mq4e/TUrF/Ee
	 la7roDVnIpcXa51aviHx/Y+vps+Mdje3u1n2kLGljnCKTwFApqPRX6FojZdLlovwmM
	 sD0H0lvrBVUW7dNfD/PJ9BcsX+fU/tG+KcMxygbaibx6Tb5CLbO5QYZPfvf1Qz2MoV
	 vWNy48hTSd5sZaT7A6oFr3Ze/WCKSR36O89KLxMgpS8C9EFAqoB74GAvrIPnPQ5lg9
	 9qzHkULpyhAbg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M5wjm2Hc5z1GSm;
	Mon, 15 Aug 2022 09:53:48 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M5wjk0hF6z1GkR
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 09:53:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 666E3325117
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 09:53:45 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id TrG7yiCf-qD5 for <lttng-dev@lists.lttng.org>;
 Mon, 15 Aug 2022 09:53:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D1EFE3250A4
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 09:53:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D1EFE3250A4
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 8IkizWCkQesU for <lttng-dev@lists.lttng.org>;
 Mon, 15 Aug 2022 09:53:44 -0400 (EDT)
Received: from [10.10.0.55] (unknown [38.141.136.237])
 by mail.efficios.com (Postfix) with ESMTPSA id B7508324F45
 for <lttng-dev@lists.lttng.org>; Mon, 15 Aug 2022 09:53:44 -0400 (EDT)
Message-ID: <dd0df1d0-12ed-a568-839e-7d2ff1fbcff7@efficios.com>
Date: Mon, 15 Aug 2022 09:53:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org
References: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
In-Reply-To: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
Subject: Re: [lttng-dev] Change to CPU number detection breaks QNX
 compilation
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-08-13 19 h 10, Elad Lahav via lttng-dev wrote:
> Hello,
> 
> I have just downloaded and built the library for QNX/aarch64 and
> noticed that the code in compat-smp.h breaks the build. This file
> appears to be a (very) recent addition, from this commit:
> 
> ---
> commit 5cfe81b7ddff9543d451746de9965cac58c67182
> Author: Michael Jeanson <mjeanson@efficios.com>
> Date:   Wed Jul 27 10:44:00 2022 -0400
> 
>      fix: sysconf(_SC_NPROCESSORS_CONF) can be less than max cpu id
> 
> ---
> 
> I started working around it, but it got a bit ugly. Is the change not
> a Linuxism? Does it make sense on other systems? If QNX is the
> exception then I can try to come up with a patch, but if not perhaps
> the entire code should be wrapped by #ifdef __linux__?
> 
> --Elad

Hi,

We'll need more details on the build failure you are seeing, there is 
already an '#ifdef __linux__' in 'src/compat-smp.h'.

Can you send the relevant build errors?

Michael

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
