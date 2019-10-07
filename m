From: Yonghong Yan <yanyh15@gmail.com>
Subject: use of extern before tracepoint definition
Date: Mon, 7 Oct 2019 12:06:10 -0400
Message-ID: <CACJEY86Mkpd2umxzFbHo9b11RSyEcNAVJyS5vaOjNw4iJDj-qg__27862.1458028041$1570464406$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3496939228984422565=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 by lists.lttng.org (Postfix) with ESMTPS id 46n5283YJjzr3d
 for <lttng-dev@lists.lttng.org>; Mon,  7 Oct 2019 12:06:24 -0400 (EDT)
Received: by mail-io1-xd2c.google.com with SMTP id b19so29822270iob.4
 for <lttng-dev@lists.lttng.org>; Mon, 07 Oct 2019 09:06:24 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3496939228984422565==
Content-Type: multipart/alternative; boundary="000000000000a8a7ee0594543ba5"

--000000000000a8a7ee0594543ba5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am not sure whether this is a bug or the wrong I am using it. When I use
extern declaration as follows, I always have compilation error. I used the
easy-ust to demonstrate:

*diff --git a/doc/examples/easy-ust/sample_component_provider.h
b/doc/examples/easy-ust/sample_component_provider.h*

*index dd3c5f0..e70d650 100644*

*--- a/doc/examples/easy-ust/sample_component_provider.h*

*+++ b/doc/examples/easy-ust/sample_component_provider.h*

@@ -61,6 +61,8 @@

  */

 #include <lttng/tracepoint.h>



+extern int testint(int i);

+

 /*

  * The following tracepoint event writes a message (c string) into the

  * field message of the trace event message in the provider





*yanyh@vm*:*~/tools/lttng/lttng-ust/doc/examples/easy-ust*$ make

cc  -I.   \

-save-temps -c -o sample.o sample.c

cc  -I.   \

-save-temps -c -o tp.o tp.c

In file included from */usr/include/lttng/ust-tracepoint-event.h:974:0*,

                 from */usr/include/lttng/tracepoint-event.h:58*,

                 from *sample_component_provider.h:137*,

                 from *tp.c:33*:

*././sample_component_provider.h:64:1:* *error: *expected expression before
=E2=80=98*extern*=E2=80=99

 extern int testint(int i);

* ^*

Makefile:34: recipe for target 'tp.o' failed

make: *** [tp.o] Error 1


Thank you

Yonghong

--000000000000a8a7ee0594543ba5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div d=
ir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">I am not sure=
 whether this is a bug or the wrong I am using it. When I use extern declar=
