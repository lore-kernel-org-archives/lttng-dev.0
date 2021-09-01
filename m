Return-Path: <SRS0=5x+2=NX=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F7DC432BE
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Sep 2021 18:25:32 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2270961053
	for <lttng-dev@archiver.kernel.org>; Wed,  1 Sep 2021 18:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2270961053
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4H0CCs4QqGz14K9;
	Wed,  1 Sep 2021 14:25:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1630520730;
	bh=BOXyeNOl/ZMf8xA2+Ka77RFxRxB5enSn2WcAc3V5Duw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Iq49Aa9cOnTzqegJQ6rTtd48DolHbv91A3yT6jxK5Ntkq8DnRckhQbcRiqMfdB7NK
	 tsWfmGCRYbrePKyC/HtlqTAwrq6FUOPYw3tUkJRY3dl1b5p5CHkytOJE9nYK+S53al
	 vULqiggVnk5SUMsFPp6mbGKy6e+hZYdcmy5c0axe5jJENiaJnGSJG5q5cWEeHTXcFh
	 +9J1IV5YGWoR5j5HDxWo2OkAPREg0DCsKPYMxxtDLiUvhu4NLfkTHHt4z21UItlDK+
	 bWVIdFM7kEEsOr8++nEy77WD2uUMtjxvj9rW4+ZJiK1fKMBhg4xOJ0glfdW1o/bOGR
	 9n/KBeVucBTNA==
Received: from mail-ot1-x361.google.com (mail-ot1-x361.google.com
 [IPv6:2607:f8b0:4864:20::361])
 by lists.lttng.org (Postfix) with ESMTPS id 4H09rq5Br6z13yh
 for <lttng-dev@lists.lttng.org>; Wed,  1 Sep 2021 13:23:55 -0400 (EDT)
Received: by mail-ot1-x361.google.com with SMTP id
 i3-20020a056830210300b0051af5666070so617558otc.4
 for <lttng-dev@lists.lttng.org>; Wed, 01 Sep 2021 10:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=1LgNMm7tYrEE51NoRmdU8CJuW+y3iCuA7sYukiPiwUo=;
 b=XakJNAHj/m6VZmT79LSCsZEnnYwjCIriTll4vvPegWqK81VbQYj20eauiPYg+HgQ29
 xiF0kadTL+wL3zs+OEPxKagvz45j1J4hObqD5b7Pr9r/xWRP6Vc2r/4TE6ySgbnUfIkO
 NLwf8dJn/y7OUKPYMjv40HM+zp2BlMzEPxn+3zjnUISJ4372brHpSLF5zXrSnTZGOmHM
 ssFIRBv7TDjGB+fYclXQ5jY+D/naxlZ9nE65UBnCIE4z3IN2ox5rEAZA/8VZehYPeIGt
 QOfRlu8y7iBi2uXWXdBgBjOPyKf+MkzHtSf0A3xw5y/xBU0XPLIIrKsX3QsI9Z5jU+QO
 Srhg==
X-Gm-Message-State: AOAM530f2TtrFluYpRK80fckHssTh57hGLPZP6lvi6TPkJFG5d8EKUQq
 p7jA2lGbJln5m7t4zz65DDw8y6ULdo0jekyKJAJj2x6l3rSyzg==
X-Google-Smtp-Source: ABdhPJz3lsY6z5u0du+KyGUzWI+LivtNK0l5W9oohEdVzl1QwOpFGtODOQJWGkpydHaKyBlfEmhqzlZmgzje
X-Received: by 2002:a05:6830:1647:: with SMTP id
 h7mr430932otr.123.1630517034589; 
 Wed, 01 Sep 2021 10:23:54 -0700 (PDT)
Received: from ams1-relay.sendergen.com (chi2-relay.sendergen.com.
 [67.212.168.66])
 by smtp-relay.gmail.com with ESMTPS id w24sm92478oop.14.2021.09.01.10.23.54
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Sep 2021 10:23:54 -0700 (PDT)
X-Relaying-Domain: disguise.one
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by ams1-relay.sendergen.com (Postfix) with ESMTPS id B398C22F27AB5
 for <lttng-dev@lists.lttng.org>; Wed,  1 Sep 2021 13:23:46 -0400 (EDT)
Received: by mail-oo1-f70.google.com with SMTP id
 s20-20020a4aead40000b029028b41986b27so132442ooh.14
 for <lttng-dev@lists.lttng.org>; Wed, 01 Sep 2021 10:23:46 -0700 (PDT)
