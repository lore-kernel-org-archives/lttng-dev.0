From: =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: Babeltrace Patch
Date: Wed, 11 Apr 2018 11:37:43 -0400
Message-ID: <d0e120c7-1c29-271f-fbff-2b8023b6e75b__18417.8172414706$1523464068$gmane$org@versatic.net>
References: <CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5138061001636845482=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 40LqJ24yyDzxKK
 for <lttng-dev@lists.lttng.org>; Wed, 11 Apr 2018 12:29:38 -0400 (EDT)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim
 4.89_1) (envelope-from <gbastien@versatic.net>) id 1f6Hoe-000saF-8w
 for lttng-dev@lists.lttng.org; Wed, 11 Apr 2018 11:37:44 -0400
Received: from station16.dorsal.polymtl.ca ([132.207.72.9]:57996)
 by s056.panelboxmanager.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89_1)
 (envelope-from <gbastien@versatic.net>) id 1f6Hod-000sa5-Vb
 for lttng-dev@lists.lttng.org; Wed, 11 Apr 2018 11:37:44 -0400
In-Reply-To: <CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ@mail.gmail.com>
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
--===============5138061001636845482==
Content-Type: multipart/alternative;
 boundary="------------CDD414C5076634B66171B232"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CDD414C5076634B66171B232
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Nesrine,


I don't know about babeltrace over TCP/IP. But there are tools to read
lttng traces on Windows: Trace Compass [1] can read and analyse a trace
with all kind of data driven analyzes. It can also control a tracing
session [2] and bring the trace on your windows machine. There's also
lttng-scope that reads CTF traces on Windows [3].

[1] http://tracecompass.org
[2]
http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/LTTng-Tracer-Control.html#LTTng_Tracer_Control
[3] https://lttng.org/beta/

Cheers,

Geneviève




On 2018-04-11 08:11 AM, Nesrine Zouari wrote:
> Hello,
>
> I am computer engineering student and I am actually working on my
> graduation project which is about Qemu Trace. 
>
> In this project, Qemu is considered as a user-space instrumented
> application. 
>
> I have used:
>
> 1) LTTng-Tools to control Qemu trace. 
>
> 2) Babeltrace to convert the CTF traces to a human readable text.
>
> Now, I aim to develop a patch to the Babeltrace. Instead of printing
> the traces on the console or in a file, I would like to send the
> traces over TCP/IP to a third-party tool for processing.
> My third-party tool is installed on a windows machine. For this
> reason, the use of LTTng relay daemon will not be a good solution.
>
> My question is the following:
>
> To which file (of the Babeltrace source code) should I make changes to
> answer my use case?
>
> Best regards,
>
> -----------------------------------------------------------------------------------------
>
> Nesrine ZOUARI
> Computer Engineering Student 
> Department of Computer Engineering and Applied Mathematics
> National Engineering School of Sfax (ENIS)
> University of Sfax-Tunisia
> Tel: +216 52 620 475
>
>
> ‌
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------CDD414C5076634B66171B232
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Nesrine,</p>
    <p><br>
    </p>
    <p>I don't know about babeltrace over TCP/IP. But there are tools to
      read lttng traces on Windows: Trace Compass [1] can read and
      analyse a trace with all kind of data driven analyzes. It can also
      control a tracing session [2] and bring the trace on your windows
      machine. There's also lttng-scope that reads CTF traces on Windows
      [3]. <br>
    </p>
    <p>[1] <a class="moz-txt-link-freetext" href="http://tracecompass.org">http://tracecompass.org</a><br>
      [2]
<a class="moz-txt-link-freetext" href="http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/LTTng-Tracer-Control.html#LTTng_Tracer_Control">http://archive.eclipse.org/tracecompass/doc/stable/org.eclipse.tracecompass.doc.user/LTTng-Tracer-Control.html#LTTng_Tracer_Control</a><br>
      [3] <a class="moz-txt-link-freetext" href="https://lttng.org/beta/">https://lttng.org/beta/</a></p>
    <p>Cheers,</p>
    <p>Geneviève<br>
    </p>
    <br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2018-04-11 08:11 AM, Nesrine Zouari
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ@mail.gmail.com">
      <div dir="ltr"><img class="mailtrack-img" alt=""
          style="display:flex"
src="https://mailtrack.io/trace/mail/e23be10a85712f90d75c20e203084a37d54d5929.png?u=2189147"
          moz-do-not-send="true" width="0" height="0">
        <div
style="color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><span
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255);float:none;display:inline"><font
              color="#000000">Hello,</font></span>
          <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><span
style="font-family:arial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><font
                color="#000000"><br>
              </font></span></div>
          <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><font
              color="#000000"><span
style="font-family:arial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline">I
                am computer engineering student and I am actually
                working on my graduation project which is about<span> </span></span><span
class="gmail-m_-5990065758927244463gmail-m_6820945704080840124gmail-m_-6755159426057962638gmail-m_3226980521649496158gmail-m_4311176812459725481gmail-m_3469504987072534619gmail-m_-2143354602622622349gmail-m_5367336902020713707gmail-m_567988643051350633gmail-m_-2504658086804125746m_-670507402164016222gmail-il"
style="font-family:arial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initial">Qemu</span><span
style="font-family:arial,sans-serif;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span> </span>Trace. </span></font></div>
          <div
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial"><font
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)"
              color="#000000"><br>
            </font>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><span
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><font
                  color="#000000"><font
style="font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;font-family:arial,sans-serif;font-size:12.8px;background-color:rgb(255,255,255)"><span
                      style="font-size:12.8px">In this project, Qemu is<span> </span></span></font><span
