Return-Path: <SRS0=U5mz=K3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92207C47082
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Jun 2021 00:48:54 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA64D6124B
	for <lttng-dev@archiver.kernel.org>; Tue,  1 Jun 2021 00:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA64D6124B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FvD780RLsz58w;
	Mon, 31 May 2021 20:48:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1622508532;
	bh=dakOvzRwErHBR/9iCeGvd1BBU7HWQQSexS9IjRjarew=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=PR5u+j2x6B+zVoTkV3YTyZjGsSfbuN9gaol6nh71xwRjSCIcA1YVoGZgRpaXljfEB
	 3nfA8ezjnE987T2GROBm2Lf51CaSBG3Nt4rOXnmLAfbsRBke0rUNGe+TaeZKGi3L9g
	 x7bRZ1IDx8RDaSpYOYva3kME+mNYQaoGCFze5Av0ys4egRzb3NnQy1G+ylUskmzvr2
	 no0+bc9DQmYCHu0fiWkaf560oazdmI3pT9Cm0Fz4Zez0TQ44R3xeKaIteM+h4SK6st
	 cgfKoaDWROx4j4Eu4SM7R2iF8DMaIoZlvJM3Ld8XgXfu7PVm7k8T/rfQYSrUm9mTd+
	 agisWbetgSDVA==
Received: from smtp.avcs-au.com (unknown [144.130.96.35])
 by lists.lttng.org (Postfix) with SMTP id 4FvD752VTtz5C3
 for <lttng-dev@lists.lttng.org>; Mon, 31 May 2021 20:48:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by pac.avcs-au.com (Postfix) with ESMTP id 523A111A6F99
 for <lttng-dev@lists.lttng.org>; Tue,  1 Jun 2021 10:48:35 +1000 (AEST)
