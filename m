Return-Path: <SRS0=nP6W=AE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48CC433DF
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Jun 2020 15:12:16 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112592073E
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Jun 2020 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="Gb19FVAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112592073E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49rqWf3wQ3z13FH;
	Tue, 23 Jun 2020 11:12:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1592925135;
	bh=9ZIeR/I7uhvpszUC6P+r2QcSeq6RahnhtGwIvuGhXMo=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Gb19FVAqi/9RKEsNeOAl2drKJa9qVK9zCrxiIj7HCI/zg1kbmMxyozpNky4Vx1fXZ
	 WZv4aIO9CtTxdLlqD8Lm+r8j2RAnyz/FhWRGqRlTMHsbig/q+GlT/zvphkEmhiZWvy
	 JJx+G9TT4tmXMZhywCbTP8Gt15+M1pSSJUA8fyPhhhl8oFXHRD+K7eauIsjmHIsJ27
	 001atUEYBkaWQri2lbMVTYiq8GOF4M/R0KJZwBh8g5tP5NbkJIFwd3d8KBYvWaFDhn
	 dbrmNKNrfAnxI22R/UdMFf9tBAk9zxvfH8D5jxn7v9dxyqifjY+E9towJfoR1zU7qD
	 dwgpxqQJ96FqA==
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by lists.lttng.org (Postfix) with ESMTPS id 49rqWc0dgzz1368
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2020 11:12:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAAn0leKNzZw2zuE/ZhDy/8qJF3z1MZz2d0nds2rw7pYoV73aKL05Mqcgz4qC/vSyl3zRB8LKETWK1nz1wHRdhaDoz4l5dRbCoThehvm5UniS7a+WnWs8sGgggagzCFnzJjatnhOAO/CkXdZspTQ3VAOUiNVGhC7e0ZQFE1Vl9kJk4C5cyBvSzEc8eShaqMSzbmeux60xwJhuRPDj0JE991IE39PqTi/WUQBgORAmAtKKMCNAgvy84JaJuNStUSrhlQqBhNO6VJaacb4jtymRq5DkHCvGaVli/vtKwwAP9OADRXqZwEttXR8e1xMkHBbsZAom4dLfs2KOtJoubG7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LljnxvmkMrV9eQMkCckvOw3LtkmxadHq4Srm7e7NWsM=;
 b=DFR6FEhfRy6K4Yhw562yHzFba5esAjp954kM5IZFG6xsTg3gt75pe31pp+ZKRLXWX8pK0Nt5rkhzPl1PQxE2NdH4nqP8Cpb5zxXklyyY9o/orp2o0561pIiHOoxDxNdLsto/xTQEfvfR5LfbNsqnlQyOibyMNgklTIlIvLpoeZqh2wftMOiQQ+R4F12BfxPUxvhGZJOGkTvbs6pcxNpg8s5qBnBC1uBHFTD3KnYaYk9X8vkBIh2idgegRaehmZ+t/9Bb+1s9PVVqBYRAh2fKYus1C5PrVnoZ0owlYhZsGGW9bpYprYzag1+6035wBpNB5C0uEVV5MuajyhSpqfUXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SA0PR15MB3872.namprd15.prod.outlook.com (2603:10b6:806:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 15:12:10 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::3926:33a:1acb:9f06]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::3926:33a:1acb:9f06%2]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 15:12:10 +0000
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Liu, Changcheng"
 <changcheng.liu@intel.com>
