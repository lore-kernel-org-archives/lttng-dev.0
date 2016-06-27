From: Vijay Anand <vjanandr85@gmail.com>
Subject: subbuffers count and size
Date: Mon, 27 Jun 2016 15:42:54 +0530
Message-ID: <CAHxF_R85MSZ5LqvH1JGUXyj2HaMNfyO7pT7ypQ=o=zoE1F4ybw__31300.4236239523$1467022393$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0793273201295204799=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D04ADA0287
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2016 10:12:54 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id v199so93533628wmv.0
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jun 2016 03:12:54 -0700 (PDT)
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

--===============0793273201295204799==
Content-Type: multipart/alternative; boundary=089e0102d80082714705363fc344

--089e0102d80082714705363fc344
Content-Type: text/plain; charset=UTF-8

Hi,

I have been trying to understand the impact of performance while logging
user space program based on the subbuffer count and size.

I have a simple program logging 1 million traces and I dont seem to see any
appreciable performance between the below two configurations.

a. default 4 subbufers 128KB each
b. 16 subbufers with 1024kB each.

Moreover I have been looking at the lttng-ust code to understand the
performance impacts from the implementation and unable to comprehend what
is documented at

http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-count

I see that channel_backend_init, _shm_object_table_alloc_shm seems to
allocate one big shared memory chunk which again is subdivided into
subbuffers with each subbuffer referenced using the subbufer index.

Further more lib_ring_buffer_write seems to find the subbuffer index and
write "len" number of bytes into the subbuffer index.

Could anyone please enlighten me what is the overhead involved while
switching from one subbufer to another as documented.

Regards,
Vijay

--089e0102d80082714705363fc344
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;font-size:small"><font color=3D"#000000">Hi,</font></div><div cl=
ass=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:sma=
ll"><font color=3D"#000000"><br></font></div><div class=3D"gmail_default" s=
tyle=3D"font-family:verdana,sans-serif;font-size:small"><font color=3D"#000=
000">I have been trying to understand the impact of performance while loggi=
ng user space program based on the subbuffer count and size.</font></div><d=
iv class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-siz=
e:small"><font color=3D"#000000"><br></font></div><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif;font-size:small"><font color=3D=
"#000000">I have a simple program logging 1 million traces and I dont seem =
to see any appreciable performance between the below two configurations.</f=
ont></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-se=
rif;font-size:small"><font color=3D"#000000"><br></font></div><div class=3D=
"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:small"><f=
ont color=3D"#000000">a. default 4 subbufers 128KB each</font></div><div cl=
ass=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:sma=
ll"><font color=3D"#000000">b. 16 subbufers with 1024kB each.</font></div><=
div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-si=
ze:small"><font color=3D"#000000"><br></font></div><div class=3D"gmail_defa=
ult" style=3D"font-family:verdana,sans-serif;font-size:small"><font color=
=3D"#000000">Moreover I have been looking at the lttng-ust code to understa=
nd the performance impacts from the implementation and unable to comprehend=
 what is documented at=C2=A0</font></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif;font-size:small"><font color=3D"#000000"=
><br></font></div><div class=3D"gmail_default" style=3D""><font color=3D"#0=
00000"><font face=3D"verdana, sans-serif"><a href=3D"http://lttng.org/docs/=
#doc-channel-subbuf-size-vs-subbuf-count">http://lttng.org/docs/#doc-channe=
l-subbuf-size-vs-subbuf-count</a></font><br></font></div><div class=3D"gmai=
l_default" style=3D""><font face=3D"verdana, sans-serif" color=3D"#000000">=
<br></font></div><div class=3D"gmail_default" style=3D""><font face=3D"verd=
ana, sans-serif" color=3D"#000000">I see that=C2=A0channel_backend_init,=C2=
=A0_shm_object_table_alloc_shm seems to allocate one big shared memory chun=
k which again is subdivided into subbuffers with each subbuffer referenced =
using the subbufer index.</font></div><div class=3D"gmail_default" style=3D=
""><font face=3D"verdana, sans-serif" color=3D"#000000"><br></font></div><d=
iv class=3D"gmail_default" style=3D""><font face=3D"verdana, sans-serif" co=
lor=3D"#000000">Further more=C2=A0lib_ring_buffer_write seems to find the s=
ubbuffer index and write &quot;len&quot; number of bytes into the subbuffer=
 index.</font></div><div class=3D"gmail_default" style=3D""><font face=3D"v=
erdana, sans-serif" color=3D"#000000"><br></font></div><div class=3D"gmail_=
default" style=3D""><font face=3D"verdana, sans-serif" color=3D"#000000">Co=
uld anyone please enlighten me what is the overhead involved while switchin=
g from one subbufer to another as documented.</font></div><div class=3D"gma=
il_default" style=3D"font-family:verdana,sans-serif;font-size:small"><font =
color=3D"#000000"><br></font></div><div><div class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"verdana, sans=
-serif" color=3D"#000000">Regards,</font><div><font face=3D"verdana, sans-s=
erif" color=3D"#000000">Vijay</font></div></div></div></div>
</div>

--089e0102d80082714705363fc344--

--===============0793273201295204799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0793273201295204799==--
