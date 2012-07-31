From: Danny Serres <serres@live.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Tue, 31 Jul 2012 16:56:57 -0400
Message-ID: <BLU170-W9B01B1DF726CCE265D8C1C0C50__3144.81882746822$1343769649$gmane$org@phx.gbl>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>,
	<CAGDH53k19=bVBO-ZK6+nbds0v1gwf06NdErO2a54pgVK9DKbSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0529529776=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu0-omc1-s15.blu0.hotmail.com ([65.55.116.26])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <serres@live.ca>) id 1SwJV0-0000WT-Tz
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 16:57:02 -0400
In-Reply-To: <CAGDH53k19=bVBO-ZK6+nbds0v1gwf06NdErO2a54pgVK9DKbSw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: christian.babeux@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0529529776==
Content-Type: multipart/alternative;
	boundary="_083a2537-1923-4674-971f-04e1659b3820_"

--_083a2537-1923-4674-971f-04e1659b3820_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




Date: Tue=2C 31 Jul 2012 15:56:47 -0400
Subject: Re: [lttng-dev] [lttng-tools PATCH] lttng-tools python module
From: christian.babeux@efficios.com
To: danny.serres@efficios.com
CC: lttng-dev@lists.lttng.org

Hi Danny=2C
First of all=2C thank you for your work on Python bindings!This will be ver=
y useful in the near future :).
Here are some comments on your patch:
> SWIG >=3D 2.0 is used to create the wrapper and its> 'warning md variable=
 unused' bug is patched in Makefile.am.> [...]> diff --git a/src/python/Mak=
efile.am b/src/python/Makefile.am> new file mode 100644> index 0000000..b67=
d550> --- /dev/null> +++ b/src/python/Makefile.am> [...]> +lttng_wrap.c: lt=
tng.i> +       $(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm=
 lttng.i> +       sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" l=
ttng_wrap.c> +       sed -i "s/PyObject \*m=2C \*d=2C \*md=3B/PyObject \*m=
=2C \*d=3B\n#if defined(SWIGPYTHON_BUILTIN)\nPyObject *md=3B\n#endif/g" ltt=
ng_wrap.c> +       sed -i "s/md =3D d/d/g" lttng_wrap.c> +       sed -i "s/=
(void)public_symbol=3B/(void)public_symbol=3B\n  md =3D d=3B/g" lttng_wrap.=
c
If I understand correctly your commit message=2C those sed invocations are =
necessary to remove an 'unused variable warning'. Is this a known upstreamb=
ug in SWIG?











Yes=2C it is.  So far=2C it has not been fixed but a patch has been propose=
d (same as I apply here using sed)
(see http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D3530021&g=
roup_id=3D1645&atid=3D101645 )

> +       sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" lttng_wra=
p.c=20
This sed replacement didn't work on my machine. I have a Python3 install an=
d the appropriate Python.h header is located in '/usr/include/python3.2mu'.=
To reliably detect Python include paths=2C the 'python-config --includes'co=
mmand can be used like you did in the main configure.ac.

I would suggest generating the binding like this:
-AM_CFLAGS =3D -I$(PYTHONINC) -I../lib/lttng-ctl -I../common \     +AM_CFLA=
GS =3D -I$(PYTHON_INCLUDE) -I../lib/lttng-ctl -I../common \              $(=
BUDDY_CFLAGS)                                    [...] lttng_wrap.c: lttng.=
i        $(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng=
.i-       sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" lttng_wra=
p.c[...]
The README should also mention that in order to generate the Python binding=
s=2C python headers are also required (python-dev on Debian/Ubuntu).

Fixed.  I will post a second version soon.

Thanks=2C
Danny


Thank you=2C
Christian










 		 	   		  =

--_083a2537-1923-4674-971f-04e1659b3820_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
<br><br><div><blockquote><hr id=3D"stopSpelling">Date: Tue=2C 31 Jul 2012 1=
5:56:47 -0400<br>Subject: Re: [lttng-dev] [lttng-tools PATCH] lttng-tools p=
ython module<br>From: christian.babeux@efficios.com<br>To: danny.serres@eff=
icios.com<br>CC: lttng-dev@lists.lttng.org<br><br><div>Hi Danny=2C</div><di=
v><br></div><div>First of all=2C thank you for your work on Python bindings=
!</div><div>This will be very useful in the near future :).</div><div><br><=
/div><div>Here are some comments on your patch:</div><div><br></div><div>&g=
t=3B SWIG &gt=3B=3D 2.0 is used to create the wrapper and its</div><div>&gt=
=3B 'warning md variable unused' bug is patched in Makefile.am.</div><div>&=
gt=3B [...]</div><div>&gt=3B diff --git a/src/python/Makefile.am b/src/pyth=
on/Makefile.am</div><div>&gt=3B new file mode 100644</div><div>&gt=3B index=
 0000000..b67d550</div><div>&gt=3B --- /dev/null</div><div>&gt=3B +++ b/src=
/python/Makefile.am</div><div>&gt=3B [...]</div><div>&gt=3B +lttng_wrap.c: =
lttng.i</div><div>&gt=3B + &nbsp=3B &nbsp=3B &nbsp=3B $(SWIG) -python -I. -=
I$(top_srcdir)/src/common/sessiond-comm lttng.i</div><div>&gt=3B + &nbsp=3B=
 &nbsp=3B &nbsp=3B sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" =
lttng_wrap.c</div><div>&gt=3B + &nbsp=3B &nbsp=3B &nbsp=3B sed -i "s/PyObje=
ct \*m=2C \*d=2C \*md=3B/PyObject \*m=2C \*d=3B\n#if defined(SWIGPYTHON_BUI=
LTIN)\nPyObject *md=3B\n#endif/g" lttng_wrap.c</div><div>&gt=3B + &nbsp=3B =
&nbsp=3B &nbsp=3B sed -i "s/md =3D d/d/g" lttng_wrap.c</div><div>&gt=3B + &=
nbsp=3B &nbsp=3B &nbsp=3B sed -i "s/(void)public_symbol=3B/(void)public_sym=
bol=3B\n &nbsp=3Bmd =3D d=3B/g" lttng_wrap.c</div><div><br></div><div>If I =
understand correctly your commit message=2C those sed invocations are&nbsp=
=3B</div><div>necessary to remove an 'unused variable warning'. Is this a k=
nown upstream</div>bug in SWIG?<br></blockquote>









