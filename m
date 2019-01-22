From: Yonghong Yan <yanyh15@gmail.com>
Subject: Re: add cpu_id context to the channel
Date: Tue, 22 Jan 2019 11:44:51 -0500
Message-ID: <CACJEY86jVwQ4qYXgSqEhvqf__=P-XM-CTcBZi1D+vbChK_AEXw__10681.4105690987$1548175530$gmane$org@mail.gmail.com>
References: <CACJEY86QpFpjiDe_eHfCnpEhRRPgsfW-+xW5LdM=xRFWNgOL-Q@mail.gmail.com>
 <2127783106.260.1548097581357.JavaMail.zimbra@efficios.com>
 <CACJEY85gdy86ttpJJwK==1zOhkTERrRcSG_6WQET1_znLSqTdw@mail.gmail.com>
 <439e2c9e-cd74-c0fb-ae25-53455082265f@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2984407499011626648=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by lists.lttng.org (Postfix) with ESMTPS id 43kZ5v3qRmznGY
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 11:45:07 -0500 (EST)
Received: by mail-pf1-x42b.google.com with SMTP id b7so12024592pfi.8
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 08:45:07 -0800 (PST)
In-Reply-To: <439e2c9e-cd74-c0fb-ae25-53455082265f@versatic.net>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Genevieve Bastien <gbastien@versatic.net>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2984407499011626648==
Content-Type: multipart/alternative; boundary="00000000000018936105800eb388"

--00000000000018936105800eb388
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Genevieve, "cpu" field works.

Yonghong


On Mon, Jan 21, 2019 at 7:57 PM Genevieve Bastien <gbastien@versatic.net>
wrote:

> Hi Yonghong,
>
> With TraceCompass XML analyses, you can use as state value or attribute a=
n
> eventField called 'cpu' to get the CPU id of an event. For example,
>
> <stateAttribute type=3D"eventField" value=3D"cpu" />
>
> With LTTng traces, it will automatically be the CPU, obtained as Mathieu
> described, no need for an extra field.
>
> Regards,
>
> Genevi=C3=A8ve
>
>
> On 2019-01-21 4:21 p.m., Yonghong Yan wrote:
>
> Thank you. make sense. I am using Trace Compass XML based approach to
> display UST trace records. Using CPU id helps me easier to sort out the
> event records in trace compass. I will check out more on trace compass.
>
> Yonghong
>
>
> On Mon, Jan 21, 2019 at 2:06 PM Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>>
>> ----- On Jan 21, 2019, at 12:14 PM, Yonghong Yan <yanyh15@gmail.com>
>> wrote:
>>
>> I saw there is cpu_id field in babeltrace list, how can I add it to the
>> context of UST tracepoint events. lttng add-context --list does not show
>> that field and I do not see a similar field for the cpu_id.
>>
>>
>> The cpu_id context only exists for the purpose of lttng-ust and
>> lttng-modules filtering.
>> (e.g. lttng enable-event {-u,-k} --filter '$ctx.cpu_id =3D=3D 2').
>>
>> It is not possible to add it as context to the streams, because its
>> information would
>> be completely redundant with the fact that all the data is written into
>> per-cpu buffers,
>> and the cpu_id field is available within each packet context (which is
>> right after each
>> packet header).
>>
>> You just need to use babeltrace to convert to text, and while doing so,
>> it prints a
>> "cpu_id =3D N" context based on the packet_context cpu_id field for each
>> event.
>>
>> Thanks,
>>
>> Mathieu
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttps://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--00000000000018936105800eb388
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"=
><div>Thank you Genevieve, &quot;cpu&quot; field works.=C2=A0</div><div><br=
></div><div>Yonghong</div></div></div></div></div><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr">On Mon, Jan 21, 2019 at 7:57 PM Genevieve=
 Bastien &lt;<a href=3D"mailto:gbastien@versatic.net">gbastien@versatic.net=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <p>Hi Yonghong,</p>
    <p>With TraceCompass XML analyses, you can use as state value or
      attribute an eventField called &#39;cpu&#39; to get the CPU id of an
      event. For example,<br>
    </p>
    <p>&lt;stateAttribute type=3D&quot;eventField&quot; value=3D&quot;cpu&q=
