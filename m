From: Ravindra Kumar Meena <rmeena840@gmail.com>
Subject: Re: Need help in converting trace data into CTF
Date: Wed, 19 Jun 2019 21:34:55 +0530
Message-ID: <CAEWVvOS-Xe_q7BuPiV7LEJ0Cx96tjsydYALvytvrzg-D+8TYhg__46841.670751904$1560960356$gmane$org@mail.gmail.com>
References: <CAEWVvOS6WyAkE+5GAyn_WEoFW_6h_fWbze-im0w7oqvXS-+dBw@mail.gmail.com>
 <1448366760.18406.1559146893765.JavaMail.zimbra@efficios.com>
 <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa> <20190604145312.GB13240@joraj-alpa>
 <CAEWVvORHWTQLe_uhw2M+aT6tEjgdz3emfxEUosbo+bMsqdN=QA@mail.gmail.com>
 <CAEWVvOR0wv2Du2KNCZE0dpNAhMaFh7JvDFG0FOQ8uWyTBpSoOw@mail.gmail.com>
 <20190617165154.GA7208@joraj-alpa>
 <CAEWVvOSXKF=Ey_edFSFp=CqUDHyhoB_iZQEdTHwcwwYNM3LpJg@mail.gmail.com>
 <20190618141714.GC7208@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5107159723232934706=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by lists.lttng.org (Postfix) with ESMTPS id 45TVCy10Grz17Tm
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2019 12:05:33 -0400 (EDT)
Received: by mail-wm1-x336.google.com with SMTP id v19so55862wmj.5
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2019 09:05:33 -0700 (PDT)
In-Reply-To: <20190618141714.GC7208@joraj-alpa>
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

--===============5107159723232934706==
Content-Type: multipart/alternative; boundary="0000000000001fb521058baf66dd"

--0000000000001fb521058baf66dd
Content-Type: text/plain; charset="UTF-8"

>
> > I used "barectf config.yaml -m ctf" command. It helpled me generating the
> > metadata file. I looked at some other metadata file but they are binary
> > packetized. The one I generated using barectf is not binary packetized.
> >
> > Are these file different?
>
> Yes, they are. As you said one is packetized and the other simply text.
>
> > Will both work the same way?
>
> It will work the same as long as you use a reader that does not care.
> AFAIK, Babeltrace is one of those readers.
>
Okay. This was helpful.

I will be storing the event stream in a file and I will pass metadata file
to babeltrace in order to read the CTF.

 I want to make babeltrace read my metadata file and event stream stored in
a file. How does babeltrace read an arbitrary CTF session(CTF+event stream)?

What should be the file format to store the event stream? I will use
fwrite() to store the events.

Thanks

-- 
*Ravindra Kumar Meena*,
B. Tech. Computer Science and Engineering,
Indian Institute of Technology (Indian School of Mines)
<https://www.iitism.ac.in/>, Dhanbad

--0000000000001fb521058baf66dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">&gt; I used &quot;barectf config.yaml -m ctf&quot; comma=
nd. It helpled me generating the<br>
&gt; metadata file. I looked at some other metadata file but they are binar=
y<br>
&gt; packetized. The one I generated using barectf is not binary packetized=
.<br>
&gt; <br>
&gt; Are these file different?<br>
<br>
Yes, they are. As you said one is packetized and the other simply text.<br>
<br>
&gt; Will both work the same way?<br>
<br>
It will work the same as long as you use a reader that does not care.<br>
AFAIK, Babeltrace is one of those readers.<br></blockquote><div>Okay. This =
was helpful.</div><div><br></div><div>I will be storing the event stream in=
 a file and I will pass metadata file to babeltrace in order to read the CT=
F.</div><div><br></div><div>=C2=A0I want to make babeltrace read my metadat=
a file and event stream stored in a file. How does babeltrace read an arbit=
rary CTF session(CTF+event stream)?</div><div><br></div><div>What should be=
 the file format to store the event stream? I will use fwrite() to store th=
e events.</div><div><br></div><div>Thanks</div></div><div><br></div>-- <br>=
<div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><font size=3D"4"><b>Ravindra Kumar Meena</b></font>,<div><span sty=
le=3D"color:rgb(102,102,102)">B. Tech. Computer Science and Engineering,<br=
></span></div><div><span style=3D"color:rgb(102,102,102)"><a href=3D"https:=
//www.iitism.ac.in/" style=3D"color:rgb(17,85,204)" target=3D"_blank">India=
n Institute of Technology (Indian School of Mines)</a>, Dhanbad</span></div=
></div></div></div></div></div>

--0000000000001fb521058baf66dd--

--===============5107159723232934706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5107159723232934706==--
