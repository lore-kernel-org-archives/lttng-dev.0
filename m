From: Mohamad Gebai <mgebai@suse.de>
Subject: Re: Babeltrace Patch
Date: Wed, 11 Apr 2018 10:41:11 -0400
Message-ID: <4dc85d3f-8397-31e2-f9d2-fd0f81bdc2f8__28788.1484524862$1523458320$gmane$org@suse.de>
References: <CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6733311074742294108=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by lists.lttng.org (Postfix) with ESMTPS id 40Ln9c0bJTzwwl
 for <lttng-dev@lists.lttng.org>; Wed, 11 Apr 2018 10:53:55 -0400 (EDT)
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
To: Nesrine Zouari <nesrine.zouari@enis.tn>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============6733311074742294108==
Content-Type: multipart/alternative;
 boundary="------------9E669D9859F88DAE8A0BD9A5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9E669D9859F88DAE8A0BD9A5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Nesrine,

You can use LTTng to send your traces over the network. See
https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network

Mohamad


On 04/11/2018 08:11 AM, Nesrine Zouari wrote:
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


--------------9E669D9859F88DAE8A0BD9A5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    Hi Nesrine,<br>
    <br>
    You can use LTTng to send your traces over the network. See
    <a class="moz-txt-link-freetext" href="https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network">https://lttng.org/docs/v2.10/#doc-sending-trace-data-over-the-network</a><br>
    <br>
    Mohamad<br>
    <br>
    <br>
    <div class="moz-cite-prefix">On 04/11/2018 08:11 AM, Nesrine Zouari
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPHFV4no6vfu0HV-D9Fy0HwGnuN84LT-4m3yLV_9ZOjqA+ytqQ@mail.gmail.com">
      <div dir="ltr"><img class="mailtrack-img" alt=""
          style="display:flex"
src="https://mailtrack.io/trace/mail/e23be10a85712f90d75c20e203084a37d54d5929.png?u=2189147"
          moz-do-not-send="true" height="0" width="0">
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
                        <div dir="ltr"><font face="arial, helvetica,
                            sans-serif" size="2" color="#444444"><br>
                          </font></div>
                        <div dir="ltr"><font face="arial, helvetica,
                            sans-serif" size="2" color="#444444">Nesrine
                            ZOUARI</font></div>
                        <div dir="ltr"><font face="arial, helvetica,
                            sans-serif" size="2" color="#444444">Computer
                            Engineering Student <br>
                          </font></div>
                        <div dir="ltr"><font face="arial, helvetica,
                            sans-serif" size="2" color="#444444">Department
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
                                face="arial, helvetica, sans-serif"
                                size="2">University of Sfax-</font><span
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

--------------9E669D9859F88DAE8A0BD9A5--

--===============6733311074742294108==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6733311074742294108==--
