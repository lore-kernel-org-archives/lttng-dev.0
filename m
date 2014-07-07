From: Antoine Busque <antoine.busque@efficios.com>
Subject: Re: LTTng not generating trace contents
Date: Sun, 6 Jul 2014 20:14:08 -0400
Message-ID: <CA+MZcXs4P7hZRANttjS=tD-NUyUa-q=YC2g=bXvYdz3sY4nxnw__29802.2414128811$1404692097$gmane$org@mail.gmail.com>
References: <CAKQh6pi4+cbUi0p7P899aF3QvRs0nBMAEYsnFGaqzGn617r3Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1868541153=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <nintendopro@gmail.com>) id 1X3wZS-00034l-B1
 for lttng-dev@lists.lttng.org; Sun, 06 Jul 2014 20:14:18 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so4459532pab.3
 for <lttng-dev@lists.lttng.org>; Sun, 06 Jul 2014 17:14:08 -0700 (PDT)
In-Reply-To: <CAKQh6pi4+cbUi0p7P899aF3QvRs0nBMAEYsnFGaqzGn617r3Jw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shariyar <syed.shariyar@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1868541153==
Content-Type: multipart/alternative; boundary=047d7b15a8478e162504fd8f5a0c

--047d7b15a8478e162504fd8f5a0c
Content-Type: text/plain; charset=UTF-8

On Sun, Jul 6, 2014 at 6:49 PM, Shariyar <syed.shariyar@gmail.com> wrote:

> Hi,
>
> I am having a problem in generating a kernel trace using the latest LTTng
> on Ubuntu 12.04. It was working fine previously but when I updated LTTng it
> stopped generating the trace contents. I did an uninstall and reinstall but
> it didn't work either.
>
> In particular, I am able to create a session, list all kernel events,
> start a trace and stop a trace. My user is also in the tracing group.
> However, there are no contents in the trace files generated for every CPU
> in the system. Initially, the Babeltrace and the TMF both gave errors and
> when I explored the trace folder I found out that they are empty files.The
> metadata and index files do show some contents; however, nothing exists in
> the channelx_x files.
>
> What would be wrong? Please let me know.
>
> Regards,
> Shariyar
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
Hi,

The stable Ubuntu packages are currently in a not-so-stable state, so you
will probably want to use the packages from the PPA
<https://launchpad.net/~lttng/+archive/ppa>. Make sure to get the
whole toolchain there, and to cleanly uninstall the packages already
present on your machine to avoid any conflicts.

Regards,
Antoine Busque.

--047d7b15a8478e162504fd8f5a0c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>On Sun, Jul 6, 2014 at 6:49 PM, Shariyar <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:syed.shariyar@gmail.com" target=3D"_blank"=
>syed.shariyar@gmail.com</a>&gt;</span> wrote:<br></div></div><div class=3D=
"gmail_extra">
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></=
div>
<div>I am having a problem in generating a kernel trace using the latest LT=
Tng on Ubuntu 12.04. It was working fine previously but when I updated LTTn=
g it stopped generating the trace contents. I did an uninstall and reinstal=
l but it didn&#39;t work either.=C2=A0</div>

<div><br></div><div>In particular, I am able to create a session, list all =
kernel events, start a trace and stop a trace. My user is also in the traci=
ng group. However, there are no contents in the trace files generated for e=
very CPU in the system. Initially, the Babeltrace and the TMF both gave err=
ors and when I explored the trace folder I found out that they are empty fi=
les.The metadata and index files do show some contents; however, nothing ex=
ists in the channelx_x files.</div>

<div><br></div><div>What would be wrong? Please let me know.</div><div><br>=
</div><div>Regards,</div><div>Shariyar</div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div><div class=3D"gmail_extra"><div><div><div>=
Hi,</div><div><br></div><div>The stable Ubuntu packages are currently in a =
not-so-stable state, so you</div><div>will probably want to use the package=
s from the <a href=3D"https://launchpad.net/~lttng/+archive/ppa">PPA</a>. M=
ake sure to get the</div>
<div>whole toolchain there, and to cleanly uninstall the packages already</=
div><div>present on your machine to avoid any conflicts.</div><div><br></di=
v><div>Regards,</div><div>Antoine Busque.</div></div></div></div></div>

--047d7b15a8478e162504fd8f5a0c--


--===============1868541153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1868541153==--