Thread-Topic: [lttng-dev] get function names with lttng-ust-cyg-profile
Thread-Index: AQHWSWx6nALML+E3ZkesbKGR9FOrDajmTdK8
Date: Tue, 23 Jun 2020 15:12:10 +0000
Message-ID: <SA0PR15MB38396A864018025F971F2A239E940@SA0PR15MB3839.namprd15.prod.outlook.com>
References: <20200623143758.GB4160129@jerryopenix>
In-Reply-To: <20200623143758.GB4160129@jerryopenix>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.176.1.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 666bd1b9-c94f-40f7-425b-08d81787cd66
x-ms-traffictypediagnostic: SA0PR15MB3872:
x-microsoft-antispam-prvs: <SA0PR15MB3872A9F494FA8F9792EE631D9E940@SA0PR15MB3872.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3VFgY6sPo/ZjCnh9td+IZmyClSpnDZRdgqb2GNwCTTtjZPSPsF/sG+tsa1MkKYHzYTecVFUe8qGOQm9pL2qHZe9+yRTKEJKM9vCKZ3a/wR7E1RZN9dd+DImlyP5iIPvrK1YSWN7rfdgE4hxIHcZE1z94P9EsTx3Z/o0iUFl0pIjTNfiqRLdU7NRXln6ZHiecRTjCAFhiR90PqhNS/Cjhh/hNTdgR3ooqUgyhcmGn/mErfwk7rutllMKPY86vLw0gnTUB+lvdHbJnryLFccJdUtPLvnes33FjqVgKH68rdn80eHNOUUh5TI7v9e1IOUqOIH8hddoDTYtOWuPVzsiBm3cV/sERMoQUkDo65p+r+pxiDQlWwO13inHHw7U5h/0q1ffa7ySQeNYtImyPCIUcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR15MB3839.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(52536014)(478600001)(2906002)(33656002)(66446008)(64756008)(66476007)(110136005)(66556008)(8676002)(55016002)(8936002)(7696005)(316002)(9686003)(71200400001)(83380400001)(19627405001)(86362001)(44832011)(186003)(6506007)(53546011)(166002)(66946007)(76116006)(5660300002)(26005)(966005)(91956017);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9LZeiImVASKFtNvhDf1bWDru0lp6AO8d5tN9SH6vOZstCCl2TeBPHDAhfWOPtxFbVTWkZPQRB95C6PCP0o+nNv+Bm7dFJQyJaknGFddkjhAxCV3if4/xyMPgXGcx98CP8SpZCVJ1YYIDA5wi3iJwQFYRs5VmeiIjPH5AJ4fWx2Or8vMUWz+W5tzhxkl9MuQr1KTb9ewOjE+QCyU6PwjNUeb+KrFwhbKtz4O5au27CF0bgq9dkYVnNeu6b9tgC2qISdu51eUnVZ+rUDkYEcFSucjoR71GLJ9VDQMJAdGMC/VvsL86NcoCJpErZFqUUuvllx1Vbrt3RW9EBcPhu5eGCr7WCrMZfLXZZ6/uRly50quhlwLH16Ndtm+jMyNGjKB4GL5mjoll0a3fcg6sI8vtVd3ZFVkfiVF5H8hCxfbcn0EAGSxAaHUyplNRjUciRYdp4zrcEPD+LI1+eC7mclM9+6VLwrO8HTfPADM1HgYdzr4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666bd1b9-c94f-40f7-425b-08d81787cd66
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 15:12:10.5456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gh08sEMhlbtTzIyRT/cqv5OkvGwb9BCW6+iKRA9s5XdCrLwJEqDlFjRREtHoUR/WpoPOkPH9cd3zQmlDKDpLhTSSKDweuUoEnAekY8d3T+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3872
Subject: Re: [lttng-dev] get function names with lttng-ust-cyg-profile
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
From: Matthew Khouzam via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Content-Type: multipart/mixed; boundary="===============0359904280060498912=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200623151210.ANWwIWQvOWm-TNx0OHSy3az7eBpM7sUOTbI2-4dTYU8@z>

--===============0359904280060498912==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_"

--_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

You have the pointers that are traced. Babeltrace is doing exactly what it =
should as far as I know.

You could use the command 'nm' to get your symbols and look them up. I am s=
ure Babeltrace can do this from a python level. You could also use a GUI ba=
sed trace viewer to get the information.

