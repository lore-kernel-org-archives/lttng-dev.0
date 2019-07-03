From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: Need help in converting trace data into CTF
Date: Wed, 3 Jul 2019 20:54:33 +0530
Message-ID: <CAEWVvOT1X2NLSHnCFt3owbWZz3Tth=7qmb+3K_y7V8JO8K5rMQ__24841.6871343338$1562167552$gmane$org@mail.gmail.com>
References: <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa> <20190604145312.GB13240@joraj-alpa>
 <CAEWVvORHWTQLe_uhw2M+aT6tEjgdz3emfxEUosbo+bMsqdN=QA@mail.gmail.com>
 <CAEWVvOR0wv2Du2KNCZE0dpNAhMaFh7JvDFG0FOQ8uWyTBpSoOw@mail.gmail.com>
 <20190617165154.GA7208@joraj-alpa>
 <CAEWVvOSXKF=Ey_edFSFp=CqUDHyhoB_iZQEdTHwcwwYNM3LpJg@mail.gmail.com>
 <20190618141714.GC7208@joraj-alpa>
 <CAEWVvOS-Xe_q7BuPiV7LEJ0Cx96tjsydYALvytvrzg-D+8TYhg@mail.gmail.com>
 <20190619171057.GB32505@joraj-alpa>
 <CAEWVvOT=geq4KRmmiQWHNF8mDqrF4H3RVt04pcMkmx1bmTCpig@mail.gmail.com>
 <CAEWVvORDgrb2RwFpfj6vDzctSwgHCwONmmJhDXMYPiYZcd8eQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7293519131078055583=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by lists.lttng.org (Postfix) with ESMTPS id 45f4fv1GSXzqrg
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jul 2019 11:25:10 -0400 (EDT)
Received: by mail-wm1-x342.google.com with SMTP id u8so2868052wmm.1
 for <lttng-dev@lists.lttng.org>; Wed, 03 Jul 2019 08:25:10 -0700 (PDT)
In-Reply-To: <CAEWVvORDgrb2RwFpfj6vDzctSwgHCwONmmJhDXMYPiYZcd8eQA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7293519131078055583==
Content-Type: multipart/alternative; boundary="0000000000007d2ca1058cc877a4"

--0000000000007d2ca1058cc877a4
Content-Type: text/plain; charset="UTF-8"

Hi developers,

I have multiple binary stream files. Each event stream file contains the
events of the same structure. Each file is for a particular CPU. There is a
total of 32 event stream files.

How to tell the consumers of the streams which file is for which CPU?

Thanks

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000007d2ca1058cc877a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi developers,</div><div><br></div><div>I have multip=
le binary stream files. Each event stream file contains the events of the s=
ame structure. Each file is for a particular CPU. There is a total of 32 ev=
ent stream files.=C2=A0</div><div><br></div><div>How to tell the consumers =
of the streams which file is for which CPU?</div><div><br></div><div>Thanks=
</div><div dir=3D"ltr"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmai=
l-m_-1260393982112446876gmail_signature"><div dir=3D"ltr"><div><div dir=3D"=
ltr"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span style=
=3D"color:rgb(102,102,102)">B. Tech. Computer Science and Engineering,<br><=
/span></div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"https://=
www.iitism.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">Indian =
Institute of Technology (Indian School of Mines)</a>, Dhanbad</span></div><=
/div></div></div></div></div>
</div>

--0000000000007d2ca1058cc877a4--

--===============7293519131078055583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7293519131078055583==--
