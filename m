From: Divya Vyas <dvyas@mvista.com>
Subject: Re: babeltrace CTF -> Text -> CTF
Date: Tue, 11 Nov 2014 11:47:40 +0530
Message-ID: <CA+=dQ-8rh9zBOebN=sM0N08yaKHwgRc6YQeMdcEVdNs4tV2oTQ__33471.9590995975$1415686721$gmane$org@mail.gmail.com>
References: <CA+=dQ-9JigPHaP=_u8kBYQ4vWGGUowY7YsWwPjyZfVxaMjYuKA@mail.gmail.com>
 <CAE_Gge14wobmw8n1MsuXnfpS2eDtC4s=3tqGSEO+agAzY2nqJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1905401955=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dvyas@mvista.com>) id 1Xo4mE-000526-31
 for lttng-dev@lists.lttng.org; Tue, 11 Nov 2014 01:18:07 -0500
Received: by mail-wi0-f182.google.com with SMTP id d1so565337wiv.15
 for <lttng-dev@lists.lttng.org>; Mon, 10 Nov 2014 22:18:00 -0800 (PST)
In-Reply-To: <CAE_Gge14wobmw8n1MsuXnfpS2eDtC4s=3tqGSEO+agAzY2nqJg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?Rapha=C3=ABl_Beamonte?= <raphael.beamonte@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1905401955==
Content-Type: multipart/alternative; boundary=f46d04428f56b32e5105078f3dff

--f46d04428f56b32e5105078f3dff
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ok

But the lttng output and converted CTF output from text log  are not same
in visualizer .






On Tue, Nov 11, 2014 at 11:03 AM, Rapha=C3=ABl Beamonte <
raphael.beamonte@gmail.com> wrote:

> Hi Divya,
>
> 2014-11-11 0:27 GMT-05:00 Divya Vyas <dvyas@mvista.com>:
> > The text_output first line is
> >
> > [12:44:05.438190693] (+?.?????????) kmem_cache_alloc: { cpu_id =3D 0 },=
 {
> > call_site =3D 0xFFFFFFFF811806FC, ptr =3D 0xFFFF8800157248C0, bytes_req=
 =3D
> 304,
> > bytes_alloc =3D 320, gfp_flags =3D 32976 }
> >
> > missing timestamp
>
> The timestamp is here: 12:44:05.438190693
> The "+?.?????????" part represents the time difference between the
> previous event and this one, but as it is the first event of the
> trace, there isn't any previous event, thus leading to the
> "+?.?????????".
>
> Rapha=C3=ABl
>

--f46d04428f56b32e5105078f3dff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok=C2=A0<div><br></div><div>But the lttng output and conve=
rted CTF output from text log =C2=A0are not same in visualizer .</div><div>=
<br></div><div><br></div><div><br></div><div><br></div><div><br></div></div=
><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Nov 11, =
2014 at 11:03 AM, Rapha=C3=ABl Beamonte <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:raphael.beamonte@gmail.com" target=3D"_blank">raphael.beamonte@gmail.c=
om</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Divya,<br>
<br>
2014-11-11 0:27 GMT-05:00 Divya Vyas &lt;<a href=3D"mailto:dvyas@mvista.com=
">dvyas@mvista.com</a>&gt;:<br>
<span class=3D"">&gt; The text_output first line is<br>
&gt;<br>
&gt; [12:44:05.438190693] (+?.?????????) kmem_cache_alloc: { cpu_id =3D 0 }=
, {<br>
&gt; call_site =3D 0xFFFFFFFF811806FC, ptr =3D 0xFFFF8800157248C0, bytes_re=
q =3D 304,<br>
&gt; bytes_alloc =3D 320, gfp_flags =3D 32976 }<br>
&gt;<br>
&gt; missing timestamp<br>
<br>
</span>The timestamp is here: 12:44:05.438190693<br>
The &quot;+?.?????????&quot; part represents the time difference between th=
e<br>
previous event and this one, but as it is the first event of the<br>
trace, there isn&#39;t any previous event, thus leading to the<br>
&quot;+?.?????????&quot;.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Rapha=C3=ABl<br>
</font></span></blockquote></div><br></div>

--f46d04428f56b32e5105078f3dff--


--===============1905401955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1905401955==--
