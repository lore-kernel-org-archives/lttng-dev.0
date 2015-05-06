From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [BUG] lttng-sessiond
Date: Wed, 6 May 2015 12:18:24 -0400
Message-ID: <CA+jJMxsjez3-++rViws03D9AJ0giH3wVLGVKiLaNPqXudRPVeg__5612.18567095256$1430929181$gmane$org@mail.gmail.com>
References: <3E06425C-5C41-4BF7-8156-A62C4E9B5E60@mailbox.tu-dresden.de>
 <1230298824.35208.1429817200877.JavaMail.zimbra@efficios.com>
 <1795330554.35257.1429820009277.JavaMail.zimbra@efficios.com>
 <DE838679-50E7-464E-B47B-934EF31813A9@mailbox.tu-dresden.de>
 <480136718.35882.1429900335415.JavaMail.zimbra@efficios.com>
 <9E6E6DE2-E219-4F79-9687-BE7A45910C34@mailbox.tu-dresden.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0213666935=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Yq21m-0000jc-9P
 for lttng-dev@lists.lttng.org; Wed, 06 May 2015 12:18:35 -0400
Received: by qgej70 with SMTP id j70so7147129qge.2
 for <lttng-dev@lists.lttng.org>; Wed, 06 May 2015 09:18:25 -0700 (PDT)
In-Reply-To: <9E6E6DE2-E219-4F79-9687-BE7A45910C34@mailbox.tu-dresden.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0213666935==
Content-Type: multipart/alternative; boundary=001a11c137ceffdb0405156c240f

--001a11c137ceffdb0405156c240f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Hannes,

Thanks for reporting this issue! Philippe has submitted two patches which
are now merged in both master and stable-2.6 [1][2].

Let us know if the problem persists,
J=C3=A9r=C3=A9mie

[1]
https://github.com/lttng/lttng-tools/commit/9ae17e21d5de3a709182f11eaba3ba1=
75ee0c432
[2]
https://github.com/lttng/lttng-tools/commit/44603c80f2e1ce55b6237a02810de8e=
7fc1687d4


On Sat, Apr 25, 2015 at 10:37 AM, Hannes Weisbach <
hannes.weisbach@mailbox.tu-dresden.de> wrote:

> >
> > Why do you need to load those explicitly ? They should be
> > already loaded by default. I don't get those errors here.
> > Which shell are you using (sh symlink) ? Can you reproduce
> > using bash ?
> Ok.  Found the bug.  In append_list_to_probes() index is used to get
> the current index into the probes array.  However in the loop, index
> is never incremented.  Therefore, the first entry of probes is
> overwritten, but nr_probes is incremented, and later those "empty"
> entries are referenced.
>
> There is also a memory leak in append_list_to_probes():
>
> tmp_list =3D strdup(list); // uses malloc()
> next =3D strtok(tmp_list, ","); // tmp_list needs to be NULL except in th=
e
> first iteration
> tmp_list =3D NULL; // so set it NULL
> free(tmp_list); // good intention, does not work.
>
> Best regards,
> Hannes
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a11c137ceffdb0405156c240f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Hannes,<div><br></div><div>Thanks for reporting this is=
sue! Philippe has submitted two patches which are now merged in both master=
 and stable-2.6 [1][2].</div><div><br></div><div>Let us know if the problem=
 persists,</div><div>J=C3=A9r=C3=A9mie</div><div><br></div><div><div>[1] <a=
 href=3D"https://github.com/lttng/lttng-tools/commit/9ae17e21d5de3a709182f1=
1eaba3ba175ee0c432">https://github.com/lttng/lttng-tools/commit/9ae17e21d5d=
e3a709182f11eaba3ba175ee0c432</a><br></div><div>[2] <a href=3D"https://gith=
ub.com/lttng/lttng-tools/commit/44603c80f2e1ce55b6237a02810de8e7fc1687d4">h=
ttps://github.com/lttng/lttng-tools/commit/44603c80f2e1ce55b6237a02810de8e7=
fc1687d4</a><br></div></div><div><br></div></div><div class=3D"gmail_extra"=
><br><div class=3D"gmail_quote">On Sat, Apr 25, 2015 at 10:37 AM, Hannes We=
isbach <span dir=3D"ltr">&lt;<a href=3D"mailto:hannes.weisbach@mailbox.tu-d=
resden.de" target=3D"_blank">hannes.weisbach@mailbox.tu-dresden.de</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt;<br>
&gt; Why do you need to load those explicitly ? They should be<br>
&gt; already loaded by default. I don&#39;t get those errors here.<br>
&gt; Which shell are you using (sh symlink) ? Can you reproduce<br>
&gt; using bash ?<br>
</span>Ok.=C2=A0 Found the bug.=C2=A0 In append_list_to_probes() index is u=
sed to get<br>
the current index into the probes array.=C2=A0 However in the loop, index<b=
r>
is never incremented.=C2=A0 Therefore, the first entry of probes is<br>
overwritten, but nr_probes is incremented, and later those &quot;empty&quot=
;<br>
entries are referenced.<br>
<br>
There is also a memory leak in append_list_to_probes():<br>
<br>
tmp_list =3D strdup(list); // uses malloc()<br>
next =3D strtok(tmp_list, &quot;,&quot;); // tmp_list needs to be NULL exce=
pt in the first iteration<br>
tmp_list =3D NULL; // so set it NULL<br>
free(tmp_list); // good intention, does not work.<br>
<br>
Best regards,<br>
Hannes<br>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a></div>
</div>

--001a11c137ceffdb0405156c240f--


--===============0213666935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0213666935==--
