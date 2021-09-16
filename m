Return-Path: <SRS0=odM6=OG=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A0C433F5
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Sep 2021 13:08:16 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F2C6105A
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Sep 2021 13:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6F2C6105A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4H9HSs6Sg0z18pc;
	Thu, 16 Sep 2021 09:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1631797694;
	bh=+OeIyCI5aXCRDGTr4PQY/n65i4KaEwd9ZuGqGvwFhKo=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LtJvvn6xv4hsxqIYEkt+E5rqrowwkPpwj9OnKzR5gX01LD/Fj2+kZLvggzwtvsBJl
	 Lc5E3xkDKqq1HMTi+YecpddGXXJZE9Obrt6UKjdchmEZ4TwOSAxruU4iuPjq3tMW9F
	 CQso3u4W7bzBOrrlE809qlePSL0s+5lJLq8hkzq6cjgCy88hI3wJyPoymQFFcnQY6v
	 kWgLIMFCfmk+DTDoAJLMPIKgxVSeLDn9q8Z2RM1l3TIvqr7EV6MNfP8Q37qe7HiyLo
	 TI7riTfZUd8fAssDgQWvNLHoIIy1W/FoU83OXk9bq6lA4+vgH0aXsbNmPVnTYRUYFC
	 KqDJg3DHIRSdA==
Received: from mail-pj1-x1061.google.com (mail-pj1-x1061.google.com
 [IPv6:2607:f8b0:4864:20::1061])
 by lists.lttng.org (Postfix) with ESMTPS id 4H9Fy53cmkz18pX
 for <lttng-dev@lists.lttng.org>; Thu, 16 Sep 2021 07:59:57 -0400 (EDT)
Received: by mail-pj1-x1061.google.com with SMTP id j1so4372602pjv.3
 for <lttng-dev@lists.lttng.org>; Thu, 16 Sep 2021 04:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LSHEyy/3okfJzgqjMbhGL8VixTnE0+Tq9o9Du/yzjzE=;
 b=VPgghvFknz+UGE1PKK74T1ESqVZW3dimgEuAqgOPHSHCWc8gIFfDNtnNY2sz4aF27t
 sMJe9fbCNCf5momAlsdq6kAlZMccCOGGZv7TmplN3he7LndxGnBmCvLEYCgE+Xl39y/I
 5lhMf0YG7wSXxCTbR6O0Zhv9g7mA3pg9C9MHmsaHEaZNAA/Z+Y6tfHdOpUk86offeNQ5
 sOkUG1MsDyQKIriZ+ML5ZjvqUI1B6cjgooMxdw0XvxOLqu7GWe4JDXL7m/TmL7H1XsqY
 BvoPia6DzAMFrgbeaBjnmjDfm9uTkVrMGCe9NId1Tbp01JZyXvLcjBQUb4odYY/uGLyQ
 FmtA==
X-Gm-Message-State: AOAM532yu1p5QQoj5UA5QFArLJpdPnm6BzXc5ZbJXZnwbSHOU3clSh0p
 m+truxlOU/vsotA3MEOL02ruRBFk5DSD2Q+9nVEnXiPRC7GqRg==
X-Google-Smtp-Source: ABdhPJzgVz5Be6bGBTCSZWLzMMAOV66HEyIiIDZoapVs9J/PTFP5jlW8fRIiVkPahTyTUgK1Q7DRWN0LSJBM
X-Received: by 2002:a17:90a:1957:: with SMTP id
 23mr14579303pjh.141.1631793595952; 
 Thu, 16 Sep 2021 04:59:55 -0700 (PDT)
Received: from ams1-relay.sendergen.com (elk2-relay.sendergen.com.
 [108.163.197.50])
 by smtp-relay.gmail.com with ESMTPS id q32sm1969495pja.1.2021.09.16.04.59.55
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Sep 2021 04:59:55 -0700 (PDT)
X-Relaying-Domain: disguise.one
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by ams1-relay.sendergen.com (Postfix) with ESMTPS id 0A0FA226229D0
 for <lttng-dev@lists.lttng.org>; Thu, 16 Sep 2021 07:59:54 -0400 (EDT)
