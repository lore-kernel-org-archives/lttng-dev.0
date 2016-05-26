From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: scale numbers for LTTNG
Date: Thu, 26 May 2016 14:02:57 -0400
Message-ID: <CAF4oYfHHARzj+h_nKVb8+M=KAn=LHDesZbj=O34qjiAVTDKJ8A__5012.95832586965$1464285802$gmane$org@mail.gmail.com>
References: <CAHxF_R8QdRQjbgfE1d+Zgi=CmDiB6SEgL2Up1G-p21YdQz9pYA@mail.gmail.com>
 <CAHxF_R9iWBOU=hawM8ZjJCVG3TV7YZOtkwvaqhm2MTdwza48jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3576301348165061792=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 91A46A34F1
 for <lttng-dev@lists.lttng.org>; Thu, 26 May 2016 18:02:58 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id f8so57766549ioe.3
 for <lttng-dev@lists.lttng.org>; Thu, 26 May 2016 11:02:58 -0700 (PDT)
In-Reply-To: <CAHxF_R9iWBOU=hawM8ZjJCVG3TV7YZOtkwvaqhm2MTdwza48jg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Vijay Anand <vjanandr85@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3576301348165061792==
Content-Type: multipart/alternative; boundary=001a113fd5869bfe430533c299d7

--001a113fd5869bfe430533c299d7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

Could you share with us a test program or details on how you evaluated
those limitation ?

Thanks

On Thu, May 26, 2016 at 8:23 AM, Vijay Anand <vjanandr85@gmail.com> wrote:

> Could anyone please let us know how do we go about this ?
>
> Regards,
> Vijay
>
> On Tue, May 24, 2016 at 11:31 AM, Vijay Anand <vjanandr85@gmail.com>
> wrote:
>
>> Hello Folks,
>>
>> We have been evaluating LTTNG for use in our production systems for user
>> space tracing. We have evaluated most of the features supported by LTTNG
>> and very much see a value add LTTNG brings into our debugging
>> infrastructure.
>>
>>    - Our current requirement is to trace Userspace programs running on
>>    linux.
>>    - Each of the linux processes define their own tracepoint providers.
>>    - We would like to trace event histories of each process
>>    independently.
>>    - We could potentially have 1000s of such processes running
>>    simultaneously.
>>    - We concluded on using a session/channel to trace one tracepoint
>>    provider corresponding to a unique process.
>>       - But I understand we could also create one system wide session
>>       and use channels to trace each of the providers. Either of the app=
roaches
>>       seems to work for us.
>>    - But upon evaluating I see that we could create only 25 active
>>    process-sessions and not traces from all the processes are logged.
>>       - Please note I have tried increasing the buffer size and the
>>       number of buffers. This doesn't help.
>>       - Each of the process trace 52 events at and interval of 1 second
>>       each.
>>    - I have evaluated this with lttng in session,live and snapshot modes
>>    and I have not been getting favourable.
>>
>> Could you folks share the scale numbers that LTTNG supports, especially
>> when it comes to tracing user space programs ?
>>
>> Regards,
>> Vijay
>> =E2=80=8B=E2=80=8B
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
Jonathan Rajotte Julien

