From: =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: [tracecompass-dev] Question related to LTTng
Date: Fri, 29 Mar 2019 11:04:05 -0400
Message-ID: <3f170528-e3b4-4b37-b94b-5f8276abb53e__42054.4629961782$1553874239$gmane$org@versatic.net>
References: <CAEWVvOTEJjw3kYfPfrcW68Ux6fy1g5utoHBpy=o++d71rxddbg@mail.gmail.com>
 <f0d5b7b4-dacc-ca93-10d5-cc3f7c88d320@versatic.net>
 <BN8PR15MB3090BB0C0E9FC7D9865EF2369E580@BN8PR15MB3090.namprd15.prod.outlook.com>
 <CAEWVvOT1EQ9aS3Ao5u-nypV2ZrsDyHHMh9fEguLDgG27w6=gRw@mail.gmail.com>
 <BN8PR15MB30907BD062BC346E35C2B7E09E580@BN8PR15MB3090.namprd15.prod.outlook.com>
 <CAEWVvOTtN_sckmpsXn6w4JkfFo4HYcta_YzwnfBhmZt_OeUJtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2249804075913953162=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 44W5cc1qQ4z1KL9
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 11:43:43 -0400 (EDT)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.91)
 (envelope-from <gbastien@versatic.net>) id 1h9t3F-00AdGn-ET
 for lttng-dev@lists.lttng.org; Fri, 29 Mar 2019 11:04:13 -0400
In-Reply-To: <CAEWVvOTtN_sckmpsXn6w4JkfFo4HYcta_YzwnfBhmZt_OeUJtA@mail.gmail.com>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Ravindra Kumar Meena <rmeena840@gmail.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "tracecompass-dev@eclipse.org" <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============2249804075913953162==
Content-Type: multipart/alternative;
 boundary="------------82DAA19EC4E1E6E9C02509D2"
Content-Language: en-US-large

This is a multi-part message in MIME format.
--------------82DAA19EC4E1E6E9C02509D2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Ravindra,

On 2019-03-27 2:49 p.m., Ravindra Kumar Meena wrote:
>
>     > So you have a user space application that generates a trace. It is virtualized, and you want to open it in trace compass to analyze it.
>
>   
>
>     Yes. That's what I want to do but it has to in real-time manner.
>
Trace Compass does not support live traces. It is made for post-mortem analyses, so it works only on complete trace. We briefly supported live traces a few years back, but that made the code much more complicated, so this support was dropped. TraceCompass is not made for trace monitoring!
>  
>
>     > I would like to know if there is a way to transfer CTF to Trace Compass in a real-time manner using TCP/UDP.
>
>
>     >Would scp work? Just asking.
>
>  
>
>     I am supposed to transfer it through only TCP/UDP.
>
LTTng does support relaying the data over the network (see https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network). But Trace Compass does not open traces that are not terminated. The 2.11 version (not yet released) and master also support session rotation, so you can have traces in chunks of say 1 minutes and whenever a chunk is closed, it is ready to be opened by Trace Compass. This is as close to live trace analysis as you can get.

>  
>
>     >How can I convert CTF Trace Data to LTTng? Since TraceCompass already understands LTTng Trace Data.
>
>
>     >The CTF trace should be openable in Trace Compass. You won't have as many pretty graphs and whatnot, but you can get some basic analyses done with searching and filters. If you want some more advanced analyses, you can code an XML analysis, or use any language you want and parse it to make a LAMI report. Finally you can make your own analysis (and even commit it to the incubator! 😉 😉 ).
>
>
>     >The information that I want to analyze and display information includes CPU usage, IRQ analysis(IRQ Statistics, IRQ Table, IRQ vs Count, IRQ vs Time), Linux Kernel(Control Flow, Resources)

With an LTTng kernel trace, you can get all that. Add a UST trace to it and you can correlate both traces together.

Cheers,

Geneviève



--------------82DAA19EC4E1E6E9C02509D2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Ravindra,<br>
    </p>
    <div class="moz-cite-prefix">On 2019-03-27 2:49 p.m., Ravindra Kumar
      Meena wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEWVvOTtN_sckmpsXn6w4JkfFo4HYcta_YzwnfBhmZt_OeUJtA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div
id="m_7752166956455312320gmail-m_6403026334017903746divtagdefaultwrapper"
style="font-size:12pt;font-family:Calibri,Helvetica,sans-serif"
                dir="ltr">
                <p style="margin-top:0px;margin-bottom:0px"><span
                    style="font-size:12pt"><font color="#ff0000">&gt; So
                      you have a user space application that generates a
                      trace. It is virtualized, and you want to open it
                      in trace compass to analyze it.</font></span></p>
              </div>
            </div>
          </blockquote>
          <div>  </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div
