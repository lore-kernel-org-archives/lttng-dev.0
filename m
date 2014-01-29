From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: liblttng-ust-cyg-profile.so not found
Date: Wed, 29 Jan 2014 13:17:24 -0500
Message-ID: <CAKQh6pjvC6t1b4jJBCfQ1bfEo3+-Tm5W-QLUHWQnBZK2NqELhw__19462.5333803289$1391019511$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267DD6EB@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2040293575=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1W8Zha-0007go-IL
	for lttng-dev@lists.lttng.org; Wed, 29 Jan 2014 13:17:36 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so2069367pbc.30
	for <lttng-dev@lists.lttng.org>; Wed, 29 Jan 2014 10:17:24 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267DD6EB@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2040293575==
Content-Type: multipart/alternative; boundary=047d7b678314e0709304f11ff333

--047d7b678314e0709304f11ff333
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Download and install the following UST packages but first remove the
already installed versions. For other LTTng packages, you can   reinstall
from your previous repository or from here.

http://packages.debian.org/sid/liblttng-ust-ctl2
http://packages.debian.org/sid/liblttng-ust0
http://packages.debian.org/unstable/liblttng-ust-dev


On Wed, Jan 29, 2014 at 9:26 AM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> ----------------------------------------------------------------------
> Date: Tue, 28 Jan 2014 11:37:20 -0500
> From: Shariyar <syed.shariyar@gmail.com>
>
> > I am trying to collect function entry and exit points in a trace. I
>  have followed the instructions written on the following man page:
> >
> http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-profile.3.h=
tml
> .
> >
> > In my system, UST tracepoint tracing  is working fine and I am able to
> collect traces with the statically typed tracepoints in the code.
> > However, there is no liblttng-ust-cyg-profile.so in my system and I get
> an error when I execute the following:
> >
> >      *LD_PRELOAD=3Dliblttng-ust-cyg-profile.so* appname
> ------------------------------
> Date: Tue, 28 Jan 2014 12:29:43 -0500
> From: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
>
> > Check if the liblttng-ust-cyg-profile.so is present in system using
> 'locate'. On my system its in /usr/lib64
> > Then give the absolute path -
> >*LD_PRELOAD=3D/usr/lib64/liblttng-ust-cyg-profile.so* appname
> ------------------------------
> Date: Tue, 28 Jan 2014 12:32:14 -0500
> From: Shariyar <syed.shariyar@gmail.com>
>
> > It is not present in the system even after reinstalling ust libs from
> PPA.
> > I am working on Ubuntu 12.04.1 LTS, 64 bit.
> ------------------------------
> Date: Tue, 28 Jan 2014 12:45:34 -0500
> From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
>
> > On Ubuntu/Debian, there is no "lib64", it's /usr/lib/x86_64-linux-gnu/
> >
> > If you installed UST from the distro package, it should be at:
> > /usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so.0
> >
> > (the .so symlink is only installed by the -dev package)
> >
> > If you installed from source, it would be at:
> > /usr/local/lib/liblttng-ust-cyg-profile.so
> >
> > Quick tip: you can use:
> > dpkg -L liblttng-ust0
> > to list the files installed by a package.
> ------------------------------
> Date: Tue, 28 Jan 2014 16:19:09 -0500
> From: Shariyar <syed.shariyar@gmail.com>
>
> > dpkg -L liblttng-ust0 gives the following; i.e., no
> liblttng-ust-cyg-profile.so
> >
> > /usr/share/man/man3/lttng-ust-cyg-profile.3.gz
>
>    Which package did you install, and whence came it?
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--047d7b678314e0709304f11ff333
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Download and install the following UST packages but first =
remove the already installed versions. For other LTTng packages, you can=A0=
=A0 reinstall=A0 from your previous repository or from here.<br>
<br>
<a href=3D"http://packages.debian.org/sid/liblttng-ust-ctl2">http://package=
s.debian.org/sid/liblttng-ust-ctl2</a><br>
<a href=3D"http://packages.debian.org/sid/liblttng-ust0">http://packages.de=
bian.org/sid/liblttng-ust0</a><br><a href=3D"http://packages.debian.org/uns=
table/liblttng-ust-dev">http://packages.debian.org/unstable/liblttng-ust-de=
v</a><br>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed,=
 Jan 29, 2014 at 9:26 AM, Thibault, Daniel <span dir=3D"ltr">&lt;<a href=3D=