Received: by mail-ot1-f70.google.com with SMTP id
 a4-20020a056830008400b005194eddc1d4so21957815oto.23
 for <lttng-dev@lists.lttng.org>; Thu, 16 Sep 2021 04:59:53 -0700 (PDT)
X-Received: by 2002:a9d:7294:: with SMTP id t20mr4327590otj.275.1631793592703; 
 Thu, 16 Sep 2021 04:59:52 -0700 (PDT)
X-Received: by 2002:a9d:7294:: with SMTP id t20mr4327564otj.275.1631793592359; 
 Thu, 16 Sep 2021 04:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZxD0qL61Q2PmCd+10UHAngBcwH9KjSOL0JyFYNu-T19Q+3ZQ@mail.gmail.com>
 <2051744562.19686.1631721610084.JavaMail.zimbra@efficios.com>
In-Reply-To: <2051744562.19686.1631721610084.JavaMail.zimbra@efficios.com>
X-SG-Signature: true
Date: Thu, 16 Sep 2021 12:59:42 +0100
Message-ID: <CAMZxD0qb2R2s-LDvQyrYCU2j5CbQSFgXJ_c+8iPMVVu4Zp08jg@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
X-Scanned-By: 'EmailPostmaster' on 45.158.37.162
X-Mailman-Approved-At: Thu, 16 Sep 2021 09:08:11 -0400
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
From: Mayur Patel via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mayur Patel <mayur.patel@disguise.one>
Content-Type: multipart/mixed; boundary="===============8455440463438098081=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============8455440463438098081==
Content-Type: multipart/alternative; boundary="0000000000006b704105cc1b8d2d"

--0000000000006b704105cc1b8d2d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you for the information!

On Wed, 15 Sept 2021 at 17:00, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
> ----- On Sep 1, 2021, at 1:23 PM, lttng-dev <lttng-dev@lists.lttng.org>
> wrote:
>
> Hi there,
>
> I am currently evaluating the use of CTF and lttng tooling for application
> tracing on windows. We are exploring alternatives to ETW that are more
> customisable.
> One thing we would really like to do is real-time monitoring of our
> application from another machine. I have a few questions regarding this:
>
> 1. Is lttng live protocol suitable for this purpose? What kind of latency
> would we expect? (e.g 10s or 100s of milliseconds or more)
>
>
> The lttng live protocol has been designed for extracting a low-throughput
> of events to a live pretty-printer, with delays in the area of
> a few seconds. It's a polling-based mechanism at the moment.
>
> 2. Is the protocol documented?
>
>
> No. There is only an implementation with the lttng project and in
> babeltrace.
>
> 3. Is it possible to use lttng-relayd to read from local CTF log files
> (which are being written to) and stream events to other machines / a view=
er
> on the same machine? The reason I ask this is the documentation seems
> suggests lttng-relayd can consume CTF files
> https://lttng.org/docs/v2.13/#doc-lttng-relayd.
>
>
> lttng-relayd needs to control both writing to the CTF log files and
> reading from them. The "writing to"
> cannot be done by an external process.
>
> 4. I see there is a windows cygwin build on jenkins. Would you recommend
> this for production use?
>
>
> We do not recommend Cygwin builds for production use unless there are no
> alternatives. From my own
> past experience, the Cygwin layer is not a solid basis for
> production-quality software.
>
> Thanks for your interest,
>
> Mathieu
>
>
> Any guidance would be much appreciated.
>
> Thanks in advance,
>
> Mayur
>
> --
>
> <http://www.disguise.one>
>
> Mayur Patel
>
> Lead Software Engineer
>
> T : +44 20 7234 9840
>
> M : +44 7342 180127
>
> A : 88-89 Blackfriars Road, London, SE1 8HA
> <https://www.google.com/maps/place/88-89%20Blackfriars%20Road,%20London,%=
20SE1%208HA>
>
> <https://www.facebook.com/disguise.one/>
>
> <https://twitter.com/disguise_one>
>
> <https://www.youtube.com/channel/UCBXckvTm2VHU29BUoKJizvA>
>
> <https://www.instagram.com/disguise_one/>
>
> <https://www.linkedin.com/company/disguise-/>
>
> disguise Technologies Limited is a privately owned business registered in
> England and Wales (registered number 07937973), with its registered office
> located at 88-89 Blackfriars Road, London, SE1 8HA. This e-mail, and any
> attachments thereto, is intended only for use by the addressee(s) named
> herein and may contain legally privileged and/or confidential information.
> If you are not the intended recipient of this e-mail, you are hereby
> notified that any dissemination, distribution or copying of this e-mail,
> and any attachments thereto, is strictly prohibited. If you have received
> this e-mail in error, please notify me by replying to this message and
> permanently delete the original and any copy of this e-mail and any
> printout thereof. Although this e-mail and any attachments are believed to
> be free of any virus, or other defect which might affect any computer or
> system into which they are received and opened, it is the responsibility =
of
> the recipient to ensure that they are virus free and no responsibility is
> accepted by disguise for any loss or damage from receipt or use thereof.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>


