Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664A6D59F48
	for <lttng-dev@archiver.kernel.org>; Wed,  6 Nov 2024 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1730908624;
	bh=1TzBj06qkGW6heidPzpqa1lGoLFE41vqNJPyeevkdpA=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=v0RrI9emKtPZOBQ6T0MdQ8n633znypvng3zeoIQoRbDbiutXGgpXy+860BVK9YxnX
	 adVkb7+ftgMCrZVWfv3pmLYWLtZ5gaNZo4JbBLgpEi075anhawMXGbsAk8B7rsr5l2
	 buLJw5EY+F4MjVvrSxokrJA1J19uFClxclur9p8PX+R3CjqnoLoixGb0HQxkmr4Km4
	 H/GFeQVDDMLFnuR5K6UtFfx7Ar2Oo9yzBz4O7brqoFqvwVzo7rJ0+8g8mt51W+2clF
	 Mk+HGfP3ApkidqxCGvipFWowaDRXqjal55vBiSjh3SwNM+s518YCRyqcE+L0zrgIxZ
	 m7GKGszy6evOw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Xk8wH42Kfz1SGZ;
	Wed,  6 Nov 2024 10:57:03 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4Xk8wD13p1z1S9T
 for <lttng-dev@lists.lttng.org>; Wed,  6 Nov 2024 10:56:59 -0500 (EST)
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown
 [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xk8w52d4TzjyN;
 Wed,  6 Nov 2024 10:56:53 -0500 (EST)
Message-ID: <b54eb26d-1818-4c6f-b64d-9b61f02ccc44@efficios.com>
Date: Wed, 6 Nov 2024 10:55:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel tracing from inside a Docker container
To: "Eibach, Dirk" <Dirk.Eibach@cloos.de>,
 "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
References: <9cd16ae1-a2c8-4279-b8df-82ab5be5b31e.9610e98a-1b50-4bc4-83bb-532efa96e9a9.ca90a335-62b6-4541-8ae3-a07498ba9de9@emailsignatures365.codetwo.com>
 <GV1PR10MB65629CEE94282989CBD614C297532@GV1PR10MB6562.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <GV1PR10MB65629CEE94282989CBD614C297532@GV1PR10MB6562.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

lttng-modules exposes its control ABI through the
virtual file /proc/lttng.

Does you container have access to that file ?

Note that if you give access to that file within the
container, then the container can observe detailed
information about kernel internals (including related
to other containers).

Thanks,

Mathieu

On 2024-11-06 02:38, Eibach, Dirk via lttng-dev wrote:
> Hi,
> 
> I want to do kernel tracing from inside a Docker container. 
> Kernel-tracing works from the host and the modules are loaded.
> Userspace tracing works inside the container. But when I do "lttng list 
> --kernel" from the container I get "Error: Unable to list kernel events: 
> Kernel tracer not available". Running in the container in priviledged 
> mode makes no difference.
> 
> Mit freundlichen Grüßen / Best Regards
> Dirk Eibach
> _________________________________
> CARL CLOOS SCHWEISSTECHNIK GMBH
> Softwareentwickler / AU-EW
> Softwaredeveloper / AU-EW
> Hauptverwaltung/Headquarters: Carl-Cloos-Strasse 1
> Zentrallager/Central Warehouse: Carl-Cloos-Strasse 6
> 35708 Haiger
> Germany
> Tel:      +49 2773 85-888
> E-Mail: mailto:dirk.eibach@cloos.de <mailto:dirk.eibach@cloos.de>
> Internet: http://www.cloos.de/ <http://www.cloos.de/>
> 
> Sitz der Firma/Headquarters: 35708 Haiger, Germany
> Amtsgericht/Lower district court: Wetzlar HR B 3052
> UST.-ID-Nr./VAT ID No.: DE 111 79 45 11
> WEEE-Reg.-Nr./WEEE-Reg. No.: DE83919745
> Geschäftsführer/Management: Stephan Pittner (CEO)
> 
> <https://www.linkedin.com/company/carl-cloos-schwei%C3%9Ftechnik-gmbh> 
> <https://www.youtube.com/user/CloosWelding> 
> <https://www.facebook.com/CloosWelding> 
> <https://www.instagram.com/CloosWelding> 
> <https://www.xing.com/profile/carlcloosschweisstechnikgmbh>
> 
> CLOOS-Newsletter <https://www.cloos.de/de-de/#newsletter>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

