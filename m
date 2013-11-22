From: Willy Lambert <lambert.willy@gmail.com>
Subject: Re: Building LTTNG as a debian package
Date: Fri, 22 Nov 2013 13:28:54 +0100
Message-ID: <CAKvQZ_3PXVfaFxQN44fPMb=hkZiiNfvaNgNFHQ3ZxYttUBEJEg__11721.0687989884$1385123389$gmane$org@mail.gmail.com>
References: <CAKvQZ_3Kus-9FnXmn_qJtVux_U+U5nPUis2es_Ws0NeMXxWqpQ@mail.gmail.com>
	<528EA133.1090500@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0338091734=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lambert.willy@gmail.com>) id 1Vjpr2-0003c4-Ct
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 07:29:05 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so1908189ieb.36
	for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2013 04:28:54 -0800 (PST)
In-Reply-To: <528EA133.1090500@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0338091734==
Content-Type: multipart/alternative; boundary=089e0122f4f054079004ebc328cd

--089e0122f4f054079004ebc328cd
Content-Type: text/plain; charset=ISO-8859-1

2013/11/22 Alexandre Montplaisir <alexmonthy@voxpopuli.im>

> Hi,
>
> The packaging for distributions is usually managed by the distribution
> itself, not the upstream project.
>
>
Said that way it was obvious, don't know why I didn't think to look there :D


> For the official Debian packages, you can search on packages.debian.org
> for the package names, and from there you can download the
> *.debian.tar.gz for the packaging "recipe". Or follow the links to get
> to the git tree where it is stored. For example, for the lttng-modules
> package:
>
> http://anonscm.debian.org/gitweb/?p=collab-maint/lttng-modules.git;a=summary
>
> We also maintain a Ubuntu PPA which does automatic builds from git
> roughly every day. If you want to package a git snapshot, you may find
> those useful:
> https://code.launchpad.net/~lttng
> (under the *-packaging-daily branches)
>
>
Thanks for the links, I'll have a look.


>
> Cheers,
> Alexandre
>
>
> On 13-11-21 06:24 PM, Willy Lambert wrote:
> > Hi all,
> >
> > I have successfully build an embedded target with the LTTNG toolset and
> I'm
> > now trying to package this to be able to repopulate a target from
> scratch.
> >
> > I'm starting with the kernel modules and I did not succeed in building
> them
> > with make-kpkg modules_images.
> >
> > As I have seen you produce Debian packages for recent distributions, I
> > wonder if your packaging architecture is available somewhere (I had q
> quick
> > look on git but debian packaging infrastructure isn't present).
> >
> > Or maybe is there any documentation on this ?
> >
> > Regards.
> >
>

--089e0122f4f054079004ebc328cd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2013=
/11/22 Alexandre Montplaisir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmo=
nthy@voxpopuli.im" target=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span>=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
Hi,<br>
<br>
The packaging for distributions is usually managed by the distribution<br>
itself, not the upstream project.<br>
<br></blockquote><div><br></div><div>Said that way it was obvious, don&#39;=
t know why I didn&#39;t think to look there :D<br></div><div>=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">

For the official Debian packages, you can search on <a href=3D"http://packa=
ges.debian.org" target=3D"_blank">packages.debian.org</a><br>
for the package names, and from there you can download the<br>
*.debian.tar.gz for the packaging &quot;recipe&quot;. Or follow the links t=
o get<br>
to the git tree where it is stored. For example, for the lttng-modules<br>
package:<br>
<a href=3D"http://anonscm.debian.org/gitweb/?p=3Dcollab-maint/lttng-modules=
.git;a=3Dsummary" target=3D"_blank">http://anonscm.debian.org/gitweb/?p=3Dc=
ollab-maint/lttng-modules.git;a=3Dsummary</a><br>
<br>
We also maintain a Ubuntu PPA which does automatic builds from git<br>
roughly every day. If you want to package a git snapshot, you may find<br>
those useful:<br>
<a href=3D"https://code.launchpad.net/%7Elttng" target=3D"_blank">https://c=
ode.launchpad.net/~lttng</a><br>
(under the *-packaging-daily branches)<br>
<br></blockquote><div><br></div><div>Thanks for the links, I&#39;ll have a =
look.<br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">

<br>
Cheers,<br>
Alexandre<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On 13-11-21 06:24 PM, Willy Lambert wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I have successfully build an embedded target with the LTTNG toolset an=
d I&#39;m<br>
&gt; now trying to package this to be able to repopulate a target from scra=
tch.<br>
&gt;<br>
&gt; I&#39;m starting with the kernel modules and I did not succeed in buil=
ding them<br>
&gt; with make-kpkg modules_images.<br>
&gt;<br>
&gt; As I have seen you produce Debian packages for recent distributions, I=
<br>
&gt; wonder if your packaging architecture is available somewhere (I had q =
quick<br>
&gt; look on git but debian packaging infrastructure isn&#39;t present).<br=
>
&gt;<br>
&gt; Or maybe is there any documentation on this ?<br>
&gt;<br>
&gt; Regards.<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--089e0122f4f054079004ebc328cd--


--===============0338091734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0338091734==--