Hope that helps.
Matthew
________________________________
From: lttng-dev <lttng-dev-bounces@lists.lttng.org> on behalf of Liu, Chang=
cheng via lttng-dev <lttng-dev@lists.lttng.org>
Sent: Tuesday, June 23, 2020 10:37 AM
To: lttng-dev@lists.lttng.org <lttng-dev@lists.lttng.org>
Cc: changcheng.liu@intel.com <changcheng.liu@intel.com>
Subject: [lttng-dev] get function names with lttng-ust-cyg-profile

Hi all,
   I'm trying to use lttng-ust-cyg-profile to trace program.
   Does anyone know how to get function names and offset through lttng-ust-=
cyg-profile?

   In below example, the babeltrace could only get the function entry/exit =
value.
   1. Source program: instrument.c
         1 #include <stdio.h>
         2
         3 int add3(int val) {
         4         return val + 3;
         5 }
         6
         7 int main(int argc, char **argv) {
         8     int x =3D 4;
         9
        10     puts("Press Enter to continue...");
        11     getchar();
        12
        13     x =3D add3(x);
        14
        15     return 0;
        16 }

   2. build source code:
        $ gcc -g -finstrument-functions instrument.c -o instrument

   3. run program:
       $ LD_PRELOAD=3D/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so=
 ./instrument

   4. start trace process:
       trace@trace:~/cc$ sudo lttng create instrument
       Session instrument created.
       Traces will be output to /root/lttng-traces/instrument-20200623-2229=
17

       trace@trace:~/cc$ sudo lttng enable-channel user_func_trace --usersp=
ace
       UST channel user_func_trace enabled for session instrument

       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_=
profile:func_entry --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_entry created in channel user_f=
unc_trace
       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_=
profile:func_exit --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_exit created in channel user_fu=
nc_trace

       trace@trace:~/cc$ sudo lttng start
       Tracing started for session instrument

       trace@trace:~/cc$ sudo lttng destroy
       Destroying session instrument..
       Session instrument destroyed

       trace@trace:~/cc$ sudo babeltrace /root/lttng-traces/instrument-2020=
0623-222917
       [22:29:55.388607059] (+?.?????????) trace lttng_ust_cyg_profile:func=
_entry: { cpu_id =3D 2 }, { addr =3D 0x5625C88B01A9, call_site =3D 0x5625C8=
8B0237 }
       [22:29:55.388612293] (+0.000005234) trace lttng_ust_cyg_profile:func=
_exit: { cpu_id =3D 2 }, { addr =3D 0x5625C88B01A9, call_site =3D 0x5625C88=
B0237 }
       [22:29:55.388613215] (+0.000000922) trace lttng_ust_cyg_profile:func=
_exit: { cpu_id =3D 2 }, { addr =3D 0x5625C88B01EE, call_site =3D 0x7FE40BD=
5C0B3 }

B.R.
Changcheng
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://protect2.fireeye.com/v1/url?k=3D98478753-c6e73d3d-9847c7c8-869a14f4=
b08c-41638b2508ab85dd&q=3D1&e=3D703483a0-63a9-4269-ac8e-c1fc5a57edad&u=3Dht=
tps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Flistinfo%2Flttng-dev

