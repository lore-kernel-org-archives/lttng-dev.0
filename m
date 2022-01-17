Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CB2C433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 17 Jan 2022 14:39:55 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Jcvgt35YvzHSy;
	Mon, 17 Jan 2022 09:39:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642430395;
	bh=GG+Vd9hpj9TMWJATSojWKH/ynkHiPrpgxKszV3UxOpQ=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=resvgn026I89dumhbAmi6W6YAPenKFb7yJQg2WjVbLyZNiQNYQkkD00ii256owaYu
	 vRCC4GuwpoF4VVKcxDSskAuvU88Z2mQs1qMmqsF8ReQCJFotVSZqpHvGSn7wTKZvTa
	 ZzA012298LN8XHEbDP1JT92/cr148Jgp4RNy6sxXQHgWKuPNIJfMdoqgbD1H2GY1eh
	 jHEb4fZgyDW5qy38ofdQKNnns2itIst7PRuNZt3qEGcUytdJjbpNm7V8R5TasUHiJc
	 niDSDMwFazp7LsTfXb+8Db8lEmITm0qkp2QPeN/jG/jWM0kEjPxSTDGDx1cBPnz9oi
	 I+eeXWPg37XHA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Jcvgr4wyPzHW3
 for <lttng-dev@lists.lttng.org>; Mon, 17 Jan 2022 09:39:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 43BE7300D4F
 for <lttng-dev@lists.lttng.org>; Mon, 17 Jan 2022 09:39:46 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id mI7Q4fj-J84G; Mon, 17 Jan 2022 09:39:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id CD707300D49;
 Mon, 17 Jan 2022 09:39:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CD707300D49
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 5s97PDUy9FnF; Mon, 17 Jan 2022 09:39:45 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C0890300D48;
 Mon, 17 Jan 2022 09:39:45 -0500 (EST)
Date: Mon, 17 Jan 2022 09:39:45 -0500 (EST)
To: Subrata Paul <subrata.turs@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <495231298.38601.1642430385666.JavaMail.zimbra@efficios.com>
In-Reply-To: <CABAcCUO1b5fPHKTY=9tHerojSGuJ3PpFrmqVWtrJQO3eqWn-VQ@mail.gmail.com>
References: <CABAcCUO1b5fPHKTY=9tHerojSGuJ3PpFrmqVWtrJQO3eqWn-VQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: date in lttng trace logs
Thread-Index: YLNmle5JBDy+KMRtAtzsOF9h02mznw==
Subject: Re: [lttng-dev] date in lttng trace logs
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
Content-Type: multipart/mixed; boundary="===============3831444640832339003=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3831444640832339003==
Content-Type: multipart/alternative; 
	boundary="=_3bcc0822-1670-4abc-b0e8-080700df85b2"

--=_3bcc0822-1670-4abc-b0e8-080700df85b2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jan 16, 2022, at 6:29 AM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi,
> Is it possible to have date in lttng trace logs like below?

> [Sat-Jan-15 06:03:53.725525515] (+2.019614411) localhost:....

See man babeltrace(1), especially "--clock-date". 

Thanks, 

Mathieu 

> --------------------------------------------------------------
> Regards,
> Subrata Paul

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_3bcc0822-1670-4abc-b0e8-080700df85b2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Jan 16, 2022, at 6:29 AM, =
lttng-dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div dat=
a-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt;"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div>Is =
it possible to have date in lttng trace logs like below?</div><br><div>[Sat=
-Jan-15&nbsp;06:03:53.725525515] (+2.019614411) localhost:....</div></div><=
/div></div></blockquote><div><br></div><div>See man babeltrace(1), especial=
ly "--clock-date".<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogu=
s=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin=
-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;=
text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;=
"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><br></div><div><b=
r clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D=
"ltr"><div><table style=3D"max-width:600px;direction:ltr"><tbody><tr><td>=
=20
=09=09=09 <table style=3D"max-width:440px;padding-bottom:10px;margin-bottom=
:8px" cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td> <tab=
le cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td style=3D=
"vertical-align:top" valign=3D"top"><font face=3D"tahoma, sans-serif">-----=
---------------------------------------------------------<br>Regards,<br>Su=
brata Paul</font></td></tr></tbody></table></td></tr></tbody></table></td><=
/tr></tbody></table>
=09</div></div></div></div></div></div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_3bcc0822-1670-4abc-b0e8-080700df85b2--

--===============3831444640832339003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3831444640832339003==--