id="m_7752166956455312320gmail-m_6403026334017903746divtagdefaultwrapper"
style="font-size:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif"
                dir="ltr">
                <p style="margin-top:0px;margin-bottom:0px">Yes. That's
                  what I want to do but it has to in real-time manner.</p>
              </div>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
    Trace Compass does not support live traces. It is made for
    post-mortem analyses, so it works only on complete trace. We briefly
    supported live traces a few years back, but that made the code much
    more complicated, so this support was dropped. TraceCompass is not
    made for trace monitoring!<br>
    <blockquote type="cite"
cite="mid:CAEWVvOTtN_sckmpsXn6w4JkfFo4HYcta_YzwnfBhmZt_OeUJtA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div
id="m_7752166956455312320gmail-m_6403026334017903746divtagdefaultwrapper"
style="font-size:12pt;font-family:Calibri,Helvetica,sans-serif"
                dir="ltr">
                <p style="margin-top:0px;margin-bottom:0px"><font
                    color="#ff0000">&gt; I would like to know if there
                    is a way to transfer CTF to Trace Compass in a
                    real-time manner using TCP/UDP.</font></p>
                <p
                  style="color:rgb(0,0,0);margin-top:0px;margin-bottom:0px"><br>
                </p>
                <p style="margin-top:0px;margin-bottom:0px"><font
                    color="#ff0000">&gt;Would scp work? Just asking.</font></p>
              </div>
            </div>
          </blockquote>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div
id="m_7752166956455312320gmail-m_6403026334017903746divtagdefaultwrapper"
style="font-size:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif"
                dir="ltr">
                <p style="margin-top:0px;margin-bottom:0px">I am
                  supposed to transfer it through only TCP/UDP.</p>
              </div>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p>LTTng does support relaying the data over the network (see
      <a class="moz-txt-link-freetext" href="https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network">https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network</a>).
      But Trace Compass does not open traces that are not terminated.
      The 2.11 version (not yet released) and master also support
      session rotation, so you can have traces in chunks of say 1
      minutes and whenever a chunk is closed, it is ready to be opened
      by Trace Compass. This is as close to live trace analysis as you
      can get. <br>
    </p>
    <blockquote type="cite"
cite="mid:CAEWVvOTtN_sckmpsXn6w4JkfFo4HYcta_YzwnfBhmZt_OeUJtA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div
id="m_7752166956455312320gmail-m_6403026334017903746divtagdefaultwrapper"
style="font-size:12pt;font-family:Calibri,Helvetica,sans-serif"
                dir="ltr">
                <p style="margin-top:0px;margin-bottom:0px"><font
                    color="#ff0000">&gt;How can I convert CTF Trace Data
                    to LTTng? Since TraceCompass already understands
                    LTTng Trace Data.</font></p>
                <p style="margin-top:0px;margin-bottom:0px"><font
                    color="#ff0000"><br>
                  </font></p>
                <p style="margin-top:0px;margin-bottom:0px"><font
                    color="#ff0000">&gt;The CTF trace should be openable
                    in Trace Compass. You won't have as many pretty
                    graphs and whatnot, but you can get some basic
                    analyses done with searching and filters. If you
                    want some more advanced analyses, you can code an
                    XML analysis, or use any language you want and parse
                    it to make a LAMI report. Finally you can make your
                    own analysis (and even commit it to the incubator!
                    😉 😉 ).</font></p>
                <p
                  style="color:rgb(0,0,0);margin-top:0px;margin-bottom:0px"><br>
                </p>
              </div>
            </div>
          </blockquote>
          <div>    &gt;<span style="background-color:transparent;color:rgb(0,0,0);font-family:Arial;font-size:12pt;white-space:pre-wrap">The information that I want to analyze and display information includes CPU usage, IRQ analysis(IRQ Statistics, IRQ Table, IRQ vs Count, IRQ vs Time), Linux Kernel(Control Flow, Resources)</span></div>
        </div>
      </div>
    </blockquote>
    <p>With an LTTng kernel trace, you can get all that. Add a UST trace
      to it and you can correlate both traces together.</p>
    <p>Cheers,</p>
    <p>Geneviève<br>
    </p>
    <br>
  </body>
</html>

--------------82DAA19EC4E1E6E9C02509D2--

--===============2249804075913953162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2249804075913953162==--
