From: Sudhagar Chinnaswamy <sudhagar@gmail.com>
Subject: Re: Use LTTng in legacy codebase/variable arguments
Date: Thu, 1 Jan 2015 21:39:21 +0530
Message-ID: <CA+XthnRoUT+dmF+svNUf7T0JMCzYQqm-zw8c3RzQU5dhdC-d9A__16536.2615873621$1420128656$gmane$org@mail.gmail.com>
References: <CA+XthnSaxt2EJuJzm7J7EUAbUnbdh07LnbodQfFbf4bDm4JEKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0622709544=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sudhagar@gmail.com>) id 1Y6iK6-00010U-SU
 for lttng-dev@lists.lttng.org; Thu, 01 Jan 2015 11:10:09 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so8301600ykp.25
 for <lttng-dev@lists.lttng.org>; Thu, 01 Jan 2015 08:10:01 -0800 (PST)
In-Reply-To: <CA+XthnSaxt2EJuJzm7J7EUAbUnbdh07LnbodQfFbf4bDm4JEKw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0622709544==
Content-Type: multipart/alternative; boundary=001a113aba9cd04265050b997428

--001a113aba9cd04265050b997428
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Would appreciate any input/suggestion on this. Thanks a lot.

Regards,
Sudhagar

Visit my blog at: http://sudhagarc.blogspot.com

On Tue, Dec 23, 2014 at 3:16 AM, Sudhagar Chinnaswamy <sudhagar@gmail.com>
wrote:

> Hi:
>
> I have the same need as discussed in the below mentioned thread. I want t=
o
> use LTTng, but most of the cases we need to log different parameters unde=
r
> the same provider and event.
>
> http://lists.lttng.org/pipermail/lttng-dev/2013-December/022134.html
>
> When I tried a simple program to log the variable arguments under same
> provider/event as suggested in the above thread using the macro below, I
> found that the function "my_snprintf" is called "twice" when the logging
> for the event is enabled for each tracepoint call. It seems inefficient t=
o
> call the same function twice. Is there something that could be done to ma=
ke
> it efficient or am I missing something?
>
> =E2=80=94 8< =E2=80=94
>
> #define tracepoint_for_format_string(provider, name, =E2=80=A6) \
>
>       do { \
>
>             char msg_buf[MAX_BUFFER_SIZE]; \
>
>             tracepoint(provider, name, my_snprintf(msg_buf, MAX_BUFFER_SI=
ZE, __VA_ARGS__)); \
>
>       } while (0)
>
> =E2=80=94 8< =E2=80=94
>
> Alternatively, is there any other approach to achieve my requirement: Nee=
d
> to use same provider & event name to log variable arguments?
>
> For e.g.,
> my_tracepoint(hello_world, test, "argc=3D%d, argv=3D%p", argc, argv);
> my_tracepoint(hello_world, test, "argv[%u] :: %s", x, argv[x]);
> my_tracepoint(hello_world, test, "Quitting now!");
>
> Thanks in advance.
>
> Regards,
> Sudhagar
>
>

--001a113aba9cd04265050b997428
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Would appreciate any input/suggestion on this. Thanks a lo=
t.</div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gma=
il_signature">Regards,<br>Sudhagar<br><br>Visit my blog at: <a href=3D"http=
://sudhagarc.blogspot.com">http://sudhagarc.blogspot.com</a></div></div>
<br><div class=3D"gmail_quote">On Tue, Dec 23, 2014 at 3:16 AM, Sudhagar Ch=
innaswamy <span dir=3D"ltr">&lt;<a href=3D"mailto:sudhagar@gmail.com" targe=
t=3D"_blank">sudhagar@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div>Hi:</div><div><br></div><div>I have the=
 same need as discussed in the below mentioned thread. I want to use LTTng,=
 but most of the cases we need to log different parameters under the same p=
rovider and event.=C2=A0</div><div><br></div><a href=3D"http://lists.lttng.=
org/pipermail/lttng-dev/2013-December/022134.html" target=3D"_blank">http:/=
/lists.lttng.org/pipermail/lttng-dev/2013-December/022134.html</a><div><br>=
</div><div>When I tried a simple program to log the variable arguments unde=
r same provider/event as suggested in the above thread using the macro belo=
w, I found that the function &quot;my_snprintf&quot; is called &quot;twice&=
quot; when the logging for the event is enabled for each tracepoint call. I=
t seems inefficient to call the same function twice. Is there something tha=
t could be done to make it efficient or am I missing something?</div><div><=
div style=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:medium"><p cl=
ass=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:12pt;font-fami=
ly:&#39;Times New Roman&#39;,serif"><span style=3D"font-size:10.5pt;font-fa=
mily:Helvetica,sans-serif">=E2=80=94 8&lt; =E2=80=94</span></p></div><div s=
tyle=3D"color:rgb(0,0,0);font-family:Helvetica;font-size:medium"><pre style=
=3D"margin:0in 0in 0.0001pt;font-size:10pt;font-family:&#39;Courier New&#39=
;;white-space:pre-wrap">#define tracepoint_for_format_string(provider, name=
, =E2=80=A6) \</pre><pre style=3D"margin:0in 0in 0.0001pt;font-size:10pt;fo=
nt-family:&#39;Courier New&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do { \</pre=
><pre style=3D"margin:0in 0in 0.0001pt;font-size:10pt;font-family:&#39;Cour=
ier New&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 char msg_buf[MAX_BUFFER_SIZE]; \</pre><pre style=3D"margin:0in 0in 0=
.0001pt;font-size:10pt;font-family:&#39;Courier New&#39;">=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracepoint(provider, na=
me, my_snprintf(msg_buf, MAX_BUFFER_SIZE, __VA_ARGS__)); \</pre><pre style=
=3D"margin:0in 0in 0.0001pt;font-size:10pt;font-family:&#39;Courier New&#39=
;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (0)</pre><div><p class=3D"MsoNorm=
al" style=3D"margin:0in 0in 0.0001pt;font-size:12pt;font-family:&#39;Times =
New Roman&#39;,serif"><span style=3D"font-size:10.5pt;font-family:Helvetica=
,sans-serif">=E2=80=94 8&lt; =E2=80=94</span></p></div></div><div style=3D"=
color:rgb(0,0,0);font-family:Helvetica;font-size:medium"></div></div><div><=
br></div><div>Alternatively, is there any other approach to achieve my requ=
irement: Need to use same provider &amp; event name to log variable argumen=
ts?</div><div><br></div><div>For e.g.,</div><div><div>my_tracepoint(hello_w=
orld, test, &quot;argc=3D%d, argv=3D%p&quot;, argc, argv);</div><div>my_tra=
cepoint(hello_world, test, &quot;argv[%u] :: %s&quot;, x, argv[x]);</div><d=
iv>my_tracepoint(hello_world, test, &quot;Quitting now!&quot;);</div></div>=
<div><br></div><div>Thanks in advance.</div><div><br clear=3D"all"><div><di=
v>Regards,<br>Sudhagar<br><br></div></div>
</div></div>
</blockquote></div><br></div>

--001a113aba9cd04265050b997428--


--===============0622709544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0622709544==--
