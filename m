From: Aananth CN <c.n.aananth@gmail.com>
Subject: Re: LTTV build failure in ubuntu 12.04
Date: Wed, 4 Dec 2013 06:54:23 +0530
Message-ID: <CAFuHdY0yB6aS=p_7ieFoZ3biwYT3RQZ=w9N29tA0oQHXe1b+cA__11083.8422588587$1386120324$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267B25FA@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184570728=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <c.n.aananth@gmail.com>) id 1Vo1CY-0006bo-6q
	for lttng-dev@lists.lttng.org; Tue, 03 Dec 2013 20:24:34 -0500
Received: by mail-wg0-f48.google.com with SMTP id z12so14453712wgg.27
	for <lttng-dev@lists.lttng.org>; Tue, 03 Dec 2013 17:24:24 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267B25FA@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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

--===============0184570728==
Content-Type: multipart/alternative; boundary=047d7ba97f3af4db6504ecab45f5

--047d7ba97f3af4db6504ecab45f5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Daniel, Brosseau,

Here is the package/libs and their library versions.

babeltrace - 1.0.0-rc1
automake - NOT INSTALLED
gcc version - 4.6.3
libtool - NOT INSTALLED
libgtk2.0-dev - 2.24.10-0ubuntu6 (DOES NOT MEET >=3D 2.4)
libglib2.0-dev - 2.32.4-0ubuntu1
libpopt-dev - 1.16-3ubuntu1
libpango1.0-dev - 1.30.0-0ubuntu3.1
libc6-dev - 2.15-0ubuntu10.5


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Later I installed the following and re-built the lttv:

automake - 1.11.3
libtool - 2.4.2

Still the error persists. May be the libgtk2.0-dev not meeting the
dependency is causing this.

Thanks for your time.

Regards,
Aananth C N


On Tue, Dec 3, 2013 at 6:53 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> Date: Mon, 25 Nov 2013 22:22:01 +0530
> From: Aananth CN <c.n.aananth@gmail.com>
>
> > I could not find lttv (viewer) on ubuntu, hence I built from source. I
> get
> > following error. Could you please help me resolving this issue? (Am I
> > missing something, should I install any other packages?)
>
> lttv
>
> Depends: automake (>=3D 1.10), gcc (>=3D 3.2), libtool (>=3D 2.2), libgtk=
2.0-dev
> (>=3D 2.4), libglib2.0-dev (>=3D 2.16), libpopt-dev (>=3D 1.14), libpango=
1.0-dev
> (>=3D 1.20), libc6-dev (>=3D 2.4), babeltrace (>=3D 1.0.0)
>
> Suggests: libglpk-dev, default-jdk
>
> ./bootstrap 2>&1 | tee bootstrap.log
> LDFLAGS=3D-L/usr/local/lib ./configure 2>&1 | tee configure.log
> make 2>&1 | tee make.log
> make install 2>&1 | tee install.log
> ldconfig
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> R & D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defenc=
e R&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>



--=20
*Aananth C N*
Ph: 9444776690

=E0=AE=8E=E0=AE=AA=E0=AF=8D=E0=AE=AA=E0=AF=8A=E0=AE=B0=E0=AF=81=E0=AE=B3=E0=
=AF=8D =E0=AE=AF=E0=AE=BE=E0=AE=B0=E0=AF=8D =E0=AE=AF=E0=AE=BE=E0=AE=B0=E0=
=AF=8D =E0=AE=B5=E0=AE=BE=E0=AE=AF=E0=AF=8D =E0=AE=95=E0=AF=87=E0=AE=9F=E0=
=AF=8D=E0=AE=AA=E0=AE=BF=E0=AE=A9=E0=AF=81=E0=AE=AE=E0=AF=8D =E0=AE=85=E0=
=AE=AA=E0=AF=8D=E0=AE=AA=E0=AF=8A=E0=AE=B0=E0=AF=81=E0=AE=B3=E0=AF=8D

=E0=AE=AE=E0=AF=86=E0=AE=AF=E0=AF=8D=E0=AE=AA=E0=AF=8A=E0=AE=B0=E0=AF=81=E0=
=AE=B3=E0=AF=8D =E0=AE=95=E0=AE=BE=E0=AE=A3=E0=AF=8D=E0=AE=AA=E0=AE=A4=E0=
=AE=B1=E0=AE=BF=E0=AE=B5=E0=AF=81

--047d7ba97f3af4db6504ecab45f5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Daniel, Brosseau,</div><div><br></div><div>Here is=
 the package/libs and their library versions.</div><div><br></div><div><fon=
