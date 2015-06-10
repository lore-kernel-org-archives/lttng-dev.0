From: Chidhu R <chid1989@gmail.com>
Subject: Printing bit fields with LTTng
Date: Wed, 10 Jun 2015 14:16:53 -0700
Message-ID: <CAL1ZhON=nEPuoXks2AKq4k7nCpK_W_FQ96TM3299V69V6RgW_w__8527.15857695348$1433971136$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1548756921=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f46.google.com ([209.85.215.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <chid1989@gmail.com>) id 1Z2nNR-0007Ac-8i
 for lttng-dev@lists.lttng.org; Wed, 10 Jun 2015 17:17:42 -0400
Received: by laew7 with SMTP id w7so40937355lae.1
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jun 2015 14:17:33 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1548756921==
Content-Type: multipart/alternative; boundary=089e01419f68442fc70518306781

--089e01419f68442fc70518306781
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I am getting compilation issues while trying to print bit field values with
LTTng.

Error:

hello.c: In function =E2=80=98main=E2=80=99:
hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-field
hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-field
hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to a bit-field
hello.c:36:1: error: =E2=80=98sizeof=E2=80=99 applied to a bit-field

Snippet:

struct abc{
        int a:16;
        int b:8;
};

Line 36: tracepoint(hello_world, my_third_tracepoint, aa.a, "welcome");
Line 37: printf("val =3D %x\n",aa.a);

tracepoint line results in compilation error.
printf succeeds.

Tp definition looks like this.

TRACEPOINT_EVENT(
    hello_world,
    my_third_tracepoint,
    TP_ARGS(
        uint32_t, arg,
        const char * , my_string_arg
    ),
    TP_FIELDS(
        ctf_integer_hex(uint32_t, my_arg, arg)
        ctf_string(field, my_string_arg)
    )
)

How to print bit field values?

Thanks
Chid

--089e01419f68442fc70518306781
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I am getting compilation issues =
while trying to print bit field values with LTTng.</div><div><br></div><div=
>Error:</div><div><br></div><div><div>hello.c: In function =E2=80=98main=E2=
=80=99:</div><div>hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied to =
a bit-field</div><div>hello.c:36:1: error: =E2=80=98typeof=E2=80=99 applied=
 to a bit-field</div><div>hello.c:36:1: error: =E2=80=98typeof=E2=80=99 app=
lied to a bit-field</div><div>hello.c:36:1: error: =E2=80=98sizeof=E2=80=99=
 applied to a bit-field</div></div><div><br></div><div>Snippet:</div><div><=
br></div><div><div>struct abc{</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int a:=
16;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int b:8;</div><div>};</div></div>=
<div><br></div><div>Line 36: tracepoint(hello_world, my_third_tracepoint, a=
a.a, &quot;welcome&quot;);<br></div><div>Line 37: printf(&quot;val =3D %x\n=
&quot;,aa.a);<br></div><div><br></div><div>tracepoint line results in compi=
lation error.</div><div>printf succeeds.=C2=A0</div><div><br></div><div>Tp =
definition looks like this.</div><div><br></div><div><div>TRACEPOINT_EVENT(=
</div><div>=C2=A0 =C2=A0 hello_world,</div><div>=C2=A0 =C2=A0 my_third_trac=
epoint,</div><div>=C2=A0 =C2=A0 TP_ARGS(</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t, arg,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char * , my_=
string_arg</div><div>=C2=A0 =C2=A0 ),</div><div>=C2=A0 =C2=A0 TP_FIELDS(</d=
iv><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctf_integer_hex(uint32_t, my_arg, arg)<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctf_string(field, my_string_arg)</div=
><div>=C2=A0 =C2=A0 )</div><div>)</div></div><div><br></div><div>How to pri=
nt bit field values?</div><div><br></div><div>Thanks</div><div>Chid</div></=
div>

--089e01419f68442fc70518306781--


--===============1548756921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1548756921==--