style="font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;font-family:arial,sans-serif;font-size:12.8px;background-color:rgb(255,255,255)">considered</span><font><span
                      style="background-color:rgb(255,255,255)"><span
                        style="font-size:12.8px"> as a user-space
                        instrumented application. </span></span></font></font></span></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><span
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span
                  style="background-color:rgb(255,255,255)"><span
                    style="font-size:12.8px"><font color="#000000"><br>
                    </font></span></span></span></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><span
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span
                  style="background-color:rgb(255,255,255)"><span
                    style="font-size:12.8px"><font color="#000000">I
                      have used:</font></span></span></span></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><span
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span
                  style="background-color:rgb(255,255,255)"><span
class="gmail-m_-5990065758927244463gmail-m_6820945704080840124gmail-m_-6755159426057962638gmail-m_3226980521649496158gmail-m_4311176812459725481gmail-m_3469504987072534619gmail-il"
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><font
                      color="#000000"><br>
                    </font></span></span></span></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><span
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span
                  style="background-color:rgb(255,255,255)"><font
                    color="#000000"><span
class="gmail-m_-5990065758927244463gmail-m_6820945704080840124gmail-m_-6755159426057962638gmail-m_3226980521649496158gmail-m_4311176812459725481gmail-m_3469504987072534619gmail-il"
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px">1)
                      LTTng</span><span style="font-size:12.8px">-Tools
                      to control Qemu trace. </span></font></span></span></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><span
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span
                  style="background-color:rgb(255,255,255)"><span
                    style="font-size:12.8px"><font color="#000000"><br>
                    </font></span></span></span></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"><span
style="text-align:start;text-indent:0px;text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span
                  style="background-color:rgb(255,255,255)"><font
                    color="#000000"><span style="font-size:12.8px">2)
                      Babeltrace to convert the CTF traces to </span><span
style="text-align:start;text-indent:0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initial;float:none;display:inline"><span
                        style="font-size:12.8px">a human readable text.</span></span></font></span></span></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)"><font
                color="#000000"><br>
              </font></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)"><font
                color="#000000"><span
style="background-color:rgb(247,247,247);font-family:Cabin,sans-serif;font-size:12.8px">Now, </span><span
                  style="font-size:12.8px">I aim to develop a patch to
                  the Babeltrace. Instead of printing the traces on the
                  console or in a file, </span></font><span
                style="color:rgb(0,0,0)">I would like </span><span
                style="color:rgb(0,0,0);font-size:small">to send the
                traces over TCP/IP to a third-party tool for processing.</span></div>
            <div style="background-color:rgb(255,255,255)"><font
                color="#000000">My third-party tool is installed on a
                windows machine. For this reason, the use of LTTng relay
                daemon will not be a good solution.</font></div>
            <div
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)"><br>
            </div>
          </div>
          <font
style="font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-transform:none;white-space:normal;word-spacing:0px"
            color="#000000">My question is the following:</font></div>
        <div
style="color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><font
            color="#000000"><br>
          </font></div>
        <div
style="color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><font
            color="#000000">To which file (of the Babeltrace source
            code) should I make changes to answer my use case?<br>
          </font></div>
        <div
style="color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><font
            color="#000000"><br>
          </font></div>
        <div
style="color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decoration-style:initial;text-decoration-color:initial;background-color:rgb(255,255,255)"><font
            color="#000000">Best regards,</font></div>
        <br>
        <div class="gmail_signature" data-smartmail="gmail_signature">
          <div dir="ltr">
            <div>
              <div dir="ltr">
                <div>
                  <div dir="ltr">
                    <div dir="ltr">
                      <div dir="ltr" style="font-size:12.8px">
                        <div dir="ltr"><span style="font-size:12.8px"><font
                              color="#444444">-----------------------------------------------------------------------------------------</font></span></div>
                        <div dir="ltr"><font size="2" face="arial,
                            helvetica, sans-serif" color="#444444"><br>
                          </font></div>
                        <div dir="ltr"><font size="2" face="arial,
                            helvetica, sans-serif" color="#444444">Nesrine
                            ZOUARI</font></div>
                        <div dir="ltr"><font size="2" face="arial,
                            helvetica, sans-serif" color="#444444">Computer
                            Engineering Student <br>
                          </font></div>
                        <div dir="ltr"><font size="2" face="arial,
                            helvetica, sans-serif" color="#444444">Department
                            of Computer Engineering and Applied
                            Mathematics</font></div>
                        <div dir="ltr"><span
style="color:rgb(68,68,68);font-family:arial,helvetica,sans-serif;font-size:small">National
                            Engineering School of Sfax (ENIS)</span></div>
                        <div dir="ltr">
                          <div dir="ltr"
                            style="font-size:12.8px;margin:0px;padding:0px;border:0px"><font
                              color="#444444"><font
                                style="margin:0px;padding:0px;border:0px"
                                size="2" face="arial, helvetica,
                                sans-serif">University of Sfax-</font><span
style="font-family:arial,helvetica,sans-serif;font-size:small">Tunisia<br>
                              </span></font></div>
                          <div
                            style="font-size:12.8px;margin:0px;padding:0px;border:0px
                            none"><font color="#444444"><span
                                style="font-family:arial,helvetica,sans-serif;font-size:small">Tel:
                                +216 52 620 475<br>
                              </span></font></div>
                          <div dir="ltr"
                            style="font-size:12.8px;margin:0px;padding:0px;border:0px"><font
                              color="#444444"><span
                                style="font-family:arial,helvetica,sans-serif;font-size:small"><br>
                              </span></font></div>
                          <div><font color="#444444"><span
                                style="font-family:arial,helvetica,sans-serif;font-size:small"><br>
                              </span></font></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        ‌</div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CDD414C5076634B66171B232--

--===============5138061001636845482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5138061001636845482==--
