From: Aananth CN <c.n.aananth@gmail.com>
Subject: LTTV build failure in ubuntu 12.04
Date: Mon, 25 Nov 2013 22:22:01 +0530
Message-ID: <CAFuHdY2g+6ezgRWyFPY_iPm87DTgVT-6OD4KZiQnBVThxBSBhg__7886.26631624556$1386054895$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1681265141=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <c.n.aananth@gmail.com>) id 1VkzOK-0006lN-OQ
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 11:52:14 -0500
Received: by mail-wg0-f48.google.com with SMTP id z12so4116532wgg.15
	for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2013 08:52:02 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1681265141==
Content-Type: multipart/alternative; boundary=f46d043892b1d6e89404ec032ebc

--f46d043892b1d6e89404ec032ebc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I could not find lttv (viewer) on ubuntu, hence I built from source. I get
following error. Could you please help me resolving this issue? (Am I
missing something, should I install any other packages?)

make  all-recursive
make[1]: Entering directory `/home/caananth/Downloads/lttv-1.5'
Making all in lttv
make[2]: Entering directory `/home/caananth/Downloads/lttv-1.5/lttv'
Making all in lttv
make[3]: Entering directory `/home/caananth/Downloads/lttv-1.5/lttv/lttv'
  CC       state.o
state.c: In function =E2=80=98restore_init_state=E2=80=99:
state.c:413:25: error: =E2=80=98BT_CLOCK_REAL=E2=80=99 undeclared (first us=
e in this
function)
state.c:413:25: note: each undeclared identifier is reported only once for
each function it appears in
state.c:413:9: error: too many arguments to function
=E2=80=98bt_trace_handle_get_timestamp_begin=E2=80=99
/usr/include/babeltrace/trace-handle.h:45:10: note: declared here
state.c: In function =E2=80=98state_save_after_trace_hook=E2=80=99:
state.c:3531:2: warning: #warning "Would we move max_time to traceset"
[-Wcpp]
make[3]: *** [state.o] Error 1
make[3]: Leaving directory `/home/caananth/Downloads/lttv-1.5/lttv/lttv'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/caananth/Downloads/lttv-1.5/lttv'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/caananth/Downloads/lttv-1.5'
make: *** [all] Error 2


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

--f46d043892b1d6e89404ec032ebc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I could not find lttv (v=
iewer) on ubuntu, hence I built from source. I get following error. Could y=
ou please help me resolving this issue? (Am I missing something, should I i=
nstall any other packages?)<br>
</div><div><br></div><div>make =C2=A0all-recursive</div><div>make[1]: Enter=
ing directory `/home/caananth/Downloads/lttv-1.5&#39;</div><div>
Making all in lttv</div><div>make[2]: Entering directory `/home/caananth/Do=
wnloads/lttv-1.5/lttv&#39;</div><div>Making all in lttv</div><div>make[3]: =
Entering directory `/home/caananth/Downloads/lttv-1.5/lttv/lttv&#39;</div>

<div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 state.o</div><div>state.c: In function =
=E2=80=98restore_init_state=E2=80=99:</div><div>state.c:413:25: error: =E2=
=80=98BT_CLOCK_REAL=E2=80=99 undeclared (first use in this function)</div><=
div>state.c:413:25: note: each undeclared identifier is reported only once =
for each function it appears in</div>

<div>state.c:413:9: error: too many arguments to function =E2=80=98bt_trace=
_handle_get_timestamp_begin=E2=80=99</div><div>/usr/include/babeltrace/trac=
e-handle.h:45:10: note: declared here</div><div>state.c: In function =E2=80=
=98state_save_after_trace_hook=E2=80=99:</div>

<div>state.c:3531:2: warning: #warning &quot;Would we move max_time to trac=
eset&quot; [-Wcpp]</div><div>make[3]: *** [state.o] Error 1</div><div>make[=
3]: Leaving directory `/home/caananth/Downloads/lttv-1.5/lttv/lttv&#39;</di=
v>

<div>make[2]: *** [all-recursive] Error 1</div><div>make[2]: Leaving direct=
ory `/home/caananth/Downloads/lttv-1.5/lttv&#39;</div><div>make[1]: *** [al=
l-recursive] Error 1</div><div>make[1]: Leaving directory `/home/caananth/D=
ownloads/lttv-1.5&#39;</div>

<div>make: *** [all] Error 2</div><div><br></div><div><br></div>-- <br><u s=
tyle=3D"color:rgb(0,0,153)"><b>Aananth C N</b></u><br><span style=3D"font-f=
amily:tahoma,sans-serif;color:rgb(102,102,102)">Ph: <a href=3D"tel:94447766=
90" value=3D"+919444776690" target=3D"_blank">9444776690</a></span><br>
<font style=3D"color:rgb(204,204,255)" size=3D"1"><b></b></font><p style=3D=
"margin:0px">
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

--f46d043892b1d6e89404ec032ebc--


--===============1681265141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1681265141==--
