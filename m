Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD8BC433EF
	for <lttng-dev@archiver.kernel.org>; Mon, 18 Jul 2022 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658159940;
	bh=yPwLnwWRoHyeVMnnn2MLbgcWRbAoUON/nixmVH8FiK8=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fLWZmDTBtmgzapdl0JdDUlX/OA4wIgJK01FI+HdDRYP90O3NIVwKQ8cnrwDmgHNSe
	 0F93MggNCdNTwSMKs36UyG//2sBGAxWp8vmpPIMA45fl3V1SIFmdiPQMI3qupEa4T7
	 RB7ZZEyDQX/m36bIm5gBs6nvf7h6yhs/It/O5jPWMkWy7tdFkCgea9tobqAEck1JvX
	 Pq6FHaZy1OS9+F2ImKoDZV5SkoWzgET8pyLNSyIWonQu3ukZzK1TwS7hXRceZTFFVn
	 FgdtMxjShO7XPbbaqd8Jgulju9UroxTyesADmmzv33cNHfyU3RcMDZTxh22nhoHgas
	 UeFIaPagIG4xQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Lmmq72LFczPVl;
	Mon, 18 Jul 2022 11:58:59 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Lmmq61P4YzPVd
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 11:58:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C89A6424327
 for <lttng-dev@lists.lttng.org>; Mon, 18 Jul 2022 11:58:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id V7nAD4MnFrt0; Mon, 18 Jul 2022 11:58:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 51918424321;
 Mon, 18 Jul 2022 11:58:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 51918424321
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id QHyBsDoqdirU; Mon, 18 Jul 2022 11:58:56 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 421FB42431D;
 Mon, 18 Jul 2022 11:58:56 -0400 (EDT)
Date: Mon, 18 Jul 2022 11:58:56 -0400 (EDT)
To: Pennese Marco <marco.pennese@leonardo.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1511510448.72040.1658159936177.JavaMail.zimbra@efficios.com>
In-Reply-To: <e1e5a7797fa044e6a9010c494a451be7@leonardo.com>
References: <e1e5a7797fa044e6a9010c494a451be7@leonardo.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: LTTng on RHEL 7.9 with real time kernel patch
Thread-Index: AdiYTTrdh6Eu3U95S9aYfchNDPwHdakFTwyO
Subject: Re: [lttng-dev] LTTng on RHEL 7.9 with real time kernel patch
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
Content-Type: multipart/mixed; boundary="===============3710285673505283581=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3710285673505283581==
Content-Type: multipart/alternative; 
	boundary="=_c216f0a7-9969-4104-82c3-e98183e6f551"

--=_c216f0a7-9969-4104-82c3-e98183e6f551
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jul 15, 2022, at 9:19 AM, Pennese Marco via lttng-dev <lttng-dev@l=
ists.lttng.org> wrote:=20

> Hi,

> I=E2=80=99m trying to use LTTng on a Red Hat Enterprise Linux 7.9 (with t=
he real time
> kernel patch).

> I installed LTTng on the machine following the EfficiOS guide linked by l=
ttng
> official website.

> In my configuration, lttng manages to record user space events.

> I=E2=80=99d like to record also kernel space events, so I=E2=80=99m follo=
wing the quickstart
> guide on the website.
> As soon as I run =E2=80=9C lttng list =E2=80=93-kernel=E2=80=9D , I obtai=
n the error:
> Error: Unable to list kernel events: Kernel tracer not available
> Error: Command error

> If I repeat the procedure on a machine without the real time kernel patch=
, it
> works as it should.

> The real time kernel I=E2=80=99m using is the following

> 3.10.0-1160.62.1.rt56.1203.el7.x86_64

> Do you think the error is due to the real time patch? Can LTTng work with=
 a real
> time kernel?

> Do I need to follow a different procedure for installing LTTng on a RHEL =
7.9
> real time machine?

Hi Marco,=20