Mayur Patel
Lead Software Engineer
+44 20 7234 9840
88-89 Blackfriars Road, London, SE1 8HA
=E2=80=8A=

--0000000000006b704105cc1b8d2d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thank=C2=A0you for the=C2=A0information!<=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, 15 Sept 2021 at 17:00, Mathieu Desnoyers &lt;<a href=3D"mailto:mathi=
eu.desnoyers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D=
"font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><d=
iv><br></div><div><span id=3D"gmail-m_-4441276656839478866zwchr">----- On S=
ep 1, 2021, at 1:23 PM, lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.ltt=
ng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a>&gt; wrote:<br></spa=
n></div><div><blockquote style=3D"border-left:2px solid rgb(16,16,255);marg=
in-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style=
:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-si=
ze:12pt"><div dir=3D"ltr">Hi there,<div><br><div>I am currently evaluating =
the use of CTF and lttng tooling for application tracing on windows. We are=
 exploring alternatives to ETW that are more customisable.</div><div>One th=
ing we would really like to do is real-time monitoring of our application f=
rom another machine. I have a few questions regarding this:</div><br><div>1=
. Is lttng live protocol suitable for this purpose? What kind of latency wo=
uld we expect? (e.g 10s or 100s of milliseconds or more)=C2=A0</div></div><=
/div></blockquote><div><br></div><div>The lttng live protocol has been desi=
gned for extracting a low-throughput of events to a live pretty-printer, wi=
th delays in the area of<br></div><div>a few seconds. It&#39;s a polling-ba=
sed mechanism at the moment.<br></div><div><br></div><blockquote style=3D"b=
order-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:=
rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;font-f=
amily:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><div=
>2. Is the protocol documented?=C2=A0</div></div></div></blockquote><div><b=
r></div><div>No. There is only an implementation with the lttng project and=
 in babeltrace.<br></div><div><br></div><blockquote style=3D"border-left:2p=
x solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div><div>3. Is it pos=
sible to use lttng-relayd to read from local CTF log files (which are being=
 written to) and stream events to other machines / a viewer on the same mac=
hine? The reason I ask this is the documentation seems suggests lttng-relay=
d can consume CTF files=C2=A0<a href=3D"https://lttng.org/docs/v2.13/#doc-l=
ttng-relayd" rel=3D"nofollow noopener noreferrer" target=3D"_blank">https:/=
/lttng.org/docs/v2.13/#doc-lttng-relayd</a>.</div></div></div></blockquote>=
<div><div><br></div></div><div>lttng-relayd needs to control both writing t=
o the CTF log files and reading from them. The &quot;writing to&quot;<br></=
div><div>cannot be done by an external process.<br></div><br><blockquote st=
yle=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5p=
x;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><=
div><div>4. I see there is a windows cygwin build on jenkins. Would you rec=
ommend this for production use?</div></div></div></blockquote><div><br></di=
v><div>We do not recommend Cygwin builds for production use unless there ar=
e no alternatives. From my own</div><div>past experience, the Cygwin layer =
is not a solid basis for production-quality software.<br></div><div><br></d=
iv><div>Thanks for your interest,<br></div><div><br></div><div>Mathieu<br><=
/div><div><br></div><blockquote style=3D"border-left:2px solid rgb(16,16,25=
5);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;fon=
t-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;=
font-size:12pt"><div dir=3D"ltr"><div><br><div>Any guidance would=C2=A0be m=
uch appreciated.</div><br><div>Thanks in advance,</div><br><div>Mayur</div>=
<div><br>-- <br><div dir=3D"ltr"><table style=3D"font-family:sans-serif;lin=
e-height:1.4;max-width:580px;color:rgb(54,54,54);border-collapse:collapse" =
cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td valign=3D"t=
op">
                <table style=3D"font-family:sans-serif;border-collapse:coll=
