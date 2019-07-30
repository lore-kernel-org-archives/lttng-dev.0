From: =?UTF-8?Q?Christophe_B=C3=A9dard?= <bedard.christophe@gmail.com>
Subject: Re: gcc plugin for instrumenting individual functions
Date: Tue, 30 Jul 2019 16:05:15 +0200
Message-ID: <CAAS9doY5DNPWY6KBsv6sBxaaN8u+1MDw7HGJrGiN9cvLWOx45A__25184.5215958141$1564495565$gmane$org@mail.gmail.com>
References: <CAAS9doaz=dF_42vWaKO9mnRgua8hTNrgx+aHQZ0j9XTAhy0vmw@mail.gmail.com>
 <20190729192259.GA28213@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5629095666522041138=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 by lists.lttng.org (Postfix) with ESMTPS id 45ydcw4fyPz1JD1
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2019 10:05:52 -0400 (EDT)
Received: by mail-io1-xd32.google.com with SMTP id q22so8525153iog.4
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2019 07:05:52 -0700 (PDT)
In-Reply-To: <20190729192259.GA28213@joraj-alpa>
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

--===============5629095666522041138==
Content-Type: multipart/alternative; boundary="0000000000009d58aa058ee681d1"

--0000000000009d58aa058ee681d1
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 29 Jul 2019 at 21:23, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> For those at home wondering why this would be relevant to lttng,
> lttng-ust comes with a utility shared object allowing you to leverage the
> -finstrument-function sites to hook lttng tracepoints [1].
>
> [1] https://lttng.org/man/3/lttng-ust-cyg-profile/v2.10/
>
>
Thank you for providing some context!


> Thanks Christophe for this contribution.
>
> Do you know why GCC does not support this out of the box?
>

I'm not sure. I looked at the the relevant parts of the gcc codebase, and
came to the conclusion that it just wasn't written with this feature in
mind (which is why the plugin uses a sort of workaround).

Is this something that
> could be presented to the GCC community?


If people think it should be presented!


Christophe

--0000000000009d58aa058ee681d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>On Mon, 29 Jul 201=
9 at 21:23, Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-=
julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com=
</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi,<br>
<br>
For those at home wondering why this would be relevant to lttng,<br>
lttng-ust comes with a utility shared object allowing you to leverage the<b=
r>
-finstrument-function sites to hook lttng tracepoints [1].<br>
<br>
[1] <a href=3D"https://lttng.org/man/3/lttng-ust-cyg-profile/v2.10/" rel=3D=
"noreferrer" target=3D"_blank">https://lttng.org/man/3/lttng-ust-cyg-profil=
e/v2.10/</a><br>
<br></blockquote><div><br></div><div>Thank you for providing some context!<=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
Thanks Christophe for this contribution.<br>
<br>
Do you know why GCC does not support this out of the box?<br></blockquote><=
div>=C2=A0</div><div>I&#39;m not sure. I looked at the the relevant parts o=
f the gcc codebase, and came to the conclusion that it just wasn&#39;t writ=
ten with this feature in mind (which is why the plugin uses a sort of worka=
round).</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Is this something that<br>could be presented to the GCC community?</bloc=
kquote><div><br></div><div>If people think it should be presented!</div><di=
v><br></div><div><br></div><div>Christophe</div></div></div>

--0000000000009d58aa058ee681d1--

--===============5629095666522041138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5629095666522041138==--
