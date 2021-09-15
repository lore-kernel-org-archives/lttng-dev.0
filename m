Return-Path: <SRS0=94Rg=OF=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE4C433F5
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Sep 2021 16:00:21 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D166127B
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Sep 2021 16:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14D166127B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4H8lKv2L0hz18jL;
	Wed, 15 Sep 2021 12:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1631721620;
	bh=xxAWoPNt8iZzlyTG3DqN8Tr87id0pgKWeOLVa3yKRF4=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=U7x/MuVpGJ4iDbCnE/6MdQXpKmmu+hBj39RW/8wRa8eYYuILW9Hx+3rQf8rAkNnAX
	 d9TL0qI/8xxpkH1LGHuzKaFtz11zlKolF9X5l+08LbCGIenNbMF+5X4ZPoEINp9NJT
	 Lc3o7rg0RKESmJpSdVMCz/u4yhYH1TlbGuMxiuHorypzNJF/EFjPD3hbBj63T02cJd
	 Nc3S+2hdYxBx1GnQaLkrFyNnorFkg31BH2AcVeO1an9U6qXOSGftoXOsfoguks3nBd
	 hrLFJHi84lyTRAdvI5pcRDB8sad4fglPyYWcomNvOiCe5FuvD2snoW9qHCQTOGQ/7r
	 6IojjdRNGBVbw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4H8lKs1JHlz197J
 for <lttng-dev@lists.lttng.org>; Wed, 15 Sep 2021 12:00:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B05B5371C4A
 for <lttng-dev@lists.lttng.org>; Wed, 15 Sep 2021 12:00:11 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id YXfOP0zHal2j; Wed, 15 Sep 2021 12:00:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 456DB371E23;
 Wed, 15 Sep 2021 12:00:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 456DB371E23
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9U6aln8EZG5T; Wed, 15 Sep 2021 12:00:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 31586371AF7;
 Wed, 15 Sep 2021 12:00:10 -0400 (EDT)
Date: Wed, 15 Sep 2021 12:00:10 -0400 (EDT)
To: Mayur Patel <mayur.patel@disguise.one>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <2051744562.19686.1631721610084.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAMZxD0qL61Q2PmCd+10UHAngBcwH9KjSOL0JyFYNu-T19Q+3ZQ@mail.gmail.com>
References: <CAMZxD0qL61Q2PmCd+10UHAngBcwH9KjSOL0JyFYNu-T19Q+3ZQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF91 (Linux)/8.8.15_GA_4059)
Thread-Topic: Lttng live protocol
Thread-Index: SDkGmG7GfrLE0ssbRt86YRcrEAQmDw==
Subject: Re: [lttng-dev] Lttng live protocol
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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
Content-Type: multipart/mixed; boundary="===============8513907938051580088=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8513907938051580088==
Content-Type: multipart/alternative; 
	boundary="=_6ef2d5ad-3d8a-4cc7-8b24-65bf2465d9f7"

--=_6ef2d5ad-3d8a-4cc7-8b24-65bf2465d9f7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Sep 1, 2021, at 1:23 PM, lttng-dev <lttng-dev@lists.lttng.org> wrote: 

> Hi there,

> I am currently evaluating the use of CTF and lttng tooling for application
> tracing on windows. We are exploring alternatives to ETW that are more
> customisable.
> One thing we would really like to do is real-time monitoring of our application
> from another machine. I have a few questions regarding this:

> 1. Is lttng live protocol suitable for this purpose? What kind of latency would
> we expect? (e.g 10s or 100s of milliseconds or more)

The lttng live protocol has been designed for extracting a low-throughput of events to a live pretty-printer, with delays in the area of 
a few seconds. It's a polling-based mechanism at the moment. 

> 2. Is the protocol documented?

No. There is only an implementation with the lttng project and in babeltrace. 