apse;color:rgb(51,51,51);width:300px;line-height:14px" width=3D"300" cellsp=
acing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td style=3D"padding:=
12px 0px 8px" valign=3D"top">
                                        <p style=3D"margin:0.75pt;line-heig=
ht:0px">
                                            <a href=3D"http://www.disguise.=
one" rel=3D"nofollow noopener noreferrer" target=3D"_blank"><img alt=3D"" s=
tyle=3D"border: 0px; display: block; border-radius: 0px;" src=3D"https://sm=
art.disguise.one/v2/imagebucket/disguise.one/disguise_logo_email.png" width=
=3D"135" height=3D"38"></a>
                                        </p>
                                    </td></tr><tr><td width=3D"300" valign=
=3D"top">
                            <table style=3D"font-family:sans-serif;border-c=
ollapse:collapse;color:rgb(51,51,51);width:300px;line-height:14px" width=3D=
"300" cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td valig=
n=3D"top">
                                        <p style=3D"margin:0.75pt;color:rgb=
(0,0,0);font-weight:700;font-size:12px;font-family:arial,sans-serif"> Mayur=
 Patel </p>
                                    </td></tr><tr><td style=3D"padding-bott=
om:4px" valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:arial,sans-serif">
                                            Lead Software Engineer
                                        </p>
                                    </td></tr><tr><td valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:arial,sans-serif">
                                             <span style=3D"font-weight:700=
;color:rgb(80,80,80)">T :</span>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                                <a style=3D"text-decoration=
:none;color:rgb(51,51,51)">+44 20 7234 9840</a>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                        </p>
                                    </td></tr><tr><td valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:arial,sans-serif">
                                          <span style=3D"font-weight:700;co=
lor:rgb(80,80,80)">M :</span>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                                <a style=3D"text-decoration=
:none;color:rgb(51,51,51)">+44 7342 180127</a>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                        </p>
                                    </td></tr><tr><td valign=3D"top">
                                    <p style=3D"margin:0.75pt;font-size:12p=
x;font-family:arial,sans-serif">
                                        <span style=3D"font-weight:700;colo=
r:rgb(80,80,80)">A :</span>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                            <a href=3D"https://www.google.c=
om/maps/place/88-89%20Blackfriars%20Road,%20London,%20SE1%208HA" style=3D"t=
ext-decoration:none;color:rgb(51,51,51)" rel=3D"nofollow noopener noreferre=
r" target=3D"_blank">88-89 Blackfriars Road, London, SE1 8HA</a>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                    </p>
                                </td></tr><tr><td style=3D"padding:7px 0px =
2px" valign=3D"top">
                                    <table style=3D"font-family:sans-serif;=
border-collapse:collapse;color:rgb(51,51,51);width:auto;line-height:13px" c=
ellspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td style=3D"pad=
ding-right:4px" width=3D"16" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
facebook.com/disguise.one/" style=3D"text-decoration:none" rel=3D"nofollow =
noopener noreferrer" target=3D"_blank"><img style=3D"border: 0px;" src=3D"h=
ttps://smart.disguise.one/v2/imagebucket/disguise.one/facebook.png" width=
=3D"14" height=3D"22"></a>
                                                </p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://twit=
ter.com/disguise_one" style=3D"text-decoration:none" rel=3D"nofollow noopen=
er noreferrer" target=3D"_blank"><img style=3D"border: 0px;" src=3D"https:/=
/smart.disguise.one/v2/imagebucket/disguise.one/twitter.png" width=3D"22" h=
eight=3D"22"></a><br></p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
youtube.com/channel/UCBXckvTm2VHU29BUoKJizvA" style=3D"text-decoration:none=
" rel=3D"nofollow noopener noreferrer" target=3D"_blank"><img style=3D"bord=
er: 0px;" src=3D"https://smart.disguise.one/v2/imagebucket/disguise.one/you=
tube.png" width=3D"width" height=3D"22"></a>
                                                </p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
