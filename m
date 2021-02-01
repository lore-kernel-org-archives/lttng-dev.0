Return-Path: <SRS0=7ik+=HD=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7B0C433DB
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Feb 2021 09:39:43 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373FF64EAE
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Feb 2021 09:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373FF64EAE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DTjb0328Vz16N7;
	Mon,  1 Feb 2021 04:39:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1612172380;
	bh=JXnn/hwCE3at1f0NrnLCbmW7rg7pvMAZ/o7ZIwHN0zo=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=v/Wn7+kt5zC6KJy0BrogaUSbYFFeEGuX2a1HRfbgSxbSPE0zeHOg+TuTADLo+KfaS
	 lgliY4jHr+omACVN50MI718E+5wdfIZqh/118fM1L+syBbzWjxch++WLklckVFNbQE
	 yH8hzwc0aDSswuJEeZDGs2CY7qSXRjA9kfTnB65TuH9rdL42bccjs8erpHymfOxl0m
	 ICEQ5VXV4u5w1Meo2YscMWseDXSn2MBvsnDvfVn4aqhSnyLoQAkFhSciElUTa5BpGw
	 eGAOj4cfPVwur1A98Pbj76e2M0M1NZNHqpTNuC29CvtcI3oIPxmcpJN0a4DaJRHwrW
	 LB0236ULMlKaw==
Received: from sainfoin-smtp-out.extra.cea.fr (sainfoin-smtp-out.extra.cea.fr
 [132.167.192.228])
 by lists.lttng.org (Postfix) with ESMTPS id 4DTjZx6y4gz16Qr
 for <lttng-dev@lists.lttng.org>; Mon,  1 Feb 2021 04:39:37 -0500 (EST)
Received: from pisaure.intra.cea.fr (pisaure.intra.cea.fr [132.166.88.21])
 by sainfoin-sys.extra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with
 ESMTP id 1119COLJ034872
 for <lttng-dev@lists.lttng.org>; Mon, 1 Feb 2021 10:12:24 +0100
Received: from pisaure.intra.cea.fr (localhost [127.0.0.1])
 by localhost (Postfix) with SMTP id DFEA4203377
 for <lttng-dev@lists.lttng.org>; Mon,  1 Feb 2021 10:12:24 +0100 (CET)
Received: from muguet1-smtp-out.intra.cea.fr (muguet1-smtp-out.intra.cea.fr
 [132.166.192.12])
 by pisaure.intra.cea.fr (Postfix) with ESMTP id D44AE2033D0
 for <lttng-dev@lists.lttng.org>; Mon,  1 Feb 2021 10:12:24 +0100 (CET)
Received: from EXCAH-A3.intra.cea.fr (excah-a3.intra.cea.fr [132.166.88.77])
 by muguet1-sys.intra.cea.fr (8.14.7/8.14.7/CEAnet-Internet-out-4.0) with ESMTP
 id 1119COUQ031844
 for <lttng-dev@lists.lttng.org>; Mon, 1 Feb 2021 10:12:24 +0100
Received: from EXDAG0-B1.intra.cea.fr ([fe80::c18e:d8e8:9a27:5b84]) by
 EXCAH-A3.intra.cea.fr ([fe80::60de:a77e:427d:f7e6%10]) with mapi id
 14.03.0487.000; Mon, 1 Feb 2021 10:12:24 +0100
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: [barectf] model.emf.uri
Thread-Index: Adb4dRUTHPyxt9YlQ6yuhA5fxQglvw==
Date: Mon, 1 Feb 2021 09:12:24 +0000
Message-ID: <386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0@EXDAG0-B1.intra.cea.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [132.167.194.33]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.100.1062-25946.003
x-tm-as-result: No--5.015000-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
MIME-Version: 1.0
Subject: [lttng-dev] [barectf] model.emf.uri
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: RADERMACHER Ansgar via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: RADERMACHER Ansgar <Ansgar.RADERMACHER@cea.fr>
Content-Type: multipart/mixed; boundary="===============4708785958369988666=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============4708785958369988666==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0EXDAG0B1intrace_"

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0EXDAG0B1intrace_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

we're currently working on CTF code instrumentation in the C++ code generat=
ion from Papyrus. Unlike in a previous version, we use BareCTF.

In this context, the metadata tag "model.emf.uri" can contain the URI of th=
e element to trace. This works fine in TraceCompass, if we manually add the=
 URI to the metadata, as shown below. But I have not been able to add an en=
try to BareCTF's config.yaml that produces the model.emf.uri in the generat=
ed metadata file. Is it possible?

I could not find an suitable example in the documentation - I experimented =
with the "specific-context-field-type", but it also adds a parameter to the=
 generated C code functions which is not what I want.

Best regards

Ansgar


...
event {
    stream_id =3D 0;
    id =3D 1;
    name =3D "state_C1_FirstState_state";
    model.emf.uri =3D "platform:/resource/DemoTrace/DemoTrace.uml#_AVreJm9f=
EeqJeI8mbLLRcg";
    fields :=3D struct {
        string {
            encoding =3D UTF8;
        } instanceId;
    } align(1);
};

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0EXDAG0B1intrace_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<div>Hello,</div>
<div><br>
</div>
<div>we're currently working on CTF code instrumentation in the C&#43;&#43;=
 code generation from Papyrus. Unlike in a previous version, we use BareCTF=
.</div>
<div><br>
</div>
<div>In this context, the metadata tag &quot;model.emf.uri&quot; can contai=
n the URI of the element to trace. This works fine in TraceCompass, if we m=
anually add the URI to the metadata, as shown below. But I have not been ab=
le to add an entry to BareCTF's config.yaml
 that produces the model.emf.uri in the generated metadata file. Is it poss=
ible?</div>
<div><br>
</div>
<div>I could not find an suitable example in the documentation - I experime=
nted with the &quot;specific-context-field-type&quot;, but it also adds a p=
arameter to the generated C code functions which is not what I want.</div>
<div><br>
</div>
<div>Best regards</div>
<div><br>
</div>
<div>Ansgar<br>
</div>
<div><br>
</div>
<div><br>
</div>
<div>...<br>
</div>
<div>event {<br>
&nbsp;&nbsp; &nbsp;stream_id =3D 0;<br>
&nbsp;&nbsp; &nbsp;id =3D 1;<br>
&nbsp;&nbsp; &nbsp;name =3D &quot;state_C1_FirstState_state&quot;;<br>
&nbsp;&nbsp; &nbsp;model.emf.uri =3D &quot;platform:/resource/DemoTrace/Dem=
oTrace.uml#_AVreJm9fEeqJeI8mbLLRcg&quot;;<br>
&nbsp;&nbsp; &nbsp;fields :=3D struct {<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; string {<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; encoding =3D UTF8;=
<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; } instanceId;<br>
&nbsp;&nbsp; &nbsp;} align(1);<br>
};<br>
</div>
</div>
</body>
</html>

--_000_386C5D4D5C53C24CBC2C60CAAFD2136A5B4A40A0EXDAG0B1intrace_--

--===============4708785958369988666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4708785958369988666==--