X-Virus-Scanned: amavisd-new at avcs-au.com
Received: from smtp.avcs-au.com ([127.0.0.1])
 by localhost (smtp.avcs-au.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id YQPiRyLsfI_P for <lttng-dev@lists.lttng.org>;
 Tue,  1 Jun 2021 10:48:07 +1000 (AEST)
Received: from HPOmenPAC (unknown [192.168.100.145])
 by smtp.avcs-au.com (Postfix) with ESMTP id B2E2E11A6EC7
 for <lttng-dev@lists.lttng.org>; Tue,  1 Jun 2021 10:48:07 +1000 (AEST)
To: <lttng-dev@lists.lttng.org>
Date: Tue, 1 Jun 2021 10:48:13 +1000
Message-ID: <00e701d7567f$cd20c070$67624150$@triplanets.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-au
Thread-Index: AddWfAHl4jZEGsiKTnaAK5JnXNmBMA==
Subject: [lttng-dev] Syntax error running lttng
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
From: Merlin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: public@triplanets.com
Content-Type: multipart/mixed; boundary="===============7543628742244732590=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multipart message in MIME format.

--===============7543628742244732590==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00E8_01D756D3.9ECD93C0"
Content-Language: en-au

This is a multipart message in MIME format.

------=_NextPart_000_00E8_01D756D3.9ECD93C0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

 

I have compiled LTTNG for ARM but when I try to run the executable, I get
this error:

 

lttng: line 1: syntax error: unexpected "("

 

E.G.        lttng create my-kernel-session
--output=/mnt/sd1/nfs/temp/Innotech/lttng/my-kernel-trace

lttng list --kernel

lttng-sessiond

  all produce the same error.

 

There were no compiler errors.  I am at a loss to understand what it is
complaining about from the message.

 

Modules seem to load fine.

 

~ # lsmod

Module                  Size  Used by    Tainted: G

lttng_ring_buffer_client_discard    20480  0

lttng_ring_buffer_client_mmap_discard    20480  0

lttng_ring_buffer_metadata_mmap_client    16384  0

lttng_ring_buffer_metadata_client    16384  0

lttng_ring_buffer_event_notifier_client    16384  0

lttng_ring_buffer_client_overwrite    20480  0

lttng_tracer         1167360  6
lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lttng
_ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lttng_ri
ng_buffer_event_notifier_client,lttng_ring_buffer_client_overwrite

lttng_kprobes          16384  1 lttng_tracer

lttng_lib_ring_buffer    57344  7
lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lttng
_ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lttng_ri
ng_buffer_event_notifier_client,lttng_ring_buffer_client_overwrite,lttng_tra
cer

lttng_kretprobes       16384  1 lttng_tracer

lttng_statedump        20480  1 lttng_tracer

lttng_wrapper          16384  2 lttng_tracer,lttng_statedump

lttng_clock            16384  4
lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lttng
_ring_buffer_client_overwrite,lttng_tracer

 

Any suggestions appreciated.

 

Thank you.

 

Merlin


------=_NextPart_000_00E8_01D756D3.9ECD93C0
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-AU =
link=3D"#0563C1" vlink=3D"#954F72" style=3D'word-wrap:break-word'><div =
class=3DWordSection1><p class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I have =
compiled LTTNG for ARM but when I try to run the executable, I get this =
error:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal style=3D'text-indent:36.0pt'>lttng: line 1: syntax =
error: unexpected &quot;(&quot;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>E.G.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng =
create my-kernel-session =
--output=3D/mnt/sd1/nfs/temp/Innotech/lttng/my-kernel-trace<o:p></o:p></p=
><p class=3DMsoNormal style=3D'text-indent:36.0pt'>lttng list =
--kernel<o:p></o:p></p><p class=3DMsoNormal =
style=3D'text-indent:36.0pt'>lttng-sessiond<o:p></o:p></p><p =
class=3DMsoNormal style=3D'text-indent:36.0pt'>&nbsp; all produce the =
same error.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>There were no compiler errors.&nbsp; I am at a loss to =
understand what it is complaining about from the =
message.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Modules seem to load fine.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>~ # lsmod<o:p></o:p></p><p =
class=3DMsoNormal =
style=3D'margin-left:36.0pt'>Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Size&nbsp; Used by&nbsp;&nbsp;&nbsp; Tainted: G<o:p></o:p></p><p =
class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_ring_buffer_client_discard&nbsp;&nbsp;=
&nbsp; 20480&nbsp; 0<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_ring_buffer_client_mmap_discard&nbsp;&=
nbsp;&nbsp; 20480&nbsp; 0<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_ring_buffer_metadata_mmap_client&nbsp;=
&nbsp;&nbsp; 16384&nbsp; 0<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_ring_buffer_metadata_client&nbsp;&nbsp=
;&nbsp; 16384&nbsp; 0<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_ring_buffer_event_notifier_client&nbsp=
;&nbsp;&nbsp; 16384&nbsp; 0<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_ring_buffer_client_overwrite&nbsp;&nbs=
p;&nbsp; 20480&nbsp; 0<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_tracer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 1167360&nbsp; 6 =
lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lt=
tng_ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lt=
tng_ring_buffer_event_notifier_client,lttng_ring_buffer_client_overwrite<=
o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_kprobes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 16384&nbsp; 1 lttng_tracer<o:p></o:p></p><p =
class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_lib_ring_buffer&nbsp;&nbsp;&nbsp; =
57344&nbsp; 7 =
lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lt=
tng_ring_buffer_metadata_mmap_client,lttng_ring_buffer_metadata_client,lt=
tng_ring_buffer_event_notifier_client,lttng_ring_buffer_client_overwrite,=
lttng_tracer<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_kretprobes&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 16384&nbsp; 1 lttng_tracer<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_statedump&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 20480&nbsp; 1 lttng_tracer<o:p></o:p></p><p =
class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_wrapper&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 16384&nbsp; 2 =
lttng_tracer,lttng_statedump<o:p></o:p></p><p class=3DMsoNormal =
style=3D'margin-left:36.0pt'>lttng_clock&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16384&nbsp; 4 =
lttng_ring_buffer_client_discard,lttng_ring_buffer_client_mmap_discard,lt=
tng_ring_buffer_client_overwrite,lttng_tracer<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Any =
suggestions appreciated.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Thank =
you.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Merlin<o:p></o:p></p></div></body></html>
------=_NextPart_000_00E8_01D756D3.9ECD93C0--


--===============7543628742244732590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7543628742244732590==--