instagram.com/disguise_one/" style=3D"text-decoration:none" rel=3D"nofollow=
 noopener noreferrer" target=3D"_blank"><img style=3D"border: 0px;" src=3D"=
https://smart.disguise.one/v2/imagebucket/disguise.one/instagram.png" width=
=3D"22" height=3D"22"></a>
                                                </p>
                                            </td><td style=3D"padding-right=
:7px" width=3D"24" valign=3D"top">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
linkedin.com/company/disguise-/" style=3D"text-decoration:none" rel=3D"nofo=
llow noopener noreferrer" target=3D"_blank"><img style=3D"border: 0px;" src=
=3D"https://smart.disguise.one/v2/imagebucket/disguise.one/linked-in.png" w=
idth=3D"22" height=3D"22"></a>
                                                </p>
                                            </td></tr></tbody></table>
                                </td></tr></tbody></table>
                        </td></tr></tbody></table>
            </td></tr></tbody></table>
<br>
<p style=3D"margin:0.75pt;font-size:8px;font-family:arial,sans-serif;color:=
rgb(231,232,230)">disguise Technologies Limited is a privately owned busine=
ss registered in England and Wales (registered number 07937973), with its r=
egistered office located at 88-89 Blackfriars Road, London, SE1 8HA. This e=
-mail, and any attachments thereto, is intended only for use by the address=
ee(s) named herein and may contain legally privileged and/or confidential i=
nformation. If you are not the intended recipient of this e-mail, you are h=
ereby notified that any dissemination, distribution or copying of this e-ma=
il, and any attachments thereto, is strictly prohibited. If you have receiv=
ed this e-mail in error, please notify me by replying to this message and p=
ermanently delete the original and any copy of this e-mail and any printout=
 thereof. Although this e-mail and any attachments are believed to be free =
of any virus, or other defect which might affect any computer or system int=
o which they are received and opened, it is the responsibility of the recip=
ient to ensure that they are virus free and no responsibility is accepted b=
y disguise for any loss or damage from receipt or use thereof.</p></div></d=
iv></div></div>
=E2=80=8A<br>_______________________________________________<br>lttng-dev m=
ailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blan=
k">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-=
bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev</a><br></blockquote></div><div><br></div>=
<div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"htt=
p://www.efficios.com" target=3D"_blank">http://www.efficios.com</a></div></=
div></div></blockquote></div><br clear=3D"all"><div><br></div>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature"><table cellpadding=3D"0" cellspacing=
=3D"0" border=3D"0" style=3D"font-family:sans-serif;line-height:1.4;box-siz=
ing:initial;max-width:580px;color:#363636;border-collapse:collapse">
        <tr>
            <td valign=3D"top">
                <table width=3D"300" cellpadding=3D"0" cellspacing=3D"0" bo=
rder=3D"0" style=3D"font-family:sans-serif;border-collapse:collapse;color:#=
333;width:300px;line-height:14px">
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                            <tr>
                                    <td valign=3D"top" style=3D"padding:12p=
x 0 8px 0">
                                        <p style=3D"margin:0.75pt;line-heig=
ht:0px">
                                            <a href=3D"http://www.disguise.=
one">
                                                <img width=3D"135" height=
=3D"38" src=3D"https://smart.disguise.one/v2/imagebucket/disguise.one/disgu=
ise_logo_email.png=20
" alt=3D" " style=3D"border:0;display:block;border-radius:0px" />
                                            </a>
                                        </p>
                                    </td>
                                </tr>
<tr>
                        <td valign=3D"top" width=3D"300">
                            <table width=3D"300" cellpadding=3D"0" cellspac=
ing=3D"0" border=3D"0" style=3D"font-family:sans-serif;border-collapse:coll=
apse;color:#333;width:300px;line-height:14px">
                                <tr>
                                    <td valign=3D"top">
                                        <p style=3D"margin:0.75pt;color:#00=
