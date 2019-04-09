From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: decoding tracef msg string via babeltrace API
Date: Tue, 9 Apr 2019 13:02:06 -0400
Message-ID: <CA+jJMxvD4HOVaDpKM2-gAQ3WLiPC7odsdXLyEzxvDzVH2p3t9Q__21780.9656912991$1554829389$gmane$org@mail.gmail.com>
References: <33072915.QNGMzHgIAz@agathebauer>
 <CA+jJMxs4UAiWSanNqTigrGSLBdm+4WfcFxM5HOhvubDtXemjEA@mail.gmail.com>
 <2088473.4UkR9GzeEB@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7839943455932463847=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44dtrq53Kpz1Jw8
 for <lttng-dev@lists.lttng.org>; Tue,  9 Apr 2019 13:02:51 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 54D707D7F6
 for <lttng-dev@lists.lttng.org>; Tue,  9 Apr 2019 13:02:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
 with ESMTP id qWtG-Wh6Tw6r for <lttng-dev@lists.lttng.org>;
 Tue,  9 Apr 2019 13:02:44 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5E2927D7EB
 for <lttng-dev@lists.lttng.org>; Tue,  9 Apr 2019 13:02:44 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
 by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
 with ESMTP id uePLTx7KmCch for <lttng-dev@lists.lttng.org>;
 Tue,  9 Apr 2019 13:02:44 -0400 (EDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by mail.efficios.com (Postfix) with ESMTPSA id DF5027D7CC
 for <lttng-dev@lists.lttng.org>; Tue,  9 Apr 2019 13:02:43 -0400 (EDT)
Received: by mail-lf1-f41.google.com with SMTP id u24so5996495lfg.5
 for <lttng-dev@lists.lttng.org>; Tue, 09 Apr 2019 10:02:43 -0700 (PDT)
In-Reply-To: <2088473.4UkR9GzeEB@milian-kdab2>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7839943455932463847==
Content-Type: multipart/alternative; boundary="000000000000d5c87205861beb25"

--000000000000d5c87205861beb25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2019 at 04:36, Milian Wolff <milian.wolff@kdab.com> wrote:

> On Thursday, April 4, 2019 8:25:51 PM CEST J=C3=A9r=C3=A9mie Galarneau wr=
ote:
> > Hi Milian,
> >
> > I have pushed a fix [1] in the stable-1.5 branch that addresses the
> > issue you have encountered with using bt_ctf_get_field_list().
> > This makes it possible to consume a character sequence's content.
> >
> > The commit message contains an example to show how to essentially
> > perform what the 'ctf-text' format plug-in achieves by accessing the
> > internal string field.
> >
> > Let me know if that works for you and I'll release an updated version
> > of the 1.5 branch.
>
> Thank you, I'll try that out in the next days!
>
> But: why can't we make bt_ctf_get_string return the string for us? Why do
> we
> need to reinvent the wheel in consumers of the babeltrace API? You point
> out
>

Hi,

Strings, sequences and arrays are three different types in CTF.

bt_ctf_get_string() can only be used on CTF strings. In the babeltrace 1.x
API, those are expressed through 'bt_definition's that have a
'bt_declaration'
of type CTF_TYPE_STRING. It is not a general-purpose accessor to get
a field's content as a C-string.

Changing this in the 1.x release series goes against the design of the
API (dedicated functions per definition type) and would, arguably, be an
ABI breaking change.

As pointed out in the commit message, bt_ctf_get_char_array() is
a convenience function to access a character-array's contents as
a C-string. An equivalent function could be added for sequences.

Since you pointed-out a bug in the existing API, my priority was
in fixing that bug which prevented users from accessing the sequences'
contents at all in the "looks like a string" case. That fix can be
back-ported into existing releases and made available in a point-release.

Adding new APIs is an orthogonal concern. I'm not against a
convenience function that does what you want; but it won't be
shoe-horned into an existing one.

J=C3=A9r=C3=A9mie



>
> Cheers
>


> that it's non-trivial to get the strings decoded properly, so I'd really
> appreciate if we get that code implemented once and then can leverage it
> everywhere.
>

> Generally, I don't understand why there's both, bt_ctf_get_string and
> bt_ctf_get_char_array in the first place....
>
--=20
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--000000000000d5c87205861beb25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 9 Apr 2019 at 04:36, Milian W=
olff &lt;<a href=3D"mailto:milian.wolff@kdab.com" target=3D"_blank">milian.=
wolff@kdab.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Thursday, April 4, 2019 8:25:51 PM CEST J=C3=A9r=C3=A9mie =
Galarneau wrote:<br>
&gt; Hi Milian,<br>
&gt; <br>
&gt; I have pushed a fix [1] in the stable-1.5 branch that addresses the<br=
>
&gt; issue you have encountered with using bt_ctf_get_field_list().<br>
&gt; This makes it possible to consume a character sequence&#39;s content.<=
br>
&gt; <br>
&gt; The commit message contains an example to show how to essentially<br>
&gt; perform what the &#39;ctf-text&#39; format plug-in achieves by accessi=
ng the<br>
&gt; internal string field.<br>
&gt; <br>
&gt; Let me know if that works for you and I&#39;ll release an updated vers=
ion<br>
&gt; of the 1.5 branch.<br>
<br>
Thank you, I&#39;ll try that out in the next days!<br>
<br>
But: why can&#39;t we make bt_ctf_get_string return the string for us? Why =
do we <br>
need to reinvent the wheel in consumers of the babeltrace API? You point ou=
t <br>
</blockquote><div><br></div><div><div></div><div>Hi,<br></div><br><div clas=
s=3D"gmail_quote"><div>Strings, sequences and arrays are three different ty=
pes in CTF.</div><div><br></div><div>bt_ctf_get_string() can only be used o=
n CTF strings. In the babeltrace 1.x</div><div>API, those are expressed thr=
ough &#39;bt_definition&#39;s that have a &#39;bt_declaration&#39;</div><di=
v>of type CTF_TYPE_STRING. It is not a general-purpose accessor to get</div=
><div>a field&#39;s content as a C-string.</div><div><br></div><div>Changin=
g this in the 1.x release series goes against the design of the</div><div>A=
PI (dedicated functions per definition type) and would, arguably, be an</di=
v><div>ABI breaking change.<br></div></div><div class=3D"gmail_quote"><br><=
/div><div class=3D"gmail_quote"><div>As pointed out in the commit message, =
bt_ctf_get_char_array() is</div><div>a convenience function to access a cha=
racter-array&#39;s contents as</div><div>a C-string. An equivalent function=
 could be added for sequences.</div><div><br></div><div><div>Since you poin=
ted-out a bug in the existing API, my priority was</div><div>in fixing that=
 bug which prevented users from accessing the sequences&#39;</div><div>cont=
ents at all in the &quot;looks like a string&quot; case. That fix can be</d=
iv><div>back-ported into existing releases and made available in a point-re=
lease.</div><div><br></div><div>Adding new APIs is an orthogonal concern. I=
&#39;m not against a</div><div>convenience function that does what you want=
; but it won&#39;t be</div><div>shoe-horned into an existing one.</div></di=
v><div><br></div><div>J=C3=A9r=C3=A9mie<br></div><div><br></div><div></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Cheers<br>
</blockquote></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">that it&#39;s non-trivial to get the strings decoded prope=
rly, so I&#39;d really <br>
appreciate if we get that code implemented once and then can leverage it <b=
r>
everywhere.<br></blockquote><div></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
Generally, I don&#39;t understand why there&#39;s both, bt_ctf_get_string a=
nd <br>
bt_ctf_get_char_array in the first place....<br></blockquote></div><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
Milian Wolff | <a href=3D"mailto:milian.wolff@kdab.com" target=3D"_blank">m=
ilian.wolff@kdab.com</a> | Senior Software Engineer<br>
KDAB (Deutschland) GmbH, a KDAB Group company<br>
Tel: +49-30-521325470<br>
KDAB - The Qt, C++ and OpenGL Experts</blockquote></div><br clear=3D"all"><=
br>-- <br><div dir=3D"ltr" class=3D"m_-777251763788995089gmail_signature">J=
=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.effici=
os.com" target=3D"_blank">http://www.efficios.com</a></div></div>

--000000000000d5c87205861beb25--

--===============7839943455932463847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============7839943455932463847==--
