Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2907E63FE6
	for <lttng-dev@archiver.kernel.org>; Sun,  5 Apr 2026 00:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fpDK46lPMz1LTj
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1775349947;
	b=gEq0aHkpgLMK3J1XwSa6jRIR7iJ6hGh6Goh2XC0EB0nZnWRF7qRwNozIg7cTdmnpnb1G
	 EaGzL7gY1dtslOyF9jqmVt/SeX4BaFPu6ZaqRfIYKvKWj2foDtqPTSwG4JU8tlPmZBjCM
	 iDHL1XA4E4GbtU2vJ1dmDf00H+GfdkF1SSYo9xjKrAxpz4Yu+kd0KKobC6CxNs3VMW4Re
	 Ppq5HG2i2HayOi7wNXnjJW3ceJBohaDPul0suLsrCdCWXI8AKOfrCSVvpe+cnOsH+wql+
	 ewfMrZ0XQlwEZSdPBHoQQveAKSM3mJp/YmROdS4MQ6QnDzqG1UFWGDeSX5cAKrCAnSQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1775349947;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=rMtvQgDtVQ7Znhkc2IoNjBrzyhNVXWxiyM46qRhqFcY=;
	b=TPFv1GGxdyW0+L5ANm3afQxqzELc3Q5WSl5cOQ6HR0+YmpgnM5de4vFDp0iM7B02aAIw
	 T5nwMv32LZor4sBXeihxExphDbY9zGvPruMR7k75ifG4uBIAEkIC5uLHTxUc7JWYvMZB7
	 zqeICE1G1csRS9foMs1s/avDMyDbd8kTHywQw/wQ8f+0XWyr12j6vLtxj6ZOb43kJGHjB
	 /6thZf9xi++/QCA8trKKfpZEfi2KT1rGL6wK9v00fKFgLE+6kxX5j1n29LYuxl47dBlvE
	 vHqJ5WbOSG1AQ7O5/kjxhuNQjxi/4sHvVQ83Z9bnZHHJW/FXrhqah7Z+QcZ3Ssp6lpA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fpDK46lPMz1LTj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1775349947;
	bh=rMtvQgDtVQ7Znhkc2IoNjBrzyhNVXWxiyM46qRhqFcY=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TmV+2dDjYWW3A41d4iE0lKXosc6bwFdUDCaqvOoiKH32gUn+qrTmQ35TnfcPpFSm0
	 KhqfhVaN5TkVh0jKtx17XLEDn6/ioCnijX2pYPtz1gG44EoqQhXjZBsFMJqWgq1igd
	 u6gc39+xGlvvkr1uc3tQVeVNTkUqrnjJY6yu9azdLbozumtbFO+Xy7M0z9sVyB9ZLM
	 sWFsgnXgGHgNXPB+w4I62TS+6cGvDUUzZWvmqtsNeZsCK8irxtfF29/3OHRjV0xm62
	 4X40ArbFVzCzmBGSdTOtnPfUzSbnr3Q1EC90o+JgECH/XRU7S3/ZmAQr5LDORGbX7I
	 8IvFft+beRLeA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fpDK46lPMz1LTj;
	Sat,  4 Apr 2026 20:45:44 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fpDK24j1Zz1LTh
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fpDK24j1Zz1LTh
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by lists.lttng.org (Postfix) with ESMTPS id 4fpDK24j1Zz1LTh
 for <lttng-dev@lists.lttng.org>; Sat,  4 Apr 2026 20:45:42 -0400 (EDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DBB687A017A
 for <lttng-dev@lists.lttng.org>; Sat,  4 Apr 2026 20:45:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
 by phl-compute-05.internal (MEProxy); Sat, 04 Apr 2026 20:45:39 -0400
X-ME-Sender: <xms:s7DRabZCAvFHm_-htxvsSpFGcg9dtDCtZ8t81cUn4moVomgjkI9hPQ>
 <xme:s7DRaRUATqCFPsECkLafK2W2-EHzIgExhMpL6ruHFo57TSq2y2BUr9i-uqh7rqZU6
 QDo_bvP6Gf6RmMvw0elKXWtygXgLqlwL93M5rIv5feEGqWdQ6XEow>
X-ME-Received: <xmr:s7DRaTlSxxqkTFgzuoTB3SgpNVOhOFDSSzM2lEE1Mv13oCvmaO-elQ4wujm6qdEAHdQMVjIfKcFB85pnGoG_MMaWZ1LYmbn66iKQd70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeefvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeggfhgjhfffkffuvfevtgesrgdtreertddtjeenucfhrhhomheplfhonhgrhhcuifhr
 rghhrghmuceojhhonhgrhheskhhitghhfigrtghouggvrhhsrdgtohhmqeenucggtffrrg
 htthgvrhhnpeegvdekteegveekhfekudduleeftdegffefvdeigfdtkeekleetffetveet
 geehfeenucffohhmrghinhepghhoohhglhgvrdgtohhmpdhgihhthhhusgdrtghomhdpvg
 gtlhhiphhsvgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
 ihhlfhhrohhmpehjohhnrghhsehkihgthhifrggtohguvghrshdrtghomhdpnhgspghrtg
 hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhtthhnghdquggv
 vheslhhishhtshdrlhhtthhnghdrohhrgh
X-ME-Proxy: <xmx:s7DRaWy5vh2EpJjtPY3NPUnwdoFwfZ5-o6YT41pl--WhhM-FAa4C8g>
 <xmx:s7DRaWjwgD1A4B_ItEDdDzZz3YRYDmYhY4GXuttnWVmZufFBaEsTVQ>
 <xmx:s7DRaTW5bpk-BXxyhIJDzvJs2y7MVW2l9IgVpyc-1s3i7k5PVwkqrg>
 <xmx:s7DRaQ2DZZBURht80LV77A0C7OMRbKDF4FwPmGxTX7R4ieHlTKFeyQ>
 <xmx:s7DRafa3_IrsCQVARSYzbmPWKc80HxYGwDKGiqgk1AZFuY1FIgsekSce>
Feedback-ID: i35d941ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <lttng-dev@lists.lttng.org>; Sat, 4 Apr 2026 20:45:39 -0400 (EDT)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7a299d84b7dso20895517b3.0
 for <lttng-dev@lists.lttng.org>; Sat, 04 Apr 2026 17:45:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVKEVro9eBcrZJE9/pphZDIDEhkTxurLuBePWNIVNK+TlxpTvasJSp2Ss6WPLkXHw8EUxqWdC9E+Yg=@lists.lttng.org
X-Gm-Message-State: AOJu0Yzq3c77/1gKJYdufE8hSF7uBuxYCIMxZD9tbMC3kAeKiVUzk2kY
 g1WHiKBvhoyI0wWJfCDo47k/fvkieLIao8MaJIwbXakQzJ/LfMnzrz55KW/po5SolmaiV+ai6dX
 FnWaJC5s6wTf/xT5N0rzHlyKAzzFYQoY=
X-Received: by 2002:a05:690c:620b:b0:7a2:8cdb:b597 with SMTP id
 00721157ae682-7a4d3cd1461mr81751067b3.23.1775349939018; Sat, 04 Apr 2026
 17:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <DS4PPFB691D9211B0432FC71D96571491B79E93A@DS4PPFB691D9211.namprd15.prod.outlook.com>
In-Reply-To: <DS4PPFB691D9211B0432FC71D96571491B79E93A@DS4PPFB691D9211.namprd15.prod.outlook.com>
Date: Sat, 4 Apr 2026 20:45:27 -0400
X-Gmail-Original-Message-ID: <CAPmGMviyX-8Vcz-CDSRc7uw3_ssPd3ce6AGh2-J2q8fwcGcJOw@mail.gmail.com>
X-Gm-Features: AQROBzD5aztGZv5DbR1HjNHgKB7rSOiP5jg4dKg3dLVt7yLZCshTPnJ6UFUZNn0
Message-ID: <CAPmGMviyX-8Vcz-CDSRc7uw3_ssPd3ce6AGh2-J2q8fwcGcJOw@mail.gmail.com>
Subject: Re: [tracecompass-dev] Invitation: Trace Compass Monthly Project
 Meetings
To: tracecompass developer discussions <tracecompass-dev@eclipse.org>
Content-Type: multipart/alternative; boundary="000000000000779ed2064eabde8a"
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
From: Jonah Graham via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jonah Graham <jonah@kichwacoders.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>,
 CDT Cloud development <cdt-cloud-dev@eclipse.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000779ed2064eabde8a
Content-Type: text/plain; charset="UTF-8"

Hi folks,

Our next Trace compass community project call is this Wednesday. Everyone
is invited.

See you there.

Jonah



On Mon, Jan 26, 2026, 11:42 Matthew Khouzam via tracecompass-dev <
tracecompass-dev@eclipse.org> wrote:

> Hello everyone,
> The Trace Compass project holds monthly online meetings to discuss the
> current state of the project, ongoing development work, and upcoming plans.
> These meetings are primarily intended for committers and contributors, but
> anyone interested in Trace Compass development is welcome to attend.
> Schedule:
> The meetings take place every second Wednesday of the month at 10:00 AM
> Eastern Time.
> Location:
> The meetings are held online using Google Meet.
> https://meet.google.com/rsq-gzem-tkv
> Calendar:
> All meetings are published in a shared Google Calendar.
> View the calendar:
> https://calendar.google.com/calendar/u/0?cid=dHJhY2Vjb21wYXNzQGdtYWlsLmNvbQ
> Subscribe via iCal:
>
> https://calendar.google.com/calendar/ical/dHJhY2Vjb21wYXNzQGdtYWlsLmNvbQ/public/basic.ics
> Subscribing to the calendar is the best way to stay informed about
> upcoming meetings and any schedule changes.
> Agendas and minutes:
> Agendas and minutes are maintained on the Trace Compass GitHub Wiki (
> https://github.com/eclipse-tracecompass/org.eclipse.tracecompass/wiki/Project_Meetings)
> . Participants are encouraged to propose agenda items ahead of time by
> editing the relevant meeting page.
> We look forward to seeing you at an upcoming meeting.
> Best regards,
> The Trace Compass Project
>
> _______________________________________________
> tracecompass-dev mailing list
> tracecompass-dev@eclipse.org
> To unsubscribe from this list, visit
> https://www.eclipse.org/mailman/listinfo/tracecompass-dev
>

--000000000000779ed2064eabde8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi folks,<div dir=3D"auto"><br></div><div dir=3D"auto">Ou=
r next Trace compass community project call is this Wednesday. Everyone is =
invited.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">See you t=
here.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Jonah=C2=A0<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Mon, Jan 26, 2026, 11:42 Matthew Khouzam via tracecompass-dev &l=
t;<a href=3D"mailto:tracecompass-dev@eclipse.org">tracecompass-dev@eclipse.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">




<div dir=3D"ltr">
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Hello everyone,</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
The Trace Compass project holds monthly online meetings to discuss the curr=
ent state of the project, ongoing development work, and upcoming plans.</di=
v>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
These meetings are primarily intended for committers and contributors, but =
anyone interested in Trace Compass development is welcome to attend.</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Schedule:<br>
The meetings take place every second Wednesday of the month at 10:00 AM Eas=
tern Time.</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Location:<br>
The meetings are held online using Google Meet.<br>
<a id=3D"m_8688701062479106584OWAe86685ac-2ffd-a267-5580-1df07c75bfd4" href=
=3D"https://meet.google.com/rsq-gzem-tkv" target=3D"_blank" rel=3D"noreferr=
er">https://meet.google.com/rsq-gzem-tkv</a></div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Calendar:<br>
All meetings are published in a shared Google Calendar.</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
View the calendar:<br>
<a id=3D"m_8688701062479106584OWA86c67b98-944b-2fd3-e0ed-49cf3e58b1d2" href=
=3D"https://calendar.google.com/calendar/u/0?cid=3DdHJhY2Vjb21wYXNzQGdtYWls=
LmNvbQ" target=3D"_blank" rel=3D"noreferrer">https://calendar.google.com/ca=
lendar/u/0?cid=3DdHJhY2Vjb21wYXNzQGdtYWlsLmNvbQ</a></div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Subscribe via iCal:<br>
<a id=3D"m_8688701062479106584OWA2c3614b0-82a3-727c-0032-d9dfcd66c3e2" href=
=3D"https://calendar.google.com/calendar/ical/dHJhY2Vjb21wYXNzQGdtYWlsLmNvb=
Q/public/basic.ics" target=3D"_blank" rel=3D"noreferrer">https://calendar.g=
oogle.com/calendar/ical/dHJhY2Vjb21wYXNzQGdtYWlsLmNvbQ/public/basic.ics</a>=
</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Subscribing to the calendar is the best way to stay informed about upcoming=
 meetings and any schedule changes.</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Agendas and minutes:<br>
Agendas and minutes are maintained on the Trace Compass GitHub Wiki (<a hre=
f=3D"https://github.com/eclipse-tracecompass/org.eclipse.tracecompass/wiki/=
Project_Meetings" target=3D"_blank" rel=3D"noreferrer">https://github.com/e=
clipse-tracecompass/org.eclipse.tracecompass/wiki/Project_Meetings</a>)
 . Participants are encouraged to propose agenda items ahead of time by edi=
ting the relevant meeting page.</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
We look forward to seeing you at an upcoming meeting.</div>
<div style=3D"margin-top:1em;margin-bottom:1em;font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif;font-size:12pt;co=
lor:rgb(0,0,0)">
Best regards,<br>
The Trace Compass Project</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
</div>

_______________________________________________<br>
tracecompass-dev mailing list<br>
<a href=3D"mailto:tracecompass-dev@eclipse.org" target=3D"_blank" rel=3D"no=
referrer">tracecompass-dev@eclipse.org</a><br>
To unsubscribe from this list, visit <a href=3D"https://www.eclipse.org/mai=
lman/listinfo/tracecompass-dev" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">https://www.eclipse.org/mailman/listinfo/tracecompass-dev</a><br>
</blockquote></div>

--000000000000779ed2064eabde8a--