ation as follows, I always have compilation error. I used the easy-ust to d=
emonstrate:=C2=A0</div><div dir=3D"ltr"><br></div><div dir=3D"ltr">





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><b>diff --git a/doc/examples/ea=
sy-ust/sample_component_provider.h b/doc/examples/easy-ust/sample_component=
_provider.h</b></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><b>index dd3c5f0..e70d650 10064=
4</b></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><b>--- a/doc/examples/easy-ust/=
sample_component_provider.h</b></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><b>+++ b/doc/examples/easy-ust/=
sample_component_provider.h</b></span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(46,174,187)"><span class=3D"gmail-s1" styl=
e=3D"font-variant-ligatures:no-common-ligatures">@@ -61,6 +61,8 @@</span></=
p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0 </span>*/<span class=3D"gmail-Apple-converted-space">=
=C2=A0</span></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>#include &lt;lttng/tracepoint.h&gt;<span class=3D=
"gmail-Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p3" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0);min-height:20px"><span class=3D"gma=
il-s1" style=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"=
gmail-Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(47,180,29)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">+extern int testint(int i);=
</span></p>
<p class=3D"gmail-p4" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(47,180,29)"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">+</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>/*</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0 </span>* The following tracepoint event writes a messag=
e (c string) into the</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0 </span>* field message of the trace event message in th=
e provider</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-siz=
e:17px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=
=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"><br></sp=
an></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-stretch:normal;font-size:17px;line-he=
ight:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" st=
yle=3D"font-variant-ligatures:no-common-ligatures"><br></span></p><p class=
=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-=
east-asian:normal;font-stretch:normal;font-size:17px;line-height:normal;fon=
t-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"font-var=
iant-ligatures:no-common-ligatures"><br></span></p><p class=3D"gmail-p1" st=
yle=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-stretch:normal;font-size:17px;line-height:normal;font-family:Menlo;c=
olor:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"font-variant-ligatures:n=
o-common-ligatures"><br></span></p><p class=3D"gmail-p1" style=3D"margin:0p=
x;font:17px Menlo;color:rgb(64,11,217)"><span class=3D"gmail-s1" style=3D"f=
ont-variant-ligatures:no-common-ligatures;color:rgb(47,180,29)"><b>yanyh@vm=
</b></span><span class=3D"gmail-s2" style=3D"font-variant-ligatures:no-comm=
on-ligatures;color:rgb(0,0,0)">:</span><span class=3D"gmail-s3" style=3D"fo=
nt-variant-ligatures:no-common-ligatures"><b>~/tools/lttng/lttng-ust/doc/ex=
amples/easy-ust</b></span><span class=3D"gmail-s2" style=3D"font-variant-li=
gatures:no-common-ligatures;color:rgb(0,0,0)">$ make</span></p><p class=3D"=
gmail-p2" style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span class=
=3D"gmail-s3" style=3D"font-variant-ligatures:no-common-ligatures">cc<span =
class=3D"gmail-Apple-converted-space">=C2=A0 </span>-I. <span class=3D"gmai=
l-Apple-converted-space">=C2=A0 </span>\</span></p><p class=3D"gmail-p2" st=
yle=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3=
" style=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"gmail=
-Apple-tab-span" style=3D"white-space:pre">	</span>-save-temps -c -o sample=
.o sample.c</span></p><p class=3D"gmail-p2" style=3D"margin:0px;font:17px M=
enlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" style=3D"font-variant-ligat=
ures:no-common-ligatures">cc<span class=3D"gmail-Apple-converted-space">=C2=
=A0 </span>-I. <span class=3D"gmail-Apple-converted-space">=C2=A0 </span>\<=
/span></p><p class=3D"gmail-p2" style=3D"margin:0px;font:17px Menlo;color:r=
gb(0,0,0)"><span class=3D"gmail-s3" style=3D"font-variant-ligatures:no-comm=
on-ligatures"><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre=
">	</span>-save-temps -c -o tp.o tp.c</span></p><p class=3D"gmail-p2" style=
=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" s=
tyle=3D"font-variant-ligatures:no-common-ligatures">In file included from <=
b>/usr/include/lttng/ust-tracepoint-event.h:974:0</b>,</span></p><p class=
=3D"gmail-p2" style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span c=
lass=3D"gmail-s3" style=3D"font-variant-ligatures:no-common-ligatures"><spa=
n class=3D"gmail-Apple-converted-space">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>from <b>/usr/include/lttng/tracepoint-ev=
ent.h:58</b>,</span></p><p class=3D"gmail-p2" style=3D"margin:0px;font:17px=
 Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" style=3D"font-variant-lig=
atures:no-common-ligatures"><span class=3D"gmail-Apple-converted-space">=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>from <b>s=
ample_component_provider.h:137</b>,</span></p><p class=3D"gmail-p2" style=
=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" s=
tyle=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Ap=
ple-converted-space">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 </span>from <b>tp.c:33</b>:</span></p><p class=3D"gmail-p2" style=
=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" s=
tyle=3D"font-variant-ligatures:no-common-ligatures"><b>././sample_component=
_provider.h:64:1:</b> </span><span class=3D"gmail-s4" style=3D"font-variant=
-ligatures:no-common-ligatures;color:rgb(180,36,25)"><b>error: </b></span><=
span class=3D"gmail-s3" style=3D"font-variant-ligatures:no-common-ligatures=
">expected expression before =E2=80=98<b>extern</b>=E2=80=99</span></p><p c=
lass=3D"gmail-p2" style=3D"margin:0px;font:17px Menlo;color:rgb(0,0,0)"><sp=
an class=3D"gmail-s3" style=3D"font-variant-ligatures:no-common-ligatures">=
<span class=3D"gmail-Apple-converted-space">=C2=A0</span>extern int testint=
(int i);</span></p><p class=3D"gmail-p3" style=3D"margin:0px;font:17px Menl=
o;color:rgb(47,180,29)"><span class=3D"gmail-s3" style=3D"font-variant-liga=
tures:no-common-ligatures"><b><span class=3D"gmail-Apple-converted-space">=
=C2=A0</span>^</b></span></p><p class=3D"gmail-p2" style=3D"margin:0px;font=
:17px Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" style=3D"font-varian=
t-ligatures:no-common-ligatures">Makefile:34: recipe for target &#39;tp.o&#=
39; failed</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font-siz=
e:17px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=
=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">


















</span></p><p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:n=
ormal;font-variant-east-asian:normal;font-stretch:normal;font-size:17px;lin=
e-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3=
" style=3D"font-variant-ligatures:no-common-ligatures">make: *** [tp.o] Err=
or 1</span></p><p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-stretch:normal;font-size:17px=
;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmai=
l-s3" style=3D"font-variant-ligatures:no-common-ligatures"><br></span></p><=
p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;font-stretch:normal;font-size:17px;line-height:nor=
mal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" style=3D"f=
ont-variant-ligatures:no-common-ligatures">Thank you</span></p><p class=3D"=
gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east=
-asian:normal;font-stretch:normal;font-size:17px;line-height:normal;font-fa=
mily:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s3" style=3D"font-variant=
-ligatures:no-common-ligatures">Yonghong</span></p></div></div></div></div>=
</div></div></div></div></div></div></div>

--000000000000a8a7ee0594543ba5--

--===============3496939228984422565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3496939228984422565==--