t face=3D"courier new, monospace">babeltrace <span class=3D"" style=3D"whit=
e-space:pre">	</span>- 1.0.0-rc1</font></div>
<div><font face=3D"courier new, monospace">automake <span class=3D"" style=
=3D"white-space:pre">	</span>- NOT INSTALLED</font></div><div><font face=3D=
"courier new, monospace">gcc version <span class=3D"" style=3D"white-space:=
pre">	</span>- 4.6.3</font></div>
<div><font face=3D"courier new, monospace">libtool <span class=3D"" style=
=3D"white-space:pre">	</span>- NOT INSTALLED</font></div><div><font face=3D=
"courier new, monospace">libgtk2.0-dev<span class=3D"" style=3D"white-space=
:pre">	</span>- 2.24.10-0ubuntu6 (DOES NOT MEET &gt;=3D 2.4)</font></div>
<div><font face=3D"courier new, monospace">libglib2.0-dev<span class=3D"" s=
tyle=3D"white-space:pre">	</span>- 2.32.4-0ubuntu1=C2=A0</font></div><div><=
font face=3D"courier new, monospace">libpopt-dev<span class=3D"" style=3D"w=
hite-space:pre">	</span>- 1.16-3ubuntu1</font></div>
<div><font face=3D"courier new, monospace">libpango1.0-dev - 1.30.0-0ubuntu=
3.1</font></div><div><font face=3D"courier new, monospace">libc6-dev<span c=
lass=3D"" style=3D"white-space:pre">	</span>- 2.15-0ubuntu10.5</font></div>=
<div>
<br></div><div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div>Later I installed the following and re-built the ltt=
v:</div><div><br></div><div>automake<span class=3D"" style=3D"white-space:p=
re">	</span>- 1.11.3</div><div>libtool<span class=3D"" style=3D"white-space=
:pre">		</span>- 2.4.2</div>
<div><br></div><div>Still the error persists. May be the libgtk2.0-dev not =
meeting the dependency is causing this.</div><div><br></div><div>Thanks for=
 your time.</div><div><br></div><div>Regards,</div><div>Aananth C N</div>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue,=
 Dec 3, 2013 at 6:53 PM, Thibault, Daniel <span dir=3D"ltr">&lt;<a href=3D"=
mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@d=
rdc-rddc.gc.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Date: Mon, 25 Nov 2013 22:22:01 +0530<br>
From: Aananth CN &lt;<a href=3D"mailto:c.n.aananth@gmail.com">c.n.aananth@g=
mail.com</a>&gt;<br>
<div class=3D"im"><br>
&gt; I could not find lttv (viewer) on ubuntu, hence I built from source. I=
 get<br>
&gt; following error. Could you please help me resolving this issue? (Am I<=
br>
&gt; missing something, should I install any other packages?)<br>
<br>
</div>lttv<br>
<br>
Depends: automake (&gt;=3D 1.10), gcc (&gt;=3D 3.2), libtool (&gt;=3D 2.2),=
 libgtk2.0-dev (&gt;=3D 2.4), libglib2.0-dev (&gt;=3D 2.16), libpopt-dev (&=
gt;=3D 1.14), libpango1.0-dev (&gt;=3D 1.20), libc6-dev (&gt;=3D 2.4), babe=
ltrace (&gt;=3D 1.0.0)<br>

<br>
Suggests: libglpk-dev, default-jdk<br>
<br>
./bootstrap 2&gt;&amp;1 | tee bootstrap.log<br>
LDFLAGS=3D-L/usr/local/lib ./configure 2&gt;&amp;1 | tee configure.log<br>
make 2&gt;&amp;1 | tee make.log<br>
make install 2&gt;&amp;1 | tee install.log<br>
ldconfig<br>
<br>
Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
R &amp; D pour la d=C3=A9fense Canada - Valcartier (RDDC Valcartier) | Defe=
nce R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC =C2=A0G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><u style=3D"=
color:rgb(0,0,153)"><b>Aananth C N</b></u><br><span style=3D"font-family:ta=
homa,sans-serif;color:rgb(102,102,102)">Ph: 9444776690</span><br><font styl=
e=3D"color:rgb(204,204,255)" size=3D"1"><b></b></font><p style=3D"margin:0p=
x">
</p><p><font color=3D"#000099"><span style=3D"font-size:9pt;font-family:&#3=
9;Arial Unicode MS&#39;,sans-serif">=E0=AE=8E=E0=AE=AA=E0=AF=8D=E0=AE=AA=E0=
=AF=8A=E0=AE=B0=E0=AF=81=E0=AE=B3=E0=AF=8D =E0=AE=AF=E0=AE=BE=E0=AE=B0=E0=
=AF=8D =E0=AE=AF=E0=AE=BE=E0=AE=B0=E0=AF=8D =E0=AE=B5=E0=AE=BE=E0=AE=AF=E0=
=AF=8D =E0=AE=95=E0=AF=87=E0=AE=9F=E0=AF=8D=E0=AE=AA=E0=AE=BF=E0=AE=A9=E0=
=AF=81=E0=AE=AE=E0=AF=8D =E0=AE=85=E0=AE=AA=E0=AF=8D=E0=AE=AA=E0=AF=8A=E0=
=AE=B0=E0=AF=81=E0=AE=B3=E0=AF=8D=C2=A0</span><span style=3D"font-size:9pt;=
font-family:Arial,sans-serif"></span></font></p>


<p><span style=3D"font-size:9pt;font-family:&#39;Arial Unicode MS&#39;,sans=
-serif"><font color=3D"#000099">=E0=AE=AE=E0=AF=86=E0=AE=AF=E0=AF=8D=E0=AE=
=AA=E0=AF=8A=E0=AE=B0=E0=AF=81=E0=AE=B3=E0=AF=8D
=E0=AE=95=E0=AE=BE=E0=AE=A3=E0=AF=8D=E0=AE=AA=E0=AE=A4=E0=AE=B1=E0=AE=BF=E0=
=AE=B5=E0=AF=81</font></span><span style=3D"font-size:9pt;font-family:&#39;=
Courier New&#39;"></span></p><p></p><pre><br></pre><span style=3D"font-fami=
ly:tahoma,sans-serif;color:rgb(102,102,102)"></span><br>
</div>

--047d7ba97f3af4db6504ecab45f5--


--===============0184570728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0184570728==--
