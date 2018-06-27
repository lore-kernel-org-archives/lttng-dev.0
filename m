From: Ronan Amorim <ronanrmo@gmail.com>
Subject: Re: How to get the sequence element by using babeltrace
 c API ?
Date: Wed, 27 Jun 2018 00:27:36 -0700
Message-ID: <CAHqtAXAzup=EELEtuzxPxxjRpnQgrAE2-eVvDoUGExr0K5W=XA__25367.5137334087$1530084352$gmane$org@mail.gmail.com>
References: <7a52ddf5.cbc5.1643b72e5d1.Coremail.jielan2@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9054336144824669564=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 by lists.lttng.org (Postfix) with ESMTPS id 41FvdK2MGZz19Tt
 for <lttng-dev@lists.lttng.org>; Wed, 27 Jun 2018 03:27:49 -0400 (EDT)
Received: by mail-yw0-x244.google.com with SMTP id r19-v6so353549ywc.10
 for <lttng-dev@lists.lttng.org>; Wed, 27 Jun 2018 00:27:49 -0700 (PDT)
In-Reply-To: <7a52ddf5.cbc5.1643b72e5d1.Coremail.jielan2@163.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?B?56Ca5rGQ?= <jielan2@163.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============9054336144824669564==
Content-Type: multipart/alternative; boundary="0000000000003511dc056f9a8d3a"

--0000000000003511dc056f9a8d3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I dont remember exactly, off the top of my head I think you can do
bt_ctf_get_field_list on the field that is ctf_sequence_type and then
iterate over each of the resulting fields and use bt_ctf_get_int64 to get
the values. Not sure if it is the best way but it works for me.

Btw, is this a ctf_sequence_text or ctf_sequence field in lttng tracepoint?
If it is ctf_sequence_text it won't work because there is a bug in the API.

Regards,
Ronan

On Tue, Jun 26, 2018, 2:52 AM =E7=A0=9A=E6=B1=90 <jielan2@163.com> wrote:

> Hello,
> I found the email address via Google, I sincerely hope that it will
> not disturb you. :)
>  I'm using babeltrace API in C. I would like to know if there's an API to
> get the *se*quence items when the ctf type is CTF_TYPE_SEQUENCE. I tried
> the bt_ctf_get_index(), but it returns a bt_definition*, I don't know how
> to get the char elements of the sequence in the field. Could you give me
> some suggestions? Thanks very much!
>
>
> BR,
> Tina
>
>
>
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--0000000000003511dc056f9a8d3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div dir=3D"auto">I dont remember exactly, off the t=
op of my head I think you can do bt_ctf_get_field_list on the field that is=
 ctf_sequence_type and then iterate over each of the resulting fields and u=
se bt_ctf_get_int64 to get the values. Not sure if it is the best way but i=
t works for me.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Bt=
w, is this a ctf_sequence_text or ctf_sequence field in lttng tracepoint? I=
f it is=C2=A0<span style=3D"font-family:sans-serif">ctf_sequence_text</span=
>=C2=A0it won&#39;t work because there is a bug in the API.</div><div dir=
=3D"auto"><br></div>Regards,</div><div dir=3D"auto">Ronan<br><br><div class=
=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr">On Tue, Jun 26, 2018, 2:52 A=
M =E7=A0=9A=E6=B1=90 &lt;<a href=3D"mailto:jielan2@163.com">jielan2@163.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div style=3D"line-=
height:1.7;color:#000000;font-size:14px;font-family:Arial"><div>Hello,</div=
><div>I found the email address via Google, I=C2=A0sincerely hope that it=
=C2=A0will not=C2=A0disturb you. :)</div><div>=C2=A0I&#39;m using babeltrac=
e API=C2=A0in C. I would like to know if there&#39;s an API to get the <em>=
se</em>quence items when the ctf type is CTF_TYPE_SEQUENCE. I tried the bt_=
ctf_get_index(), but it returns a bt_definition*, I don&#39;t know how to g=
et the char elements of the sequence in the field. Could you give me some s=
uggestions? Thanks very much!</div><div><br></div><div><br></div><div>BR,</=
div><div>Tina</div><div><br></div><div><br></div><div><br></div><div><br></=
div></div><br><br><span title=3D"neteasefooter"><p>=C2=A0</p></span>_______=
________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"noref=
errer">lttng-dev@lists.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><br>
</blockquote></div></div></div>

--0000000000003511dc056f9a8d3a--

--===============9054336144824669564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============9054336144824669564==--
