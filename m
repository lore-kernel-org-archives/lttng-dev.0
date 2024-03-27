Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06058C54E67
	for <lttng-dev@archiver.kernel.org>; Wed, 27 Mar 2024 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1711560717;
	bh=iwZZX9CKb7wmZfol9T7no2UjhTJib0IeOMqnCYSTKLc=;
	h=In-Reply-To:References:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Hqkp1cZ/bchCHbculloxTQmQ863Tptq9h4EchfFBvLqP96LOQwZf9Ki8plARtlnlW
	 x384KaJSI1kpeKc8q02CaaD5aj1g20VsIr5jU1MCFX5ypYn8jO3a4iJdYVM8duf+Ix
	 ul9SE8Q3G8oaTXWAbCRSRPIi8NasJGsSEyoccAAlVlxQzH56WyQpLpKq45Y6B3sAUs
	 SHdkSIePvCBncaSgnhPE9VbI4TvVoTWNuWY/p5iraeOoQ9G7wKp9aN1FBZDuGhxQEc
	 e01fHpF8n7V1ugWDAai246Dthn21UBo0uWnTtDvPOBoFgMb8Tgj0YcYrBGW4rClSGS
	 dZXgZpgfIt0lg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4V4Yd85yBcz2Wnq;
	Wed, 27 Mar 2024 13:31:56 -0400 (EDT)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 by lists.lttng.org (Postfix) with ESMTPS id 4V4Yd75rMzz2Wnp
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2024 13:31:54 -0400 (EDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 92AD51140131
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2024 13:28:55 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
 by compute2.internal (MEProxy); Wed, 27 Mar 2024 13:28:55 -0400
X-ME-Sender: <xms:V1cEZjIW3y1aYpkMaXwbbJV7O8bg-EGWlvs_BqEfc1qfUXjVtAsHZg>
 <xme:V1cEZnJ7-w9SmP6mzXHifb-6yc_PHn9ZiP1vzj-CT3dE78DaKeMqbn-2L62zds6Yh
 K_-t64IOmwjF91j5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgjeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
 ertderredtnecuhfhrohhmpedfvehhrhhishhtohhphhgvrhcujfgrrhhvvgihfdcuoegt
 hhhrihhssegtfihhrghrvhgvhidrtggrqeenucggtffrrghtthgvrhhnpedtvdfhvdevie
 efvdektdffgeduiefgtdfgheehvddutefhgeevudfgudduhedtffenucffohhmrghinhep
 vggtlhhiphhsvgdrohhrghdpphgvrhhfvghtthhordguvghvpdhlthhtnhhgrdhorhhgne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhi
 shestgifhhgrrhhvvgihrdgtrg
X-ME-Proxy: <xmx:V1cEZrtTdF-h8APlmvDI_7XpqcJWih04T3vVUO8086wF8Y0IqTMkPg>
 <xmx:V1cEZsYUCce-zlZQUPUmEkbrTRvmUBY6ah4eVpEoYWUitEoflaOUWw>
 <xmx:V1cEZqaAU_4ojWF7drayKSU1ueVMDzspqumdHKzvPKTMWgZKiq5SzA>
 <xmx:V1cEZgCHEV1QJHvryFB1IuljjZHqUmPI34py-5K_LCixO5OYY29ghQ>
 <xmx:V1cEZtyyB2LZL5J6rPcUEG9ALHgclqVu005_w5TqfjcZbVaA6NEzoA>
Feedback-ID: i2d19425f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 19C94BC007D; Wed, 27 Mar 2024 13:28:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
MIME-Version: 1.0
Message-Id: <a128a334-b2d8-4cec-ae40-91e1384a228d@app.fastmail.com>
In-Reply-To: <CABRndgz2BHX9LubVXoaJxLH+KoYfgzQ0XzY=xHG60+HoO-Tm7A@mail.gmail.com>
References: <CABRndgz2BHX9LubVXoaJxLH+KoYfgzQ0XzY=xHG60+HoO-Tm7A@mail.gmail.com>
Date: Wed, 27 Mar 2024 13:28:27 -0400
To: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] Lttng: display active threads in multiple cores.
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
From: Christopher Harvey via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Christopher Harvey <chris@cwharvey.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

you can use an ftrace-enabled kernel with lttng (maybe even just tracecompass) or perfetto to get that kind of trace

https://archive.eclipse.org/tracecompass.incubator/doc/org.eclipse.tracecompass.incubator.ftrace.doc.user/User-Guide.html

or

https://ui.perfetto.dev/

On Wed, Mar 27, 2024, at 5:26 AM, Zvi Vered via lttng-dev wrote:
> Hello,
>
> I have an application with 4 threads. 
> I'm required to display on the graph when thread starts working till it 
> blocks for the next semaphore. 
>
> But without using the lttng userspace library.
>
> Is it possible ?
>
> Thank you,
> Zvika
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