Specific packaging needs around RHEL 7, including the real-time variant, ar=
e part of=20
EfficiOS packaging, support and feature development services, which allow u=
s to=20
develop and maintain the entire LTTng open source ecosystem. Please contact=
 us=20
in private to discuss the available options.=20

Thanks for reaching out!=20

Mathieu=20

> Thank you,

> Marco

> Il presente messaggio e-mail e ogni suo allegato devono intendersi indiri=
zzati
> esclusivamente al destinatario indicato e considerarsi dal contenuto
> strettamente riservato e confidenziale. Se non siete l'effettivo destinat=
ario o
> avete ricevuto il messaggio e-mail per errore, siete pregati di avvertire
> immediatamente il mittente e di cancellare il suddetto messaggio e ogni s=
uo
> allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusione, =
copia
> o archiviazione del presente messaggio da parte di chi non ne =C3=A8 il d=
estinatario
> =C3=A8 strettamente proibito e pu=C3=B2 dar luogo a responsabilit=C3=A0 d=
i carattere civile e
> penale punibili ai sensi di legge.
> Questa e-mail ha valore legale solo se firmata digitalmente ai sensi dell=
a
> normativa vigente.

> The contents of this email message and any attachments are intended solel=
y for
> the addressee(s) and contain confidential and/or privileged information.
> If you are not the intended recipient of this message, or if this message=
 has
> been addressed to you in error, please immediately notify the sender and =
then
> delete this message and any attachments from your system. If you are not =
the
> intended recipient, you are hereby notified that any use, dissemination,
> copying, or storage of this message or its attachments is strictly prohib=
ited.
> Unauthorized disclosure and/or use of information contained in this email
> message may result in civil and criminal liability. =E2=80=9C
> This e-mail has legal value according to the applicable laws only if it i=
s
> digitally signed by the sender

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_c216f0a7-9969-4104-82c3-e98183e6f551
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jul 15, 2022, at 9:19 AM, Pennese Marco via lttng-dev &lt;lttn=
g-dev@lists.lttng.org&gt; wrote:<br></span><style>/*<![CDATA[*/P.ImprintUni=
queID {
=09MARGIN: 0.0cm 0.0cm 0.0pt;
}
LI.ImprintUniqueID {
=09MARGIN: 0.0cm 0.0cm 0.0pt;
}
DIV.ImprintUniqueID {
=09MARGIN: 0.0cm 0.0cm 0.0pt;
}
TABLE.ImprintUniqueIDTable {
=09MARGIN: 0.0cm 0.0cm 0.0pt;
}
DIV.Section1 {
=09page: Section1;
}
/*]]>*/</style></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><style><!--
/* Font Definitions */
@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Consolas;
=09panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;
=09mso-fareast-language:EN-US;}
pre
=09{mso-style-priority:99;
=09mso-style-link:"Preformattato HTML Carattere";
=09margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:10.0pt;
=09font-family:"Courier New";}
span.StileMessaggioDiPostaElettronica17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;}
span.PreformattatoHTMLCarattere
=09{mso-style-name:"Preformattato HTML Carattere";
=09mso-style-priority:99;
=09mso-style-link:"Preformattato HTML";
=09font-family:"Courier New";
=09mso-fareast-language:IT;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:70.85pt 2.0cm 2.0cm 2.0cm;}
div.WordSection1
=09{page:WordSection1;}
--></style>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I=E2=80=99m trying to use LTTng=
 on a Red Hat Enterprise Linux 7.9 (with the real time kernel patch).</span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I installed LTTng on the machin=
e following the EfficiOS guide linked by lttng official website.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">In my configuration, lttng mana=
ges to record user space events.
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I=E2=80=99d like to record also=
 kernel space events, so I=E2=80=99m following the quickstart guide on the =
