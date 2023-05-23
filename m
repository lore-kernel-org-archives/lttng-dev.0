Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34590C7EE26
	for <lttng-dev@archiver.kernel.org>; Tue, 23 May 2023 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684844253;
	bh=BlNxs9d6wmoJx2wn7KxE+aGxGfdKq8VwG0aoutajZZw=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=AtmwQwks+PVVV8mlXVmdq9yATZclsL68Y6IKoWaoGW4x6X2G7q9+N4DRXcEfJPEFc
	 3bRqoOxz4zMBASM6AI52gySa8eeg2YmpJbDPr0xz5awr55r2nU/R7ugfUW/M7AA/if
	 YxgFvBKuwlGNnyu1CCAcIyOOuWAhfdOJEiUEmZrlppq5hzuR8o4TeuPR0n8aEXLkLC
	 WFXh46FFFFMEYVOsBu1YNcmSWfzwCVjL7VmOLD5x59vy4aX/dlkyMAesY3eIcSnqP+
	 fcVEeAp6A/LY13o9Y99xwsIAU7WPt5kBMFHgNu4Bxwxvl5J0Xlh2/LP82Bt56Zm40l
	 eEP7d9ZuSmWrw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QQYH11Ckqz1HcS;
	Tue, 23 May 2023 08:17:33 -0400 (EDT)
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com
 [99.78.197.220])
 by lists.lttng.org (Postfix) with ESMTPS id 4QQYGz20SLz1H93
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2023 08:17:31 -0400 (EDT)
X-IronPort-AV: E=Sophos;i="6.00,186,1681171200"; d="scan'208,217";a="5157606"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com)
 ([10.25.36.214]) by smtp-border-fw-80009.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 12:17:22 +0000
Received: from EX19D007EUA004.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix)
 with ESMTPS id 4611580423
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2023 12:17:22 +0000 (UTC)
Received: from EX19D007EUA004.ant.amazon.com (10.252.50.76) by
 EX19D007EUA004.ant.amazon.com (10.252.50.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 May 2023 12:17:21 +0000
Received: from EX19D007EUA004.ant.amazon.com ([fe80::d9f5:ab17:b5c0:4f4d]) by
 EX19D007EUA004.ant.amazon.com ([fe80::d9f5:ab17:b5c0:4f4d%3]) with
 mapi id 15.02.1118.026; Tue, 23 May 2023 12:17:21 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: delay between trigger and action
Thread-Index: AdmNbmIDJquxntJBTEq67T5MR6x9Dw==
Date: Tue, 23 May 2023 12:17:20 +0000
Message-ID: <ef30ea91bb3c427e84c6677350bda6d7@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.175]
MIME-Version: 1.0
Subject: [lttng-dev] delay between trigger and action
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
From: "Yitschak, Yehuda via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Yitschak, Yehuda" <yehuday@amazon.com>
Content-Type: multipart/mixed; boundary="===============7240065935221398766=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============7240065935221398766==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_ef30ea91bb3c427e84c6677350bda6d7amazoncom_"

--_000_ef30ea91bb3c427e84c6677350bda6d7amazoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi everyone

I am experimenting with enabling trace for a specific iteration of a loop i=
n my application.
I created 2 trace points at the start and end of the loop which log the ite=
ration number.
the loop itself creates thousands of trace points. It runs for ~5ms.

on lttng side I created 2 triggers to start and stop my session in case the=
 loop tracepoint registers a specific iteration number.
the triggers seem to work since there is another session entry created unde=
r the session folder but there are very few tracepoints.

is it possible that the delay between the event happening and the session t=
race starting causes loss of events ?
If yes, is there a way around this  ?

here is my setup :

#lttng-status
Recording session session: [inactive]
    Trace output: /home/user/lttng-traces/session-20230523-113537

=3D=3D=3D Domain: User space =3D=3D=3D

Buffering scheme: per-user

Tracked process attributes
  Virtual process IDs:  all
  Virtual user IDs:     all
  Virtual group IDs:    all

