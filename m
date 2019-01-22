From: Genevieve Bastien <gbastien@versatic.net>
Subject: Re: add cpu_id context to the channel
Date: Mon, 21 Jan 2019 19:46:02 -0500
Message-ID: <439e2c9e-cd74-c0fb-ae25-53455082265f__32711.3963825226$1548118656$gmane$org@versatic.net>
References: <CACJEY86QpFpjiDe_eHfCnpEhRRPgsfW-+xW5LdM=xRFWNgOL-Q@mail.gmail.com>
 <2127783106.260.1548097581357.JavaMail.zimbra@efficios.com>
 <CACJEY85gdy86ttpJJwK==1zOhkTERrRcSG_6WQET1_znLSqTdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2711816238713723682=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from barracuda.ebox.ca (barracuda.ebox.ca [96.127.255.19])
 by lists.lttng.org (Postfix) with ESMTPS id 43k94Q3sGHzpNP
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2019 19:57:26 -0500 (EST)
Received: from smtp.ebox.ca (smtp.electronicbox.net [96.127.255.82]) by
 barracuda.ebox.ca with ESMTP id z04TDo5VnnArcx8C (version=TLSv1
 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) for <lttng-dev@lists.lttng.org>;
 Mon, 21 Jan 2019 19:46:02 -0500 (EST)
Received: from [192.168.47.217] (unknown [104.163.172.174])
 by smtp.ebox.ca (Postfix) with ESMTPS id BF585441D64
 for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2019 19:46:02 -0500 (EST)
In-Reply-To: <CACJEY85gdy86ttpJJwK==1zOhkTERrRcSG_6WQET1_znLSqTdw@mail.gmail.com>
Content-Language: en-US
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

This is a multi-part message in MIME format.
--===============2711816238713723682==
Content-Type: multipart/alternative;
 boundary="------------6933424D1810A9C7378C5EC7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6933424D1810A9C7378C5EC7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yonghong,

With TraceCompass XML analyses, you can use as state value or attribute
an eventField called 'cpu' to get the CPU id of an event. For example,

<stateAttribute type=3D"eventField" value=3D"cpu" />

With LTTng traces, it will automatically be the CPU, obtained as Mathieu
described, no need for an extra field.

Regards,

Genevi=C3=A8ve


On 2019-01-21 4:21 p.m., Yonghong Yan wrote:
> Thank you. make sense. I am using Trace Compass XML based approach to
> display UST trace records. Using CPU id helps me easier to sort out
> the event records in trace compass. I will check out more on trace
> compass.=C2=A0
>
> Yonghong
>
>
> On Mon, Jan 21, 2019 at 2:06 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com
> <mailto:mathieu.desnoyers@efficios.com>> wrote:
>
>
>     ----- On Jan 21, 2019, at 12:14 PM, Yonghong Yan
>     <yanyh15@gmail.com <mailto:yanyh15@gmail.com>> wrote:
>
>         I saw there is cpu_id field in babeltrace list, how can I add
>         it to the context of UST tracepoint events.=C2=A0lttng add-cont=
ext
>         --list does not show that field and I do not see a similar
>         field for the cpu_id.=C2=A0
>
>
>     The cpu_id context only exists for the purpose of lttng-ust and
>     lttng-modules filtering.
>     (e.g. lttng enable-event {-u,-k} --filter '$ctx.cpu_id =3D=3D 2').
>
>     It is not possible to add it as context to the streams, because
>     its information would
>     be completely redundant with the fact that all the data is written
>     into per-cpu buffers,
>     and the cpu_id field is available within each packet context
>     (which is right after each
>     packet header).
>
>     You just need to use babeltrace to convert to text, and while
>     doing so, it prints a
>     "cpu_id =3D N" context based on the packet_context cpu_id field for=

>     each event.
>
>     Thanks,
>
>     Mathieu
>
>     --=20
>     Mathieu Desnoyers
>     EfficiOS Inc.
>     http://www.efficios.com
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------6933424D1810A9C7378C5EC7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Yonghong,</p>
    <p>With TraceCompass XML analyses, you can use as state value or
      attribute an eventField called 'cpu' to get the CPU id of an
      event. For example,<br>
    </p>
    <p>&lt;stateAttribute type="eventField" value="cpu" /&gt;</p>
    <p>With LTTng traces, it will automatically be the CPU, obtained as
      Mathieu described, no need for an extra field.<br>
    </p>
    <p>Regards,</p>
    <p>Geneviève<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2019-01-21 4:21 p.m., Yonghong Yan
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CACJEY85gdy86ttpJJwK==1zOhkTERrRcSG_6WQET1_znLSqTdw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">Thank you. make sense. I am using Trace Compass XML
        based approach to display UST trace records. Using CPU id helps
        me easier to sort out the event records in trace compass. I will
        check out more on trace compass. 
        <div><br>
        </div>
        <div>Yonghong<br>
          <br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr">On Mon, Jan 21, 2019 at 2:06 PM Mathieu Desnoyers
          &lt;<a href="mailto:mathieu.desnoyers@efficios.com"
            moz-do-not-send="true">mathieu.desnoyers@efficios.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <div
style="font-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
              <div><br>
              </div>
              <div><span id="gmail-m_-6511454066164686156zwchr">----- On
                  Jan 21, 2019, at 12:14 PM, Yonghong Yan &lt;<a
                    href="mailto:yanyh15@gmail.com" target="_blank"
                    moz-do-not-send="true">yanyh15@gmail.com</a>&gt;
                  wrote:<br>
                </span></div>
              <div>
                <blockquote style="border-left:2px solid
rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">
                  <div dir="ltr">
                    <div dir="ltr">I saw there is cpu_id field in
                      babeltrace list, how can I add it to the context
                      of UST tracepoint events. lttng add-context --list
                      does not show that field and I do not see a
                      similar field for the cpu_id. </div>
                  </div>
                </blockquote>
                <div><br>
                </div>
                <div>The cpu_id context only exists for the purpose of
                  lttng-ust and lttng-modules filtering.<br>
                </div>
                <div>(e.g. lttng enable-event {-u,-k} --filter
                  '$ctx.cpu_id == 2').<br>
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
                <div>"cpu_id = N" context based on the packet_context
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
                <a href="http://www.efficios.com" target="_blank"
                  moz-do-not-send="true">http://www.efficios.com</a></div>
            </div>
          </div>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
  </body>
</html>

--------------6933424D1810A9C7378C5EC7--

--===============2711816238713723682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2711816238713723682==--
