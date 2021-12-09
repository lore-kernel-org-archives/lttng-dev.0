Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F9FC433F5
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Dec 2021 20:20:24 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J954l4BRrz1sTn;
	Thu,  9 Dec 2021 15:20:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639081224;
	bh=JdJ67YLa+KP0R8z9loCkAGMyrDgshZ8fFkA9JOjiGy8=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Z2FwT/EMlh8PK496R46b5aQCmk/G0Jpem1d5T/lur82+0UK+kR5ozg+nQRgzR+hHr
	 C61k/Bm27EZVrpMMuNSAo/bPp5HcPofjUM+a6X4NHcU3+OgDBxluKXGa7ofgAt6gs7
	 Pt7XWLMCCKaFKBygzKWGu+FkHDNxoKgV3dM54zXU1p2t8FrOvaWOawMfqxsKuGsW5I
	 fVsi76VbwXdjO/HNlbEYgiCFYH2oymamIBbfsxAGSzvTZewweTwyafGOMAX7ic2alc
	 ripcIHTARomj+9LZw2g7zafp6yFyAW4f91N6IIYHwqWzacco2lCXpVjHvQxQ5n/+iO
	 Iv08R4kgX95DA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4J954j6bTBz1sP0
 for <lttng-dev@lists.lttng.org>; Thu,  9 Dec 2021 15:20:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8D58335FCA9
 for <lttng-dev@lists.lttng.org>; Thu,  9 Dec 2021 15:20:15 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id HmljeVcZbiOS; Thu,  9 Dec 2021 15:20:15 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1D70E35FD16;
 Thu,  9 Dec 2021 15:20:15 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1D70E35FD16
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id d78CvhRR_Gi9; Thu,  9 Dec 2021 15:20:15 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 135C235FC21;
 Thu,  9 Dec 2021 15:20:15 -0500 (EST)
Date: Thu, 9 Dec 2021 15:20:14 -0500 (EST)
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1486080138.26292.1639081214982.JavaMail.zimbra@efficios.com>
In-Reply-To: <0c3d0086-e024-4aa9-a7f6-d54a7d487849.zhenyu.ren@aliyun.com>
References: <6ad73114-861c-46e3-8f9e-1076e482116f.zhenyu.ren@aliyun.com>
 <1503888133.17265.1638907679680.JavaMail.zimbra@efficios.com>
 <0c3d0086-e024-4aa9-a7f6-d54a7d487849.zhenyu.ren@aliyun.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4173 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4177)
Thread-Topic: =?utf-8?B?5Zue5aSN77yaW2x0dG5nLWRldl0=?= lttng-consumerd can NOT
 get notification to consume ring buffer data
Thread-Index: j4IiitC0OYMU//aghGIG7FGB+T/7Mw==
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSN77yaIGx0dG5nLWNvbnN1bWVyZCBjYW4g?=
 =?utf-8?q?NOT_get_notification_to_consume_ring_buffer_data?=
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
Content-Type: multipart/mixed; boundary="===============2167050732034081823=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2167050732034081823==
Content-Type: multipart/alternative; 
	boundary="=_2a174b49-3a63-4b2a-944d-f2197f0d8b0c"

--=_2a174b49-3a63-4b2a-944d-f2197f0d8b0c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Dec 7, 2021, at 8:47 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote:=
=20

> Hi, Desnoyers

> For various reasons, none of the three suggestions you mentioned about
> reproducing the problem can be achieved easily.
> I am also wonder why commit counter not updated...It seems that the span
> producers not complete commiting(be killed?hang?)? It=E2=80=98s very hard=
 to debug all
> span producers since they are too many...
> So, Can I make lttng-consumer just skip out this subbuffer and try to con=
sume
> the next subbuffer?

No, it's not that simple. Once this state is reached (e.g. caused by a kill=
ed application), just skipping this sub-buffer=20
will not allow applications to continue using this buffer for tracing until=
 it is destroyed.=20

Thanks,=20

Mathieu=20

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_2a174b49-3a63-4b2a-944d-f2197f0d8b0c
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Dec 7, 2021, at 8:47 PM, zhenyu.ren &lt;zhenyu.ren@aliyun.com&=
gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=3D"__aliyun_emai=
l_body_block"><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti=
' , 'simsun';font-size:14px;color:#000000">Hi, Desnoyers</span></div><div><=
span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-si=
ze:14px;color:#000000"><br></span></div><div><span style=3D"font-family:'ta=
homa' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">&nbsp;=
 &nbsp; &nbsp; &nbsp;For various reasons, none of the three suggestions you=
 mentioned about reproducing the problem can be achieved easily.</span></di=
v><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun'=
;font-size:14px;color:#000000">&nbsp; &nbsp; &nbsp; &nbsp;I am also wonder =
why commit counter not updated...It seems that the span producers not compl=
ete commiting(be killed?hang?)? It=E2=80=98s very hard to debug all span pr=
oducers since they are too many...</span></div><div><span style=3D"font-fam=
ily:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000"=
>&nbsp; &nbsp; &nbsp; &nbsp;So, Can I make lttng-consumer just skip out thi=
s subbuffer and try to consume the next subbuffer?</span></div></div></bloc=
kquote><div>No, it's not that simple. Once this state is reached (e.g. caus=
ed by a killed application), just skipping this sub-buffer</div><div>will n=
ot allow applications to continue using this buffer for tracing until it is=
 destroyed.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div>Mathieu<br data-mce-bogus=3D"1"></div></div><div><br data-mce-b=
ogus=3D"1"></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathie=
u Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body><=
/html>
--=_2a174b49-3a63-4b2a-944d-f2197f0d8b0c--

--===============2167050732034081823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2167050732034081823==--