website.</span></p>
<pre style=3D"line-height:11.25pt;vertical-align:baseline"><span style=3D"f=
ont-size:11pt;font-family:'calibri' , sans-serif" lang=3D"EN-US">As soon as=
 I run</span><span style=3D"font-family:'consolas'" lang=3D"EN-US">=E2=80=
=9C</span><span style=3D"font-size:9pt;font-family:'consolas'" lang=3D"EN-U=
S">lttng list =E2=80=93-kernel=E2=80=9D</span><span style=3D"font-size:11pt=
;font-family:'calibri' , sans-serif" lang=3D"EN-US">, I obtain the error:</=
span></pre>

<pre style=3D"line-height:11.25pt;vertical-align:baseline"><span style=3D"f=
ont-size:9pt;font-family:'consolas'" lang=3D"EN-US">Error: Unable to list k=
ernel events: Kernel tracer not available</span></pre>
<pre style=3D"line-height:11.25pt;vertical-align:baseline"><span style=3D"f=
ont-size:9pt;font-family:'consolas'" lang=3D"EN-US">Error: Command error</s=
pan></pre>

<p class=3D"MsoNormal"><span lang=3D"EN-US">If I repeat the procedure on a =
machine without the real time kernel patch, it works as it should.</span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The real time kernel I=E2=80=99=
m using is the following</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">3.10.0-1160.62.1.rt56.1203.el7.=
x86_64</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Do you think the error is due t=
o the real time patch? Can LTTng work with a real time kernel?</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Do I need to follow a different=
 procedure for installing LTTng on a RHEL 7.9 real time machine?</span></p>=
</div></blockquote><div><br></div><div>Hi Marco,<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div>Specific packaging needs aroun=
d RHEL 7, including the real-time variant, are part of</div><div>EfficiOS p=
ackaging, support and feature development services, which allow us to</div>=
<div>develop and maintain the entire LTTng open source ecosystem. Please co=
ntact us</div><div>in private to discuss the available options.<br data-mce=
-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks for reac=
hing out!<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div=
><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2=
px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:no=
rmal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,san=
s-serif;font-size:12pt;"><div class=3D"WordSection1">

<p class=3D"MsoNormal"><span lang=3D"EN-US">Thank you,</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Marco</span></p>
</div>
<br>
<font size=3D"1" face=3D"Arial" color=3D"blue">Il presente messaggio e-mail=
 e ogni suo allegato devono intendersi indirizzati esclusivamente al destin=
atario indicato e considerarsi dal contenuto strettamente riservato e confi=
denziale. Se non siete l'effettivo destinatario
 o avete ricevuto il messaggio e-mail per errore, siete pregati di avvertir=
e immediatamente il mittente e di cancellare il suddetto messaggio e ogni s=
uo allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusione,=
 copia o archiviazione del presente
 messaggio da parte di chi non ne =C3=A8 il destinatario =C3=A8 strettament=
e proibito e pu=C3=B2 dar luogo a responsabilit=C3=A0 di carattere civile e=
 penale punibili ai sensi di legge.<br>
Questa e-mail ha valore legale solo se firmata digitalmente ai sensi della =
normativa vigente.<br></font><font size=3D"1" face=3D"Arial" color=3D"blue"=
><hr align=3D"left">
The contents of this email message and any attachments are intended solely =
for the addressee(s) and contain confidential and/or privileged information=
.<br>
If you are not the intended recipient of this message, or if this message h=
as been addressed to you in error, please immediately notify the sender and=
 then delete this message and any attachments from your system. If you are =
not the intended recipient, you
 are hereby notified that any use, dissemination, copying, or storage of th=
is message or its attachments is strictly prohibited. Unauthorized disclosu=
re and/or use of information contained in this email message may result in =
civil and criminal liability. =E2=80=9C<br>
This e-mail has legal value according to the applicable laws only if it is =
digitally signed by the sender<br></font>

<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_c216f0a7-9969-4104-82c3-e98183e6f551--

--===============3710285673505283581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3710285673505283581==--
