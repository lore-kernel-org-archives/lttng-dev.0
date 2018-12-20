From: Yonghong Yan <yanyh15@gmail.com>
Subject: TP_ARGS for TRACEPOINT_EVENT_CLASS and
 TRACEPOINT_EVENT_INSTANCE
Date: Thu, 20 Dec 2018 11:46:56 -0500
Message-ID: <CACJEY862Ytj85N+sidwaq1JEQ+FCiAFo7x5JGuTb992mUrYkdg__26870.8815835$1545324314$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0801436466408066860=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by lists.lttng.org (Postfix) with ESMTPS id 43LHjT1hNDz16H9
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 11:47:08 -0500 (EST)
Received: by mail-pl1-x630.google.com with SMTP id u18so1134437plq.7
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 08:47:08 -0800 (PST)
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

--===============0801436466408066860==
Content-Type: multipart/alternative; boundary="00000000000085b7b0057d76e160"

--00000000000085b7b0057d76e160
Content-Type: text/plain; charset="UTF-8"

I am looking at the following example from lttng-ust manual. The same
TP_ARGS ( ... ) are repeated in both the TRACEPOINT_EVENT_CLASS and
TRACEPOINT_EVENT_INSTANCE definition. My understanding is that it actually
allows using different arguments, even in this example it is the same. Am I
right?

I also like the feature of having one TP_ARGS in the TRACEPOINT_EVENT_CLASS
that declares the arguments for several TRACEPOINT_EVENT_INSTANCE so we do
not need to have TP_ARGS in TRACEPOINT_EVENT_INSTANCE. Is that possible?

Thank you
Yonghong

TRACEPOINT_EVENT_CLASS(
    my_provider,
    my_tracepoint_class,
    TP_ARGS(
        int, my_integer_arg,
        struct app_struct *, app_struct_arg
    ),
    TP_FIELDS(
        ctf_integer(int, a, my_integer_arg)
        ctf_integer(unsigned long, b, app_struct_arg->b)
        ctf_string(c, app_struct_arg->c)
    )
)

TRACEPOINT_EVENT_INSTANCE(
    my_provider,
    my_tracepoint_class,
    event_instance1,
    TP_ARGS(
        int, my_integer_arg,
        struct app_struct *, app_struct_arg
    )
)

TRACEPOINT_EVENT_INSTANCE(
    my_provider,
    my_tracepoint_class,
    event_instance2,
    TP_ARGS(
        int, my_integer_arg,
        struct app_struct *, app_struct_arg
    )
)

--00000000000085b7b0057d76e160
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">I am lo=
oking at the following example from=C2=A0lttng-ust manual. The same TP_ARGS=
 ( ... ) are repeated in both the TRACEPOINT_EVENT_CLASS and TRACEPOINT_EVE=
NT_INSTANCE definition. My understanding is that it actually allows using d=
ifferent arguments, even in this example it is the same. Am I right?</div><=
div dir=3D"ltr"><br></div><div dir=3D"ltr">I also like the feature of havin=
g one TP_ARGS in the TRACEPOINT_EVENT_CLASS that declares the arguments for=
 several TRACEPOINT_EVENT_INSTANCE so we do not need to have TP_ARGS in TRA=
CEPOINT_EVENT_INSTANCE. Is that possible?=C2=A0</div><div dir=3D"ltr"><br><=
/div><div dir=3D"ltr">Thank you</div><div dir=3D"ltr">Yonghong<br><div><div=
 dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><pre class=3D"gmail-src" style=3D"margin-to=
p:12px;margin-bottom:0px;padding:12px;border:0px;font-variant-numeric:inher=
it;font-variant-east-asian:inherit;font-stretch:inherit;font-size:12px;line=
-height:15px;font-family:&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;=
,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Nim=
bus Mono L&quot;,&quot;Ubuntu Mono&quot;,Monaco,Consolas,&quot;Lucida Conso=
le&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;Courier New&quot;,Courier=
,monospace;vertical-align:baseline;background-color:rgba(0,0,0,0.05);overfl=
ow-x:auto;color:rgba(0,0,0,0.8)">TRACEPOINT_EVENT_CLASS(
    my_provider,
    my_tracepoint_class,
    TP_ARGS(
        int, my_integer_arg,
        struct app_struct *, app_struct_arg
    ),
    TP_FIELDS(
        ctf_integer(int, a, my_integer_arg)
        ctf_integer(unsigned long, b, app_struct_arg-&gt;b)
        ctf_string(c, app_struct_arg-&gt;c)
    )
)

TRACEPOINT_EVENT_INSTANCE(
    my_provider,
    my_tracepoint_class,
    event_instance1,
    TP_ARGS(
        int, my_integer_arg,
        struct app_struct *, app_struct_arg
    )
)

TRACEPOINT_EVENT_INSTANCE(
    my_provider,
    my_tracepoint_class,
    event_instance2,
    TP_ARGS(
        int, my_integer_arg,
        struct app_struct *, app_struct_arg
    )
)
</pre><br class=3D"gmail-Apple-interchange-newline"></div></div></div></div=
></div></div></div></div></div></div>

--00000000000085b7b0057d76e160--

--===============0801436466408066860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0801436466408066860==--
