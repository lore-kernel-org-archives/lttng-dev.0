From: Aravind HT <aravind.ht@gmail.com>
Subject: lttng-ust deadlock.
Date: Thu, 23 Jun 2016 11:33:22 +0530
Message-ID: <CACd+_b4LSkLDT97SKLYJ=B59O6oaeJsgTYriAzazjKnOU-ymWg__15801.0973981165$1466661826$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9063489986026996158=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
 [209.85.214.49])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 1E583A3942
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jun 2016 06:03:24 +0000 (UTC)
Received: by mail-it0-f49.google.com with SMTP id h190so57263210ith.1
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jun 2016 23:03:24 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============9063489986026996158==
Content-Type: multipart/alternative; boundary=001a113f87d4c26b100535ebcf60

--001a113f87d4c26b100535ebcf60
Content-Type: text/plain; charset=UTF-8

Hi,

I am facing a deadlock in lttng-ust. Though my version is 2.6 I can see
that this is applicable to the the latest UST version also.

Deadlocks happening due to these two flows
1. lttng_fix_pending_events () -> ustcomm_register_event () -> calloc() ->
__GI___dl_iterate_phdr()
     Note that Im not using the libc wrapper, but using a proprietary
version for malloc() family which can call __GI___dl_iterate_phdr() .
     This flow takes up UST_LOCK() before calling __GI___dl_iterate_phdr(),
and __GI___dl_iterate_phdr() has its own mutex( lets say DL_MUTEX).
2. lttng_ust_baddr_statedump() calls  __GI___dl_iterate_phdr() which first
takes up DL_MUTEX and then takes the UST_LOCK() in the call back function
as extract_soinfo_events()->trace_baddr()->UST_LOCK().

Since the order is reversed, it can lead to deadlock. To fix this, do you
think taking UST_LOCK in  lttng_ust_baddr_statedump() ( surrounding
__GI___dl_iterate_phdr()
call ) instead of the call back function is proper ?

In the latest version of UST, I see some changes/refactoring and that the
UST_LOCK has been removed from trace_baddr() and moved one call up, but
still is being called in the call back function after __GI___dl_iterate_phdr()
is called.


Regards,
Aravind.

--001a113f87d4c26b100535ebcf60
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am facing a deadlock in lttng-ust=
. Though my version is 2.6 I can see that this is applicable to the the lat=
est UST version also.</div><div><br></div><div>Deadlocks happening due to t=
hese two flows</div><div>1.=C2=A0<span style=3D"font-size:10.5pt;font-famil=
y:Calibri,sans-serif;color:black">lttng_fix_pending_events () -&gt;<b>=C2=
=A0</b></span><span style=3D"color:black;font-family:Calibri,sans-serif;fon=
t-size:10.5pt">ustcomm_register_event () -&gt; calloc() -&gt;=C2=A0</span><=
span style=3D"color:black;font-family:Calibri,sans-serif;font-size:10.5pt">=
__GI___dl_iterate_phdr()</span></div><div><span style=3D"color:black;font-f=
amily:Calibri,sans-serif;font-size:10.5pt">=C2=A0 =C2=A0 =C2=A0Note that Im=
 not using the libc wrapper, but using a proprietary version for malloc() f=
amily which can call=C2=A0</span><span style=3D"color:rgb(0,0,0);font-famil=
y:Calibri,sans-serif;font-size:14px">__GI___dl_iterate_phdr()</span><span s=
tyle=3D"color:black;font-family:Calibri,sans-serif;font-size:10.5pt">=C2=A0=
.</span></div><div><span style=3D"color:black;font-family:Calibri,sans-seri=
f;font-size:10.5pt">=C2=A0 =C2=A0 =C2=A0This flow takes up UST_LOCK() befor=
e calling=C2=A0</span><span style=3D"color:rgb(0,0,0);font-family:Calibri,s=
ans-serif;font-size:14px">__GI___dl_iterate_phdr(), and=C2=A0</span><span s=
tyle=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14px">__G=
I___dl_iterate_phdr() has its own mutex( lets say DL_MUTEX).</span></div><d=
iv><font color=3D"#000000" face=3D"Calibri, sans-serif"><span style=3D"font=
-size:14px">2.=C2=A0lttng_ust_baddr_statedump() calls=C2=A0</span></font><s=
pan style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14px=
">=C2=A0</span><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-ser=
if;font-size:14px">__GI___dl_iterate_phdr() which first takes up DL_MUTEX a=
nd then takes the UST_LOCK() in the call back function as=C2=A0</span><font=
 color=3D"#000000" face=3D"Calibri, sans-serif"><span style=3D"font-size:14=
px">extract_soinfo_events()-&gt;trace_baddr()-&gt;UST_LOCK()</span></font><=
span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14p=
x">.</span></div><div><span style=3D"color:rgb(0,0,0);font-family:Calibri,s=
ans-serif;font-size:14px"><br></span></div><div><span style=3D"color:rgb(0,=
0,0);font-family:Calibri,sans-serif;font-size:14px">Since the order is reve=
rsed, it can lead to deadlock. To fix this, do you think taking UST_LOCK in=
=C2=A0</span><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif=
;font-size:14px">=C2=A0lttng_ust_baddr_statedump() ( surrounding=C2=A0</spa=
n><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:=
14px">__GI___dl_iterate_phdr() call ) instead of the call back function is =
proper ?</span></div><div><span style=3D"color:rgb(0,0,0);font-family:Calib=
ri,sans-serif;font-size:14px"><br></span></div><div><span style=3D"color:rg=
b(0,0,0);font-family:Calibri,sans-serif;font-size:14px">In the latest versi=
on of UST, I see some changes/refactoring and that the UST_LOCK has been re=
moved from trace_baddr() and moved one call up, but still is being called i=
n the call back function after=C2=A0</span><span style=3D"color:rgb(0,0,0);=
font-family:Calibri,sans-serif;font-size:14px">__GI___dl_iterate_phdr() is =
called.</span></div><div><span style=3D"color:rgb(0,0,0);font-family:Calibr=
i,sans-serif;font-size:14px"><br></span></div><div><span style=3D"color:rgb=
(0,0,0);font-family:Calibri,sans-serif;font-size:14px"><br></span></div><di=
v><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:=
14px">Regards,</span></div><div><span style=3D"color:rgb(0,0,0);font-family=
:Calibri,sans-serif;font-size:14px">Aravind.</span></div></div>

--001a113f87d4c26b100535ebcf60--

--===============9063489986026996158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9063489986026996158==--