<div><br>Yes=2C it is.&nbsp=3B So far=2C it has not been fixed but a patch =
has been proposed (same as I apply here using sed)<br>(see <a href=3D"http:=
//sourceforge.net/tracker/index.php?func=3Ddetail&amp=3Baid=3D3530021&amp=
=3Bgroup_id=3D1645&amp=3Batid=3D101645">http://sourceforge.net/tracker/inde=
x.php?func=3Ddetail&amp=3Baid=3D3530021&amp=3Bgroup_id=3D1645&amp=3Batid=3D=
101645</a> )<br></div><div><br></div><blockquote><div>&gt=3B + &nbsp=3B &nb=
sp=3B &nbsp=3B sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" lttn=
g_wrap.c&nbsp=3B</div><div><br></div><div>This sed replacement didn't work =
on my machine. I have a Python3 install and&nbsp=3B</div><div>the appropria=
te Python.h header is located in '/usr/include/python3.2mu'.</div><div>To r=
eliably detect Python include paths=2C the 'python-config --includes'</div>=
<div>command can be used like you did in the main <a href=3D"http://configu=
re.ac" target=3D"_blank">configure.ac</a>.<br><br></div><div>I would sugges=
t generating the binding like this:</div><div><br></div><div>-AM_CFLAGS =3D=
 -I$(PYTHONINC) -I../lib/lttng-ctl -I../common \ &nbsp=3B &nbsp=3B&nbsp=3B<=
/div><div>+AM_CFLAGS =3D -I$(PYTHON_INCLUDE) -I../lib/lttng-ctl -I../common=
 \</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B=
 $(BUDDY_CFLAGS) &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbs=
p=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B &nbsp=3B &nbsp=3B &nbsp=3B</div><div>[...]</div><div>&nbsp=3Blttng_wrap=
.c: lttng.i</div><div>&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B $(SWIG) -python -=
I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i</div><div>- &nbsp=3B &n=
bsp=3B &nbsp=3B sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" ltt=
ng_wrap.c</div><div>[...]</div><div><br></div><div>The README should also m=
ention that in order to generate&nbsp=3B</div><div>the Python bindings=2C p=
ython headers are also required&nbsp=3B</div><div>(python-dev on Debian/Ubu=
ntu).<br></div></blockquote><div><br>Fixed.&nbsp=3B I will post a second ve=
rsion soon.<br><br>Thanks=2C<br>Danny<br></div><div><br></div><blockquote><=
div><br></div><div>Thank you=2C</div><div><br></div><div>Christian</div></b=
lockquote>









<div><br></div></div> 		 	   		  </div></body>
</html>=

--_083a2537-1923-4674-971f-04e1659b3820_--


--===============0529529776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0529529776==--