uot; /&gt;</p>
    <p>With LTTng traces, it will automatically be the CPU, obtained as
      Mathieu described, no need for an extra field.<br>
    </p>
    <p>Regards,</p>
    <p>Genevi=C3=A8ve<br>
    </p>
    <p><br>
    </p>
    <div class=3D"gmail-m_1715309599997022837moz-cite-prefix">On 2019-01-21=
 4:21 p.m., Yonghong Yan
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">Thank you. make sense. I am using Trace Compass XML
        based approach to display UST trace records. Using CPU id helps
        me easier to sort out the event records in trace compass. I will
        check out more on trace compass.=C2=A0
        <div><br>
        </div>
        <div>Yonghong<br>
          <br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr">On Mon, Jan 21, 2019 at 2:06 PM Mathieu Desnoyers
          &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_=
blank">mathieu.desnoyers@efficios.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <div style=3D"font-family:arial,helvetica,sans-serif;font-size:=
12pt;color:rgb(0,0,0)">
              <div><br>
              </div>
              <div><span id=3D"gmail-m_1715309599997022837gmail-m_-65114540=
66164686156zwchr">----- On
                  Jan 21, 2019, at 12:14 PM, Yonghong Yan &lt;<a href=3D"ma=
ilto:yanyh15@gmail.com" target=3D"_blank">yanyh15@gmail.com</a>&gt;
                  wrote:<br>
                </span></div>
              <div>
                <blockquote style=3D"border-left:2px solid rgb(16,16,255);m=
argin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font=
-size:12pt">
                  <div dir=3D"ltr">
                    <div dir=3D"ltr">I saw there is cpu_id field in
                      babeltrace list, how can I add it to the context
                      of UST tracepoint events.=C2=A0lttng add-context --li=
st
                      does not show that field and I do not see a
                      similar field for the cpu_id.=C2=A0</div>
                  </div>
                </blockquote>
                <div><br>
                </div>
                <div>The cpu_id context only exists for the purpose of
                  lttng-ust and lttng-modules filtering.<br>
                </div>
                <div>(e.g. lttng enable-event {-u,-k} --filter
                  &#39;$ctx.cpu_id =3D=3D 2&#39;).<br>
                </div>
                <div><br>
                </div>
                <div>It is not possible to add it as context to the
                  streams, because its information would<br>
                </div>
                <div>be completely redundant with the fact that all the
                  data is written into per-cpu buffers,</div>
                <div>and the cpu_id field is available within each
                  packet context (which is right after each</div>
                <div>packet header).<br>
                </div>
                <div><br>
                </div>
                <div>You just need to use babeltrace to convert to text,
                  and while doing so, it prints a<br>
                </div>
                <div>&quot;cpu_id =3D N&quot; context based on the packet_c=
ontext
                  cpu_id field for each event.<br>
                </div>
                <div><br>
                </div>
                <div>Thanks,</div>
                <div><br>
                </div>
                <div>Mathieu<br>
                </div>
              </div>
              <div><br>
              </div>
              <div>-- <br>
              </div>
              <div>Mathieu Desnoyers<br>
                EfficiOS Inc.<br>
                <a href=3D"http://www.efficios.com" target=3D"_blank">http:=
//www.efficios.com</a></div>
            </div>
          </div>
        </blockquote>
      </div>
      <br>
      <fieldset class=3D"gmail-m_1715309599997022837mimeAttachmentHeader"><=
/fieldset>
      <pre class=3D"gmail-m_1715309599997022837moz-quote-pre">_____________=
__________________________________
lttng-dev mailing list
<a class=3D"gmail-m_1715309599997022837moz-txt-link-abbreviated" href=3D"ma=
ilto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org=
</a>
<a class=3D"gmail-m_1715309599997022837moz-txt-link-freetext" href=3D"https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
  </div>

_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</blockquote></div></div>

--00000000000018936105800eb388--

--===============2984407499011626648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2984407499011626648==--
