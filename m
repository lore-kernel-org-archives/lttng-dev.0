Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DDBC433EF
	for <lttng-dev@archiver.kernel.org>; Thu, 20 Jan 2022 15:41:25 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JfmvS1Wq4zKmb;
	Thu, 20 Jan 2022 10:41:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642693284;
	bh=8GuzdUXPCHNzme0ijMSMdk/vZjmv5CDlsJ3wy349adc=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YqfGXFKPgz6xV/1AXXB0RTY10Nc5HasF2w41FFgNYZCJZiQiTBEpcGGLaazY2H3Sz
	 KmKNHQ/NRhPxVbhq3P5RvmzTlMtVm9S5ecDJhvUU8c+KTwD8Jox50J9Tw6DW12K9ET
	 7v0xMX4otijDf4Byvjrmb1pRHJ33DgdQxOgfVMnQrl5VFiA3Rkfi71YTvKz9LrROiq
	 yzLb01ZSd6lUeWBH2iMLOwY0QMPCByjWUlEuQN4ngPxkue5bxedByd7k5/B9L2FucE
	 G6DbFVAubHobVHtn80lHQMhO/Ktmyy7NUg5Wkar6mtNRaOQH9z6SoqfI/V9i4aWwOy
	 azT+HcFQzx0Uw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JfmvR2tRLzKk0
 for <lttng-dev@lists.lttng.org>; Thu, 20 Jan 2022 10:41:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C2CC43233BC;
 Thu, 20 Jan 2022 10:41:22 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id PJIsGSEhgpzs; Thu, 20 Jan 2022 10:41:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 711E93233BB;
 Thu, 20 Jan 2022 10:41:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 711E93233BB
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 78Uee0g_MmOa; Thu, 20 Jan 2022 10:41:22 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 5CFEE3233B9;
 Thu, 20 Jan 2022 10:41:22 -0500 (EST)
Date: Thu, 20 Jan 2022 10:41:22 -0500 (EST)
To: olivier moussavoucotte <olivier.moussavoucotte@mail.mcgill.ca>
Cc: Jeremie Galarneau <jgalar@efficios.com>, 
 Jonathan Rajotte-Julien <joraj@efficios.com>, 
 lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <252180467.62240.1642693282241.JavaMail.zimbra@efficios.com>
In-Reply-To: <YQXPR01MB2712147C9653E6026971BAACAE5A9@YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM>
References: <1338660677.61818.1642692030254.JavaMail.zimbra@efficios.com>
 <YQXPR01MB2712147C9653E6026971BAACAE5A9@YQXPR01MB2712.CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: Transfer of LTTng copyright ownership: Olivier Cotte
Thread-Index: MdjTM5J+pJqA6C4FQZzeZ6aa9M8Czv51v1BfZwoNdWw=
Subject: Re: [lttng-dev] Transfer of LTTng copyright ownership: Olivier Cotte
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
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
Content-Type: multipart/mixed; boundary="===============4753517551411853375=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4753517551411853375==
Content-Type: multipart/alternative; 
	boundary="=_76b8cf04-e583-4367-93f3-da88b5a1dfa6"

--=_76b8cf04-e583-4367-93f3-da88b5a1dfa6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jan 20, 2022, at 10:36 AM, olivier moussavoucotte <olivier.moussavoucotte@mail.mcgill.ca> wrote: 

> Hi everyone,

> I see no inconvienecne into transfering the license to EfficiOS Inc.

Perfect, thank you! The last step will be to reply to the upcoming [PATCH] email 
with your Signed-off-by: Name <email> tag. 

Mathieu 

> Wish you all best of luck with this work,

> Best,
> Olivier

> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Sent: January 20, 2022 11:20 AM
> To: Olivier Moussavou Cotte <olivier.moussavoucotte@mail.mcgill.ca>
> Cc: Jeremie Galarneau <jgalar@efficios.com>; Jonathan Rajotte-Julien
> <joraj@efficios.com>; lttng-dev <lttng-dev@lists.lttng.org>
> Subject: Transfer of LTTng copyright ownership: Olivier Cotte
> Hi Olivier,

> In order to facilitate maintenance of the LTTng project, would you agree to
> transfer your copyright ownership for LTTng code co-authored with Jonathan
> Rajotte at Polytechnique to EfficiOS Inc. ?

> The copyright in question is for the files mi-lttng.cpp, mi-lttng.h and
> mi-lttng-4.1.xsd in the lttng-tools project:

> Copyright (C) 2014 Olivier Cotte <olivier.cotte@polymtl.ca>

> Thanks,

> Mathieu

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_76b8cf04-e583-4367-93f3-da88b5a1dfa6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body><div style="font-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000000"><div><br></div><div><br></div><div><span id="zwchr" data-marker="__DIVIDER__">----- On Jan 20, 2022, at 10:36 AM, olivier moussavoucotte &lt;olivier.moussavoucotte@mail.mcgill.ca&gt; wrote:<br></span><style style="display:none">/*<![CDATA[*/P {
	margin-top: 0;
	margin-bottom: 0;
}
/*]]>*/</style></div><div data-marker="__QUOTED_TEXT__"><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
<div style="font-family:'calibri' , 'arial' , 'helvetica' , sans-serif;font-size:12pt;color:rgb( 0 , 0 , 0 )">
Hi everyone,</div>
<div style="font-family:'calibri' , 'arial' , 'helvetica' , sans-serif;font-size:12pt;color:rgb( 0 , 0 , 0 )">
<br>
</div>
<div style="font-family:'calibri' , 'arial' , 'helvetica' , sans-serif;font-size:12pt;color:rgb( 0 , 0 , 0 )">
I see no inconvienecne into transfering the license&nbsp;<span style="font-size:12pt;background-color:rgba( 0 , 0 , 0 , 0 );display:inline !important">to EfficiOS Inc.</span></div></blockquote><div>Perfect, thank you! The last step will be to reply to the upcoming [PATCH] email<br></div><div>with your Signed-off-by: Name &lt;email&gt; tag.<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><div>Mathieu<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">
<div style="font-family:'calibri' , 'arial' , 'helvetica' , sans-serif;font-size:12pt;color:rgb( 0 , 0 , 0 )">
<span style="font-size:12pt;background-color:rgba( 0 , 0 , 0 , 0 );display:inline !important"><br></span></div>
<div style="font-family:'calibri' , 'arial' , 'helvetica' , sans-serif;font-size:12pt;color:rgb( 0 , 0 , 0 )">
<span style="font-size:12pt;background-color:rgba( 0 , 0 , 0 , 0 );display:inline !important">Wish you all best of luck with this work,</span></div>
<div style="font-family:'calibri' , 'arial' , 'helvetica' , sans-serif;font-size:12pt;color:rgb( 0 , 0 , 0 )">
<span style="font-size:12pt;background-color:rgba( 0 , 0 , 0 , 0 );display:inline !important"><br></span></div>
<div style="font-family:'calibri' , 'arial' , 'helvetica' , sans-serif;font-size:12pt;color:rgb( 0 , 0 , 0 )">
<span style="font-size:12pt;background-color:rgba( 0 , 0 , 0 , 0 );display:inline !important">Best,
<div>Olivier</div></span></div>

<hr style="display:inline-block;width:98%">
<div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br><b>Sent:</b> January 20, 2022 11:20 AM<br><b>To:</b> Olivier Moussavou Cotte &lt;olivier.moussavoucotte@mail.mcgill.ca&gt;<br><b>Cc:</b> Jeremie Galarneau &lt;jgalar@efficios.com&gt;; Jonathan Rajotte-Julien &lt;joraj@efficios.com&gt;; lttng-dev &lt;lttng-dev@lists.lttng.org&gt;<br><b>Subject:</b> Transfer of LTTng copyright ownership: Olivier Cotte</font>
<div>&nbsp;</div>
</div>
<div class="BodyFragment"><font size="2"><span style="font-size:11pt"><div class="PlainText">Hi Olivier,<br>
<br>
In order to facilitate maintenance of the LTTng project, would you agree to<br>
transfer your copyright ownership for LTTng code co-authored with Jonathan<br>
Rajotte at Polytechnique to EfficiOS Inc. ?<br>
<br>
The copyright in question is for the files mi-lttng.cpp, mi-lttng.h and<br>
mi-lttng-4.1.xsd in the lttng-tools project:<br>
<br>
Copyright (C) 2014 Olivier Cotte &lt;olivier.cotte@polymtl.ca&gt;<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href="http://www.efficios.com" target="_blank" rel="nofollow noopener noreferrer">http://www.efficios.com</a><br>
</div></span></font></div><br></blockquote></div><div><br></div><div data-marker="__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_76b8cf04-e583-4367-93f3-da88b5a1dfa6--

--===============4753517551411853375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4753517551411853375==--