--001a113fd5869bfe430533c299d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Vijay,<div><br></div><div>Could you share with us a tes=
t program or details on how you evaluated those limitation ?</div><div><br>=
</div><div>Thanks</div></div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Thu, May 26, 2016 at 8:23 AM, Vijay Anand <span dir=3D"ltr">=
&lt;<a href=3D"mailto:vjanandr85@gmail.com" target=3D"_blank">vjanandr85@gm=
ail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D=
"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;=
font-size:small"><font color=3D"#000000">Could anyone please let us know ho=
w do we go about this ?</font></div><div class=3D"gmail_extra"><font color=
=3D"#000000"><br clear=3D"all"></font><div><div><div dir=3D"ltr"><font face=
=3D"verdana, sans-serif" color=3D"#000000">Regards,</font><div><font face=
=3D"verdana, sans-serif" color=3D"#000000">Vijay</font></div></div></div></=
div><div><div class=3D"h5">
<br><div class=3D"gmail_quote">On Tue, May 24, 2016 at 11:31 AM, Vijay Anan=
d <span dir=3D"ltr">&lt;<a href=3D"mailto:vjanandr85@gmail.com" target=3D"_=
blank">vjanandr85@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div dir=3D"ltr"><div style=3D"font-family:verdana,sans-serif;font=
-size:small"><font color=3D"#000000">Hello Folks,</font></div><div style=3D=
"font-family:verdana,sans-serif;font-size:small"><font color=3D"#000000"><b=
r></font></div><div style=3D"font-family:verdana,sans-serif;font-size:small=
"><font color=3D"#000000">We have been evaluating LTTNG for use in our prod=
uction systems for user space tracing. We have evaluated most of the featur=
es supported by LTTNG and very much see a value add LTTNG brings into our d=
ebugging infrastructure.</font></div><div><ul><li><font color=3D"#000000"><=
span style=3D"font-family:verdana,sans-serif">Our current requirement is to=
 trace Userspace programs running on linux.=C2=A0</span><br></font></li><li=
><font color=3D"#000000"><span style=3D"font-family:verdana,sans-serif">Eac=
h of the linux processes define their own tracepoint providers.</span><br><=
/font></li><li><font color=3D"#000000"><span style=3D"font-family:verdana,s=
ans-serif">We would like to trace event histories of each process independe=
ntly.</span><br></font></li><li><font color=3D"#000000"><span style=3D"font=
-family:verdana,sans-serif">We could potentially have 1000s of such process=
es running simultaneously.</span><br></font></li><li><span style=3D"font-fa=
mily:verdana,sans-serif"><font color=3D"#000000">We concluded on using a se=
ssion/channel to trace one tracepoint provider corresponding to a unique pr=
ocess.=C2=A0</font></span></li><ul><li><span style=3D"font-family:verdana,s=
ans-serif"><font color=3D"#000000">But I understand we could also create on=
e system wide session and use channels to trace each of the providers. Eith=
er of the approaches seems to work for us.</font></span></li></ul><li><span=
 style=3D"font-family:verdana,sans-serif"><font color=3D"#000000">But upon =
evaluating I see that we could create only 25 active process-sessions and n=
ot traces from all the processes are logged.</font></span></li><ul><li><spa=
n style=3D"font-family:verdana,sans-serif"><font color=3D"#000000">Please n=
ote I have tried increasing the buffer size and the number of buffers. This=
 doesn&#39;t help.</font></span></li><li><span style=3D"font-family:verdana=
,sans-serif"><font color=3D"#000000">Each of the process trace 52 events at=
 and interval of 1 second each.</font></span></li></ul><li><font face=3D"ve=
rdana, sans-serif" color=3D"#000000">I have evaluated this with lttng in se=
ssion,live and snapshot modes and I have not been getting=C2=A0favourable.<=
/font></li></ul><font color=3D"#000000"><span style=3D"font-family:verdana,=
sans-serif">Could you folks share the scale numbers that LTTNG supports, es=
pecially when it comes to tracing user space programs ?</span><br></font></=
div><div style=3D"font-family:verdana,sans-serif;font-size:small"><font col=
or=3D"#000000"><br></font></div><div><div><div dir=3D"ltr"><font face=3D"ve=
rdana, sans-serif" color=3D"#000000">Regards,</font><div><font face=3D"verd=
ana, sans-serif" color=3D"#000000">Vijay<div style=3D"font-family:verdana,s=
ans-serif;font-size:small;display:inline">=E2=80=8B=E2=80=8B</div></font></=
div></div></div></div>
</div>
</blockquote></div><br></div></div></div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonathan Rajo=
tte Julien<div><br></div></div></div></div></div>
</div>

--001a113fd5869bfe430533c299d7--

--===============3576301348165061792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3576301348165061792==--
