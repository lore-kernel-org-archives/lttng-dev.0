From: Zvi Vered <veredz72@gmail.com>
Subject: Re: lttng-tools-2.10.6: Spawning consumerd failed
Date: Wed, 15 May 2019 16:42:57 +0300
Message-ID: <CABRndgxNtLbXZ0peWNm7qq_kxT4fY_PspgJ6hR=H82r3o8Nhmw__19239.3227176339$1557928039$gmane$org@mail.gmail.com>
References: <CABRndgyrxUfZqtcu=4Y7U8rvjpBa=0AqcDCkvU3UMxixRfQCoQ@mail.gmail.com>
 <20190514142948.GA10361@joraj-alpa> <20190514180433.GB10361@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3166532203717807239=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw1-xc2f.google.com (mail-yw1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by lists.lttng.org (Postfix) with ESMTPS id 453wpF18yhz11P8
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 09:47:00 -0400 (EDT)
Received: by mail-yw1-xc2f.google.com with SMTP id w18so1125561ywa.12
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 06:47:00 -0700 (PDT)
In-Reply-To: <20190514180433.GB10361@joraj-alpa>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3166532203717807239==
Content-Type: multipart/alternative; boundary="00000000000038d3e70588ed627c"

--00000000000038d3e70588ed627c
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

I'm not using buildroot nor Yokto.
In order to build lttng-tools I ran:
./configure --prefix=/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs
make
make install

This path contains a complete root file system (based on busybox) that is
later copied to my target.

On the target I ran:
lttng-sessiond -vvv --verbose-consumer
and got:
....
I/O warning : failed to load external entity
"/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/share/xml/lttng/session.xsd"
XML Error: Failed to locate the main schema resource at
'/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/share/xml/lttng/session.xsd'.
Error: XSD parsing failed
Error: Session load failed: Invalid session configuration
DEBUG1 - 00:10:36.746330272 [1476/1618]: Accepting client command ... (in
thread_manage_clients() at main.c:4374)

Then I ran:
lttng create my-kernel-session
and got:
....
DEBUG3 - 00:11:41.869875832 [1628/1628]: Looking for a kernel consumer at
these locations: (in spawn_consumerd() at main.c:2429)
DEBUG3 - 00:11:41.869901726 [1628/1628]:        1) NULL (in
spawn_consumerd() at main.c:2430)
DEBUG3 - 00:11:41.869908520 [1628/1628]:        2)
/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec/lttng-consumerd
(in spawn_consumerd() at main.c:2431)
DEBUG3 - 00:11:41.869915959 [1628/1628]:        3)
/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec/lttng-consumerd
(in spawn_consumerd() at main.c:2432)
DEBUG1 - 00:11:41.869971468 [1628/1628]: Could not find any valid consumerd
executable (in spawn_consumerd() at main.c:2444)
Error: Spawning consumerd failed

I double checked: The target has /lib/lttng-libexec/lttng-consumerd
But it looks for it in:
 /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttng/libexec ]

What is missing in my configuration ?

Thank you,
Zvika

On Tue, May 14, 2019 at 9:04 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> >
> > >
> > >
> > > I'm running under a 32 bit (x86) vanilla, 4.9.20 kernel with busybox
> > > with the following lttng versions:
>
> I took some time to at least test on a 32 bit system (buildroot) just in
> case
> and everything seems to be working fine on a base installation.
>
> The log from lttng-sessiond should provides more information on why we
> fail to
> spawn the consumerd (wrong path, etc.).
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--00000000000038d3e70588ed627c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr">Hi Jonathan,<div><br></div><div>I&#39;m not using buildroot nor Y=
okto.</div><div>In order to build lttng-tools I ran:</div><div>./configure =
--prefix=3D/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs</div><div>m=
ake</div><div>make install</div><div><br></div><div>This path contains a co=
mplete root file system (based on busybox) that is later copied to my targe=
t.=C2=A0</div><div><br></div><div>On the target I ran:</div><div>lttng-sess=
iond -vvv --verbose-consumer=C2=A0</div><div>and got:</div><div>....</div><=
div><div>I/O warning : failed to load external entity &quot;/64_sw/git/zvi_=
vered/MY_PROJ/linux4.9.20/boot/rootfs/share/xml/lttng/session.xsd&quot;</di=
v><div>XML Error: Failed to locate the main schema resource at &#39;/64_sw/=
git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/share/xml/lttng/session.xsd&#=
39;.</div><div>Error: XSD parsing failed</div><div>Error: Session load fail=
ed: Invalid session configuration</div><div>DEBUG1 - 00:10:36.746330272 [14=
76/1618]: Accepting client command ... (in thread_manage_clients() at main.=
c:4374)</div></div><div><br></div><div>Then I ran:</div><div>lttng create m=
y-kernel-session<br></div><div>and got:</div><div>....</div><div><div>DEBUG=
3 - 00:11:41.869875832 [1628/1628]: Looking for a kernel consumer at these =
locations: (in spawn_consumerd() at main.c:2429)</div><div>DEBUG3 - 00:11:4=
1.869901726 [1628/1628]:=C2=A0 =C2=A0 =C2=A0 =C2=A0 1) NULL (in spawn_consu=
merd() at main.c:2430)</div><div>DEBUG3 - 00:11:41.869908520 [1628/1628]:=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 2) /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boo=
t/rootfs/lib/lttng/libexec/lttng-consumerd (in spawn_consumerd() at main.c:=
2431)</div><div>DEBUG3 - 00:11:41.869915959 [1628/1628]:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 3) /64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/lib/lttn=
g/libexec/lttng-consumerd (in spawn_consumerd() at main.c:2432)</div><div>D=
EBUG1 - 00:11:41.869971468 [1628/1628]: Could not find any valid consumerd =
executable (in spawn_consumerd() at main.c:2444)</div><div>Error: Spawning =
consumerd failed</div></div><div><br></div><div>I double checked: The targe=
t has /lib/lttng-libexec/lttng-consumerd=C2=A0</div><div>But it looks for i=
t in:</div><div>=C2=A0/64_sw/git/zvi_vered/MY_PROJ/linux4.9.20/boot/rootfs/=
lib/lttng/libexec=C2=A0]</div><div><br></div><div>What is missing in my con=
figuration ?</div><div><br></div><div>Thank you,</div><div>Zvika=C2=A0=C2=
=A0<br></div></div></div></div></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 14, 2019 at 9:04 PM Jonath=
an Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@efficios.co=
m">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">&gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; I&#39;m running under a 32 bit (x86) vanilla, 4.9.20 kernel with =
busybox<br>
&gt; &gt; with the following lttng versions:<br>
<br>
I took some time to at least test on a 32 bit system (buildroot) just in ca=
se<br>
and everything seems to be working fine on a base installation.<br>
<br>
The log from lttng-sessiond should provides more information on why we fail=
 to<br>
spawn the consumerd (wrong path, etc.).<br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--00000000000038d3e70588ed627c--

--===============3166532203717807239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3166532203717807239==--
