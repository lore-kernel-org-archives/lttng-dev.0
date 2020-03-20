From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Babeltrace2 - compilation error with intel18
Date: Fri, 20 Mar 2020 15:10:26 -0600
Message-ID: <CADtyBo7jFiv-E-DCp4kYfY7WRSLsN3Oos6iRr35Sy9o=iNZKOg@mail.gmail.com>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240191621678651241=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by lists.lttng.org (Postfix) with ESMTPS id 48kbz75QYsz1PC1
 for <lttng-dev@lists.lttng.org>; Fri, 20 Mar 2020 17:10:43 -0400 (EDT)
Received: by mail-oi1-x22e.google.com with SMTP id 9so8015076oiq.12
 for <lttng-dev@lists.lttng.org>; Fri, 20 Mar 2020 14:10:43 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0240191621678651241==
Content-Type: multipart/alternative; boundary="000000000000d5f16b05a14fb74d"

--000000000000d5f16b05a14fb74d
Content-Type: text/plain; charset="UTF-8"

I am trying to compile BT2 with Python bindings using Intel18.  I receive
the following error during the build:

In file included from py-common.c(31):
/apps/intel/intelpython3/include/python3.6m/Python.h(149): error #193: zero
used for undefined preprocessing identifier "_MSC_VER"
  #if _MSC_VER
      ^

In file included from py-common.c(31):
/apps/intel/intelpython3/include/python3.6m/Python.h(151): error #193: zero
used for undefined preprocessing identifier "__clang__"
  #elif __clang__ || __GNUC__
        ^

py-common.c(187): error #3179: deprecated conversion of string literal to
char* (should be const char*)
  format_exc_func_name = py_exc_tb ? "format_exception" :
                                                       ^

compilation aborted for py-common.c (code 2)
make[2]: *** [py-common.lo] Error 1
make[2]: Leaving directory
`/home/Rocky.Dunlap/babeltrace/babeltrace2-2.0.2/src/py-common'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory
`/home/Rocky.Dunlap/babeltrace/babeltrace2-2.0.2/src'


Rocky

--000000000000d5f16b05a14fb74d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am trying to compile BT2 with Python bindings using Inte=
l18.=C2=A0 I receive the following error during the build:<div><br></div><d=
iv>In file included from py-common.c(31):<br>/apps/intel/intelpython3/inclu=
de/python3.6m/Python.h(149): error #193: zero used for undefined preprocess=
ing identifier &quot;_MSC_VER&quot;<br>=C2=A0 #if _MSC_VER<br>=C2=A0 =C2=A0=
 =C2=A0 ^<br><br>In file included from py-common.c(31):<br>/apps/intel/inte=
lpython3/include/python3.6m/Python.h(151): error #193: zero used for undefi=
ned preprocessing identifier &quot;__clang__&quot;<br>=C2=A0 #elif __clang_=
_ || __GNUC__<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br><br>py-common.c(187): err=
or #3179: deprecated conversion of string literal to char* (should be const=
 char*)<br>=C2=A0 	format_exc_func_name =3D py_exc_tb ? &quot;format_except=
ion&quot; :<br>=C2=A0 	 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br><br>=
compilation aborted for py-common.c (code 2)<br>make[2]: *** [py-common.lo]=
 Error 1<br>make[2]: Leaving directory `/home/Rocky.Dunlap/babeltrace/babel=
trace2-2.0.2/src/py-common&#39;<br>make[1]: *** [all-recursive] Error 1<br>=
make[1]: Leaving directory `/home/Rocky.Dunlap/babeltrace/babeltrace2-2.0.2=
/src&#39;<br></div><div><br></div><div><br></div><div>Rocky</div></div>

--000000000000d5f16b05a14fb74d--

--===============0240191621678651241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0240191621678651241==--