Channels:
-------------
- user-channel: [enabled]

    Attributes:
      Event-loss mode:  discard
      Sub-buffer size:  16777216 bytes
      Sub-buffer count: 128
      Switch timer:     inactive
      Read timer:       inactive
      Monitor timer:    1000000 us
      Blocking timeout: 0 us
      Trace file count: 1 per stream
      Trace file size:  unlimited
      Output mode:      mmap

    Statistics:
      Discarded events: 0

    Recording event rules:
      trace_events* (type: tracepoint) [enabled]
      loop* (type: tracepoint) [enabled]

#lttng list-triggers

- name: iter-start
  owner uid: 1000
  condition: event rule matches
    rule: loop:iteration (type: user tracepoint, filter: iter=3D=3D2 && sta=
rt =3D=3D 1)
    errors: none
  actions:
    start session `session`
      errors: none
  errors: none
- name: iter-stop
  owner uid: 1000
  condition: event rule matches
    rule: loop:iteration (type: user tracepoint, filter: iter=3D=3D2 && sta=
rt =3D=3D 0)
    errors: none
  actions:
    stop session `session`
      errors: none
  errors: none


Thanks

Yehuda

--_000_ef30ea91bb3c427e84c6677350bda6d7amazoncom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
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
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi everyone <br>
<br>
I am experimenting with enabling trace for a specific iteration of a loop i=
n my application.
<br>
I created 2 trace points at the start and end of the loop which log the ite=
ration number.<br>
the loop itself creates thousands of trace points. It runs for ~5ms. <br>
&nbsp;<br>
on lttng side I created 2 triggers to start and stop my session in case the=
 loop tracepoint registers a specific iteration number.<br>
the triggers seem to work since there is another session entry created unde=
r the session folder but there are very few tracepoints.<br>
<br>
is it possible that the delay between the event happening and the session t=
race starting causes loss of events ?
<br>
If yes, is there a way around this&nbsp; ? <br>
<br>
here is my setup :<br>
<br>
#lttng-status<br>
Recording session session: [inactive]<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Trace output: /home/user/lttng-tr=
aces/session-20230523-113537<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">=3D=3D=3D Domain: User space =3D=3D=3D<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Buffering scheme: per-user<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Tracked process attributes<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; Virtual process IDs:&nbsp; all<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; Virtual user IDs:&nbsp;&nbsp;&nbsp;&nbsp; all=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; Virtual group IDs:&nbsp;&nbsp;&nbsp; all<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Channels:<o:p></o:p></p>
<p class=3D"MsoNormal">-------------<o:p></o:p></p>
<p class=3D"MsoNormal">- user-channel: [enabled]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Attributes:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Event-loss mode:&nbsp=
; discard<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sub-buffer size:&nbsp=
; 16777216 bytes<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sub-buffer count: 128=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Switch timer:&nbsp;&n=
bsp;&nbsp;&nbsp; inactive<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read timer:&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; inactive<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Monitor timer:&nbsp;&=
nbsp;&nbsp; 1000000 us<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Blocking timeout: 0 u=
s<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Trace file count: 1 p=
er stream<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Trace file size:&nbsp=
; unlimited<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Output mode:&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mmap<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Statistics:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Discarded events: 0<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; Recording event rules:<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_events* (type: =
tracepoint) [enabled]<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loop* (type: tracepoi=
nt) [enabled]<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
#lttng list-triggers<br>
<br>
- name: iter-start<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; owner uid: 1000<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; condition: event rule matches<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; rule: loop:iteration (type: user =
tracepoint, filter: iter=3D=3D2 &amp;&amp; start =3D=3D 1)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; errors: none<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; actions:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; start session `session`<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errors: none<o:p></o:=
p></p>
<p class=3D"MsoNormal">&nbsp; errors: none<o:p></o:p></p>
<p class=3D"MsoNormal">- name: iter-stop<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; owner uid: 1000<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; condition: event rule matches<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; rule: loop:iteration (type: user =
tracepoint, filter: iter=3D=3D2 &amp;&amp; start =3D=3D 0)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; errors: none<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; actions:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; stop session `session`<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errors: none<o:p></o:=
p></p>
<p class=3D"MsoNormal">&nbsp; errors: none<br>
<br>
<br>
Thanks <br>
<br>
Yehuda <o:p></o:p></p>
</div>
</body>
</html>

--_000_ef30ea91bb3c427e84c6677350bda6d7amazoncom_--

--===============7240065935221398766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7240065935221398766==--
