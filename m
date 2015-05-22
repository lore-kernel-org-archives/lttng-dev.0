From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH] Fix: multiple definition error with gcc 5.1
Date: Fri, 22 May 2015 15:38:54 -0400
Message-ID: <CA+jJMxvb-gLSGMuLTy3M62K+azs53VqcdPytDUALL=FwM1FTwQ__21972.1143054359$1432323630$gmane$org@mail.gmail.com>
References: <1430170305-26566-1-git-send-email-zifeitong@gmail.com>
 <CAJ7wx-Eze7hKh3ZTcxDTREois10BjoQ_118W2W8k4vUQd0bOSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1105346822=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1Yvsma-00077b-CJ
 for lttng-dev@lists.lttng.org; Fri, 22 May 2015 15:39:09 -0400
Received: by qkgv12 with SMTP id v12so20160785qkg.0
 for <lttng-dev@lists.lttng.org>; Fri, 22 May 2015 12:38:54 -0700 (PDT)
In-Reply-To: <CAJ7wx-Eze7hKh3ZTcxDTREois10BjoQ_118W2W8k4vUQd0bOSg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <zifeitong@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1105346822==
Content-Type: multipart/alternative; boundary=001a114339527ec38b0516b0cf1c

--001a114339527ec38b0516b0cf1c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Zifei,

It seems I had missed the patch you had sent with this e-mail. I did end up
having the same issue today as I upgraded to gcc 5.1.

My fix is a combination of what was reported on the open embedded mailing
list (marking the mi and config declarations as extern) and removing what
was left of the function:entry feature.

commit 96ffaa0c61089296dd5c9dd07810f32f97931fc8
Author: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Fri May 22 12:55:57 2015 -0400

    Clean-up: Remove ifdef-ed out function:entry feature

    Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.=
com>

commit 4965f956f3ef47388fb4a1b2f8f504abfe31afe7
Author: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
Date:   Fri May 22 12:53:30 2015 -0400

    Fix: Mark MI and Config string declarations as extern

    This fixes a build issue with GCC 5.1 which would complain about
    these symbols being defined multiple times.

    Signed-off-by: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.=
com>

Thanks a lot and sorry for the delay!
J=C3=A9r=C3=A9mie

On Mon, Apr 27, 2015 at 5:39 PM, Zifei Tong <zifeitong@gmail.com> wrote:

> I created a minimal reproducer [1] for the UB if you are interested.
>
> [1]: https://gist.github.com/5kg/7304cf74bc0fe13a9f70
>
> Thanks,
> Zifei Tong
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a114339527ec38b0516b0cf1c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Zifei,<div><br></div><div>It seems I had missed the pat=
ch you had sent with this e-mail. I did end up having the same issue today =
as I upgraded to gcc 5.1.</div><div><br></div><div>My fix is a combination =
of what was reported on the open embedded mailing list (marking the mi and =
config declarations as extern) and removing what was left of the function:e=
ntry feature.</div><div><br></div><div><div>commit 96ffaa0c61089296dd5c9dd0=
7810f32f97931fc8</div><div>Author: J=C3=A9r=C3=A9mie Galarneau &lt;<a href=
=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarneau@efficios.com</=
a>&gt;</div><div>Date: =C2=A0 Fri May 22 12:55:57 2015 -0400</div><div><br>=
</div><div>=C2=A0 =C2=A0 Clean-up: Remove ifdef-ed out function:entry featu=
re</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 Signed-off-by: J=
=C3=A9r=C3=A9mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios=
.com">jeremie.galarneau@efficios.com</a>&gt;</div><div><br></div><div>commi=
t 4965f956f3ef47388fb4a1b2f8f504abfe31afe7</div><div>Author: J=C3=A9r=C3=A9=
mie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie=
.galarneau@efficios.com</a>&gt;</div><div>Date: =C2=A0 Fri May 22 12:53:30 =
2015 -0400</div><div><br></div><div>=C2=A0 =C2=A0 Fix: Mark MI and Config s=
tring declarations as extern</div><div>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0=
 =C2=A0 This fixes a build issue with GCC 5.1 which would complain about</d=
iv><div>=C2=A0 =C2=A0 these symbols being defined multiple times.</div><div=
>=C2=A0 =C2=A0=C2=A0</div><div>=C2=A0 =C2=A0 Signed-off-by: J=C3=A9r=C3=A9m=
ie Galarneau &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.=
galarneau@efficios.com</a>&gt;</div></div><div><br></div><div>Thanks a lot =
and sorry for the delay!</div><div>J=C3=A9r=C3=A9mie</div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Apr 27, 2015 at 5:3=
9 PM, Zifei Tong <span dir=3D"ltr">&lt;<a href=3D"mailto:zifeitong@gmail.co=
m" target=3D"_blank">zifeitong@gmail.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">I created a minimal reproducer [1] for the UB if you =
are interested.<br>
<br>
[1]: <a href=3D"https://gist.github.com/5kg/7304cf74bc0fe13a9f70" target=3D=
"_blank">https://gist.github.com/5kg/7304cf74bc0fe13a9f70</a><br>
<br>
Thanks,<br>
Zifei Tong<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hre=
f=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a>=
</div>
</div>

--001a114339527ec38b0516b0cf1c--


--===============1105346822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1105346822==--
