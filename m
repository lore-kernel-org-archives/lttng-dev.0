From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: LTTng not generating trace contents
Date: Mon, 7 Jul 2014 13:43:12 -0400
Message-ID: <CAKQh6pjJ9SUFKtLwONVySiPbtP-udZCfs9L87mGszPVPCu2PKA__37706.8131500438$1404755062$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C729D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0482179625=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <syed.shariyar@gmail.com>) id 1X4Cwg-0000kB-G2
 for lttng-dev@lists.lttng.org; Mon, 07 Jul 2014 13:43:24 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so5813900pab.34
 for <lttng-dev@lists.lttng.org>; Mon, 07 Jul 2014 10:43:12 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359C729D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0482179625==
Content-Type: multipart/alternative; boundary=001a1136048c56f8cd04fd9e02b5

--001a1136048c56f8cd04fd9e02b5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 lttng --version,
    lttng (LTTng Trace Control) 2.4.1 - =C3=89poque Opaque

 lttng-sessiond --version
    2.4.1


I removed all LTTng packages from the system by manually searching in dpkg
and reinstalled it as follows:
sudo apt-get install lttng-tools lttng-modules-dkms babeltrace

The ppa in the system is: http://ppa.launchpad.net/lttng/ppa/ubuntu

Now, I get the following error:
sudo lttng list -k
Error: Unable to list kernel events: Kernel tracer not available
Error: Command error

I have encountered this problem on two different systems running Ubuntu
12.04, after the update of system and LTTng

Regards,
Shariyar


On Mon, Jul 7, 2014 at 11:42 AM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> ----------------------------------------------------------------------
> Date: Sun, 6 Jul 2014 18:49:51 -0400
> From: Shariyar <syed.shariyar@gmail.com>
>
> > I am having a problem in generating a kernel trace using the latest
> LTTng on Ubuntu 12.04.
> > It was working fine previously but when I updated LTTng it stopped
> generating the trace contents. I did an uninstall and reinstall but it
> didn't work either.
> ----------------------------------------------------------------------
>
>    Please define what you mean by "the latest LTTng".  What are the
> versions?  ($ lttng --version, $ lttng-sessiond --version)
>
> Daniel U. Thibault
> Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection =
&
> Countermeasures (SPC)
> Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission C=
ritical
> Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research
> Centre
> 2459 route de la Bravoure
> Qu=C3=A9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--001a1136048c56f8cd04fd9e02b5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"font-family:arial,sans-serif;font-size=
:13px">=C2=A0lttng --version,</span><br></div><div>=C2=A0 =C2=A0 lttng (LTT=
ng Trace Control) 2.4.1 - =C3=89poque Opaque</div><div><br></div><div><span=
 style=3D"font-family:arial,sans-serif;font-size:13px">=C2=A0lttng-sessiond=
 --version</span><br>

</div><div><span style=3D"font-family:arial,sans-serif;font-size:13px">=C2=
=A0 =C2=A0 2.4.1</span></div><div><span style=3D"font-family:arial,sans-ser=
if;font-size:13px"><br></span></div><div><span style=3D"font-family:arial,s=
ans-serif;font-size:13px"><br>

</span></div><div><span style=3D"font-family:arial,sans-serif;font-size:13p=
x">I removed all LTTng packages from the system by manually searching in dp=
kg and reinstalled it as follows:</span></div><div><span style=3D"color:rgb=
(51,51,51);font-family:monospace;font-size:12px;line-height:18px">sudo apt-=
get install lttng-tools lttng-modules-dkms babeltrace</span><span style=3D"=
font-family:arial,sans-serif;font-size:13px"><br>

</span></div><div><span style=3D"color:rgb(51,51,51);font-family:monospace;=
font-size:12px;line-height:18px"><br></span></div><div><span style=3D"color=
:rgb(51,51,51);font-family:monospace;font-size:12px;line-height:18px">The p=
pa in the system is:=C2=A0</span><font color=3D"#333333" face=3D"monospace"=
><span style=3D"font-size:12px;line-height:18px"><a href=3D"http://ppa.laun=
chpad.net/lttng/ppa/ubuntu" target=3D"_blank">http://ppa.launchpad.net/lttn=
g/ppa/ubuntu</a></span></font></div>

<div><font color=3D"#333333" face=3D"monospace"><span style=3D"font-size:12=
px;line-height:18px"><br></span></font></div><div><font color=3D"#333333" f=
ace=3D"monospace"><span style=3D"font-size:12px;line-height:18px">Now, I ge=
t the following error:</span></font></div>
<div><font color=3D"#333333" face=3D"monospace"><div style><span style=3D"l=
ine-height:18px">sudo lttng list -k</span></div><div style><span style=3D"l=
ine-height:18px">Error: Unable to list kernel events: Kernel tracer not ava=
ilable</span></div>
<div style><span style=3D"line-height:18px">Error: Command error</span></di=
v><div style=3D"font-size:12px;line-height:18px"><br></div></font></div>
<div><font color=3D"#333333" face=3D"monospace"><span style=3D"font-size:12=
px;line-height:18px">I have encountered this problem on two different syste=
ms running Ubuntu 12.04, after the update of system and LTTng</span></font>=
</div>
<div><font color=3D"#333333" face=3D"monospace"><span style=3D"font-size:12=
px;line-height:18px"><br></span></font></div><div><font color=3D"#333333" f=
ace=3D"monospace"><span style=3D"font-size:12px;line-height:18px">Regards,<=
/span></font></div>
<div><font color=3D"#333333" face=3D"monospace"><span style=3D"font-size:12=
px;line-height:18px">Shariyar</span></font></div></div><div class=3D"gmail_=
extra"><br><br><div class=3D"gmail_quote">On Mon, Jul 7, 2014 at 11:42 AM, =
Thibault, Daniel <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibault@dr=
dc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt;</s=
pan> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">--------------------------------------------=
--------------------------<br>
Date: Sun, 6 Jul 2014 18:49:51 -0400<br>
From: Shariyar &lt;<a href=3D"mailto:syed.shariyar@gmail.com">syed.shariyar=
@gmail.com</a>&gt;<br>
<div class=3D""><br>
&gt; I am having a problem in generating a kernel trace using the latest LT=
Tng on Ubuntu 12.04.<br>
&gt; It was working fine previously but when I updated LTTng it stopped gen=
erating the trace contents. I did an uninstall and reinstall but it didn&#3=
9;t work either.<br>
</div>---------------------------------------------------------------------=
-<br>
<br>
=C2=A0 =C2=A0Please define what you mean by &quot;the latest LTTng&quot;. =
=C2=A0What are the versions? =C2=A0($ lttng --version, $ lttng-sessiond --v=
ersion)<br>
<br>
Daniel U. Thibault<br>
Protection des syst=C3=A8mes et contremesures (PSC) | Systems Protection &a=
mp; Countermeasures (SPC)<br>
Cyber s=C3=A9curit=C3=A9 pour les missions essentielles (CME) | Mission Cri=
tical Cyber Security (MCCS)<br>
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re<br>
2459 route de la Bravoure<br>
Qu=C3=A9bec QC =C2=A0G3J 1X5<br>
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

--001a1136048c56f8cd04fd9e02b5--


--===============0482179625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0482179625==--