--_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You have the pointers that are traced. Babeltrace is doing exactly what it =
should as far as I know.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
You could use the command 'nm' to get your symbols and look them up. I am s=
ure Babeltrace can do this from a python level. You could also use a GUI ba=
sed trace viewer to get the information.&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hope that helps.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Matthew<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> lttng-dev &lt;lttng-d=
ev-bounces@lists.lttng.org&gt; on behalf of Liu, Changcheng via lttng-dev &=
lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Sent:</b> Tuesday, June 23, 2020 10:37 AM<br>
<b>To:</b> lttng-dev@lists.lttng.org &lt;lttng-dev@lists.lttng.org&gt;<br>
<b>Cc:</b> changcheng.liu@intel.com &lt;changcheng.liu@intel.com&gt;<br>
<b>Subject:</b> [lttng-dev] get function names with lttng-ust-cyg-profile</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi all,<br>
&nbsp;&nbsp; I'm trying to use lttng-ust-cyg-profile to trace program.<br>
&nbsp;&nbsp; Does anyone know how to get function names and offset through =
lttng-ust-cyg-profile?<br>
<br>
&nbsp;&nbsp; In below example, the babeltrace could only get the function e=
ntry/exit value.<br>
&nbsp;&nbsp; 1. Source program: instrument.c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 #include &lt;stdio.h&gt;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3 int add3(int val) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return val &#43; 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7 int main(int argc, char =
**argv) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbsp;&nbsp;&nbsp; =
int x =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp; =
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10&nbsp;&nbsp;&nbsp;&nbsp; puts(=
&quot;Press Enter to continue...&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11&nbsp;&nbsp;&nbsp;&nbsp; getch=
ar();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13&nbsp;&nbsp;&nbsp;&nbsp; x =3D=
 add3(x);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp; retur=
n 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 }<br>
<br>
&nbsp;&nbsp; 2. build source code:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ gcc -g -finstrument-functions =
instrument.c -o instrument<br>
<br>
&nbsp;&nbsp; 3. run program:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $ LD_PRELOAD=3D/usr/lib/x86_64-linux-g=
nu/liblttng-ust-cyg-profile.so ./instrument<br>
<br>
&nbsp;&nbsp; 4. start trace process:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng create in=
strument<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Session instrument created.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Traces will be output to /root/lttng-t=
races/instrument-20200623-222917<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng enable-ch=
annel user_func_trace --userspace<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UST channel user_func_trace enabled fo=
r session instrument<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng enable-ev=
ent --userspace lttng_ust_cyg_profile:func_entry --channel user_func_trace<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UST event lttng_ust_cyg_profile:func_e=
ntry created in channel user_func_trace<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng enable-ev=
ent --userspace lttng_ust_cyg_profile:func_exit --channel user_func_trace<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UST event lttng_ust_cyg_profile:func_e=
xit created in channel user_func_trace<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng start<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Tracing started for session instrument=
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo lttng destroy<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Destroying session instrument..<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Session instrument destroyed<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace@trace:~/cc$ sudo babeltrace /roo=
t/lttng-traces/instrument-20200623-222917<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [22:29:55.388607059] (&#43;?.?????????=
) trace lttng_ust_cyg_profile:func_entry: { cpu_id =3D 2 }, { addr =3D 0x56=
25C88B01A9, call_site =3D 0x5625C88B0237 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [22:29:55.388612293] (&#43;0.000005234=
) trace lttng_ust_cyg_profile:func_exit: { cpu_id =3D 2 }, { addr =3D 0x562=
5C88B01A9, call_site =3D 0x5625C88B0237 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [22:29:55.388613215] (&#43;0.000000922=
) trace lttng_ust_cyg_profile:func_exit: { cpu_id =3D 2 }, { addr =3D 0x562=
5C88B01EE, call_site =3D 0x7FE40BD5C0B3 }<br>
<br>
B.R.<br>
Changcheng<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
<a href=3D"https://protect2.fireeye.com/v1/url?k=3D98478753-c6e73d3d-9847c7=
c8-869a14f4b08c-41638b2508ab85dd&amp;q=3D1&amp;e=3D703483a0-63a9-4269-ac8e-=
c1fc5a57edad&amp;u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmailman%2Fli=
stinfo%2Flttng-dev">https://protect2.fireeye.com/v1/url?k=3D98478753-c6e73d=
3d-9847c7c8-869a14f4b08c-41638b2508ab85dd&amp;q=3D1&amp;e=3D703483a0-63a9-4=
269-ac8e-c1fc5a57edad&amp;u=3Dhttps%3A%2F%2Flists.lttng.org%2Fcgi-bin%2Fmai=
lman%2Flistinfo%2Flttng-dev</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_SA0PR15MB38396A864018025F971F2A239E940SA0PR15MB3839namp_--

--===============0359904280060498912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0359904280060498912==--
