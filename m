Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159EDC25B0E
	for <lttng-dev@archiver.kernel.org>; Tue, 16 Aug 2022 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660663261;
	bh=qqQxcal7t9G9xD8LUxz4S+L+WGYuhkLVbXY28f4BmMw=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dyzDGiHEb0e2K9JZI6PSnkTrM5OChl6JsPSRZ7F8gH8wMGqlxGei3w9vnDlCr9qx0
	 QuWSe/zYdEcrFiMEUwGr3jZncqEnaiqr2Pp/RweG182GtmiXWA1fhEV2Kri65kyzVw
	 uv5zwvj6eoE44D7CgyzpQzYmxk/Pt83JF1N2Ob7ivNeawdlhDEDLEwP5vUUk9rxFRo
	 W1uJ3AUprXkfxofEjl05HkQ9iT04crdll85Z7LFT1s8PR6LczwzojfxkqG4ZUzr7j9
	 cFGTVWAVmNrogpmSx3eDVAeq+MY9ll15Rvp3uksTY7usF3769puIW+1G1ZhzazSjBf
	 2L93xTeVyUP9A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M6Zbx651sz1Gy4;
	Tue, 16 Aug 2022 11:21:01 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4M6Zbq4Zj3z1GrT
 for <lttng-dev@lists.lttng.org>; Tue, 16 Aug 2022 11:20:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 04BE033ADD2
 for <lttng-dev@lists.lttng.org>; Tue, 16 Aug 2022 11:20:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id uV3qOqCpi0I0; Tue, 16 Aug 2022 11:20:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id ADE0333AB7E;
 Tue, 16 Aug 2022 11:20:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ADE0333AB7E
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id GkWtQPJry6bK; Tue, 16 Aug 2022 11:20:44 -0400 (EDT)
Received: from [10.10.0.55] (unknown [38.141.136.237])
 by mail.efficios.com (Postfix) with ESMTPSA id 9AB0633ACC0;
 Tue, 16 Aug 2022 11:20:44 -0400 (EDT)
Message-ID: <c20ae630-466f-c9ca-78c8-7de8a86ff1d6@efficios.com>
Date: Tue, 16 Aug 2022 11:20:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Elad Lahav <e2lahav@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
 <dd0df1d0-12ed-a568-839e-7d2ff1fbcff7@efficios.com>
 <CAJbg=FWjjBT1RbGxvCcx1+6qgJfhqtF3h3WpLB11cGSb1Efzqw@mail.gmail.com>
 <7e3f4047-101e-d8d4-93ed-370c8eaf7494@efficios.com>
 <CAJbg=FVMKPrZ+s2UdMN57R_rwDMF6ZH7BkpfMZ-Waf_AQXh9Dw@mail.gmail.com>
 <a5f31003-9cc9-33e3-5c23-e4360fe7edbf@efficios.com>
 <CAJbg=FUVVfNkDM4xvmMtVtw+GCs2nXmbCT02BXoA+3Jd1Nc2cQ@mail.gmail.com>
In-Reply-To: <CAJbg=FUVVfNkDM4xvmMtVtw+GCs2nXmbCT02BXoA+3Jd1Nc2cQ@mail.gmail.com>
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

On 2022-08-15 13 h 52, Elad Lahav wrote:
> /bin/sh on QNX is (by default) ksh, not bash, so perhaps that's the issue.
> 
> Shouldn't block you from submitting that change. +1 from me, if that matters ;-)
> 
> --Elad

I'll get this merged.

Thanks,

Michael

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