> 3. Is it possible to use lttng-relayd to read from local CTF log files (which
> are being written to) and stream events to other machines / a viewer on the
> same machine? The reason I ask this is the documentation seems suggests
> lttng-relayd can consume CTF files [
> https://lttng.org/docs/v2.13/#doc-lttng-relayd |
> https://lttng.org/docs/v2.13/#doc-lttng-relayd ] .

lttng-relayd needs to control both writing to the CTF log files and reading from them. The "writing to" 
cannot be done by an external process. 

> 4. I see there is a windows cygwin build on jenkins. Would you recommend this
> for production use?

We do not recommend Cygwin builds for production use unless there are no alternatives. From my own 
past experience, the Cygwin layer is not a solid basis for production-quality software. 

Thanks for your interest, 

Mathieu 

> Any guidance would be much appreciated.

> Thanks in advance,

> Mayur

> --

> [ http://www.disguise.one/ ]

> Mayur Patel

> Lead Software Engineer

> T : +44 20 7234 9840

> M : +44 7342 180127

> A : [
> https://www.google.com/maps/place/88-89%20Blackfriars%20Road,%20London,%20SE1%208HA
> | 88-89 Blackfriars Road, London, SE1 8HA ]

> [ https://www.facebook.com/disguise.one/ ]

> [ https://twitter.com/disguise_one ]


> [ https://www.youtube.com/channel/UCBXckvTm2VHU29BUoKJizvA ]

> [ https://www.instagram.com/disguise_one/ ]

> [ https://www.linkedin.com/company/disguise-/ ]

> disguise Technologies Limited is a privately owned business registered in
> England and Wales (registered number 07937973), with its registered office
> located at 88-89 Blackfriars Road, London, SE1 8HA. This e-mail, and any
> attachments thereto, is intended only for use by the addressee(s) named herein
> and may contain legally privileged and/or confidential information. If you are
> not the intended recipient of this e-mail, you are hereby notified that any
> dissemination, distribution or copying of this e-mail, and any attachments
> thereto, is strictly prohibited. If you have received this e-mail in error,
> please notify me by replying to this message and permanently delete the
> original and any copy of this e-mail and any printout thereof. Although this
> e-mail and any attachments are believed to be free of any virus, or other
> defect which might affect any computer or system into which they are received
> and opened, it is the responsibility of the recipient to ensure that they are
> virus free and no responsibility is accepted by disguise for any loss or damage
> from receipt or use thereof.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_6ef2d5ad-3d8a-4cc7-8b24-65bf2465d9f7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Sep 1, 2021, at 1:23 PM, l=
ttng-dev &lt;lttng-dev@lists.lttng.org&gt; wrote:<br></span></div><div data=
-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #101=
0FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-sty=
le:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-=
size:12pt;"><div dir=3D"ltr">Hi there,<div><br><div>I am currently evaluati=
ng the use of CTF and lttng tooling for application tracing on windows. We =
are exploring alternatives to ETW that are more customisable.</div><div>One=
 thing we would really like to do is real-time monitoring of our applicatio=
n from another machine. I have a few questions regarding this:</div><br><di=
v>1. Is lttng live protocol suitable for this purpose? What kind of latency=
 would we expect? (e.g 10s or 100s of milliseconds or more)&nbsp;</div></di=
v></div></blockquote><div><br></div><div>The lttng live protocol has been d=
esigned for extracting a low-throughput of events to a live pretty-printer,=
 with delays in the area of<br data-mce-bogus=3D"1"></div><div>a few second=
s. It's a polling-based mechanism at the moment.<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2p=
x solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt;"><div dir=3D"ltr"><div><div>2. Is the protocol docum=
ented?&nbsp;</div></div></div></blockquote><div><br></div><div>No. There is=
 only an implementation with the lttng project and in babeltrace.<br data-m=
ce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div>3. Is =
it possible to use lttng-relayd to read from local CTF log files (which are=
 being written to) and stream events to other machines / a viewer on the sa=
me machine? The reason I ask this is the documentation seems suggests lttng=
-relayd can consume CTF files&nbsp;<a href=3D"https://lttng.org/docs/v2.13/=
#doc-lttng-relayd" target=3D"_blank" rel=3D"nofollow noopener noreferrer" d=
ata-mce-href=3D"https://lttng.org/docs/v2.13/#doc-lttng-relayd">https://ltt=
ng.org/docs/v2.13/#doc-lttng-relayd</a>.</div></div></div></blockquote><div=
><div><br data-mce-bogus=3D"1"></div></div><div>lttng-relayd needs to contr=
ol both writing to the CTF log files and reading from them. The "writing to=
"<br data-mce-bogus=3D"1"></div><div>cannot be done by an external process.=
<br data-mce-bogus=3D"1"></div><br><blockquote style=3D"border-left:2px sol=
id #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt;"><div dir=3D"ltr"><div><div>4. I see there is a windows c=
ygwin build on jenkins. Would you recommend this for production use?</div><=
/div></div></blockquote><div><br></div><div>We do not recommend Cygwin buil=
ds for production use unless there are no alternatives. From my own</div><d=
iv>past experience, the Cygwin layer is not a solid basis for production-qu=
ality software.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div>Thanks for your interest,<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid=
 #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;fon=
t-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;=
font-size:12pt;"><div dir=3D"ltr"><div><br><div>Any guidance would&nbsp;be =
much appreciated.</div><br><div>Thanks in advance,</div><br><div>Mayur</div=
><div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><table style=3D=
"font-family:sans-serif;line-height:1.4;max-width:580px;color:#363636;borde=
r-collapse:collapse" cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbod=
y><tr><td valign=3D"top">
                <table style=3D"font-family:sans-serif;border-collapse:coll=
apse;color:#333;width:300px;line-height:14px" width=3D"300" cellspacing=3D"=
0" cellpadding=3D"0" border=3D"0"><tbody><tr><td style=3D"padding:12px 0 8p=
x 0" valign=3D"top">
                                        <p style=3D"margin:0.75pt;line-heig=
ht:0px">
                                            <a href=3D"http://www.disguise.=
one" target=3D"_blank" rel=3D"nofollow noopener noreferrer"><img alt=3D" " =
style=3D"border:0;display:block;border-radius:0px" src=3D"https://smart.dis=
guise.one/v2/imagebucket/disguise.one/disguise_logo_email.png" width=3D"135=
" height=3D"38"></a>
                                        </p>
                                    </td></tr><tr><td width=3D"300" valign=
=3D"top">
                            <table style=3D"font-family:sans-serif;border-c=
ollapse:collapse;color:#333;width:300px;line-height:14px" width=3D"300" cel=
lspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td valign=3D"top"=
>
                                        <p style=3D"margin:0.75pt;color:#00=
0;font-weight:700;font-size:12px;font-family:'arial' , sans-serif"> Mayur P=
atel </p>
                                    </td></tr><tr><td style=3D"padding-bott=
om:4px" valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:'arial' , sans-serif">
                                            Lead Software Engineer
                                        </p>
                                    </td></tr><tr><td valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:'arial' , sans-serif">
                                             <span style=3D"font-weight:700=
;color:#505050">T :</span>
                                           =20
                                                <a style=3D"text-decoration=
:none;color:#333">+44 20 7234 9840</a>
                                           =20
                                        </p>
                                    </td></tr><tr><td valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:'arial' , sans-serif">
                                          <span style=3D"font-weight:700;co=
lor:#505050">M :</span>
                                           =20
                                                <a style=3D"text-decoration=
:none;color:#333">+44 7342 180127</a>
                                           =20
                                        </p>
                                    </td></tr><tr><td valign=3D"top">
                                    <p style=3D"margin:0.75pt;font-size:12p=
x;font-family:'arial' , sans-serif">
                                        <span style=3D"font-weight:700;colo=
r:#505050">A :</span>
                                       =20
                                            <a href=3D"https://www.google.c=
om/maps/place/88-89%20Blackfriars%20Road,%20London,%20SE1%208HA" style=3D"t=
ext-decoration:none;color:#333" target=3D"_blank" rel=3D"nofollow noopener =
noreferrer">88-89 Blackfriars Road, London, SE1 8HA</a>
                                       =20
                                    </p>
                                </td></tr><tr><td style=3D"padding:7px 0 2p=
x" valign=3D"top">
                                    <table style=3D"font-family:sans-serif;=
border-collapse:collapse;color:#333;width:auto;line-height:13px" cellspacin=
g=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td style=3D"padding-righ=
t:4px" width=3D"16" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
facebook.com/disguise.one/" style=3D"text-decoration:none" target=3D"_blank=
" rel=3D"nofollow noopener noreferrer"><img style=3D"border:0" src=3D"https=
://smart.disguise.one/v2/imagebucket/disguise.one/facebook.png" width=3D"14=
" height=3D"22"></a>
                                                </p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://twit=
ter.com/disguise_one" style=3D"text-decoration:none" target=3D"_blank" rel=
=3D"nofollow noopener noreferrer"><img style=3D"border:0" src=3D"https://sm=
art.disguise.one/v2/imagebucket/disguise.one/twitter.png" width=3D"22" heig=
ht=3D"22"></a><br data-mce-bogus=3D"1"></p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
youtube.com/channel/UCBXckvTm2VHU29BUoKJizvA" style=3D"text-decoration:none=
" target=3D"_blank" rel=3D"nofollow noopener noreferrer"><img style=3D"bord=
er:0" src=3D"https://smart.disguise.one/v2/imagebucket/disguise.one/youtube=
.png" width=3D"width" height=3D"22"></a>
                                                </p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
instagram.com/disguise_one/" style=3D"text-decoration:none" target=3D"_blan=
k" rel=3D"nofollow noopener noreferrer"><img style=3D"border:0" src=3D"http=
s://smart.disguise.one/v2/imagebucket/disguise.one/instagram.png" width=3D"=
22" height=3D"22"></a>
                                                </p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
linkedin.com/company/disguise-/" style=3D"text-decoration:none" target=3D"_=
blank" rel=3D"nofollow noopener noreferrer"><img style=3D"border:0" src=3D"=
https://smart.disguise.one/v2/imagebucket/disguise.one/linked-in.png" width=
=3D"22" height=3D"22"></a>
                                                </p>
                                            </td></tr></tbody></table>
                                </td></tr></tbody></table>
                        </td></tr></tbody></table>
            </td></tr></tbody></table>
<br>
<p style=3D"margin:0.75pt;font-size:8px;font-family:'arial' , sans-serif;co=
lor:#e7e8e6">disguise Technologies Limited is a privately owned business re=
gistered in England and Wales (registered number 07937973), with its regist=
ered office located at 88-89 Blackfriars Road, London, SE1 8HA. This e-mail=
, and any attachments thereto, is intended only for use by the addressee(s)=
 named herein and may contain legally privileged and/or confidential inform=
ation. If you are not the intended recipient of this e-mail, you are hereby=
 notified that any dissemination, distribution or copying of this e-mail, a=
nd any attachments thereto, is strictly prohibited. If you have received th=
is e-mail in error, please notify me by replying to this message and perman=
ently delete the original and any copy of this e-mail and any printout ther=
eof. Although this e-mail and any attachments are believed to be free of an=
y virus, or other defect which might affect any computer or system into whi=
ch they are received and opened, it is the responsibility of the recipient =
to ensure that they are virus free and no responsibility is accepted by dis=
guise for any loss or damage from receipt or use thereof.</p></div></div></=
div></div>
=E2=80=8A<br>_______________________________________________<br>lttng-dev m=
ailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-=
marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc=
.<br>http://www.efficios.com</div></div></body></html>
--=_6ef2d5ad-3d8a-4cc7-8b24-65bf2465d9f7--

--===============8513907938051580088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8513907938051580088==--