0;font-weight:700;font-size:12px;font-family:Arial, sans-serif"> Mayur Pate=
l </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign=3D"top" style=3D"padding-bot=
tom:4px">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:Arial, sans-serif">
                                            <span>Lead Software Engineer</s=
pan>
                                        </p>
                                    </td>
                                </tr>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
                                <tr>
                                    <td valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:Arial, sans-serif">
                                             <span style=3D"font-weight:700=
;color:#505050">T :</span>
                                            <span>
                                                <a href=3D"tel:+44 20 7234 =
9840" style=3D"text-decoration:none;color:#333">+44 20 7234 9840</a>
                                            </span>
                                        </p>
                                    </td>
                                </tr>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
                                <tr>
                                    <td valign=3D"top">
                                        <p style=3D"margin:0.75pt;font-size=
:12px;font-family:Arial, sans-serif">
                                          <span style=3D"font-weight:700;co=
lor:#505050">M :</span>
                                            <span>
                                                <a href=3D"tel:+44 7342 180=
127" style=3D"text-decoration:none;color:#333">+44 7342 180127</a>
                                            </span>
                                        </p>
                                    </td>
                                </tr>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
=20=20=20=20=20=20=20=20=20
                            <tr>
                                <td valign=3D"top">
                                    <p style=3D"margin:0.75pt;font-size:12p=
x;font-family:Arial, sans-serif">
                                        <span style=3D"font-weight:700;colo=
r:#505050">A :</span>
                                        <span>
                                            <a href=3D"https://www.google.c=
om/maps/place/88-89 Blackfriars Road, London, SE1 8HA" style=3D"text-decora=
tion:none;color:#333">88-89 Blackfriars Road, London, SE1 8HA</a>
                                        </span>
                                    </p>
                                </td>
                            </tr>
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
                                <tr>
                                    <td valign=3D"top" style=3D"padding:7px=
 0 2px">
                                    <table cellpadding=3D"0" cellspacing=3D=
"0" border=3D"0" style=3D"font-family:sans-serif;border-collapse:collapse;c=
olor:#333;width:auto;line-height:13px">
                                        <tr>
                                            <td valign=3D"top" width=3D"16"=
 style=3D"padding-right:4px">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
facebook.com/disguise.one/" style=3D"text-decoration:none"><img width=3D"14=
" height=3D"22" src=3D"https://smart.disguise.one/v2/imagebucket/disguise.o=
ne/facebook.png" style=3D"border:0" /></a>
                                                </p>
                                            </td>
                                            <td valign=3D"top" width=3D"24"=
 style=3D"padding-right:7px">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://twit=
ter.com/disguise_one" style=3D"text-decoration:none"><img width=3D"22" heig=
ht=3D"22" src=3D"https://smart.disguise.one/v2/imagebucket/disguise.one/twi=
tter.png" style=3D"border:0" />
                                                    </a></p>
                                            </td>
                                            <td valign=3D"top" width=3D"24"=
 style=3D"padding-right:7px">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
youtube.com/channel/UCBXckvTm2VHU29BUoKJizvA" style=3D"text-decoration:none=
"><img width height=3D"22" src=3D"https://smart.disguise.one/v2/imagebucket=
/disguise.one/youtube.png" style=3D"border:0" /></a>
                                                </p>
                                            </td>
                                            <td valign=3D"top" width=3D"24"=
 style=3D"padding-right:7px">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
instagram.com/disguise_one/" style=3D"text-decoration:none"><img width=3D"2=
2" height=3D"22" src=3D"https://smart.disguise.one/v2/imagebucket/disguise.=
one/instagram.png" style=3D"border:0" /></a>
                                                </p>
                                            </td>
                                            <td valign=3D"top" width=3D"24"=
 style=3D"padding-right:7px">
                                                <p style=3D"margin:0.75pt">
                                                    <a href=3D"https://www.=
linkedin.com/company/disguise-/" style=3D"text-decoration:none"><img width=
=3D"22" height=3D"22" src=3D"https://smart.disguise.one/v2/imagebucket/disg=
uise.one/linked-in.png" style=3D"border:0" /></a>
                                                </p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table></div></div>

--0000000000006b704105cc1b8d2d--

--===============8455440463438098081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8455440463438098081==--