X-Received: by 2002:a9d:2208:: with SMTP id o8mr462762ota.78.1630517025385;
 Wed, 01 Sep 2021 10:23:45 -0700 (PDT)
X-Received: by 2002:a9d:2208:: with SMTP id o8mr462733ota.78.1630517024976;
 Wed, 01 Sep 2021 10:23:44 -0700 (PDT)
MIME-Version: 1.0
X-SG-Signature: true
Date: Wed, 1 Sep 2021 18:23:33 +0100
Message-ID: <CAMZxD0qL61Q2PmCd+10UHAngBcwH9KjSOL0JyFYNu-T19Q+3ZQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Scanned-By: 'EmailPostmaster' on 45.158.37.162
X-Mailman-Approved-At: Wed, 01 Sep 2021 14:25:28 -0400
Subject: [lttng-dev] Lttng live protocol
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
Content-Type: multipart/mixed; boundary="===============6640885296453520237=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6640885296453520237==
Content-Type: multipart/alternative; boundary="000000000000130a3605caf254cc"

--000000000000130a3605caf254cc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi there,

I am currently evaluating the use of CTF and lttng tooling for application
tracing on windows. We are exploring alternatives to ETW that are more
customisable.
One thing we would really like to do is real-time monitoring of our
application from another machine. I have a few questions regarding this:

1. Is lttng live protocol suitable for this purpose? What kind of latency
would we expect? (e.g 10s or 100s of milliseconds or more)
2. Is the protocol documented?
3. Is it possible to use lttng-relayd to read from local CTF log files
(which are being written to) and stream events to other machines / a viewer
on the same machine? The reason I ask this is the documentation seems
suggests lttng-relayd can consume CTF files
https://lttng.org/docs/v2.13/#doc-lttng-relayd.
4. I see there is a windows cygwin build on jenkins. Would you recommend
this for production use?

Any guidance would be much appreciated.

Thanks in advance,

Mayur

Mayur Patel
Lead Software Engineer
+44 20 7234 9840
88-89 Blackfriars Road, London, SE1 8HA
=E2=80=8A=

--000000000000130a3605caf254cc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi there,<div><br><div>I am currently evaluating the use o=
f CTF and lttng tooling for application tracing on windows. We are explorin=
g alternatives to ETW that are more customisable.</div><div>One thing we wo=
uld really like to do is real-time monitoring of our application from anoth=
er machine. I have a few questions regarding this:</div><div><br></div><div=
>1. Is lttng live protocol suitable for this purpose? What kind of latency =
would we expect? (e.g 10s or 100s of milliseconds or more)=C2=A0</div><div>=
2. Is the protocol documented?=C2=A0</div><div>3. Is it possible to use ltt=
ng-relayd to read from local CTF log files (which are being written to) and=
 stream events to other machines / a viewer on the same machine? The reason=
 I ask this is the documentation seems suggests lttng-relayd can consume CT=
F files=C2=A0<a href=3D"https://lttng.org/docs/v2.13/#doc-lttng-relayd">htt=
ps://lttng.org/docs/v2.13/#doc-lttng-relayd</a>.</div><div>4. I see there i=
s a windows cygwin build on jenkins. Would you recommend this for productio=
n use?</div><div><br></div><div>Any guidance would=C2=A0be much appreciated=
.</div><div><br></div><div>Thanks in advance,</div><div><br></div><div>Mayu=
r</div><div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature"><table cellpadding=3D"0" cellspacing=
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
    </table>
<br />
<p style=3D"margin:0.75pt;font-size:8px;font-family:Arial, sans-serif;color=
:#e7e8e6">disguise Technologies Limited is a privately owned business regis=
tered in England and Wales (registered number 07937973), with its registere=
d office located at 88-89 Blackfriars Road, London, SE1 8HA. This e-mail, a=
nd any attachments thereto, is intended only for use by the addressee(s) na=
med herein and may contain legally privileged and/or confidential informati=
on. If you are not the intended recipient of this e-mail, you are hereby no=
tified that any dissemination, distribution or copying of this e-mail, and =
any attachments thereto, is strictly prohibited. If you have received this =
e-mail in error, please notify me by replying to this message and permanent=
ly delete the original and any copy of this e-mail and any printout thereof=
. Although this e-mail and any attachments are believed to be free of any v=
irus, or other defect which might affect any computer or system into which =
they are received and opened, it is the responsibility of the recipient to =
ensure that they are virus free and no responsibility is accepted by disgui=
se for any loss or damage from receipt or use thereof.</p></div></div></div=
></div>
=E2=80=8A=

--000000000000130a3605caf254cc--

--===============6640885296453520237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6640885296453520237==--
