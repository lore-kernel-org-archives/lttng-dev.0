From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@polymtl.ca>
Subject: Re: [PATCH lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Wed, 3 Apr 2013 19:13:51 -0400
Message-ID: <CAE_Gge0iyEL6JaYR+si0URMQ0r_mHEGyTezzs23t5+ZZtk7Avg__41519.5194691934$1365030915$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D04580@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<CAFXXi0nKoZA4RNFCBEEqC4sYm2cjY8xfAute+aQvx3-Xaw8SiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0799344503=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1UNWsi-0004ik-Rc
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 19:14:17 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so2097426oag.25
	for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2013 16:14:11 -0700 (PDT)
In-Reply-To: <CAFXXi0nKoZA4RNFCBEEqC4sYm2cjY8xfAute+aQvx3-Xaw8SiQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Thibault,
	Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

--===============0799344503==
Content-Type: multipart/alternative; boundary=e89a8fb1fa1000724c04d97d038a

--e89a8fb1fa1000724c04d97d038a
Content-Type: text/plain; charset=ISO-8859-1

2013/4/3 Simon Marchi <simon.marchi@polymtl.ca>

> >    Normally I'd be the first to advocate k, M, G as powers of 10 and Ki,
> Mi, Gi as powers of two (ISO/IEC 80000-13:2008) but the kernel parameters
> use exclusively K, M, and G in the powers of two sense, and I believe just
> about every other part of Linux does also.  We should thus, somewhat
> unfortunately, stick to powers of two.  Just be sure to explicitly give the
> multipliers' values in the help.  Oh, and accept just the upper-case
> letters, like the kernel parameters do.
>
> Yeah.. we need to accept capital K for kilo (kibi) because everyone
> else does. Actually I was thinking of mimicking the behaviour of dd.
> For kilo (kibi), you can use upper and lower case (probably reeks of
> when there was no such things as lower case letters in computing. I
> look at you FORTRAN). But for mega (mibi) and giga (gibi), it's upper
> case only.
>
> The more I think about it, the more I think it doesn't matter if we
> accept upper and lower case for all... I don't know anybody who will
> request a buffer of 32 millibytes.


I guess we could follow the "dd" way of work :
BLOCKS and BYTES may be followed by the following multiplicative suffixes:
c =1, w =2, b =512, kB =1000, K =1024, MB =1000*1000, M =1024*1024, xM =M
GB =1000*1000*1000, G =1024*1024*1024, and so on for T, P, E, Z, Y.

--e89a8fb1fa1000724c04d97d038a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2013/4/3 Simon Marchi <span dir=3D"ltr">&lt;<a href=3D"mailto:simon.marchi@=
polymtl.ca" target=3D"_blank">simon.marchi@polymtl.ca</a>&gt;</span><br><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">


<div>&gt; =A0 =A0Normally I&#39;d be the first to advocate k, M, G as power=
s of 10 and Ki, Mi, Gi as powers of two (ISO/IEC 80000-13:2008) but the ker=
nel parameters use exclusively K, M, and G in the powers of two sense, and =
I believe just about every other part of Linux does also. =A0We should thus=
, somewhat unfortunately, stick to powers of two. =A0Just be sure to explic=
itly give the multipliers&#39; values in the help. =A0Oh, and accept just t=
he upper-case letters, like the kernel parameters do.<br>



<br>
</div>Yeah.. we need to accept capital K for kilo (kibi) because everyone<b=
r>
else does. Actually I was thinking of mimicking the behaviour of dd.<br>
For kilo (kibi), you can use upper and lower case (probably reeks of<br>
when there was no such things as lower case letters in computing. I<br>
look at you FORTRAN). But for mega (mibi) and giga (gibi), it&#39;s upper<b=
r>
case only.<br>
<br>
The more I think about it, the more I think it doesn&#39;t matter if we<br>
accept upper and lower case for all... I don&#39;t know anybody who will<br=
>
request a buffer of 32 millibytes.</blockquote><div><br></div><div>I guess =
we could follow the &quot;dd&quot; way of work :</div><div><span style=3D"f=
ont-size:13px;font-family:arial,sans-serif">BLOCKS and BYTES may be followe=
d by the following multiplicative suffixes: c =3D1, w =3D2, b =3D512, kB =
=3D1000, K =3D1024, MB =3D1000*1000, M =3D1024*1024, xM =3DM GB =3D1000*100=
0*1000, G =3D1024*1024*1024, and so on for T, P, E, Z, Y.</span>=A0</div>


</div>

--e89a8fb1fa1000724c04d97d038a--


--===============0799344503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0799344503==--