"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@=
drdc-rddc.gc.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">--------------------------------------------=
--------------------------<br>
Date: Tue, 28 Jan 2014 11:37:20 -0500<br>
From: Shariyar &lt;<a href=3D"mailto:syed.shariyar@gmail.com">syed.shariyar=
@gmail.com</a>&gt;<br>
<div class=3D"im"><br>
&gt; I am trying to collect function entry and exit points in a trace. I =
=A0have followed the instructions written on the following man page:<br>
&gt; <a href=3D"http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-c=
yg-profile.3.html" target=3D"_blank">http://manpages.ubuntu.com/manpages/tr=
usty/man3/lttng-ust-cyg-profile.3.html</a>.<br>
&gt;<br>
&gt; In my system, UST tracepoint tracing =A0is working fine and I am able =
to collect traces with the statically typed tracepoints in the code.<br>
&gt; However, there is no liblttng-ust-cyg-profile.so in my system and I ge=
t an error when I execute the following:<br>
&gt;<br>
&gt; =A0 =A0 =A0*LD_PRELOAD=3Dliblttng-ust-cyg-profile.so* appname<br>
</div>------------------------------<br>
Date: Tue, 28 Jan 2014 12:29:43 -0500<br>
From: Suchakrapani Datt Sharma &lt;<a href=3D"mailto:suchakrapani.sharma@po=
lymtl.ca">suchakrapani.sharma@polymtl.ca</a>&gt;<br>
<div class=3D"im"><br>
&gt; Check if the liblttng-ust-cyg-profile.so is present in system using &#=
39;locate&#39;. On my system its in /usr/lib64<br>
&gt; Then give the absolute path -<br>
&gt;*LD_PRELOAD=3D/usr/lib64/liblttng-ust-cyg-profile.so* appname<br>
</div>------------------------------<br>
Date: Tue, 28 Jan 2014 12:32:14 -0500<br>
From: Shariyar &lt;<a href=3D"mailto:syed.shariyar@gmail.com">syed.shariyar=
@gmail.com</a>&gt;<br>
<div class=3D"im"><br>
&gt; It is not present in the system even after reinstalling ust libs from =
PPA.<br>
&gt; I am working on Ubuntu 12.04.1 LTS, 64 bit.<br>
</div>------------------------------<br>
Date: Tue, 28 Jan 2014 12:45:34 -0500<br>
From: Alexandre Montplaisir &lt;<a href=3D"mailto:alexmonthy@voxpopuli.im">=
alexmonthy@voxpopuli.im</a>&gt;<br>
<div class=3D"im"><br>
&gt; On Ubuntu/Debian, there is no &quot;lib64&quot;, it&#39;s /usr/lib/x86=
_64-linux-gnu/<br>
&gt;<br>
&gt; If you installed UST from the distro package, it should be at:<br>
&gt; /usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so.0<br>
&gt;<br>
&gt; (the .so symlink is only installed by the -dev package)<br>
&gt;<br>
&gt; If you installed from source, it would be at:<br>
&gt; /usr/local/lib/liblttng-ust-cyg-profile.so<br>
&gt;<br>
&gt; Quick tip: you can use:<br>
&gt; dpkg -L liblttng-ust0<br>
&gt; to list the files installed by a package.<br>
</div>------------------------------<br>
Date: Tue, 28 Jan 2014 16:19:09 -0500<br>
From: Shariyar &lt;<a href=3D"mailto:syed.shariyar@gmail.com">syed.shariyar=
@gmail.com</a>&gt;<br>
<div class=3D"im"><br>
&gt; dpkg -L liblttng-ust0 gives the following; i.e., no liblttng-ust-cyg-p=
rofile.so<br>
&gt;<br>
</div>&gt; /usr/share/man/man3/lttng-ust-cyg-profile.3.gz<br>
<br>
=A0 =A0Which package did you install, and whence came it?<br>
<br>
Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC =A0G3J 1X5<br>
CANADA<br>
Vox : <a href=3D"tel:%28418%29%20844-4000%20x4245" value=3D"+14188444000">(=
418) 844-4000 x4245</a><br>
Fax : <a href=3D"tel:%28418%29%20844-4538" value=3D"+14188444538">(418) 844=
-4538</a><br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br></div>

--047d7b678314e0709304f11ff333--


--===============2040293575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2040293575==--
