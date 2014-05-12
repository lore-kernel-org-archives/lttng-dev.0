From: Jessica Foest <jessica.foest@gmail.com>
Subject: Re: babeltrace
Date: Mon, 12 May 2014 19:24:47 -0400
Message-ID: <CAPxN80CigEdS6x6EE1czpShX1v8cqXh4TwXfY-=_3NuyQLxkKA__18354.9571353526$1399937165$gmane$org@mail.gmail.com>
References: <CAPxN80BCJuB0u_5pk_a=aWw2gQ99eWK_cRnQ4_Kw6Sf8dEaJCg@mail.gmail.com>
 <534FEA8C.8040504@ericsson.com>
 <CA+jJMxum9CmGNDgkqjW3EVCokWx=f-k-iiAjEsXVfY2EjjxmMg@mail.gmail.com>
 <CAPxN80BRHcyEsVPBAQC-xaaYwZv0Mqzik2SehaXtnrs2Wsdoow@mail.gmail.com>
 <536B2BA4.7060107@voxpopuli.im>
 <CAFXXi0=C3_fSHUNsGYu3xPw8oS84A=bRyeig0R714GfPsvc6=g@mail.gmail.com>
 <536BA864.10608@voxpopuli.im>
 <CAPxN80DHt6nMQjL24szbZsYbkd1du97ExokjPBQX40QwuX70+w@mail.gmail.com>
 <CAPxN80CzV2Y9XJkrqv+vzFOF40OLm1tf7Grgh+n0MOR_UuMmdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513492503=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jessica.foest@gmail.com>) id 1WjzaX-0007Ph-Bf
 for lttng-dev@lists.lttng.org; Mon, 12 May 2014 19:24:59 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so9221802oag.0
 for <lttng-dev@lists.lttng.org>; Mon, 12 May 2014 16:24:47 -0700 (PDT)
In-Reply-To: <CAPxN80CzV2Y9XJkrqv+vzFOF40OLm1tf7Grgh+n0MOR_UuMmdg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1513492503==
Content-Type: multipart/alternative; boundary=047d7bd7649ed02a3e04f93c4077

--047d7bd7649ed02a3e04f93c4077
Content-Type: text/plain; charset=UTF-8

Thanks for your detailed responses :)
Actually i will begin by taking my own trace that i will configure it in
advance ( same event type , and i will add the different event context that
i need ) .
It's my first time to develop with python and i don't really know the
architecture of babeltrace , So can you help me and tell me how to proceed
to filter my data from CTF to the output Format that i will choose ?
I'm only interested on kernel space tracing .


2014-05-08 17:29 GMT-04:00 Jessica Foest <jessica.foest@gmail.com>:

> i work only on kernel space event .
>
>
> 2014-05-08 17:10 GMT-04:00 Jessica Foest <jessica.foest@gmail.com>:
>
> Thanks for your detailed responses :)
>> Actually i will begin by taking my own trace that i will configure it in
>> advance ( same event type , and i will add the different event context that
>> i need ) .
>> It's my first time to develop with python and i don't really know the
>> architecture of babeltrace , So can you help me and tell me how to proceed
>> to filter my data from CTF to the output Format that i will choose ?
>>
>>
>> 2014-05-08 11:53 GMT-04:00 Alexandre Montplaisir <alexmonthy@voxpopuli.im
>> >:
>>
>>
>>>  To avoid doing a complete first pass of the trace, you can just
>>>> iterate on the event types as described in the metadata, and take note
>>>> of all the possible field you can find in the trace. Then, during your
>>>> only pass, you already know all your "columns".
>>>>
>>>
>>> That's true. Although right now TMF doesn't have an API to ask a trace
>>> "give me all the event types you have", other than just reading the trace ;)
>>>
>>> wrt CTF, it's possible to have events in the metadata that don't
>>> actually show up in the trace. But that's not really a problem, at worst
>>> you'd end up with empty columns.
>>>
>>
>>
>

--047d7bd7649ed02a3e04f93c4077
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:13px;font-family:arial,sans-serif=
">Thanks for your detailed responses :)</span><div style=3D"font-size:13px;=
font-family:arial,sans-serif">Actually i will begin by taking my own trace =
that i will configure it in advance ( same event type , and i will add the =
different event context that i need ) .</div>
<div style=3D"font-size:13px;font-family:arial,sans-serif">It&#39;s my firs=
t time to develop with python and i don&#39;t really know the architecture =
of babeltrace , So can you help me and tell me how to proceed to filter my =
data from CTF to the output Format that i will choose ?=C2=A0</div>
<div style=3D"font-size:13px;font-family:arial,sans-serif">I&#39;m only int=
erested on kernel space tracing .</div></div><div class=3D"gmail_extra"><br=
><br><div class=3D"gmail_quote">2014-05-08 17:29 GMT-04:00 Jessica Foest <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:jessica.foest@gmail.com" target=3D"_b=
lank">jessica.foest@gmail.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">i work only on kernel space=
 event .</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote"=
>2014-05-08 17:10 GMT-04:00 Jessica Foest <span dir=3D"ltr">&lt;<a href=3D"=
mailto:jessica.foest@gmail.com" target=3D"_blank">jessica.foest@gmail.com</=
a>&gt;</span>:<div>
<div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Thanks for your detailed re=
sponses :)<div>Actually i will begin by taking my own trace that i will con=
figure it in advance ( same event type , and i will add the different event=
 context that i need ) .</div>


<div>It&#39;s my first time to develop with python and i don&#39;t really k=
now the architecture of babeltrace , So can you help me and tell me how to =
proceed to filter my data from CTF to the output Format that i will choose =
?=C2=A0</div>


</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2014-05=
-08 11:53 GMT-04:00 Alexandre Montplaisir <span dir=3D"ltr">&lt;<a href=3D"=
mailto:alexmonthy@voxpopuli.im" target=3D"_blank">alexmonthy@voxpopuli.im</=
a>&gt;</span>:<div>

<div><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
To avoid doing a complete first pass of the trace, you can just<br>
iterate on the event types as described in the metadata, and take note<br>
of all the possible field you can find in the trace. Then, during your<br>
only pass, you already know all your &quot;columns&quot;.<br>
</blockquote>
<br></div>
That&#39;s true. Although right now TMF doesn&#39;t have an API to ask a tr=
ace &quot;give me all the event types you have&quot;, other than just readi=
ng the trace ;)<br>
<br>
wrt CTF, it&#39;s possible to have events in the metadata that don&#39;t ac=
tually show up in the trace. But that&#39;s not really a problem, at worst =
you&#39;d end up with empty columns.<br>
</blockquote></div></div></div><br></div>
</blockquote></div></div></div><br></div>
</blockquote></div><br></div>

--047d7bd7649ed02a3e04f93c4077--


--===============1513492503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1513492503==--
