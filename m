From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Tue, 31 Jul 2012 15:56:47 -0400
Message-ID: <CAGDH53k19=bVBO-ZK6+nbds0v1gwf06NdErO2a54pgVK9DKbSw__14748.1829896153$1343764643$gmane$org@mail.gmail.com>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0497752665=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SwIYn-0008Si-VV
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 15:56:54 -0400
Received: by lboj14 with SMTP id j14so4924279lbo.35
	for <lttng-dev@lists.lttng.org>; Tue, 31 Jul 2012 12:56:47 -0700 (PDT)
In-Reply-To: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <danny.serres@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0497752665==
Content-Type: multipart/alternative; boundary=bcaec554d45819c79404c6259404

--bcaec554d45819c79404c6259404
Content-Type: text/plain; charset=UTF-8

Hi Danny,

First of all, thank you for your work on Python bindings!
This will be very useful in the near future :).

Here are some comments on your patch:

> SWIG >= 2.0 is used to create the wrapper and its
> 'warning md variable unused' bug is patched in Makefile.am.
> [...]
> diff --git a/src/python/Makefile.am b/src/python/Makefile.am
> new file mode 100644
> index 0000000..b67d550
> --- /dev/null
> +++ b/src/python/Makefile.am
> [...]
> +lttng_wrap.c: lttng.i
> +       $(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm
lttng.i
> +       sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g"
lttng_wrap.c
> +       sed -i "s/PyObject \*m, \*d, \*md;/PyObject \*m, \*d;\n#if
defined(SWIGPYTHON_BUILTIN)\nPyObject *md;\n#endif/g" lttng_wrap.c
> +       sed -i "s/md = d/d/g" lttng_wrap.c
> +       sed -i "s/(void)public_symbol;/(void)public_symbol;\n  md = d;/g"
lttng_wrap.c

If I understand correctly your commit message, those sed invocations are
necessary to remove an 'unused variable warning'. Is this a known upstream
bug in SWIG?

> +       sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g"
lttng_wrap.c

This sed replacement didn't work on my machine. I have a Python3 install
and
the appropriate Python.h header is located in '/usr/include/python3.2mu'.
To reliably detect Python include paths, the 'python-config --includes'
command can be used like you did in the main configure.ac.

I would suggest generating the binding like this:

-AM_CFLAGS = -I$(PYTHONINC) -I../lib/lttng-ctl -I../common \
+AM_CFLAGS = -I$(PYTHON_INCLUDE) -I../lib/lttng-ctl -I../common \
              $(BUDDY_CFLAGS)
[...]
 lttng_wrap.c: lttng.i
        $(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i
-       sed -i "s/Python.h/python$(PYTHON_VERSION)\/Python.h/g" lttng_wrap.c
[...]

The README should also mention that in order to generate
the Python bindings, python headers are also required
(python-dev on Debian/Ubuntu).

Thank you,

Christian

--bcaec554d45819c79404c6259404
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Hi Danny,</div><div><br></div><div>First of all, thank you for your wo=
rk on Python bindings!</div><div>This will be very useful in the near futur=
e :).</div><div><br></div><div>Here are some comments on your patch:</div>

<div><br></div><div>&gt; SWIG &gt;=3D 2.0 is used to create the wrapper and=
 its</div><div>&gt; &#39;warning md variable unused&#39; bug is patched in =
Makefile.am.</div><div>&gt; [...]</div><div>&gt; diff --git a/src/python/Ma=
kefile.am b/src/python/Makefile.am</div>

<div>&gt; new file mode 100644</div><div>&gt; index 0000000..b67d550</div><=
div>&gt; --- /dev/null</div><div>&gt; +++ b/src/python/Makefile.am</div><di=
v>&gt; [...]</div><div>&gt; +lttng_wrap.c: lttng.i</div><div>&gt; + =C2=A0 =
=C2=A0 =C2=A0 $(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm =
lttng.i</div>

<div>&gt; + =C2=A0 =C2=A0 =C2=A0 sed -i &quot;s/Python.h/python$(PYTHON_VER=
SION)\/Python.h/g&quot; lttng_wrap.c</div><div>&gt; + =C2=A0 =C2=A0 =C2=A0 =
sed -i &quot;s/PyObject \*m, \*d, \*md;/PyObject \*m, \*d;\n#if defined(SWI=
GPYTHON_BUILTIN)\nPyObject *md;\n#endif/g&quot; lttng_wrap.c</div>

<div>&gt; + =C2=A0 =C2=A0 =C2=A0 sed -i &quot;s/md =3D d/d/g&quot; lttng_wr=
ap.c</div><div>&gt; + =C2=A0 =C2=A0 =C2=A0 sed -i &quot;s/(void)public_symb=
ol;/(void)public_symbol;\n =C2=A0md =3D d;/g&quot; lttng_wrap.c</div><div><=
br></div><div>If I understand correctly your commit message, those sed invo=
cations are=C2=A0</div>

<div>necessary to remove an &#39;unused variable warning&#39;. Is this a kn=
own upstream</div><div>bug in SWIG?</div><div><br></div><div>&gt; + =C2=A0 =
=C2=A0 =C2=A0 sed -i &quot;s/Python.h/python$(PYTHON_VERSION)\/Python.h/g&q=
uot; lttng_wrap.c=C2=A0</div>

<div><br></div><div>This sed replacement didn&#39;t work on my machine. I h=
ave a Python3 install and=C2=A0</div><div>the appropriate Python.h header i=
s located in &#39;/usr/include/python3.2mu&#39;.</div><div>To reliably dete=
ct Python include paths, the &#39;python-config --includes&#39;</div>

<div>command can be used like you did in the main <a href=3D"http://configu=
re.ac" target=3D"_blank">configure.ac</a>.</div><div><br></div><div>I would=
 suggest generating the binding like this:</div><div><br></div><div>-AM_CFL=
AGS =3D -I$(PYTHONINC) -I../lib/lttng-ctl -I../common \ =C2=A0 =C2=A0=C2=A0=
</div>

<div>+AM_CFLAGS =3D -I$(PYTHON_INCLUDE) -I../lib/lttng-ctl -I../common \</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(BUDDY_CFLAGS) =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>[...]</div><=
div>=C2=A0lttng_wrap.c: lttng.i</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(SWI=
G) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i</div>

<div>- =C2=A0 =C2=A0 =C2=A0 sed -i &quot;s/Python.h/python$(PYTHON_VERSION)=
\/Python.h/g&quot; lttng_wrap.c</div><div>[...]</div><div><br></div><div>Th=
e README should also mention that in order to generate=C2=A0</div><div>the =
Python bindings, python headers are also required=C2=A0</div>

<div>(python-dev on Debian/Ubuntu).</div><div><br></div><div>Thank you,</di=
v><div><br></div><div>Christian</div><div><br></div>

--bcaec554d45819c79404c6259404--


--===============0497752665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0497752665==--
